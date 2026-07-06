# AGENTS.md — Rules for Writing AI-dō

Guidelines for any AI agent (or human) drafting this book.

## Skills

- Reusable skills live **once**, under **`.agents/skills/`** (the vendor-neutral [Agent Skills](https://agentskills.io) `SKILL.md` standard). This is the single source of truth — do not create a second copy.
- Discovery: **Copilot** and **Antigravity** read `.agents/skills/` natively; **Claude Code** only scans `.claude/skills/`, so `.claude/skills` is a symlink to `../.agents/skills`. Editing a skill in `.agents/skills/` updates it for every tool at once.
- The book build calls skill scripts by their real path, e.g. `.agents/skills/book-build/scripts/build_site.py` (see `quarto/build.sh` and `.github/workflows/deploy.yml`).
- Subagent definitions are *not* skills and stay tool-specific: `.claude/agents/*.md` (Claude Code) and `.github/agents/*.agent.md` (Copilot).

## Structure

- 6 chapters; former chapters are now sections. Keep it that way.
- **Number section headings.** H2 sections are numbered `N.M` (chapter.section, e.g. `## 1.2 Mental Models for AI`) and H3 subsections `N.M.K` (e.g. `### 2.2.1 …`). The chapter `# ` title and the `## References` section stay unnumbered; the preface is front matter and stays unnumbered. Renumber if sections are added, removed, or reordered.
- Each section flows through principle → why it matters → practice → pitfalls, mostly as connected prose. Use bullet lists where they genuinely aid scanning, not as a default.
- Always review sources before writing

## Audience

- Write for a well-educated general reader (master's level), not specifically an engineer. Assume curiosity, numeracy, and patience, not a CS degree.
- They can read code and an arXiv paper if asked, and bring consultant-grade judgement; they do not live in a terminal. Lead with ideas, treat code/jargon as optional depth.
- Reach for everyday and cross-disciplinary metaphors (craft, music, navigation, the professions) over engineering-internal ones. Define any technical term plainly on first use.

## Style

The model to imitate is Kernighan & Pike's *The Unix Programming Environment* (a full copy is at `sources/software-engineering/unix-programming-environment.md` — read a few pages when in doubt). Its hallmarks are plainness, mechanism over metaphor, understatement, and worked examples that carry the argument. Also in the tradition: Kernighan & Ritchie's *C* and Knuth's *TAOCP*. Teach, don't summarise; be a professor who is warm and exact but never chatty. No pep, no hype, no hand-holding. Natural contractions are welcome.

- **One idea per sentence; keep sentences short.** Two clauses is usually the limit. When a sentence stacks three or more clauses joined by dashes and semicolons, break it into two or three plain sentences. Kernighan & Pike almost never run a sentence past two clauses, and neither should we. This is the single biggest lever for sounding like the model.
- **Explain the mechanism, plainly.** State how the thing actually works before the evidence: the idea, the intuition for why it holds, then the example or number that proves it. The reader should finish understanding *why*, not just *that*. Prefer a direct description of the mechanism ("the kernel moves the data through the pipe") to an image that stands in for it.
- **Metaphor is rare and functional.** Reach for one only when it makes an idea clearer or more memorable, and keep it to a phrase, not a set piece. Cut showy closings and "clever" flourishes — the courtier, the parlour game, the stagecraft. If a reader has to decode the metaphor before the point, cut it. State the point and stop.
- **Understatement over flourish.** Make the claim and let it stand; don't reach for a rhetorical peak to end a paragraph. Be frank about limits and imperfection — name what doesn't work — and never sell. A dry, quiet wit is welcome; exclamation and drama are not.
- **Prefer the plainest precise word.** Choose the simplest wording that stays exact: "explains" not "glosses", "a trick" not "stagecraft", "the main limit" not "the binding constraint". Spell a term out in full on first use ("large language model", not "model") where it helps a non-specialist. This is not a licence to dumb down — keep the right technical terms — only to drop ornamentation that adds nothing.
- **Let real examples carry the argument.** Prefer concrete, tested, real examples over invented or abstract ones; give the specifics, because the specifics are the argument (the three projects in Chapter 3 are the model). Favour a short worked example over a paragraph of abstraction.
- **Use numbered enumerations for principles and summaries.** When drawing several lessons together, count them out — "First… Second… Third…" — as Kernighan & Pike do in their look-backs. It is clearer and more memorable than a run of prose.
- **Pose a question, then answer it directly.** "What makes this work? Three things." is a good shape for opening a hard topic.
- **Close a dense stretch with a brief look back.** Where a section has covered a lot, restate plainly what was shown and draw the lesson, then move on.
- Build ideas in order — each concept rests on the previous one, so a careful reader never meets a term before it is defined. Introduce each major source in its own paragraph: name it, explain its method, give the concrete result, draw the lesson. Give credit to the people behind ideas by name.
- Keep paragraphs short — three to five sentences, one idea each. Break long stretches into multiple paragraphs so the page stays easy to read.
- Stay dense but unhurried: every sentence earns its place, yet leave room to develop a point fully. Lead with a clear claim, then develop it. Bullet lists are welcome for steps, options, or contrasts — keep ideas balanced and skimmable.
- Use GitHub-Flavored Markdown: `> [!NOTE]`/`> [!TIP]`/`> [!IMPORTANT]` alerts for asides and definitions, tables for complex breakdowns, ```mermaid diagrams for relationships, fenced code with a language. No H1 inside chapters.

## Voice

- The seasoned professor: curious, precise, generous. Confident without showing off, never selling. Trust the reader's intelligence; respect their time.
- First person — "I" for the author, "you" for the reader, "we" when reasoning together. Open sections with a short, concrete anecdote where it earns its place.
- Human-centred (愛), disciplined (道). Augmentation, not replacement.
- Methodology over hacks; repeatable patterns over one-off prompts.

## Accuracy

- **Never hallucinate.** No invented facts, stats, dates, or quotes.
- **Always cite sources.** Every claim, figure, or quote links to its origin.
- **Citation style is APA 7.** In-text citations are hyperlinked, pointing to the original source (URL, DOI, or arXiv link), never an internal download. Disambiguate same-author-same-year works with letters (`2026a`, `2026b`, …) consistently across the book.
  - **First mention of a source in a chapter names the author and title**, then the year: `([Wolfram, *What is ChatGPT doing … and why does it work?*, 2023](url))`. The title is italicised. First-mention resets per chapter (each chapter has its own reference list and may be read on its own).
  - **Subsequent mentions of the same source in that chapter use plain author–year**: `([Wolfram, 2023](url))`.
  - Title-authored works (e.g. Wikipedia pages) keep their short quoted form on every mention, since the author already is the title.
  - Every chapter (and the preface) ends with a `## References` section: full APA 7 entries, alphabetised, with the URL/DOI shown and clickable. Prefer the published venue where known; fall back to arXiv/preprint otherwise.
  - Source metadata (authors, titles, venues, DOIs) comes from the `summaries/**/*.md` dossier headers; verify web/news titles and bylines against the live page before citing. Never invent an author list or title.
- **Research before writing.** Read official/primary sources first; assume internal knowledge is stale.
- Mark anything uncertain as a draft assumption; do not present it as fact.

## Collaboration

- **Grill the author when unsure.** Ask before guessing intent, scope, or facts.
- Confirm restructuring before renumbering or deleting chapters.

## Sources so far

Downloaded research is organised into three repo-root folders:

- **`sources/`** — original downloaded sources (PDF or converted Markdown), by **topic** (not by chapter, since a source may serve several). All arXiv PDFs live in `sources/arXiv/`; other sources sit in topic folders (`llm-foundations/`, `agent-architecture/`, `spec-vs-vibe/`, …).
- **`summaries/`** — one Markdown summary/dossier per source, mirroring the `sources/` topic folders (arXiv summaries in `summaries/arXiv/`). Each links to its source with a relative link.
- **`misc/`** — meta and working files that are not sources (walkthroughs, plans, images, author notes). `misc/research.md` has the original link list.

The citation↔source mapping is `references.json` at the repo root (used by [[apa-citations]]).
