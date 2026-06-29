---
name: deepen-section-research
description: >-
  Deepen the research behind one Level-2 section of the AI-dō book. USE WHEN the
  author names a chapter section (an "## " heading) and wants more/better sources:
  search the web (prefer arxiv.org and primary sources), download each source as
  PDF, read the FULL paper (not the abstract), write a detailed per-source dossier
  with real result tables and 2-level citation recursion, and report which book
  edits the new evidence justifies. DO NOT use for general writing, single-file
  edits, or summarising one already-saved paper.
---

# Deepen Section Research

Workflow to enrich one book section with full-text, verifiable sources. Follow the
order; never skip the full-paper read or the PDF download.

## 0. Constraints (read first)

- Pull FULL papers via `arxiv.org/html/<id>vN`, not `/abs` (abstract only). Extract
  methodology, data, real result tables with numbers, conclusions, limitations.
- Download every source PDF; never store only a summary. Cite all; never invent figures.
- One dossier per source — never group sources. Recurse 2 levels into key citations.
- Author works on Windows, corporate proxy: file creation/edits and `Invoke-WebRequest`
  work; `npm`/`npx` do not. Run all GFM lint checks; keep blanks around headings/lists.

## 1. Scope the section

- Read the chosen `## ` heading and its prose in `book/0N-*.md`.
- List the claims that need evidence and the gaps. Note existing inline citations.

## 2. Find sources

- Web-search the section's claims; prefer arxiv.org, then primary docs (vendor system
  cards, standards bodies, peer-reviewed). Aim 3–6 strong sources per section.
- Record each as `<arxiv-id> short-title` or canonical URL.

## 3. Download PDFs

```powershell
$dir="research\papers\pdf"; New-Item -ItemType Directory -Force -Path $dir | Out-Null
foreach($id in "<id1>","<id2>"){ Invoke-WebRequest "https://arxiv.org/pdf/$id" -OutFile "$dir\$id.pdf" -TimeoutSec 60 }
```

## 4. Read full + recurse

- Fetch `arxiv.org/html/<id>vN`; capture sections, tables, conclusions, references.
- Fetch the 1–2 most-cited works each source leans on (2-level recursion).

## 5. Write dossiers

- One file per source: `research/papers/<id>-<slug>.md` — NOTE header (source/date/full-HTML),
  thesis, method, results table, key cited works, "use in book".

## 6. Rewrite the section

- Expand the section so each strong source gets its own paragraph: introduce the
  source, its method, its concrete numbers, and what it means for practice — depth
  over compression. Replace weak/blog stubs with the new peer-reviewed evidence.
- Keep voice per AGENTS.md: connected prose, lead-claim-then-develop, define terms
  once. Cite every figure inline to its arxiv/abs link; never group sources.

## 7. Report edits

- Map evidence → section, propose Enhanced/Used edits with justification; await go-ahead.
- After edits, `get_errors` for lint; keep all chapters clean.
