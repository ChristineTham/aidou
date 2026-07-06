#!/usr/bin/env python3
"""Convert saved HTML source files to rough Markdown (cross-platform).

Walks a directory for *.html and writes a sibling *.md: strips script/style/
head/nav/footer, turns headings, list items, paragraphs and line breaks into
Markdown, unescapes entities, and collapses whitespace. Meant for quickly
turning a fetched web/source page into readable notes — not a perfect converter.

By default the original .html is kept; pass --delete to remove it (the original
PowerShell version deleted by default).

Usage:
    html2md.py sources
    html2md.py research/raw --delete
"""
import argparse, html as htmllib, os, re


def convert(html: str) -> str:
    t = html
    for tag in ("script", "style", "head", "nav", "footer"):
        t = re.sub(rf"(?is)<{tag}.*?</{tag}>", "", t)
    t = re.sub(r"(?i)<h1[^>]*>", "\n# ", t)
    t = re.sub(r"(?i)<h2[^>]*>", "\n## ", t)
    t = re.sub(r"(?i)<h3[^>]*>", "\n### ", t)
    t = re.sub(r"(?i)<li[^>]*>", "\n- ", t)
    t = re.sub(r"(?i)</p>", "\n\n", t)
    t = re.sub(r"(?i)<br[^>]*>", "\n", t)
    t = re.sub(r"(?s)<[^>]+>", " ", t)
    t = htmllib.unescape(t)
    t = re.sub(r"[ \t]+", " ", t)
    t = re.sub(r"(\r?\n){3,}", "\n\n", t)
    return t.strip()


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("root", nargs="?", default="sources", help="directory to walk")
    ap.add_argument("--delete", action="store_true", help="remove the .html after converting")
    a = ap.parse_args()

    n = 0
    for dirpath, _dirs, files in os.walk(a.root):
        for fn in files:
            if not fn.lower().endswith(".html"):
                continue
            src = os.path.join(dirpath, fn)
            with open(src, encoding="utf-8", errors="ignore") as f:
                md = convert(f.read())
            out = os.path.splitext(src)[0] + ".md"
            with open(out, "w", encoding="utf-8") as f:
                f.write(md)
            if a.delete:
                os.remove(src)
            n += 1
            print(f"{src} -> {out}")
    print(f"converted {n} file(s)")


if __name__ == "__main__":
    main()
