---
name: apa-citations
description: 'Apply and audit APA 7 citations across a Markdown book. Rewrites in-text citations to hyperlinked author–year (author + title on first mention, plain on later mentions), regenerates a per-chapter References section, and audits for internal-download links, orphans, and broken link text. Use when adding or reformatting citations, adding a source, or building the reference lists.'
argument-hint: 'Name the Markdown files to process and the references JSON, or the source to add.'
user-invocable: true
---

# APA 7 citations & references

Turns loosely-labelled Markdown links into consistent APA 7 citations and per-chapter reference lists, from a single portable source list. Built for the AI-dō book but data-driven, so it works for any Markdown project.

## Conventions

- **In-text = hyperlinked author–year.** The visible text is `Author, Year`; the link points to the **original source** (URL, DOI, or arXiv `abs` link) — never an internal download.
- **First mention in a chapter names the author and _title_**: `([Wolfram, *What is ChatGPT doing … and why does it work?*, 2023](url))`. Later mentions in the same chapter are plain: `([Wolfram, 2023](url))`.
- **Title-authored works** (Wikipedia pages, etc.) keep their short quoted form on every mention.
- **Same author, same year** → disambiguate with letters (`2026a`, `2026b`) kept consistent book-wide.
- **Every chapter (and the preface) ends with `## References`** — full APA 7 entries, alphabetised, URL/DOI shown and clickable.
- Prefer the published venue where known; fall back to arXiv/preprint. Get author lists, titles, years, and DOIs from the source itself (arXiv abstract page, the dossier notes, or the live web page) — never invent them.

## Source list — `references.json`

The project keeps one JSON file at the repo root (`references.json`). Each entry:

```json
{
  "urls": ["https://arxiv.org/abs/2201.11903"],
  "intext": "Wei et al., 2022a",
  "reference": "Wei, J., Wang, X., … (2022a). *Chain-of-thought prompting elicits reasoning in large language models*. Advances in Neural Information Processing Systems. [https://arxiv.org/abs/2201.11903](https://arxiv.org/abs/2201.11903)",
  "title_authored": false
}
```

- `urls` — one or more; several URLs may map to the same reference (dedupes in the list).
- `intext` — the short `Author, Year` label (include the disambiguation letter).
- `reference` — the full APA entry; the **title must be the first `*italic*` span** (the engine lifts it for the first-mention label). End with a clickable `[url](url)`.
- `title_authored` — `true` for Wikipedia/title-as-author works so first mention is not re-titled.

To add a source: append an entry, then re-run the engine.

## Scripts

- **`scripts/apply_citations.py`** — rewrite in-text citations and regenerate References. Idempotent; only link text changes.

  ```bash
  python scripts/apply_citations.py --refs references.json book/00-preface.md book/0[1-6]*.md
  ```

- **`scripts/audit_citations.py`** — advisory checks: internal-download links, in-text↔References mismatches, brackets in link text.

  ```bash
  python scripts/audit_citations.py book/0[1-6]*.md
  ```

## Workflow

1. Confirm each source's metadata (see [[arxiv-research]] for papers; fetch the live page for web/news titles and bylines).
2. Add or update its entry in `references.json`.
3. Write the citation inline as `([Author, Year](url))` with the exact source URL.
4. Run `apply_citations.py` to normalise first-mention titles and rebuild References.
5. Run `audit_citations.py` and clear any flags.

> [!TIP]
