---
name: revise-chapter
description: >-
  Review and rewrite one whole chapter of the AI-dō book. USE WHEN the author
  names a chapter (e.g. "Chapter 1", "01-foundations") and wants the full pass:
  deepen every Level-2 section with fresh sources, revisit existing sources and
  summarise them, then rewrite the chapter in the current house style using all
  evidence — new and old. Orchestrates the deepen-section-research skill per
  section. DO NOT use for a single section (use deepen-section-research) or a
  quick copy-edit.
---

# Revise Chapter

End-to-end pass over one chapter: research every section, refresh all dossiers,
then rewrite. Do sections in order; keep all lint clean.

## 0. Constraints (read first)

- Read AGENTS.md and any /memories/repo/aidou-style notes before writing; the
  house style is the spec. Verify lint with `get_errors` after each file edit.
- Never fabricate. Cite every figure inline to its arxiv /abs or primary URL.
- One dossier per source; never group. Author is on Windows + proxy: `Invoke-WebRequest`
  works, `npm`/`npx` do not.

## 1. Scope the chapter

- List every `## ` section in `book/0N-*.md`. Note existing inline citations and
  the dossiers in `research/papers/` already backing them.

## 2. Deepen each section

- For each section, run the **deepen-section-research** skill: web-search (arxiv
  first), download PDFs, read full HTML, 2-level cite recursion, write per-source
  dossiers. Aim 3–6 strong sources per section.

## 3. Revisit existing sources

- For every source already cited, re-fetch and refresh its dossier: thesis,
  method, real result tables, key cited works, "use in book". Replace stubs and
  blog cites with peer-reviewed where possible.

## 4. Rewrite the chapter

- Rewrite in house style: first person (I/you/we), short 3–5-sentence paragraphs,
  one idea each; lead with an anecdote where it earns its place; explain mechanism
  before evidence; one paragraph per major source. Bullets/tables/mermaid/alerts
  where they aid scanning. Frame as philosophy, not a kit of methods.

## 5. Report

- Map evidence → section; list new vs refreshed dossiers; `get_errors` clean.
  Await go-ahead before deleting or renumbering anything.
