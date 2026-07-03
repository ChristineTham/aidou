#!/usr/bin/env python3
"""Build a single HTML and PDF from a book's Markdown chapters.

Pipeline: concatenate chapters -> Markdown to HTML (tables, fenced code, GFM
`> [!NOTE]`-style alerts) -> render Mermaid locally in a headless Chromium
browser -> print to PDF.

Portable and cross-platform: paths, chapter order, output name, and the browser
are all configurable, and the browser is auto-discovered on macOS, Linux, and
Windows.

  python build_pdf.py                      # book/ -> dist/AI-do.{html,pdf}
  python build_pdf.py --book book --dist dist --name AI-do
  python build_pdf.py --html-only          # skip the browser/PDF step
  python build_pdf.py --chapters 00-title.md,00-preface.md,01-foundations.md
  python build_pdf.py --browser "/path/to/chrome"

Requires the `markdown` and `beautifulsoup4` packages, and a Chromium-based
browser (Edge/Chrome/Chromium/Brave) unless --html-only.
"""
from __future__ import annotations
import argparse, os, re, shutil, ssl, subprocess, sys, urllib.request, html as htmllib
from pathlib import Path

MERMAID_URL = "https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"
ALERTS = {
    "NOTE": ("note", "Note"), "TIP": ("tip", "Tip"),
    "IMPORTANT": ("important", "Important"), "WARNING": ("warning", "Warning"),
    "CAUTION": ("caution", "Caution"),
}


def default_chapters(book: str) -> list[str]:
    """All *.md in the book dir (minus README), sorted, with any *title* first."""
    files = [f for f in sorted(os.listdir(book))
             if f.endswith(".md") and f.lower() != "readme.md"]
    titles = [f for f in files if "title" in f.lower()]
    return titles + [f for f in files if "title" not in f.lower()]


def fetch_mermaid(dest: str) -> None:
    if os.path.exists(dest) and os.path.getsize(dest) > 100_000:
        print("mermaid.min.js already present")
        return
    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    req = urllib.request.Request(MERMAID_URL, headers={"User-Agent": "Mozilla/5.0"})
    data = urllib.request.urlopen(req, context=ctx, timeout=60).read()
    with open(dest, "wb") as f:
        f.write(data)
    print(f"downloaded mermaid.min.js ({len(data)} bytes)")


def extract_mermaid(md: str, store: list[str]) -> str:
    def repl(m: re.Match) -> str:
        idx = len(store)
        store.append(m.group(1).strip())
        return f"\n\nxMERMAIDx{idx}x\n\n"
    return re.sub(r"```mermaid\s*\n(.*?)```", repl, md, flags=re.S)


def md_to_html(md: str) -> str:
    import markdown
    md = md.replace('<div align="center">', '<div align="center" markdown="1">')
    return markdown.markdown(
        md, extensions=["extra", "sane_lists", "md_in_html", "toc"],
        output_format="html5",
    )


def style_alerts(html_text: str) -> str:
    from bs4 import BeautifulSoup
    soup = BeautifulSoup(html_text, "html.parser")
    marker = re.compile(r"^\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*(<br\s*/?>)?\s*", re.I)
    for bq in soup.find_all("blockquote"):
        p = bq.find("p")
        if not p:
            continue
        inner = p.decode_contents()
        m = marker.match(inner)
        if not m:
            continue
        kind, label = ALERTS[m.group(1).upper()]
        bq["class"] = bq.get("class", []) + ["callout", f"callout-{kind}"]
        rest = marker.sub("", inner)
        if rest.strip():
            new_p = BeautifulSoup(f"<p>{rest}</p>", "html.parser")
            p.replace_with(new_p.p)
        else:
            p.decompose()
        title = soup.new_tag("p")
        title["class"] = "callout-title"
        title.string = label
        bq.insert(0, title)
    return str(soup)


def reinsert_mermaid(html_text: str, store: list[str]) -> str:
    for idx, code in enumerate(store):
        div = f'<div class="mermaid">{htmllib.escape(code)}</div>'
        html_text = re.sub(rf"<p>\s*xMERMAIDx{idx}x\s*</p>", div, html_text)
        html_text = html_text.replace(f"xMERMAIDx{idx}x", div)
    return html_text


def build_html(book: str, chapters: list[str], mermaid_local: str, name: str) -> str:
    sections = []
    for name_md in chapters:
        with open(os.path.join(book, name_md), encoding="utf-8") as f:
            md = f.read()
        store: list[str] = []
        md = extract_mermaid(md, store)
        body = md_to_html(md)
        body = reinsert_mermaid(body, store)
        body = style_alerts(body)
        sections.append(f'<section class="chapter">\n{body}\n</section>')
    mermaid_js = open(mermaid_local, encoding="utf-8").read()
    return (TEMPLATE.replace("__TITLE__", htmllib.escape(name))
            .replace("/*MERMAID*/", mermaid_js)
            .replace("<!--BODY-->", "\n".join(sections)))


