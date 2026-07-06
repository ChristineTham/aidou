---
name: arxiv-research
description: 'Find, verify, download, and file research sources (especially arXiv papers) for the book. Searches for supporting work, confirms exact title/authors/year/DOI from the source, downloads the PDF, and writes a short dossier note in the repo convention. Use when researching a claim, sourcing evidence, or adding a citeable paper. Pairs with apa-citations.'
argument-hint: 'Give the claim to support, or an arXiv id + slug to fetch.'
user-invocable: true
---

# arXiv research & source processing

Turn a claim you want to support into a verified, filed, citeable source.

## Where things live

- `sources/arXiv/<id>-<slug>.pdf` — the downloaded PDF (all arXiv PDFs live here; other sources go in `sources/<topic>/`).
- `summaries/arXiv/<id>-<slug>.md` — a summary/dossier: title, source line (authors, date, venue/DOI), a short thesis, and why it matters to the book. It links to its PDF with a relative link (`../../sources/arXiv/<id>-<slug>.pdf`).
- Metadata from these summaries feeds [[apa-citations]] (`references.json`, at the repo root).

## Dossier format

```markdown
# Exact Paper Title

> Source: arXiv:2201.11903 (NeurIPS 2022). Wei, Wang, Schuurmans, … (Google). PDF in `pdf/2201.11903.pdf`.

## Thesis

Two or three sentences: method, the concrete result, the lesson.

## Relevance to the book

Which chapter/claim it supports, and the balance it adds.
```

## Workflow

1. **Search** for candidates (favour arXiv for downloadable PDFs; note the id). Look for a *counterweight* too — balance beats cheerleading.
2. **Verify** each paper's exact title, full author list, submission year, venue, and DOI from its abstract page (`https://arxiv.org/abs/<id>`). Never rely on a filename or a guess. For web/news sources, open the live page for the real headline and byline.
3. **Download + scaffold**:

   ```bash
   python scripts/fetch_arxiv.py 2201.11903 chain-of-thought
   ```

   Then fill the dossier's TITLE / DATE / AUTHORS and notes from what you verified.
4. **Cite** — add the source to `references.json` and weave it in with [[apa-citations]].

For non-arXiv sources you save as raw HTML, `scripts/html2md.py <dir>` converts them to rough Markdown notes (strips chrome, keeps headings/lists/paragraphs). Cross-platform; keeps the original unless you pass `--delete`.

## Rules

- **Never invent** authors, titles, years, or findings. If you cannot confirm a detail, fetch the source or leave it flagged.
- Cite the **original source** (arXiv `abs`, DOI, or the publisher page), not an internal download.
- Prefer the published venue where known; fall back to the arXiv preprint.

> [!TIP]
