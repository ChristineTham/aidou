---
name: research-topic
description: >-
  End-to-end research pipeline for the book: take a topic all the way from discovery to integrated-and-cited.
  Use whenever the user wants to "research and add a topic", "find and integrate sources on X", "do a
  research pass on Y", or otherwise work a whole subject into the book. It orchestrates four sub-skills in
  order — search-topic (find sources) → download-source (fetch into sources/) → summarise-source (write each
  summary) → enhance-book (cite them into the chapters). Each sub-skill is also usable on its own; reach for
  this one when the user wants the full chain, not a single stage.
argument-hint: 'The topic to research and integrate into the book.'
user-invocable: true
---

# research-topic

The orchestrator. Turn a topic into downloaded sources, written summaries, and citations woven into the
book — by running the four sub-skills in sequence. Each stage is a standalone skill; this one wires them
together and keeps the run coherent.

## Pipeline

1. **Search** — run [[search-topic]] on the topic. It returns a ranked list of candidate sources (topic,
   title, type, year, URL, why-relevant) with a note on balance and gaps.

   > [!IMPORTANT]
   > **Checkpoint before the heavy steps.** Downloading, summarising, and — above all — *editing the
   > manuscript* for a batch of sources is substantial and changes the book. Show the user the source list
   > and get a go-ahead first, letting them prune it. Skip the checkpoint only if the user has said to run
   > the whole thing unattended.

2. **Download** — for each approved source, run [[download-source]] → files land under `sources/` (arXiv
   papers as PDFs in `sources/arXiv/`, web pages as Markdown in `sources/<topic>/`, other PDFs in
   `sources/<topic>/`). Independent downloads can run in parallel.

3. **Summarise** — for each downloaded source, run [[summarise-source]] → a study-guide summary (with an
   up-front Abstract) in `summaries/`, linking back to the source. Independent summaries can run in parallel.

4. **Enhance** — for each source, run [[enhance-book]] to cite it where it fits in the book (or to report it
   isn't needed).

   > [!WARNING]
   > **Serialise edits to the same chapter.** enhance-book edits `book/*.md` and `references.json`. Running
   > several in parallel on the *same* chapter will clobber each other. Group sources by the chapter they
   > land in and enhance each chapter's sources one at a time; different chapters can proceed in parallel.

5. **Report** — a table tying it together:

   | Source | Downloaded to | Summary | Added to book (or skipped, why) |
   |---|---|---|---|

## Running it well

- **Delegate the per-source work.** Downloading, summarising, and enhancing each source is independent
  work that suits subagents — fan out where the environment allows, honouring the same-chapter serialisation
  rule for the enhance stage.
- **Keep balance.** search-topic already looks for a counterweight; carry that through — the goal is a
  well-evidenced, balanced topic, not the largest pile of citations.
- **Scale to intent.** A quick "find me a source or two on X" is a short run; "thoroughly research and
  integrate X" is a big one. Match the effort to what the user asked for, and don't over-cite (enhance-book
  will decline sources that aren't needed — respect that).
- **Partial runs are fine.** Because each stage is its own skill, the user can stop after search (just a
  shortlist), after summarise (sources filed and digested but not yet cited), or run a single stage directly.

## Rules

- Verify metadata at the source (titles, authors, years) — this flows into citations; never guess.
- Prefer primary sources; cite the original, not an internal file.
- Don't edit the manuscript without the user's go-ahead on the source list (the Step 1 checkpoint).
