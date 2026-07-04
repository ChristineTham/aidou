#!/usr/bin/env python3
"""Inject a back-cover page at the end of the generated ePub.

Quarto/Pandoc gives an ePub a front cover but no back cover. This adds a final
XHTML page carrying the blurb, registers it in the OPF manifest and at the end
of the spine, and repackages the .epub (mimetype stored first, per spec).

Idempotent: if the back cover is already present it does nothing. Runs as a
Quarto post-render step (see _quarto.yml `project: post-render`), after
epub_fix.py and before cachebust.py. Runnable directly:
`python3 epub_backcover.py [output-dir]` (defaults to _book).
"""
import os
import sys
import tempfile
import zipfile

BACKCOVER = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="en-US" xml:lang="en-US">
<head>
  <meta charset="utf-8" />
  <title>About this book</title>
  <link rel="stylesheet" type="text/css" href="../styles/stylesheet1.css" />
</head>
<body epub:type="afterword">
<section class="backcover" style="border-left:3px solid #f7caca; background:#faf5f2; border-radius:0 8px 8px 0; padding:1em 1.1em;">
<h1 style="color:#b565a7; margin-top:0;">AI-dō</h1>
<p style="font-style:italic; color:#85677b; margin-top:-0.4em;">The Way of AI, grounded in practice (道)</p>
<p>Most AI writing sells tools, prompts, and features. Those go stale in a release. <em>AI-dō</em> is about what lasts underneath — how you frame a problem, gather context, and verify a result.</p>
<ul>
<li><strong style="color:#b565a7;">Method over model</strong> — the advantage is the scaffolding you build, not the model you pick.</li>
<li><strong style="color:#b565a7;">Discipline over hacks</strong> — repeatable patterns, not one-off prompts.</li>
<li><strong style="color:#b565a7;">Augmentation, not replacement</strong> — AI to extend human judgement, never to outsource it.</li>
</ul>
<p>Written first-person by a former sceptic, with every claim cited to a primary source. Each chapter reads like a good textbook: state the idea, show why it holds, then prove it with a real example. It is for thoughtful professionals and engineers who want a durable practice, not a bag of prompts — a practice guide, not a reference manual.</p>
<hr />
<p style="color:#615f5f;"><strong>Chris Tham</strong> · Hello Tham<br />Read online, or get the PDF and ePub: <a href="https://christham.net/aidou">christham.net/aidou</a></p>
</section>
</body>
</html>
"""


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

    # Write the back-cover page next to the other text documents.
    text_dir = os.path.join(os.path.dirname(opf), "text")
    os.makedirs(text_dir, exist_ok=True)
    with open(os.path.join(text_dir, "backcover.xhtml"), "w", encoding="utf-8") as f:
        f.write(BACKCOVER)

    # Register in the manifest and at the end of the spine.
    item = '<item id="backcover_xhtml" href="text/backcover.xhtml" media-type="application/xhtml+xml" />'
    ref = '<itemref idref="backcover_xhtml" />'
    opf_text = opf_text.replace("</manifest>", f"  {item}\n</manifest>", 1)
    opf_text = opf_text.replace("</spine>", f"  {ref}\n</spine>", 1)
    with open(opf, "w", encoding="utf-8") as f:
        f.write(opf_text)

    # Repackage: mimetype first and stored, everything else deflated.
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
    print("epub-backcover: injected back-cover page")


if __name__ == "__main__":
    main()
