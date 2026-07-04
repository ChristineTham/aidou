#!/usr/bin/env python3
"""Generate per-format blurb snippets from the single source `blurb.json`.

The book blurb ("why read it" / back-cover copy) is authored once in
`quarto/blurb.json`. This writes the format-specific partials the render
consumes:

  - `_blurb.md`  — Markdown, `{{< include >}}`-d by the web landing (index.qmd).
  - `_blurb.typ` — Typst, `#include`-d by the PDF back cover (typst-back-cover.typ).

The ePub back-cover page and the ePub description are built separately by
epub_backcover.py, which reads the same `blurb.json`.

Runs as a Quarto `project: pre-render` step (cwd = the project dir). Runnable
directly: `python3 gen_blurb.py [project-dir]` (defaults to `.`). Underscore-
prefixed outputs are ignored by Quarto as input documents.
"""
import json
import os
import re
import sys

PURPLE = '#b565a7'


def emph_md(s):
    return s  # already Markdown


def emph_typ(s):
    return re.sub(r"\*([^*]+)\*", r"#emph[\1]", s)


def main():
    base = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("QUARTO_PROJECT_DIR", ".")
    with open(os.path.join(base, "blurb.json"), encoding="utf-8") as f:
        b = json.load(f)
    lead, close, cons = b["lead"], b["close"], b["convictions"]

    # --- Markdown (web landing) ---
    md = [emph_md(lead), ""]
    md += [f"- **{c['label']}** — {c['text']}" for c in cons]
    md += ["", emph_md(close), ""]
    with open(os.path.join(base, "_blurb.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(md))

    # --- Typst (PDF back cover) ---
    items = ",\n".join(
        f'    [#text(weight: "bold", fill: rgb("{PURPLE}"))[{c["label"]}] — {emph_typ(c["text"])}]'
        for c in cons
    )
    typ = f"""{emph_typ(lead)}

#v(0.9em)

#stack(spacing: 0.6em,
{items},
)

#v(0.9em)

{emph_typ(close)}
"""
    with open(os.path.join(base, "_blurb.typ"), "w", encoding="utf-8") as f:
        f.write(typ)

    print("gen-blurb: wrote _blurb.md and _blurb.typ")


if __name__ == "__main__":
    main()
