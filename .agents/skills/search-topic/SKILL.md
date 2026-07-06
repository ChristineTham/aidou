---
name: search-topic
description: >-
  Do deep research on a topic and return a curated list of sources relevant to the book.
  Use whenever the user wants to find or research sources on a subject — "find papers on X",
  "what's the research on Y", "search for sources about Z", "any good sources on ...". Prioritises
  arXiv and other academic/primary sources but also returns Wikipedia (definitions/history),
  analyst and industry reports, and reputable blog/news articles. Returns a ranked list (topic,
  title, type, year, URL, why-relevant) — it does NOT download; pair with download-source next.
argument-hint: 'The topic or claim to research for the book.'
user-invocable: true
---

# search-topic

Given a topic, find the sources worth pulling into the book and hand back a clean, actionable list.
This is the *discovery* stage — no downloading, no writing. The output is a shortlist a human (or the
`research-topic` orchestrator) can act on.

The book is **AI-dō**, a practical, evidence-led guide to working with AI; it favours **primary sources**
(it has deliberately replaced encyclopedia citations with primary ones) and values **balance** over
cheerleading. Search with that in mind.

## What to return

A Markdown table, most-relevant first:

| Topic | Title | Type | Year | URL | Why relevant |
|---|---|---|---|---|---|

- **Topic** — the `sources/` topic folder it maps to (an existing one where it fits; otherwise propose a
  new kebab-case topic name and say it's new). Existing topics include `llm-foundations`, `ai-landscape`,
  `agent-architecture`, `agent-security`, `spec-vs-vibe`, `ai-coding`, `code-quality`, `memory-context`,
  `knowledge-work`, `personal-productivity`, `ambient-agents`, `agent-disciplines`, `governance-law`,
  `human-ai-future`, `mastery-improvement`, `philosophy-ethics`, `software-engineering`.
- **Type** — `arXiv`, `journal/conference`, `analyst report`, `wikipedia`, `blog/news`, `docs`.
- **URL** — the canonical link: arXiv `abs` page, DOI, or the publisher/original page. For arXiv, note the id.
- **Why relevant** — one line: the claim it supports or the balance it adds.

Below the table, add a short note on **coverage and balance**: which angle each cluster of sources takes,
whether you found a genuine counterweight, and any gap the search did not fill.

## How to search

1. **Frame the topic** against the book: which chapter/theme does it serve, and what claim is it meant to
   support or challenge? A sharper frame gives sharper results.
2. **Search broadly**, then rank by quality and fit. Priority order:
   - **arXiv and peer-reviewed / conference papers** — primary evidence; prefer these. Capture the arXiv id.
   - **Analyst and industry reports** (Stanford HAI AI Index, McKinsey, Deloitte, State-of-AI) — for
     adoption/economics claims.
   - **Primary/official pages** (lab blogs, standards bodies, product docs) — for what a lab/tool actually says.
   - **Wikipedia** — only for definitions, history, or orientation, not as evidence for a contested claim.
   - **Reputable blog/news** — practitioner writing, journalism; use with care and prefer the primary it cites.
3. **Verify the essentials at the source**: exact title, author/org, year, canonical URL. Never rely on a
   search snippet or a guessed author list.
4. **Seek a counterweight.** If the topic is contested (most are), deliberately look for a source that
   complicates or opposes the majority view — balance beats a one-sided pile.
5. **Filter hard.** Drop SEO filler, content farms, and thin restatements. Prefer the primary over anything
   that merely quotes it. Flag paywalled or hard-to-download items so download-source knows.
6. **Note likely overlap.** If a candidate looks already covered in the book (the point is already cited),
   say so — the reader may not need it.

## Rules

- **Never invent** a title, author, year, or URL. If you cannot confirm it, fetch the page or leave it flagged.
- Prefer the **published venue** where one exists; fall back to the arXiv/preprint link.
- Relevance to *this book* is the bar, not general interest — a great paper off-topic for AI-dō is a no.
