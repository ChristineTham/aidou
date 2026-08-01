# AGENTS.md — Rules for Writing AI-dō

Guidelines for any AI agent (or human) drafting this book.

## Skills

- Reusable skills live **once**, under **`.agents/skills/`** (the vendor-neutral [Agent Skills](https://agentskills.io) `SKILL.md` standard). This is the single source of truth — do not create a second copy.
- Discovery: **Copilot** and **Antigravity** read `.agents/skills/` natively; **Claude Code** only scans `.claude/skills/`, so `.claude/skills` is a symlink to `../.agents/skills`. Editing a skill in `.agents/skills/` updates it for every tool at once.
- The book build calls skill scripts by their real path, e.g. `.agents/skills/book-build/scripts/build_site.py` (see `quarto/build.sh` and `.github/workflows/deploy.yml`).
- Subagent definitions are *not* skills and stay tool-specific: `.claude/agents/*.md` (Claude Code) and `.github/agents/*.agent.md` (Copilot).

### Skill catalogue

All skills live in `.agents/skills/<name>/SKILL.md`, grouped by what they do:

**Research pipeline** — compose in this order; each also runs on its own:

- **research-topic** — orchestrator: take a topic through the whole chain (search → download → summarise → enhance).
- **search-topic** — deep-research a topic; return a ranked shortlist of candidate sources (no download).
- **download-source** — fetch a source into `sources/` (arXiv → PDF in `sources/arXiv/`; web pages → Markdown in `sources/<topic>/`).
- **summarise-source** — write a study-guide summary (an up-front Abstract over a structure-mirroring body) into `summaries/`.
- **enhance-book** — cite a summarised source into the book where it fits, or report that it isn't needed.

**Writing & citations:**

- **book-style** — rewrite a section or chapter into the house style, looping a self-check ("does this sound like AI?") until a pass comes back clean; carries the style rules, a prose linter, and a citation/structure preservation check.
- **apa-citations** — apply and audit APA-7 citations; regenerate per-chapter reference lists from `references.json`.
- **heading-numbering** — number section headings `N.M` / `N.M.K` (idempotent).

**Build & scripting:**

- **book-build** — build the website + PDF + ePub from `book/` via Quarto; cover/chapter art; deploy. *(agent-triggered)*
- **python-scripts** — write and run Python for analysis, scraping, validation, or one-off automation.

**Diagrams:**

- **mermaid-diagrams** — general Mermaid diagrams (flowchart, sequence, class, ER, state, …).
- **c4-architecture** — C4 architecture views (context / container / component) in Mermaid.
- **draw-io** — create/edit `.drawio` diagrams; export to PNG/SVG.
- **draw-io-diagram-generator** — low-level mxGraph XML authoring for draw.io. *(agent-triggered)*
- **mermaid-to-drawio** — convert Mermaid source into editable draw.io XML.

### Invoking a skill

- **By description (any tool).** State the task in plain language — "summarise the Harness-Bench paper", "research loop engineering and add it to §2.6". Each skill's description makes it trigger automatically in Claude Code, Copilot, and Antigravity.
- **Explicitly (Claude Code / Copilot).** Type `/<skill-name>` to run a user-invocable skill directly — e.g. `/summarise-source`, `/research-topic`, `/apa-citations`. The two agent-triggered skills above (**book-build**, **draw-io-diagram-generator**) fire when relevant rather than as slash-commands.
- **Pipeline.** `research-topic` runs the full research chain; `search-topic`, `download-source`, `summarise-source`, and `enhance-book` each run a single stage on their own.

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

**The target is Chris's own voice.** This is her book, told largely out of her own working life, and it has to read as though she wrote it. The next section is the specification: it is measured from four of her own pieces, and it governs. Kernighan & Pike come after it, and only for the thing they are actually good for.

Where the two disagree, **her voice wins**. The clearest case is punctuation: K&P use 17 em dashes per 10,000 words and she uses none, so on that point the model is simply wrong for this book.

### The author's own voice (the specification)

These findings come from measuring four of her own pieces (253 sentences, 1987 to 2020): the *Rubato* honours thesis, "How to Avoid FOLO", "Why I consider myself to be Retired", and "A celebration of 50 Years of Unix". Read one in full before a long drafting session. A description of a voice is far weaker calibration than the voice itself.

> [!CAUTION]
> **The absolute rule: never use an em dash (—).** Not one appears in 253 sentences of her writing. Where a dash is wanted she reaches for a spaced hyphen ( - ), and otherwise for a comma, a colon, or a new sentence. This is the most reliable signal that a machine wrote a passage in her name.
>
> The habit is not inherited from the model, either. K&P run 17 em dashes per 10,000 words; drafts of this book have run at 148, nearly nine times the density of the very book it claims to imitate. When you catch yourself reaching for one, the sentence usually wants to be two sentences.
>
> **Scope.** The rule covers running prose, which is what the corpus measured (prose paragraphs only, excluding headings, lists, block quotes and code). A dash used typographically in a title, a subtitle, or a term-and-definition line inside an alert is a different animal and stays: the title page's "愛道 — The Way of AI" and the glossary dashes in `book/00-title.md` are deliberate. Verbatim quotations from a source keep their own punctuation too, and so do **cited titles**: Ahuja's *The method that replaces spec-driven development — IDSD* carries a dash in its real title, so the dash stays in both the in-text citation and the References entry. Removing it would falsify the citation.

**Six constants, in order of how much damage it does to get them wrong:**

1. **Personal experience carries the argument.** It does not illustrate a point made elsewhere; it *is* the point. Even her history of Unix is told through which machine she sat at, what she was paid, and who rang her up. A claim arrives attached to the moment she learned it.
2. **Concrete specifics, constantly.** Not "an early minicomputer" but a VAX 11/780. Not "quite cheap" but ten dollars an hour. Named machines, real prices, real sizes. When she generalises, she has almost always just earned it with a particular.
3. **Candour that does not protect her own image.** Naive, arrogant, foolish, forgiven for hacking a university. The unflattering detail is never softened, and that candour is what buys the reader's trust for whatever advice follows. Do not tidy her into competence.
4. **Dry understatement, delivered flat.** The funny line is said plainly and then left alone. She never points at her own jokes and never follows one with a second.
5. **Short paragraphs, unevenly cut.** One idea each, and the lengths are deliberately lumpy: six words next to sixty. When the idea is the turn of the story it gets a paragraph to itself, sometimes a single sentence long. *Evenly sized paragraphs are themselves a tell.*
6. **The ending turns, it does not recap.** The last line compresses the piece into something plainly said, arrived at rather than announced. A closing paragraph that lists what the section covered is the strongest single signal she did not write it.

**Measured baselines.** A shape to land inside, not a target to hit. Most of this book sits in the technical register.

| Measure | Personal essay | Technical / historical |
| --- | --- | --- |
| Median sentence | 13–15 words | 20 words |
| Median paragraph | 36 words | 72 words |
| Longest sentence | 43–49 words | 68 words |
| Parenthetical asides | 0–12 per piece | 39 per piece |
| Bold runs in prose | 0–1 per piece | 0 per piece |
| Em dashes | 0 | 0 |

**Habits worth using:**

- **The rhetorical question is her main engine of transition.** Asked on the reader's behalf, not the writer's, and answered immediately. When she expects scepticism she puts it in the heading, in the reader's own words: "C'mon really? Does that strategy even work?" / "Yes, really."
- **Objections are voiced, conceded, then answered.** The concession is short and unqualified before the argument resumes. "Fair enough. But let's examine what your expectations are."
- **Parenthetical asides do three jobs** and may run long without apology: the technical gloss, the wry qualification, and the correction of her younger self. In technical writing they carry much of the detail.
- **Remembered dialogue is set as a block quote**, not woven into the paragraph.
- **A capitalised abstract noun, used sparingly**, marks the moment a piece turns on a concept: "Happiness is a State of Mind."
- **A wrong version and a right version in the same shape.** The parallel structure does the arguing, so the prose does not have to.

**Never present in her writing:** em dashes; "it's not just X, it's Y"; tricolons for swell; "in this article we will"; a summary that recaps; bolded phrases mid-paragraph; stacked hedging; "game-changing"; "seamless"; enthusiasm in place of detail; evenly sized paragraphs; American spelling.

> [!IMPORTANT]
> Striking those out is the easy half, and on its own it changes nothing. A passage with no em dashes and no personal stake still reads as though a machine wrote it, because what is missing is not a punctuation habit but the person who was there.

### Kernighan & Pike (a reference for the teaching passages only)

Her four measured pieces are a thesis, two personal essays and a technical history. None of them is a book that teaches a method over six chapters, so they do not show how to *explain* at that length. That, and only that, is what K&P are here for.

Use them for the explanatory register: how to walk a reader through an idea step by step, patiently, without going dense. A full copy is at `sources/software-engineering/unix-programming-environment.md`. A typical passage:

> Let's begin with filename patterns. Suppose you're typing a large document like a book. Logically this divides into many small pieces, like chapters and perhaps sections. Physically it should be divided too, because it is cumbersome to edit large files. Thus you should type the document as a number of files.

Five plain sentences, each following from the last, and a person in every one. K&P are *not* dense: "Let's begin with…", "we'll show you how a little later". Teach, don't summarise. No pep, no hype. Natural contractions are welcome. Also in the tradition: Kernighan & Ritchie's *C* and Knuth's *TAOCP*.

**The readability bar comes from here too:** K&P can be read by a high-school student, and every paragraph of this book should pass the same test. Read it aloud once; if a bright sixteen-year-old would stumble or ask what a word means, simplify it.

What K&P must **not** be used for: punctuation, paragraph rhythm, how a section ends, or how much of the author shows up on the page. Those come from the specification above. And the book's own best reference sample is not K&P at all: it is the **Chapter 2 introduction and §2.1**, which is Chris writing well. When in doubt, match those.

> [!WARNING]
> **The failure mode to avoid is the aphorism.** Told to write with "plainness and understatement", agents tend to compress prose into clipped, quotable pronouncements: abstract nouns doing things, epigram pairs, no reader in the sentence. That is pastiche of K&P, and it reads as dense and obtuse. A real example from a draft of this book:
>
> - **Wrong:** "Leverage compounds only if you stop re-deciding everything."
> - **Right:** "Everything this chapter has built — the skills, the loops, the wiki, the Markdown — only pays off if you stop solving the same problems from scratch."
>
> The first has to be decoded; the second explains itself. If a sentence would look at home on a poster, unpack it.

> [!WARNING]
> **Avoid the habits that make prose read as AI-written.** Each of these is fine once in a while; as a habit they are a fingerprint. Before finishing any section, sweep for them:
>
> - **"Not X but Y" contrast scaffolding** — "a result to review, not a transcript", "it is delegation done well, not a failure". AI reaches for this shape constantly; K&P almost never does. Say what the thing *is*, plainly, and only draw the contrast when the reader would genuinely make the mistake.
> - **Mirrored triads and parallel clauses** — "the plays carry your methods, the preferences your taste, the loop the day". Rhythmic, quotable, and empty. Write three ordinary sentences instead, or use a numbered list.
> - **Bombastic abstractions** — *leverage*, *compounding*, *friction*, *infrastructure*, *scaffolding*, *surface* (as a verb), *anchor* (as a verb), *the arc*, *earns its place*. Use the everyday word or give an example: not "this compounds" but "each skill you save makes the next task quicker".
> - **Dramatic verbs where plain ones do** — *collapses*, *rockets*, *plummets*, *dulls*, *shadows*. Say *falls*, *rises*, *gets worse*.
> - **Em dashes: none at all.** See the absolute rule under *The author's own voice* above. This is the single strongest tell.
> - **The paragraph-ending button** — a tidy mini-conclusion capping every paragraph. Some paragraphs should just end.
> - **Mirror payoffs** — a sentence whose second half echoes the shape of the first: "the one you arrive at, not the one you began with"; "made explicit they become checks; left implicit they stay wishes"; "stops being X and becomes Y". Humans continue a thought; they don't balance it. Write the second half in a different shape, or as its own plain sentence.
> - **The elegant definite article** — packaging an idea into an artful noun phrase as if it were already agreed: "the one constraint that was missing", "the prompt worth keeping", "the rule that makes the others safe". Say it loosely instead: "whatever was missing", "a prompt you want to keep".
> - **Self-referential wit** — "this is a book and not a footnote", "the whole book in miniature". Cut it; say the plain thing ("Two differences matter").
> - **Classifier openings** — "Prompting is iterative by nature", "Composition is itself a distinct skill". Don't classify the thing; describe what happens: "Do not expect a prompt to come out right the first time."
> - **Three-beat imperatives** — "start simple, read what comes back, and add the one constraint that was missing". Even instructions fall into AI rhythm. Vary the shapes, or use a numbered list.
>
> The one test that catches all of these: **would you say this sentence out loud to a colleague across a desk?** AI writes shapes nobody says. It is fine for prose to be a little loose — the user's own drafts sometimes run to a comma splice, and they read as human. Perfectly balanced rhythm is itself the fingerprint. When a sentence turns abstract, replace it with an example. When it turns grand, shrink it. The metaphors that stay are the homely kind K&P and good documentation use — "a USB-C port for AI", "an onboarding guide for a new hire" — never literary set pieces.

- **Explain, don't pronounce.** Walk the reader through an idea step by step, each sentence following from the previous one, the way K&P walk through the filesystem. Two easy sentences always beat one compressed one. If a reader could ask "what does that mean?", the explanation is missing — write it.
- **Keep people in the sentences.** "I", "you", "we", or a named researcher should be doing the things: "you send it with the text and read the result", not "quality lives in that loop". Abstract nouns make poor protagonists — when *leverage*, *quality*, or *the compounding* is the subject of a sentence, rewrite it around a person.
- **Easy to follow beats short.** Break up any sentence that stacks three or more clauses with dashes and semicolons — a freight train of findings is unreadable. But do not chop prose into staccato fragments either: a longer sentence that flows in one direction reads easily, and K&P write plenty of them. The test is whether the sentence can be read once, aloud, without backtracking.
- **Explain the mechanism, plainly.** State how the thing actually works before the evidence: the idea, the intuition for why it holds, then the example or number that proves it. The reader should finish understanding *why*, not just *that*. Prefer a direct description of the mechanism ("the kernel moves the data through the pipe") to an image that stands in for it.
- **Metaphor should be homely, not literary.** A simple everyday comparison that makes an idea click is welcome — "MCP is a USB-C port for AI", "a skill is an onboarding guide for a new hire", the cooking story that opens §1.6. What gets cut is the showy kind: the courtier, the parlour game, "in another coat", anything that has to be decoded before the point lands. If the metaphor is something you'd say across a desk, keep it; if it belongs in a novel, cut it.
- **No hype, no selling — but understatement is not compression.** Make the claim and let it stand; be frank about limits and imperfection; skip the rhetorical peak at the end of a paragraph. None of that means squeezing the explanation out. A dry, quiet wit is welcome — K&P again: "This isn't very interesting for the poem, but let's do it anyway, just to see what it looks like."
- **Prefer the plainest precise word.** Choose the simplest wording that stays exact: "explains" not "glosses", "a trick" not "stagecraft", "the main limit" not "the binding constraint". Spell a term out in full on first use ("large language model", not "model") where it helps a non-specialist. This is not a licence to dumb down — keep the right technical terms — only to drop ornamentation that adds nothing.
- **Let real examples carry the argument.** Prefer concrete, tested, real examples over invented or abstract ones; give the specifics, because the specifics are the argument (the three projects in Chapter 3 are the model). Favour a short worked example over a paragraph of abstraction.
- **Use numbered enumerations for principles and summaries.** When drawing several lessons together, count them out — "First… Second… Third…" — as Kernighan & Pike do in their look-backs. It is clearer and more memorable than a run of prose.
- **Pose a question, then answer it directly.** "What makes this work? Three things." is a good shape for opening a hard topic.
- **Look back mid-section, but never end on a recap.** Where a dense stretch has covered a lot, it is fine to draw the lesson plainly and move on, the way K&P do in their summaries. What must not happen is a *closing* paragraph that lists what the section covered: her endings turn instead, compressing the argument into something plainly said. If the last paragraph could be retitled "in summary", rewrite it.
- Build ideas in order — each concept rests on the previous one, so a careful reader never meets a term before it is defined. Introduce each major source in its own paragraph: name it, explain its method, give the concrete result, draw the lesson. Give credit to the people behind ideas by name.
- Keep paragraphs short, one idea each, and **vary the lengths**. Around 72 words is the middle of her technical register; the current draft runs to a median of 111, so most paragraphs want cutting. Let some run to a single sentence where the idea turns. A page of paragraphs all the same size reads as machine-made even when every sentence is fine.
- **Unhurried, not dense.** Every sentence should earn its place, but leave room to develop a point fully — cutting the connective tissue that carries a reader from one idea to the next saves words and loses them. Lead with a clear claim, then develop it. Bullet lists are welcome for steps, options, or contrasts — keep ideas balanced and skimmable.
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
  - Source metadata (authors, titles, venues, DOIs) comes from the `summaries/**/*.md` summary headers; verify web/news titles and bylines against the live page before citing. Never invent an author list or title.
- **Research before writing.** Read official/primary sources first; assume internal knowledge is stale.
- Mark anything uncertain as a draft assumption; do not present it as fact.

## Collaboration

- **Grill the author when unsure.** Ask before guessing intent, scope, or facts.
- Confirm restructuring before renumbering or deleting chapters.

## Sources so far

Downloaded research is organised into three repo-root folders:

- **`sources/`** — original downloaded sources (PDF or converted Markdown), by **topic** (not by chapter, since a source may serve several). All arXiv PDFs live in `sources/arXiv/`; other sources sit in topic folders (`llm-foundations/`, `agent-architecture/`, `spec-vs-vibe/`, …).
- **`summaries/`** — one Markdown study-guide summary per source, produced by the [[summarise-source]] skill (an up-front **Abstract** of key points and takeaways, over a structure-mirroring body), mirroring the `sources/` topic folders (arXiv summaries in `summaries/arXiv/`). Each links to its source with a relative link. This replaces the old short "dossier" format.
- **`misc/`** — meta and working files that are not sources (walkthroughs, plans, images, author notes). `misc/research.md` has the original link list.

The citation↔source mapping is `references.json` at the repo root (used by [[apa-citations]]).
