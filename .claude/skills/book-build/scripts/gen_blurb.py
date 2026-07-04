#!/usr/bin/env python3
"""Generate the landing/back-cover partials from editable Markdown in book/.

Authored sources (edit these):
  - book/blurb.md    — the back-cover / "why read it" blurb. YAML frontmatter
                       `description:` (used for the ePub <dc:description>), then a
                       body of: a lead paragraph, a bulleted list of convictions
                       (`- **Label** — text.`), and a closing paragraph.
  - book/epigraph.md — the landing-page epigraph teaser (prose only; the
                       `.epigraph` styling wrapper lives in index.qmd).

Outputs (generated, git-ignored) written into the Quarto project dir:
  - _blurb.md    — Markdown, {{< include >}}-d by the web landing (index.qmd).
  - _blurb.typ   — Typst, #include-d by the PDF back cover.
  - _blurb.json  — structured blurb (lead/convictions/close/description), read by
                   epub_backcover.py (post-render) for the ePub page + description.
  - _epigraph.md — copy of book/epigraph.md, {{< include >}}-d by index.qmd.

Runs pre-render (build.sh + CI) because Quarto resolves {{< include >}} before
its pre-render hooks. Usage: gen_blurb.py [project-dir]  (default '.').
"""
import json
import os
import re
import sys

PURPLE = '#b565a7'  # fallback if _tokens.json (from theme.yml) isn't present
FRONTMATTER = re.compile(r"^---\s*\n(.*?)\n---\s*\n", re.S)


def token_purple(base):
    p = os.path.join(base, "_tokens.json")
    if os.path.isfile(p):
        try:
            return json.load(open(p, encoding="utf-8"))["colors"]["purple"]
        except (ValueError, OSError, KeyError):
            pass
    return PURPLE
BULLET = re.compile(r"^-\s+\*\*(.+?)\*\*\s+—\s+(.+)$")


def parse_blurb(text):
    """Split the blurb Markdown into lead / convictions / close / description."""
    desc = ""
    m = FRONTMATTER.match(text)
    body = text[m.end():] if m else text
    if m:
        dm = re.search(r"^description:\s*(.+)$", m.group(1), re.M)
        if dm:
            desc = dm.group(1).strip().strip('"').strip("'")
    lead, convictions, close = [], [], []
    seen_bullet = False
    for ln in body.strip("\n").split("\n"):
        b = BULLET.match(ln)
        if b:
            seen_bullet = True
            convictions.append({"label": b.group(1).strip(), "text": b.group(2).strip()})
        elif not ln.strip():
            continue
        elif seen_bullet:
            close.append(ln.strip())
        else:
            lead.append(ln.strip())
    return {"lead": " ".join(lead), "convictions": convictions,
            "close": " ".join(close), "description": desc}, body


def emph_typ(s):
    return re.sub(r"\*([^*]+)\*", r"#emph[\1]", s)


def main():
    base = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("QUARTO_PROJECT_DIR", ".")
    book = os.path.join(base, "..", "book")

    # ---- blurb ----
    raw = open(os.path.join(book, "blurb.md"), encoding="utf-8").read()
    b, body = parse_blurb(raw)
    lead, close, cons = b["lead"], b["close"], b["convictions"]

    # _blurb.md — web include (the body verbatim, frontmatter stripped)
    open(os.path.join(base, "_blurb.md"), "w", encoding="utf-8").write(body.strip("\n") + "\n")

    # _blurb.typ — PDF back cover
    purple = token_purple(base)
    items = ",\n".join(
        f'    [#text(weight: "bold", fill: rgb("{purple}"))[{c["label"]}] — {emph_typ(c["text"])}]'
        for c in cons)
    typ = (f"{emph_typ(lead)}\n\n#v(0.9em)\n\n#stack(spacing: 0.6em,\n{items},\n)\n\n"
           f"#v(0.9em)\n\n{emph_typ(close)}\n")
    open(os.path.join(base, "_blurb.typ"), "w", encoding="utf-8").write(typ)

    # _blurb.json — structured, for epub_backcover.py
    open(os.path.join(base, "_blurb.json"), "w", encoding="utf-8").write(
        json.dumps(b, ensure_ascii=False, indent=2))

    # ---- epigraph ----
    epi = open(os.path.join(book, "epigraph.md"), encoding="utf-8").read()
    open(os.path.join(base, "_epigraph.md"), "w", encoding="utf-8").write(epi)

    print("gen-blurb: wrote _blurb.md, _blurb.typ, _blurb.json, _epigraph.md")


if __name__ == "__main__":
    main()
