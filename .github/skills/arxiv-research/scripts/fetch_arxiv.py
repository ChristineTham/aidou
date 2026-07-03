#!/usr/bin/env python3
"""Download an arXiv paper's PDF and scaffold a dossier note.

Downloads https://arxiv.org/pdf/<id> to <pdf-dir>/<id>.pdf and, unless it
already exists, writes a dossier stub <dossier-dir>/<id>-<slug>.md using the
repo's standard header. Fill the TITLE / DATE / AUTHORS and the notes from the
paper's abstract page (https://arxiv.org/abs/<id>) — do not guess them.

Usage:
    fetch_arxiv.py 2201.11903 chain-of-thought
    fetch_arxiv.py 2201.11903 chain-of-thought --pdf-dir research/papers/pdf \\
                   --dossier-dir research/papers
"""
import os, argparse, urllib.request


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("id", help="arXiv id, e.g. 2201.11903")
    ap.add_argument("slug", help="short kebab-case slug for the filename")
    ap.add_argument("--pdf-dir", default="research/papers/pdf")
    ap.add_argument("--dossier-dir", default="research/papers")
    a = ap.parse_args()

    os.makedirs(a.pdf_dir, exist_ok=True)
    os.makedirs(a.dossier_dir, exist_ok=True)

    pdf = os.path.join(a.pdf_dir, f"{a.id}.pdf")
    req = urllib.request.Request(
        f"https://arxiv.org/pdf/{a.id}", headers={"User-Agent": "Mozilla/5.0"}
    )
    with urllib.request.urlopen(req) as r, open(pdf, "wb") as f:
        f.write(r.read())
    size = os.path.getsize(pdf) // 1024
    if size < 5:
        print(f"WARNING: {pdf} is only {size} KB — check the id / network")
    print(f"downloaded {pdf} ({size} KB)")

    dossier = os.path.join(a.dossier_dir, f"{a.id}-{a.slug}.md")
    if os.path.exists(dossier):
        print(f"dossier exists (left unchanged): {dossier}")
        return
    with open(dossier, "w", encoding="utf-8") as f:
        f.write(
            f"""# TITLE

> Source: arXiv:{a.id} (DATE). AUTHORS. PDF in `pdf/{a.id}.pdf`.

## Thesis

...

## Relevance to the book

...
"""
        )
    print(f"scaffolded {dossier} — fill TITLE/DATE/AUTHORS from arxiv.org/abs/{a.id}")


if __name__ == "__main__":
    main()
