#!/usr/bin/env python3
"""Download an arXiv paper's PDF into the sources tree.

Downloads https://arxiv.org/pdf/<id> to <pdf-dir>/<id>-<slug>.pdf. Producing the
summary is a separate step — hand the downloaded PDF to the summarise-source
skill, which writes the study-guide summary to summaries/arXiv/<id>-<slug>.md.

Usage:
    fetch_arxiv.py 2201.11903 chain-of-thought
    fetch_arxiv.py 2201.11903 chain-of-thought --pdf-dir sources/arXiv
"""
import os, argparse, urllib.request


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("id", help="arXiv id, e.g. 2201.11903")
    ap.add_argument("slug", help="short kebab-case slug for the filename")
    ap.add_argument("--pdf-dir", default="sources/arXiv")
    a = ap.parse_args()

    os.makedirs(a.pdf_dir, exist_ok=True)

    pdf = os.path.join(a.pdf_dir, f"{a.id}-{a.slug}.pdf")
    req = urllib.request.Request(
        f"https://arxiv.org/pdf/{a.id}", headers={"User-Agent": "Mozilla/5.0"}
    )
    with urllib.request.urlopen(req) as r, open(pdf, "wb") as f:
        f.write(r.read())
    size = os.path.getsize(pdf) // 1024
    if size < 5:
        print(f"WARNING: {pdf} is only {size} KB — check the id / network")
    print(f"downloaded {pdf} ({size} KB)")
    print(f"next: run the summarise-source skill on {pdf} to write its summary")


if __name__ == "__main__":
    main()
