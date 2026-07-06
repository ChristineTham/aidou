---
name: summarise-source
description: >-
  Turn a downloaded source document into a dense, faithful study-guide summary in
  the repo's summaries/ folder. Use whenever the user wants to summarise, digest,
  condense, or write a Cliff's-Notes / study-guide version of a source in sources/
  (a Markdown file, an arXiv or other PDF, or any other downloaded document) — or
  wants to (re)generate, backfill, or refresh a file in summaries/. Trigger even if
  the user only names a file, a paper, or a topic under sources/ and asks to
  "summarise it", "write it up", "make a summary", or "create a dossier".
argument-hint: 'The source file (in sources/) to summarise.'
user-invocable: true
---

# summarise-source

Produce a **study-guide summary** of one source document and save it under `summaries/`,
mirroring where the source lives under `sources/`. The goal is a summary a reader can
study *instead of* the original for most purposes: dense with the source's actual content
(names, numbers, definitions, claims, arguments), faithful to its structure, and readable.

Each summary carries two layers, so it serves both quick reference and deep study — and fully
replaces the old short "dossier" format:

1. an up-front **Abstract** — a fast, dense digest of the key points and takeaways, readable in
   thirty seconds; and
2. the **body** — the full, structure-mirroring study guide beneath it.

The summary is built in three movements — a text pass, a diagram/table pass, then a
verification loop that hunts down and fixes gaps against the original. The loop is what
makes the output trustworthy: a first draft always misses things, so we check the summary
back against the source and repair it until nothing material is missing.

## Where things go

- **Input:** a file under `sources/<topic>/<name>.<ext>` (arXiv PDFs live in `sources/arXiv/`).
- **Output:** `summaries/<topic>/<name>.md` — the **same topic folder and stem**, always `.md`.
  Example: `sources/arXiv/2509.10970-psychogenic-machine.pdf` → `summaries/arXiv/2509.10970-psychogenic-machine.md`.
- Create the topic folder under `summaries/` if it does not exist.
- If a summary already exists at that path (e.g. an older short dossier), **supersede it** —
  but first read it and salvage anything not reconstructable from the source itself:
  the citation metadata (authors, date, venue, DOI) into the new header, **and** any
  hand-authored editorial notes the old file carries — e.g. a `## Relevance to the book`
  or `## Stance` section — by appending them, unchanged, at the end of the new summary
  under their own heading. Never lose the source citation or the author's own analysis.

## Step 0 — Locate and set up

1. Resolve the source path and compute the output path by the mirroring rule above.
2. If an old summary exists at the output path, read it and note any citation metadata worth keeping.
3. Read the source. For **PDFs**, use the Read tool with `pages` ranges (it renders each page,
   so you see text *and* figures); read the whole document in order, not just the abstract.
   If the Read tool cannot render the PDF (e.g. a missing system dependency like poppler),
   render its pages to images first — with `pymupdf`/`fitz` or `pdftoppm` — and read those.
   For **Markdown** web-scrapes, ignore boilerplate chrome (nav menus, "Edit this page",
   cookie notices, reference-list cruft) and work from the real content.

## Step 1 — First pass: the text summary

Summarise the **prose**. Deliberately set diagrams and figures aside for now (Step 2 handles
them) so this pass stays focused on capturing the argument and the facts.

Write it to the output path as GitHub-Flavoured Markdown, following these principles:

- **Mirror the source's structure.** Reproduce its chapter / section / subsection hierarchy as
  Markdown headings, in the same order. A reader should be able to map any part of your summary
  back to the original. Keep the source's own section titles where they are meaningful. If the
  source is loosely sectioned — an essay whose ending runs on with no headings, say — you may add
  your own reader-serving subheadings to group that content. That is *not* structural drift, as
  long as you keep the source's order and never reorder or relabel its real sections; drift means
  losing or scrambling the structure the source actually has.
- **Be dense, not vague.** Every sentence should carry information from the source. Preserve the
  *specifics* — key figures, percentages, dataset sizes, dates, proper nouns, defined terms,
  named methods, and the precise claim being made. Those specifics are the whole point of a study
  guide; a summary that drops them is just a blurb. Cut filler, hedging, and restatement, not facts.
- **Stay faithful.** Summarise what the source says; do not add claims, judgements, or outside
  knowledge it does not contain. If the source argues X, the summary says the source argues X —
  it does not silently agree or extend.
- **Make it scannable** in the Cliff's-Notes / study-guide idiom:
  - **Bullet lists** for enumerations, findings, steps, pros/cons.
  - **Markdown tables** for anything comparative or multi-dimensional (options, results by
    condition, definitions, timelines). Tables are the highest-density format — reach for them.
  - **Bold** the key term at the start of a definition or point.
  - **GFM Alerts** to call out asides, definitions, caveats, and key takeaways:
    - `> [!NOTE]` — a definition, clarification, or aside.
    - `> [!IMPORTANT]` — a central claim or the source's main thesis.
    - `> [!TIP]` — a practical takeaway or how-to.
    - `> [!WARNING]` / `> [!CAUTION]` — a limitation, risk, or caveat the source raises.
  - **Mermaid diagrams** where the source describes a process, flow, hierarchy, or relationship
    that a small diagram captures better than prose. Keep them simple and valid.

Open the file with the header template below, then the structured body.

### Header template

