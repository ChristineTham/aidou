---
name: enhance-book
description: >-
  Weave a source into the book — cite it and put its evidence to work in the chapters. Use whenever the
  user wants to add/integrate/cite a source into the book, or after summarise-source has written a summary.
  Given a summarised source (a file in summaries/, or a source the user names), it finds where the source
  belongs in book/*.md, adds an inline APA citation plus a References entry, and updates references.json.
  If the user names a section it focuses there; otherwise it finds the right place(s), which may be several.
  If the source is *already* cited, it finds every place the book uses it and reviews each citation against the
  (possibly newly regenerated) summary, tightening claims, numbers, placement, or citation form where the source
  now supports something better. If the source isn't relevant, or the point is already well covered by another
  source, it says so instead of forcing a cite.
argument-hint: 'A summary/source to integrate, and optionally the target section(s).'
user-invocable: true
---

# enhance-book

Put a source to work in the book: find where its evidence genuinely strengthens the argument, and cite it
there in the book's house style. The bar is *usefulness to the reader*, not adding another citation — a
source that isn't needed should be reported, not shoehorned in.

## Inputs

- A **source**, usually as its summary in `summaries/<topic>/<stem>.md` (read the **Abstract** first — its
  key points and takeaways tell you what the source can support, and its header carries the exact citation
  metadata). The user may instead name a raw source or URL; if so, skim it (or summarise it first with
  [[summarise-source]]).
- Optionally, **target section(s)** (e.g. "§3.4", "the harness section"). If given, focus there.

## Process

1. **Understand what the source establishes** — the specific, citable claims/figures from its Abstract and
   key points (read the summary's Abstract first). A source is only worth citing for a *particular* point.
2. **Find every place the source already appears.** Before adding anything, grep `references.json` and
   `book/*.md` for the source's **URL** (the most reliable key) and its **author–year**. This decides whether
   you are *adding* a citation or *reviewing* existing ones — and catches the common case where the book
   already leans on this exact source.
3. **If the source is already cited — review, don't duplicate.** Treat a fresh or enhanced summary as a chance
   to improve the *existing* citations, following *Reviewing an already-cited source* below. Add a new mention
   elsewhere only if the source genuinely supports a distinct claim the book has not already made.
4. **If the source is new — find the home(s).**
   - If the user named a section, work there.
   - Otherwise search `book/*.md` for the claim(s) this source supports and read the surrounding prose. There
     may be **several** good homes (corroborate one place, add a counterweight in another). List them first.
5. **Relevance gate — be willing to say no.** If the source is off-argument, or its point is already made and
   cited *by another source*, **stop and tell the user** which existing citation covers it. Over-citing dilutes
   the evidence and bloats the prose. "Not needed, already covered by [X]" is a good outcome.
6. **Weave it in, evidence-first.** Add the source where it earns its place, in the house voice
   ([[book-style]]): state the finding and let the citation support it, rather than name-dropping the paper.
   Keep the specific number/result that makes the source worth citing.
7. **Cite in the book's exact format** (see [[apa-citations]]):
   - **First mention in a chapter**: `[Author, *Exact Title*, Year](url)`.
   - **Later mentions in that chapter**: `[Author, Year](url)`.
   - Escape stray `$` as `\$` so Pandoc doesn't read math.
8. **Update the reference list and the map.**
   - Add the full APA entry to that chapter's `## References`, in alphabetical position.
   - Add/confirm the entry in `references.json` (repo root) so the citation↔source map stays complete.
9. **Verify.** The in-text citation resolves to a References entry; no orphan/dangling ref; the first-mention
   vs later-mention forms are right for that chapter. A build (`cd quarto && ./build.sh`) is the strongest
   check but optional for a small change.

## Reviewing an already-cited source

When the book already cites the source, a new or regenerated summary is a chance to make the *existing*
citations better — not to pile on more. Find **every** citation of the source (grep its URL across
`book/*.md`; the same source can appear in several chapters, each with its own first-mention). For each one,
read the sentence that cites it and compare it against the summary, looking for:

- **A sharper or corrected number/finding** — the summary surfaces a more precise or more decisive figure than
  the prose uses, or the prose misstates what the source actually found. Tighten it to match the source.
- **An overstated or understated claim** — the sentence leans harder than the source supports, or softer than
  it could. Bring the claim in line with what the summary establishes.
- **A better or additional home** — the source now looks like stronger support for a nearby claim, or supports
  a distinct point elsewhere that is unsupported or only weakly sourced. Move or add a mention *only* if it
  genuinely helps.
- **Citation-form errors** — first- vs later-mention is wrong (a first mention that lost its title, or a later
  one that repeats it), or the title/year in the link is stale against the summary header.

Apply the improvements you find. If a citation is already accurate, well-placed, and using the source's best
evidence, **say so and leave it** — the goal is a better book, not more edits.

## Output

Report, per source, which of three happened: **added** (where — chapter + section, first vs later mention —
plus the reference entry and `references.json` update); **reviewed** an already-cited source (what improved
across which citations — a number, a claim, placement, citation form — or that they were already sound); or
**declined** (why — off-topic, or already covered by which other citation).

## Rules

- Cite the **primary/original** source (arXiv `abs`, DOI, publisher page), never an internal file path.
- **Never invent** author, title, year, or a finding the source doesn't contain.
- One well-placed citation beats three; respect the chapter's existing first-mention/later-mention pattern.
- Don't restructure a chapter to fit a source — fit the source to the chapter, or report it doesn't fit.
