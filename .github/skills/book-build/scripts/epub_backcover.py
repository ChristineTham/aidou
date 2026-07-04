#!/usr/bin/env python3
"""Inject a back-cover page (and set the description) in the generated ePub.

Quarto/Pandoc gives an ePub a front cover but no back cover. This adds a final
XHTML page carrying the blurb, registers it in the OPF manifest and at the end
of the spine, sets the ePub `<dc:description>`, and repackages the .epub
(mimetype stored first, per spec).

Blurb text comes from `_blurb.json`, generated pre-render by gen_blurb.py from
the editable source `book/blurb.md` — edit there, not here. Idempotent: does
nothing if the back cover is already present.
Runs as a Quarto post-render step (see _quarto.yml `project: post-render`),
after epub_fix.py and before cachebust.py. Runnable directly:
`python3 epub_backcover.py [output-dir]` (defaults to _book).
"""
import json
import os
import re
import sys
import tempfile
import zipfile

PURPLE = "#b565a7"


def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def emph_html(s):
    return re.sub(r"\*([^*]+)\*", r"<em>\1</em>", esc(s))


def load_blurb():
    base = os.environ.get("QUARTO_PROJECT_DIR", ".")
    for cand in (os.path.join(base, "_blurb.json"), "_blurb.json",
                 os.path.join(os.path.dirname(__file__), "..", "..", "..", "..", "quarto", "_blurb.json")):
        if os.path.isfile(cand):
            with open(cand, encoding="utf-8") as f:
                return json.load(f)
    raise FileNotFoundError("_blurb.json not found (run gen_blurb.py first)")


def backcover_xhtml(b):
    items = "\n".join(
        f'<li><strong style="color:{PURPLE};">{esc(c["label"])}</strong> — {emph_html(c["text"])}</li>'
        for c in b["convictions"]
    )
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="en-US" xml:lang="en-US">
<head>
  <meta charset="utf-8" />
  <title>About this book</title>
  <link rel="stylesheet" type="text/css" href="../styles/stylesheet1.css" />
</head>
<body epub:type="afterword">
<section class="backcover" style="border-left:3px solid #f7caca; background:#faf5f2; border-radius:0 8px 8px 0; padding:1em 1.1em;">
<h1 style="color:{PURPLE}; margin-top:0;">AI-dō</h1>
<p style="font-style:italic; color:#85677b; margin-top:-0.4em;">The Way of AI, grounded in practice (道)</p>
<p>{emph_html(b["lead"])}</p>
<ul>
{items}
</ul>
<p>{emph_html(b["close"])}</p>
<hr />
<p style="color:#615f5f;"><strong>Chris Tham</strong> · Hello Tham<br />Read online, or get the PDF and ePub: <a href="https://christham.net/aidou">christham.net/aidou</a></p>
</section>
</body>
</html>
"""


def set_description(opf, desc):
    d = esc(desc)
    if re.search(r"<dc:description>.*?</dc:description>", opf, re.S):
        return re.sub(r"<dc:description>.*?</dc:description>",
                      f"<dc:description>{d}</dc:description>", opf, count=1, flags=re.S)
    return opf.replace("</metadata>", f"  <dc:description>{d}</dc:description>\n</metadata>", 1)


def main():
    out = (
        sys.argv[1]
        if len(sys.argv) > 1
        else os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book")
    )
    epub = os.path.join(out, "ai-do.epub")
    if not os.path.isfile(epub):
        print("epub-backcover: no ai-do.epub found; skipping", file=sys.stderr)
        return

    b = load_blurb()

    tmp = tempfile.mkdtemp()
    with zipfile.ZipFile(epub) as z:
        z.extractall(tmp)

    opf = None
    for root, _dirs, files in os.walk(tmp):
        for fn in files:
            if fn.endswith(".opf"):
                opf = os.path.join(root, fn)
    if not opf:
        print("epub-backcover: no .opf found; skipping", file=sys.stderr)
        return

    with open(opf, encoding="utf-8") as f:
        opf_text = f.read()
    if "backcover_xhtml" in opf_text:
        print("epub-backcover: already present; skipping")
        return

    text_dir = os.path.join(os.path.dirname(opf), "text")
    os.makedirs(text_dir, exist_ok=True)
    with open(os.path.join(text_dir, "backcover.xhtml"), "w", encoding="utf-8") as f:
        f.write(backcover_xhtml(b))

    item = '<item id="backcover_xhtml" href="text/backcover.xhtml" media-type="application/xhtml+xml" />'
    ref = '<itemref idref="backcover_xhtml" />'
    opf_text = opf_text.replace("</manifest>", f"  {item}\n</manifest>", 1)
    opf_text = opf_text.replace("</spine>", f"  {ref}\n</spine>", 1)
    opf_text = set_description(opf_text, b["description"])
    with open(opf, "w", encoding="utf-8") as f:
        f.write(opf_text)

    tmpzip = epub + ".tmp"
    with zipfile.ZipFile(tmpzip, "w") as z:
        mt = os.path.join(tmp, "mimetype")
        if os.path.isfile(mt):
            z.write(mt, "mimetype", compress_type=zipfile.ZIP_STORED)
        for root, _dirs, files in os.walk(tmp):
            for fn in sorted(files):
                full = os.path.join(root, fn)
                rel = os.path.relpath(full, tmp)
                if rel == "mimetype":
                    continue
                z.write(full, rel, compress_type=zipfile.ZIP_DEFLATED)
    os.replace(tmpzip, epub)
    print("epub-backcover: injected back-cover page and set description")


if __name__ == "__main__":
    main()