```markdown
# <Source title> — Summary

> [!NOTE]
> **Source:** [<original filename>](../../sources/<topic>/<filename>) · <authors/org, year> · <venue / DOI / URL if known>.
> Study-guide summary of the full document. See the original for exact wording and figures.

## Abstract

<1–2 sentences: what this document is and its central thesis.>

**Key points**

- <the main claims, findings, or arguments the source raises — the handful a reader must know>
- <keep the specifics: the decisive numbers, names, and definitions, not vague gestures>

**Takeaways**

- <the upshot: what to conclude, why it matters, what to do with it>

## <first real section of the source> ...
...structured body mirroring the source...
```

The `../../sources/<topic>/<filename>` link is a **relative link** from `summaries/<topic>/` to the
real source, so the summary always points back to what it summarises. Use the source's actual
filename and extension.

#### The Abstract is the "read this first" layer

Every summary opens with an **Abstract** — a quick, dense digest that stands on its own, so a hurried
reader can get the whole point in thirty seconds without scrolling the full guide. This is what makes
one summary serve two needs at once: the Abstract is the fast briefing, the body below is the deep study.
It replaces the old short "dossier" entirely — there is no separate dossier file any more.

- **Key points** are the source's main claims/findings — the same substance a one-paragraph briefing
  would carry. Keep the decisive specifics (the numbers and names that matter), not generic summary-speak.
- **Takeaways** are the *so what*: the conclusion to draw, why it matters, the practical implication.
- Write the Abstract **last or revise it last**, once the body and verification loop are done, so it
  reflects what the finished summary actually establishes.
- **Avoid a duplicate.** If the source is a paper that has its own "Abstract" section, do **not** also
  mirror that as a second `## Abstract` in the body — your top digest already covers it. Begin the body
  at the first substantive section (e.g. Introduction).

## Step 2 — Second pass: diagrams and tables

Now go back through the source and study its **figures, diagrams, charts, and tables** specifically —
the content Step 1 set aside. For each one:

- Read what it actually conveys (a data trend, an architecture, a process, a comparison, a taxonomy).
- Fold that information into the summary where it belongs, in whatever form serves the reader best:
  - a short **prose** explanation of what a figure shows and why it matters;
  - a **Markdown table** reproducing the essential rows/columns of a source table (not every cell —
    the ones that carry the finding);
  - a **re-created Mermaid diagram** when the source's diagram encodes a flow or structure worth
    preserving and Mermaid can express it faithfully.
- Capture the *information*, not the pixels: a chart showing "accuracy falls as context grows" becomes
  a sentence stating that, with the numbers if the source gives them.
- **Emphasis in reproduced tables:** mirror the source's own emphasis (e.g. a bolded best-in-column).
  If you add emphasis of your own, say so in a line above the table, so the reader never mistakes your
  annotation for the source's.

For PDFs, this means looking at the rendered figure pages; for Markdown, at embedded images, Mermaid
blocks, and Markdown tables in the source.

> [!NOTE]
> **If the source has no figures or diagrams** (many essays and web pages don't), this pass does not
> vanish — it becomes a *format-fit* review: reread the summary and convert any comparative or
> multi-dimensional prose into tables where that reads better, and add small Mermaid diagrams where a
> flow or hierarchy the source describes would land more clearly as a picture. The judgement of "what
> deserves a table" lives here, whether or not the source itself drew one.

## Step 3 — Verification loop (repair against the original)

A summary is only trustworthy once it has been checked back against the source. Compare your summary
to the original and repair it. Repeat this loop **until a pass finds nothing material to fix, or you
reach 10 iterations** — whichever comes first.

Each iteration:

1. **Build (or update) a coverage checklist** from the source: every section/heading, every key claim,
   every important figure/number, every defined term, every table/diagram's finding.
2. **Check the summary against it**, looking for:
   - **Omissions** — a section, argument, finding, or figure in the source that the summary skips.
   - **Inaccuracies** — a number, name, date, or claim the summary states differently from the source.
   - **Fabrications** — anything in the summary *not* supported by the source (drop or correct it).
   - **Structural drift** — the summary's order/hierarchy no longer tracks the source.
   - **Readability regressions** — bloat, repetition, or tables/alerts that would read better as prose
     (or vice versa).
   - **Abstract drift** — the up-front Abstract's key points and takeaways no longer match what the
     finished body establishes, or have gone vague. The Abstract must be a faithful, standalone digest
     of the whole summary.
3. **Fix** every issue found, editing the file in place.
4. If this pass found and fixed nothing material, **stop** — the summary has converged.

> [!IMPORTANT]
> Accuracy beats completeness beats polish, in that order. Never invent a number or a citation to fill
> a gap; if the source is genuinely silent on something, the summary is silent too. The loop exists to
> remove errors and omissions, not to pad length.

Briefly report the outcome: the output path, roughly how much of the source it covers, and how many
verification passes it took to converge.

## Handling long or awkward sources

- **Long PDFs (books, long papers):** read and summarise in sections, then do the diagram pass and the
  verification loop over the whole. A proportional, comprehensive summary is the goal — a long source
  earns a longer summary; do not truncate coverage to hit a length.
- **Messy Markdown scrapes:** strip site chrome first; if the "source" is mostly navigation with little
  content, say so rather than padding.
- **Non-text or unreadable sources:** if a file cannot be read (e.g. a binary with no text layer), stop
  and tell the user rather than guessing.