TEMPLATE = r"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>__TITLE__</title>
<style>
  @page { size: A4; margin: 20mm 18mm; }
  html { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
  body {
    font-family: "Georgia", "Cambria", serif; font-size: 11pt; line-height: 1.55;
    color: #1a1a1a; max-width: 100%; margin: 0;
  }
  .chapter { page-break-before: always; }
  .chapter:first-of-type { page-break-before: avoid; }
  h1, h2, h3, h4 { font-family: "Segoe UI", "Helvetica", sans-serif; line-height: 1.25; color: #111; }
  h1 { font-size: 22pt; border-bottom: 2px solid #ccc; padding-bottom: .2em; }
  h2 { font-size: 16pt; margin-top: 1.4em; }
  h3 { font-size: 13pt; }
  h2, h3, h4 { page-break-after: avoid; }
  p { orphans: 2; widows: 2; }
  a { color: #1456b8; text-decoration: none; }
  code { font-family: "Consolas", "Menlo", monospace; font-size: .9em;
    background: #f3f3f3; padding: .1em .3em; border-radius: 3px; }
  pre { background: #f6f8fa; border: 1px solid #e1e4e8; border-radius: 6px;
    padding: 10px 12px; overflow: auto; page-break-inside: avoid; }
  pre code { background: none; padding: 0; }
  table { border-collapse: collapse; width: 100%; margin: 1em 0; font-size: 10pt;
    page-break-inside: avoid; }
  th, td { border: 1px solid #ccc; padding: 6px 9px; text-align: left; vertical-align: top; }
  thead th { background: #f0f2f4; }
  tbody tr:nth-child(even) { background: #fafafa; }
  blockquote { margin: 1em 0; padding: .4em 1em; border-left: 4px solid #ccc; color: #333; }
  .callout { border-left-width: 5px; border-radius: 4px; padding: .6em 1em;
    background: #f6f8fa; page-break-inside: avoid; }
  .callout-title { font-weight: 700; margin: 0 0 .3em; font-family: "Segoe UI", sans-serif;
    text-transform: uppercase; font-size: 9pt; letter-spacing: .04em; }
  .callout-note { border-left-color: #1f6feb; background: #eef4ff; }
  .callout-note .callout-title { color: #1f6feb; }
  .callout-tip { border-left-color: #1a7f37; background: #eafbef; }
  .callout-tip .callout-title { color: #1a7f37; }
  .callout-important { border-left-color: #8250df; background: #f6f0ff; }
  .callout-important .callout-title { color: #8250df; }
  .callout-warning { border-left-color: #bf8700; background: #fff8e6; }
  .callout-warning .callout-title { color: #9a6700; }
  .callout-caution { border-left-color: #cf222e; background: #fff0f0; }
  .callout-caution .callout-title { color: #cf222e; }
  .mermaid { text-align: center; margin: 1.2em 0; page-break-inside: avoid; }
  .mermaid svg { max-width: 100%; height: auto; }
  div[align="center"] h1 { border: none; font-size: 30pt; margin-bottom: .1em; }
  div[align="center"] h3 { color: #555; font-weight: 500; }
</style>
</head>
<body>
<!--BODY-->
<script>/*MERMAID*/</script>
<script>
  mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose",
    flowchart: { htmlLabels: true, useMaxWidth: true } });
</script>
</body>
</html>
"""


def find_browser(override: str | None) -> str:
    if override:
        return override
    if os.environ.get("BOOK_BUILD_BROWSER"):
        return os.environ["BOOK_BUILD_BROWSER"]
    for name in ("microsoft-edge", "microsoft-edge-stable", "google-chrome",
                 "google-chrome-stable", "chromium", "chromium-browser", "brave-browser"):
        p = shutil.which(name)
        if p:
            return p
    candidates = [
        "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
        "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
        r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    ]
    for c in candidates:
        if os.path.exists(c):
            return c
    raise FileNotFoundError(
        "No Chromium-based browser found (Edge/Chrome/Chromium/Brave). "
        "Pass --browser PATH or set BOOK_BUILD_BROWSER."
    )


def print_pdf(html_path: str, pdf_path: str, browser: str | None) -> None:
    exe = find_browser(browser)
    url = Path(html_path).resolve().as_uri()
    args = [
        exe, "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
        "--allow-file-access-from-files", "--run-all-compositor-stages-before-draw",
        "--virtual-time-budget=30000", f"--print-to-pdf={pdf_path}", url,
    ]
    print(f"rendering PDF with headless {os.path.basename(exe)} ...")
    subprocess.run(args, check=True, timeout=180)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--book", default="book", help="directory of chapter .md files")
    ap.add_argument("--dist", default="dist", help="output directory")
    ap.add_argument("--name", default="AI-do", help="output basename and <title>")
    ap.add_argument("--chapters", default=None,
                    help="comma-separated chapter filenames (default: auto-ordered)")
    ap.add_argument("--browser", default=None, help="path to a Chromium-based browser")
    ap.add_argument("--html-only", action="store_true", help="skip the PDF/browser step")
    a = ap.parse_args()

    os.makedirs(a.dist, exist_ok=True)
    chapters = a.chapters.split(",") if a.chapters else default_chapters(a.book)
    print(f"chapters: {', '.join(chapters)}")
    mermaid_local = os.path.join(a.dist, "mermaid.min.js")
    fetch_mermaid(mermaid_local)

    html_text = build_html(a.book, chapters, mermaid_local, a.name)
    html_path = os.path.join(a.dist, f"{a.name}.html")
    with open(html_path, "w", encoding="utf-8") as f:
        f.write(html_text)
    print(f"wrote {html_path} ({len(html_text)} bytes)")

    if a.html_only:
        print("--html-only: skipping PDF")
        return
    pdf_path = os.path.join(a.dist, f"{a.name}.pdf")
    print_pdf(html_path, pdf_path, a.browser)
    size = os.path.getsize(pdf_path) if os.path.exists(pdf_path) else 0
    print(f"wrote {pdf_path} ({size} bytes)")
    if not size:
        sys.exit("PDF was not produced")


if __name__ == "__main__":
    main()
