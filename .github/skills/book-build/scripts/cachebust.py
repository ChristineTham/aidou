#!/usr/bin/env python3
"""Cache-bust the PDF/ePub download links after a Quarto render.

GitHub Pages serves the book's PDF and ePub at stable URLs (ai-do.pdf,
ai-do.epub). Browsers and the Pages CDN cache those, so a reader who has
downloaded once keeps getting the old file after a redeploy. We append a
short content-hash query (?v=<hash>) to every link: the URL changes only
when the file's bytes change, so a fresh build always yields a fresh URL
and a stale cache can never match.

Run as a Quarto post-render step (see _quarto.yml `project: post-render`);
Quarto passes the output dir in QUARTO_PROJECT_OUTPUT_DIR. Runnable directly
too: `python3 cachebust.py [output-dir]` (defaults to _book).
"""
import hashlib
import os
import re
import sys

ASSETS = ("ai-do.pdf", "ai-do.epub")


def short_hash(path):
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(65536), b""):
            h.update(chunk)
    return h.hexdigest()[:10]


def main():
    out = (
        sys.argv[1]
        if len(sys.argv) > 1
        else os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book")
    )
    if not os.path.isdir(out):
        print(f"cachebust: output dir '{out}' not found; skipping", file=sys.stderr)
        return

    versions = {}
    for name in ASSETS:
        p = os.path.join(out, name)
        if os.path.isfile(p):
            versions[name] = short_hash(p)
    if not versions:
        print("cachebust: no PDF/ePub found; skipping", file=sys.stderr)
        return

    # For each asset, rewrite `name` (optionally already carrying ?v=...) when it
    # is immediately followed by a quote, so we only touch real href/src links.
    patterns = {
        name: re.compile(re.escape(name) + r"(?:\?v=[0-9a-f]+)?(?=[\"'])")
        for name in versions
    }

    changed = 0
    for root, _dirs, files in os.walk(out):
        for fn in files:
            if not fn.endswith(".html"):
                continue
            fp = os.path.join(root, fn)
            with open(fp, encoding="utf-8") as f:
                html = f.read()
            new = html
            for name, ver in versions.items():
                new = patterns[name].sub(f"{name}?v={ver}", new)
            if new != html:
                with open(fp, "w", encoding="utf-8") as f:
                    f.write(new)
                changed += 1

    stamped = ", ".join(f"{n}?v={v}" for n, v in versions.items())
    print(f"cachebust: stamped {stamped} across {changed} HTML file(s)")


if __name__ == "__main__":
    main()
