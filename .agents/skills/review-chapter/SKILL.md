---
name: review-chapter
description: >-
  Review a whole book chapter over several passes to get it publication-ready. Use whenever the user wants to
  review, polish, sanitise, finalise, proof, tighten, or "make publication-ready" a chapter or the preface —
  or names a chapter/section and asks to "clean it up", "do a pass on it", "get it ready to publish", or "check
  it over". It runs seven checks: grounded citations (every claim and quote traces to a cited primary source),
  definitions (key terms defined on first use — a GFM alert for the important ones, inline for the peripheral),
  thin sections (too few citations → research and thicken via research-topic), tables (prose that would scan
  better as a table), diagrams (relationships/processes worth a Mermaid figure), cross-chapter consistency
  (terms, citation labels, cross-references and claims kept in step with the rest of the book), and a final
  readability, consistency, Australian-spelling and flow pass. It audits first and shows you the findings for a go-ahead
  before applying fixes, because the fix stage edits the manuscript and may run research-topic. It composes
  research-topic, enhance-book, apa-citations, book-style and mermaid-diagrams; reach for it for a whole-chapter
  pass, not a single edit.
argument-hint: 'The chapter to review (file path, chapter number, or "preface").'
user-invocable: true
---

# review-chapter

Take one chapter (or the preface) from "drafted" to "publication-ready" in a disciplined sweep. The job is
not to rewrite the author's book — it is to *sanitise* it: ground every claim, define what needs defining,
shore up thin evidence, surface where a table or diagram would carry an idea better than prose, keep the
chapter in step with the rest of the book, and leave the text clean, consistent, and in Australian spelling.

This skill orchestrates the others rather than reinventing them. It reads the chapter several times with a
different lens each pass, collects what it finds, **shows you the findings and waits for a go-ahead**, then
applies the fixes through the specialist skills.

## Why audit before fixing

The fix stage edits `book/*.md` and `references.json`, and may run [[research-topic]] — which downloads
sources and cites them. That is a lot of change to set loose unattended. So the skill splits in two: a
read-only **audit** that produces a findings report, then — after you approve — a **fix** stage that works
through the list. You stay in control of what actually changes, and you can prune the list first.

One chapter at a time. A chapter is `book/0N-*.md` (or `book/00-preface.md`); the user may give the file,
the number ("chapter 1"), or "preface".

---

## Phase A — Audit (read-only, several passes)

Read the whole chapter once for sense before looking for faults — you cannot judge whether a section is
thinly cited or a term is defined late until you know where the argument is going. Then make these passes.
Record findings as you go; **change nothing yet**.

### 1. Grounded citations

Every claim, figure, statistic, and quotation should trace to a cited primary source. Go sentence by
sentence through the empirical content and flag:

- **Uncited specific claims** — a number, a named result, a "studies show", a direct quote with no citation.
- **Citations that don't resolve** — an in-text `[Author, Year](url)` with no matching `## References` entry,
  or a dead/placeholder link. (The [[apa-citations]] audit script catches these mechanically — run it.)
- **Vague, unfalsifiable claims** — "many teams find…", "it's well known that…" — that assert something
  citable but name no source. These are the ones to substantiate, not just decorate.

