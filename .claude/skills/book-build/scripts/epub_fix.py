#!/usr/bin/env python3
"""Repair malformed figure markup in the generated ePub.

Quarto emits Mermaid diagram figures as invalid XHTML — a bare `class`
attribute and a block <figure> illegally wrapped in <p>:

    <p><figure class></p> ... <p></figure></p>

That is not well-formed XML, so strict ePub 3 readers reject the file (and it
reflows badly). This rewrites those patterns into valid XHTML and repackages
the .epub (mimetype stored first, as the spec requires).

Runs as a Quarto post-render step (see _quarto.yml `project: post-render`);
Quarto passes the output dir in QUARTO_PROJECT_OUTPUT_DIR. Runnable directly:
`python3 epub_fix.py [output-dir]` (defaults to _book).
"""
import os
import re
import sys
import tempfile
import zipfile


def repair(html):
    html = html.replace("<figure class>", "<figure>")           # bare attribute
    html = re.sub(r"<p>(<figure[^>]*>)</p>", r"\1", html)        # unwrap figure open
    html = re.sub(r"<p>(</figure>)</p>", r"\1", html)            # unwrap figure close
    return html


def main():
    out = (
        sys.argv[1]
        if len(sys.argv) > 1
        else os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book")
    )
    epub = os.path.join(out, "ai-do.epub")
    if not os.path.isfile(epub):
        print("epub-fix: no ai-do.epub found; skipping", file=sys.stderr)
        return

    tmp = tempfile.mkdtemp()
    with zipfile.ZipFile(epub) as z:
        names = z.namelist()
        z.extractall(tmp)

    changed = 0
    for root, _dirs, files in os.walk(tmp):
        for fn in files:
            if not fn.endswith((".xhtml", ".html")):
                continue
            p = os.path.join(root, fn)
            with open(p, encoding="utf-8") as f:
                s = f.read()
            fixed = repair(s)
            if fixed != s:
                with open(p, "w", encoding="utf-8") as f:
                    f.write(fixed)
                changed += 1

    # Repackage: mimetype first and stored, everything else deflated.
    tmpzip = epub + ".tmp"
    with zipfile.ZipFile(tmpzip, "w") as z:
        mt = os.path.join(tmp, "mimetype")
        if os.path.isfile(mt):
            z.write(mt, "mimetype", compress_type=zipfile.ZIP_STORED)
        for name in names:
            if name == "mimetype":
                continue
            src = os.path.join(tmp, name)
            if os.path.isfile(src):
                z.write(src, name, compress_type=zipfile.ZIP_DEFLATED)
    os.replace(tmpzip, epub)
    print(f"epub-fix: repaired figure markup in {changed} XHTML file(s)")


if __name__ == "__main__":
    main()
