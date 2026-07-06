---
name: research-topic
description: >-
  End-to-end research pipeline for the book: take a topic all the way from discovery to integrated-and-cited.
  Use whenever the user wants to "research and add a topic", "find and integrate sources on X", "do a
  research pass on Y", or otherwise work a whole subject into the book. It orchestrates four sub-skills in
  order — search-topic (find sources) → download-source (fetch into sources/) → summarise-source (write each
  summary) → enhance-book (cite them into the chapters). Give it a topic, or just a section to enhance — with
  no topic it reads the section and derives the topics to research. It reuses sources already in the repo
  (refreshing any stale or dossier-style summary) as well as fetching new ones. Each sub-skill is also usable
  on its own; reach for this one when the user wants the full chain, not a single stage.
argument-hint: 'A topic to research, or a book section to enhance (topics are derived from it).'
user-invocable: true
---

# research-topic

The orchestrator. Turn a topic into downloaded sources, written summaries, and citations woven into the
book — by running the four sub-skills in sequence. Each stage is a standalone skill; this one wires them
together and keeps the run coherent.

## Pipeline

0. **Scope the topic(s).** If the user gave a topic, use it. If they gave only a **section** to enhance
   (e.g. "§2.7", "the harness section") and *no* topic, open that section, see what it argues and where it is
   thin or one-sidedly cited, and derive a short list of **suitable topics** for it — its key claims, the
   techniques or ideas it names, and any missing counterweight. Run the search on each. This is how a bare
   "enhance §2.7" becomes concrete research.

1. **Search** — run [[search-topic]] on each topic. It returns a ranked list of candidate sources (topic,
   title, type, year, URL, why-relevant) with a note on balance and gaps.

   > [!IMPORTANT]
   > **Checkpoint before the heavy steps.** Downloading, summarising, and — above all — *editing the
   > manuscript* for a batch of sources is substantial and changes the book. Show the user the source list
   > and get a go-ahead first, letting them prune it. Skip the checkpoint only if the user has said to run
   > the whole thing unattended.

2. **Reconcile with what the repo already has.** Do not treat every candidate as a fresh download — the book
   may already hold, or even cite, a matching source. Check `sources/` (grep `sources/arXiv/` by arXiv id;
   scan the relevant `sources/<topic>/` folders) and `references.json` for sources already on the topic. For
   each existing source you intend to use:
   - if it has **no summary** in `summaries/`, or the summary is an old **dossier** — short, missing the
     study-guide `## Abstract` + structure-mirroring body, or carrying `## Thesis` / `## Relevance to the
     book` / `## Stance` headings instead — **regenerate it with [[summarise-source]]**;
   - if it already has a proper study-guide summary, keep it.
   Carry these reused sources into the Enhance stage alongside the new ones. Drop candidates the repo already
   covers well from the download list.

3. **Download** — for each *new* approved source, run [[download-source]] → files land under `sources/` (arXiv
   papers as PDFs in `sources/arXiv/`, web pages as Markdown in `sources/<topic>/`, other PDFs in
   `sources/<topic>/`). Independent downloads can run in parallel.

4. **Summarise** — for each newly downloaded source, run [[summarise-source]] → a study-guide summary (with an
   up-front Abstract) in `summaries/`, linking back to the source. Parallel-safe. (Reused sources were already
   (re)summarised in step 2.)

5. **Enhance** — run [[enhance-book]] on **every** source, new *and* reused. For a new source it finds a home
   and cites it; for a source the book already cites, it reviews and improves the existing citations against
   the fresh summary. It may also report a source isn't needed.

   > [!WARNING]
   > **Serialise edits to the same chapter.** enhance-book edits `book/*.md` and `references.json`. Running
   > several in parallel on the *same* chapter will clobber each other. Group sources by the chapter they
   > land in and enhance each chapter's sources one at a time; different chapters can proceed in parallel.

6. **Report** — a table tying it together:

   | Source | New or reused | Summary | Outcome (added where / citations improved / skipped why) |
   |---|---|---|---|

## Running it well

- **Delegate the per-source work.** Downloading, summarising, and enhancing each source is independent
  work that suits subagents — fan out where the environment allows, honouring the same-chapter serialisation
  rule for the enhance stage.
- **Reuse before fetching.** The repo accumulates sources; a topic you research today may already be half
  covered, sometimes already cited. Step 2 is there so you refresh a stale/dossier summary and let enhance-book
  improve the existing citations, rather than re-downloading duplicates or piling a second citation on the same
  point.
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