For each, note the fix in the report: *find a primary source and cite it* (a specific claim with an obvious
source), or *research to substantiate* (a vague claim needing evidence — a [[research-topic]] run), or
*soften/qualify* (a claim that can't be grounded and should be hedged rather than dropped). Never invent a
citation to make a sentence look sourced.

### 2. Definitions

A reader should never meet a term before it is explained. On the **first** use of each technical term, decide:

- **Important and recurring** (central to the book — e.g. *context window*, *agent*, *harness*) → it earns a
  `> [!NOTE]` definition alert, so it stands out and can be found again.
- **Peripheral and used once** → define it inline, in a clause, and move on. A callout for a throwaway term
  is clutter.

Flag terms used before they're defined, defined twice, or used undefined. Note which treatment each needs.

### 3. Thin sections

A substantive section resting on a single source — or on none — is thin, especially where it makes empirical
or contested claims. (This is exactly what §2.3 and §2.7 looked like before their research passes.) Flag any
section that carries real weight on too little evidence, and note it for a [[research-topic]] run scoped to
that section — which will find primaries *and* a counterweight, not just pile on citations. Don't flag a
section that is deliberately brief or is narrative rather than evidential.

### 4. Table opportunities

Look for prose that is really a table in disguise: a run of options each with the same attributes, a
before/after or this-vs-that contrast, a set of results with shared dimensions, a list of tools with roles.
These scan far better as a Markdown table. Note the passage and the columns a table would have. Be
selective — a table earns its place by making a comparison legible, not by existing.

### 5. Diagram opportunities

Look for a **relationship or process** described in prose that a small figure would make clearer: a pipeline,
a control loop, a hierarchy, a state machine, a set of components and how they connect. Note the passage and
what kind of Mermaid diagram fits (flowchart, sequence, state, …). Again, be selective — one good figure
beats three decorative ones, and the book's style is restraint.

### 6. Readability, consistency, spelling, flow

The finishing pass. Part of it is mechanical — do those parts *by tool, not by eye*, because a read-through
reliably misses a lone `judgment` among a dozen `judgement`s, or a single reference filed out of order. Reading
for these does not work; grepping does.

- **Australian/British spelling — grep, don't eyeball.** This book uses Australian English (*-ise* not *-ize*,
  *-our*, *-re*, *-lled*, *catalogue*, *judgement*, *towards*, *analogue*, *licence*/*practise* as nouns). Run
  `scripts/check_australian_spelling.py <chapter>` — it lists every candidate with a line number. Triage each:
  fix the prose ones; **leave** anything inside a quoted paper title, a proper name, or a code identifier
  verbatim (a cited title's American spelling *is* the title). The script over-reports on purpose — a false
  positive you dismiss is far cheaper than a real slip that ships.
- **Citation & reference consistency — reconcile, don't sample.** Run the [[apa-citations]] audit, then check
  three things it is easy to miss by eye: the `## References` list is in **alphabetical order** (a single
  out-of-place entry hides well in a long list); the in-text citation count and the reference-list count
  **reconcile** (no silent orphan or duplicate); and first-mention-with-title vs later-mention-plain is right
  for each source.
- **Other consistency** — a term spelled or capitalised two ways, heading numbering out of sequence (see
  [[heading-numbering]]), inconsistent list/callout style, or a mixed numeral convention ("seventy per cent"
  in one section vs "88%" in another — flag it and let the author pick, since a register shift may be
  deliberate).
- **Readability** — sentences stacking three-plus clauses (the book's style is one idea per sentence; see
  [[book-style]] and run its prose linter), paragraphs that sprawl, jargon that could be plainer.
- **Flow** — abrupt transitions, a section that doesn't connect to the next, a missing look-back where a dense
  stretch needs one.

### 7. Cross-chapter consistency

Checks 1–6 look *within* the chapter; this one looks *across* the book. The book is read as a whole, yet each
chapter also resets its own reference list and its first-mentions so it can be read alone — so some things must
stay consistent between chapters even though those two things reset by design. Read the chapter under review
against the other `book/*.md` files and against the book-wide citation map (`references.json`), and flag:

- **Terminology drift.** A term should be defined *once*, in the earliest chapter that needs it, and used the
  same way after. If Chapter 1 already gives *harness* a `> [!NOTE]`, this chapter should lean on it, not
  redefine it — a second, differently-worded definition confuses the reader; a second identical one is clutter.
  Cross-reference instead. Also flag a term spelled or capitalised two ways across chapters (*vibe coding* vs
  *vibe-coding*, *context window* vs *context-window*). Grep the term across `book/*.md` to see every use.
- **Citation-label drift.** `references.json` is the book-wide source↔citation map, so it is the arbiter here.
  The same source must carry the *same* author–year label and the *same* URL in every chapter, and
  same-author-same-year works must use the *same* disambiguation letters (`2026a`/`2026b`) book-wide.
  First-mention-with-title resets per chapter — that is correct, leave it — but the title and year inside the
  link must agree across chapters. Reconcile against `references.json` (and [[apa-citations]]), not chapter by
  chapter.
- **Broken cross-references.** "As Chapter 2 showed…", "Chapter 4 covers this" must name the right chapter
  *and* the target must actually cover it. Chapter numbers and titles referenced in prose must match the real
  ones. Reordered or renamed chapters leave dangling pointers — a common, easy-to-miss defect.
- **Contradictory claims.** A figure, definition, or stance here should not contradict how another chapter
  states it — the same statistic quoted two ways, a caveat that is firm in one chapter and softened in another.
  Flag the contradiction and align both to the source.
- **Duplicated ownership.** A concept another chapter *owns* and develops should be cross-referenced here, not
  re-explained from scratch. Flag heavy duplication and name the chapter that owns it.
- **Convention drift.** Numeral style, the spelling standard, the heading-numbering scheme, and callout/table
  conventions should match the rest of the book, not just be internally consistent within this chapter.

Cross-chapter fixes often touch *two* files (move a definition earlier, correct a back-reference, realign a
label). Note both the chapter under review and the other chapter in the finding, so the fix stage knows it is a
two-file edit — and remember the same-chapter serialisation rule when applying them.

---

## Checkpoint — show the findings, get a go-ahead

Present the audit as a prioritised report before touching anything. Use this shape:

```
# Review audit — <chapter>

## 1. Grounded citations
- [§X.Y] <claim/quote> — <uncited | unresolved | vague> → <find & cite | research | qualify>
## 2. Definitions
- [§X.Y] <term> — first use <undefined | late | duplicated> → <GFM alert | inline>
## 3. Thin sections
- [§X.Y] <section> rests on <N> source(s) → research-topic to thicken
## 4. Table opportunities
- [§X.Y] <passage> → table of <columns>
## 5. Diagram opportunities
- [§X.Y] <passage> → <flowchart | sequence | …>
## 6. Readability / consistency / spelling / flow
- [§X.Y] <issue> → <fix>
## 7. Cross-chapter consistency
- [§X.Y ↔ Ch N] <term / label / cross-ref / claim> — <drift/contradiction> → <fix, noting both files>

## Proposed plan
<what you'll do, in order; which items need research-topic (downloads + edits); anything you'd leave alone>
```

Then stop and ask which items to action. Let the user prune — some "opportunities" they'll want to keep as
prose, some thin sections they'll leave brief by choice. **Do not proceed to Phase B without a go-ahead**
(unless the user said up front to run it all unattended). If you're running as a subagent with no user to
answer, stop here — the report *is* the deliverable.

---

## Phase B — Fix (only after go-ahead)

Work the approved list through the specialist skills. Order matters: add and ground content first, then
structure it, then polish — so the final readability pass sees the finished text.

1. **Ground citations.** For a specific uncited claim with a clear source, cite it via [[enhance-book]]
   (which finds the home and adds the APA citation + reference entry + `references.json`). For a vague claim
   needing evidence, or a thin section, run [[research-topic]] scoped to that section — it searches, downloads,
   summarises, and cites, checkpointing on its own source list. For a claim that can't be grounded, qualify it.
2. **Definitions.** Add `> [!NOTE]` alerts for the important first-use terms; fold peripheral ones into an
   inline clause. Keep the voice plain ([[book-style]]).
3. **Tables.** Convert the flagged passages, keeping the prose lead-in that says why the table matters.
4. **Diagrams.** Add the flagged figures as ```mermaid blocks per [[mermaid-diagrams]] — the build injects the
   book's Rosely theme, so keep the source clean and valid; describe the figure in a sentence before it.
5. **Cross-chapter consistency.** Apply the check-7 fixes: align a drifted term (or replace a duplicate
   definition with a cross-reference to the chapter that owns it), correct a broken "see Chapter N" pointer,
   and reconcile any citation label against `references.json` via [[apa-citations]]. Prefer the smallest edit
   that removes the drift, and lean on the earliest-chapter-owns-the-definition rule. Where a fix also touches
   *another* chapter, make that edit too — but one file at a time (see the warning).
6. **Final pass.** Fix readability, consistency, Australian spelling, and flow across the *whole* chapter,
   including everything you just added. Run the [[book-style]] prose linter and the [[apa-citations]] audit.

> [!WARNING]
> **Serialise edits, and mind research-topic's own checkpoint.** All of this edits the same chapter file, so
> do it in sequence, not in parallel. A cross-chapter fix may edit a *second* file — do those one at a time
> too, and don't run another chapter's review in parallel over the same files. If a step calls
> [[research-topic]], it will pause on its own source-list checkpoint — carry that back to the user rather than
> auto-approving.

## Verify

- The [[apa-citations]] audit passes: every in-text citation resolves; no orphan references; first- vs
  later-mention forms correct.
- `scripts/check_australian_spelling.py <chapter>` comes back clean apart from quoted-title/code candidates;
  the reference list is alphabetical and reconciles with the in-text count; terms are consistent.
- Cross-chapter: any citation label you touched still agrees with `references.json` and its other-chapter uses;
  cross-references point to the right chapter; a moved definition didn't leave a dangling reference behind.
- Any Mermaid blocks are syntactically valid.
- A build is the strongest check: `cd quarto && ./build.sh`. Run it if the changes were substantial.

## Report

Summarise what changed, grouped by the seven checks: citations grounded (which claims, which sources),
definitions added (which terms, which treatment), sections thickened (which, how many new sources), tables
and diagrams added (where), cross-chapter fixes (which terms/labels/references realigned, and any second file
touched), and the readability/spelling fixes made. List anything you deliberately left for the author to
decide.

## Rules

- **Audit before editing; get a go-ahead.** The report is the contract for what changes.
- **Never invent a citation, author, title, year, or finding** to make a claim look grounded. If it can't be
  sourced, qualify it or flag it — don't fabricate.
- **Restraint over volume.** The bar for a new citation, table, or diagram is that it helps the reader, not
  that it can be added. Respect enhance-book / research-topic declining a source that isn't needed.
- **Don't rewrite the author's argument.** Sanitise and strengthen what's there; fit fixes to the chapter,
  not the chapter to the fixes. Preserve the author's voice and any deliberate choices.
- **One chapter per run**, so the audit and the checkpoint stay legible.
