#!/usr/bin/env python3
"""Add "List of Figures / Diagrams / Tables" pages to the generated ePub.

Quarto numbers figures, tables, and the custom "Diagram" float in the ePub
(e.g. `Figure 1.1:`, `Diagram 2.3:`, `Table 5.2:`) and anchors each one by its
crossref id — but it emits no lists. This post-render step parses those
captions out of the chapter XHTML, builds three linked list pages, registers
them in the OPF manifest + spine (right after the nav/Contents) and in the nav
ToC, and repackages the .epub (mimetype stored first, per spec).

Mirrors epub_backcover.py. Idempotent: does nothing if the lists are present.
Runs as a Quarto post-render step (after epub_fix / epub_backcover, before
cachebust). Runnable directly: `python3 epub_lists.py [output-dir]`.
"""
import os, re, sys, tempfile, zipfile

ACCENT = "#b565a7"
KIND = {"fig": "Figures", "dia": "Diagrams", "tbl": "Tables"}
EPUBTYPE = {"fig": "loi", "dia": "loi", "tbl": "lot"}
CAP = re.compile(
    r'<figcaption class="[^"]*quarto-float-(fig|dia|tbl)[^"]*"\s+'
    r'id="([a-z0-9-]+?)-caption-[^"]*">(.*?)</figcaption>', re.S)


def clean(html):
    """Caption inner HTML -> display string: drop tags, normalise whitespace,
    keep the non-breaking space between the word and its number."""
    t = re.sub(r"<[^>]+>", "", html)
    t = t.replace("\xa0", " ")
    return re.sub(r"\s+", " ", t).strip()


def page(kind, entries):
    lis = "\n".join(
        f'<li><a href="{href}">{txt}</a></li>' for href, txt in entries)
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="en-US" xml:lang="en-US">
<head>
  <meta charset="utf-8" />
  <title>{KIND[kind]}</title>
  <link rel="stylesheet" type="text/css" href="../styles/stylesheet1.css" />
  <style>
    ol.qlist {{ list-style: none; padding-left: 0; }}
    ol.qlist li {{ margin: 0.35em 0; }}
    ol.qlist a {{ text-decoration: none; }}
  </style>
</head>
<body epub:type="frontmatter">
<section epub:type="{EPUBTYPE[kind]}">
<h1 style="color:{ACCENT};">{KIND[kind]}</h1>
<ol class="qlist">
{lis}
</ol>
</section>
</body>
</html>
"""


def main():
    out = (sys.argv[1] if len(sys.argv) > 1
           else os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book"))
    epub = os.path.join(out, "ai-do.epub")
    if not os.path.isfile(epub):
        print("epub-lists: no ai-do.epub found; skipping", file=sys.stderr); return

    tmp = tempfile.mkdtemp()
    with zipfile.ZipFile(epub) as z:
        z.extractall(tmp)

    opf = next((os.path.join(r, fn) for r, _d, fs in os.walk(tmp)
                for fn in fs if fn.endswith(".opf")), None)
    if not opf:
        print("epub-lists: no .opf; skipping", file=sys.stderr); return
    opf_text = open(opf, encoding="utf-8").read()
    if "lof_xhtml" in opf_text:
        print("epub-lists: already present; skipping"); return

    text_dir = os.path.join(os.path.dirname(opf), "text")
    chapters = sorted(fn for fn in os.listdir(text_dir)
                      if re.fullmatch(r"ch\d+\.xhtml", fn))
    found = {"fig": [], "dia": [], "tbl": []}
    for fn in chapters:
        s = open(os.path.join(text_dir, fn), encoding="utf-8").read()
        for typ, label, caphtml in CAP.findall(s):
            found[typ].append((f"{fn}#{label}", clean(caphtml)))

    total = sum(len(v) for v in found.values())
    if total == 0:
        print("epub-lists: no captioned floats found; skipping"); return

    manifest, spine, naventries = [], [], []
    for kind in ("fig", "dia", "tbl"):
        if not found[kind]:
            continue
        slug = {"fig": "lof", "dia": "lod", "tbl": "lot"}[kind]
        open(os.path.join(text_dir, f"{slug}.xhtml"), "w", encoding="utf-8").write(
            page(kind, found[kind]))
        manifest.append(f'<item id="{slug}_xhtml" href="text/{slug}.xhtml" media-type="application/xhtml+xml" />')
        spine.append(f'<itemref idref="{slug}_xhtml" />')
        naventries.append(f'<li><a href="text/{slug}.xhtml">{KIND[kind]}</a></li>')

    opf_text = opf_text.replace("</manifest>", "  " + "\n  ".join(manifest) + "\n</manifest>", 1)
    # spine: place the lists right after the nav/Contents (else before chapter 1)
    m = re.search(r'<itemref idref="nav"\s*/>', opf_text)
    ins = "\n  " + "\n  ".join(spine)
    if m:
        opf_text = opf_text[:m.end()] + ins + opf_text[m.end():]
    else:
        opf_text = re.sub(r'(<itemref idref="ch)', ins.strip() + r"\n  \1", opf_text, count=1)
    open(opf, "w", encoding="utf-8").write(opf_text)

    # nav ToC: add the three entries after the first list item, if present
    nav = next((os.path.join(r, fn) for r, _d, fs in os.walk(tmp)
                for fn in fs if fn == "nav.xhtml"), None)
    if nav:
        nt = open(nav, encoding="utf-8").read()
        block = "\n" + "\n".join(naventries)
        m2 = re.search(r"</li>", nt)
        if m2:
            nt = nt[:m2.end()] + block + nt[m2.end():]
            open(nav, "w", encoding="utf-8").write(nt)

    tmpzip = epub + ".tmp"
    with zipfile.ZipFile(tmpzip, "w") as z:
        mt = os.path.join(tmp, "mimetype")
        if os.path.isfile(mt):
            z.write(mt, "mimetype", compress_type=zipfile.ZIP_STORED)
        for root, _d, files in os.walk(tmp):
            for fn in sorted(files):
                rel = os.path.relpath(os.path.join(root, fn), tmp)
                if rel == "mimetype":
                    continue
                z.write(os.path.join(root, fn), rel, compress_type=zipfile.ZIP_DEFLATED)
    os.replace(tmpzip, epub)
    print(f"epub-lists: added Figures ({len(found['fig'])}), "
          f"Diagrams ({len(found['dia'])}), Tables ({len(found['tbl'])})")


if __name__ == "__main__":
    main()
