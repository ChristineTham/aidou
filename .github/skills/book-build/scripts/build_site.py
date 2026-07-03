#!/usr/bin/env python3
"""Generate Quarto chapter pages from the book's Markdown (single source).

Reads the canonical chapters in `book/*.md` and writes Quarto `.qmd` pages into
the Quarto project directory, applying the transforms that make them render
cleanly to HTML + PDF (Typst) + ePub:

  * the leading `# ` heading becomes the page title (frontmatter); for the
    preface it becomes an unnumbered inline H1 so Quarto numbers the six
    chapters 1..6 and leaves the preface unnumbered;
  * our manual `1.1` / `1.2.1` section numbers are stripped so Quarto numbers
    natively (consistent across all three formats, with working cross-refs);
  * `## References` is marked `{.unnumbered}`;
  * GitHub alerts (`> [!NOTE]`) become native Quarto callouts (`::: {.callout-note}`);
  * ```mermaid fences become executable ```{mermaid} cells with an init that
    disables HTML labels (so the ePub SVG is self-contained vector, and the
    PDF PNG renders cleanly).

`book/*.md` is never modified. Run it directly, or let Quarto's `pre-render`
hook call it before every render/preview.

Usage:
    build_site.py --book ../book --out .        # from the quarto/ project dir
    build_site.py --book book --out quarto       # from the repo root
"""
import argparse, os, re

# source filename -> (output slug, numbered?)
CHAPTERS = [
    ("00-preface.md", "preface", False),
    ("01-foundations.md", "foundations", True),
    ("02-productivity.md", "productivity", True),
    ("03-software-development.md", "software-development", True),
    ("04-engineering-disciplines.md", "engineering-disciplines", True),
    ("05-governance.md", "governance", True),
    ("06-mastery.md", "mastery", True),
]
ALERT = {"NOTE": "note", "TIP": "tip", "IMPORTANT": "important",
         "WARNING": "warning", "CAUTION": "caution"}
MERMAID_INIT = '%%{init: {"theme":"neutral","flowchart":{"htmlLabels":false}}}%%'
CHAPTER_PREFIX = re.compile(r"^Chapter\s+\d+\s*[—–-]\s*")


def convert_alerts(lines):
    out, i = [], 0
    while i < len(lines):
        m = re.match(r"^>\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*(.*)$", lines[i])
        if not m:
            out.append(lines[i]); i += 1; continue
        body = [m.group(2).strip()] if m.group(2).strip() else []
        i += 1
        while i < len(lines) and lines[i].startswith(">"):
            body.append(re.sub(r"^>\s?", "", lines[i])); i += 1
        while body and not body[0].strip():
            body.pop(0)
        while body and not body[-1].strip():
            body.pop()
        out.append("::: {.callout-" + ALERT[m.group(1)] + "}")
        out.extend(body)
        out.append(":::")
    return out


def mermaid_cells(lines):
    out = []
    for l in lines:
        if re.match(r"^```mermaid\s*$", l):
            out.append("```{mermaid}")
            out.append(MERMAID_INIT)
        else:
            out.append(l)
    return out


def strip_section_number(l):
    m = re.match(r"^(#{2,3}) \d+(?:\.\d+)* (.*)$", l)
    return (m.group(1) + " " + m.group(2)) if m else l


def build(book_dir, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    for src, slug, numbered in CHAPTERS:
        path = os.path.join(book_dir, src)
        if not os.path.exists(path):
            print(f"skip (missing): {path}")
            continue
        lines = open(path, encoding="utf-8").read().split("\n")
        h1 = next(i for i, l in enumerate(lines) if l.startswith("# "))
        title = lines[h1][2:].strip()
        body = lines[:h1] + lines[h1 + 1:]
        body = convert_alerts(body)
        body = mermaid_cells(body)
        body = [strip_section_number(l) for l in body]
        body = [re.sub(r"^## References\s*$", "## References {.unnumbered}", l) for l in body]
        text = "\n".join(body).lstrip("\n")
        if numbered:
            head = '---\ntitle: "' + CHAPTER_PREFIX.sub("", title) + '"\n---\n\n'
        else:
            head = "# " + title + " {.unnumbered}\n\n"
        with open(os.path.join(out_dir, slug + ".qmd"), "w", encoding="utf-8") as f:
            f.write(head + text + "\n")
        print(f"{src} -> {os.path.join(out_dir, slug + '.qmd')}")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--book", default="../book", help="directory of source chapter .md files")
    ap.add_argument("--out", default=".", help="Quarto project directory to write .qmd into")
    a = ap.parse_args()
    build(a.book, a.out)


if __name__ == "__main__":
    main()
