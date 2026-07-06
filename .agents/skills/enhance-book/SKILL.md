---
name: enhance-book
description: >-
  Weave a source into the book — cite it and put its evidence to work in the chapters. Use whenever the
  user wants to add/integrate/cite a source into the book, or after summarise-source has written a summary.
  Given a summarised source (a file in summaries/, or a source the user names), it finds where the source
  belongs in book/*.md, adds an inline APA citation plus a References entry, and updates references.json.
  If the user names a section it focuses there; otherwise it finds the right place(s), which may be several.
  If the source isn't relevant, or the point is already well covered, it says so instead of forcing a cite.
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
   key points. A source is only worth citing for a *particular* point.
2. **Find the home(s).**
   - If the user named a section, work there.
   - Otherwise search `book/*.md` for the claim(s) this source supports — grep for the relevant terms and
     read the surrounding prose. There may be **several** good homes (corroborating one place, adding a
     counterweight in another). List them before editing.
3. **Relevance gate — be willing to say no.** If the source is off-argument for the book, or the point is
   already made and cited, **stop and tell the user** which existing citation already covers it. Over-citing
   dilutes the evidence and bloats the prose. It is a good outcome to report "not needed, already covered by
   [X]".
4. **Weave it in, evidence-first.** Add the source where it earns its place, in the house voice
   ([[book-style]]): state the finding and let the citation support it, rather than name-dropping the paper.
   Keep the specific number/result that makes the source worth citing.
5. **Cite in the book's exact format** (see [[apa-citations]]):
   - **First mention in a chapter**: `[Author, *Exact Title*, Year](url)`.
   - **Later mentions in that chapter**: `[Author, Year](url)`.
   - Escape stray `$` as `\$` so Pandoc doesn't read math.
6. **Update the reference list and the map.**
   - Add the full APA entry to that chapter's `## References`, in alphabetical position.
   - Add/confirm the entry in `references.json` (repo root) so the citation↔source map stays complete.
7. **Verify.** The in-text citation resolves to a References entry; no orphan/dangling ref; the first-mention
   vs later-mention forms are right for that chapter. A build (`cd quarto && ./build.sh`) is the strongest
   check but optional for a small change.

## Output

Report, per source: where it was added (chapter + section, first vs later mention), the reference entry, and
the `references.json` update — or, if you declined, *why* (off-topic, or already covered by which citation).

## Rules

- Cite the **primary/original** source (arXiv `abs`, DOI, publisher page), never an internal file path.
- **Never invent** author, title, year, or a finding the source doesn't contain.
- One well-placed citation beats three; respect the chapter's existing first-mention/later-mention pattern.
- Don't restructure a chapter to fit a source — fit the source to the chapter, or report it doesn't fit.
