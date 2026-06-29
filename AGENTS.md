# AGENTS.md — Rules for Writing AI-dō

Guidelines for any AI agent (or human) drafting this book.

## Structure

- 6 chapters; former chapters are now sections. Keep it that way.
- Each section flows through principle → why it matters → practice → pitfalls, mostly as connected prose. Use bullet lists where they genuinely aid scanning, not as a default.
- Always review sources before writing

## Audience

- Write for a well-educated general reader (master's level), not specifically an engineer. Assume curiosity, numeracy, and patience, not a CS degree.
- They can read code and an arXiv paper if asked, and bring consultant-grade judgement; they do not live in a terminal. Lead with ideas, treat code/jargon as optional depth.
- Reach for everyday and cross-disciplinary metaphors (craft, music, navigation, the professions) over engineering-internal ones. Define any technical term plainly on first use.

## Style

- Teach, don't summarise. Write like a great university textbook — Kernighan & Ritchie's *C*, Kernighan & Pike's *The Unix Programming Environment*, Knuth's *The Art of Computer Programming*: a professor who is warm, friendly, and engaging but never chatty, rigorous and exact yet quietly playful. No "let's", pep, or hand-holding.
- Explain the mechanism before the evidence: state the idea, give the intuition for why it holds, then the example or number that proves it. The reader should finish understanding *why*, not just *that*.
- Build ideas in order — each concept rests on the previous one, so a careful reader never meets a term before it is defined. Introduce each major source in its own paragraph: name it, explain its method, give the concrete result, draw the lesson.
- Prefer correct technical terms over layman substitutes; define each once on first use, then use it plainly. Favour short, concrete examples that carry weight over abstraction.
- Stay dense but unhurried: every sentence earns its place, yet leave room to develop a point fully. Lead with a clear claim, then develop it.
- Keep paragraphs short — three to five sentences, one idea each. Break long stretches into multiple paragraphs so the page stays easy to read.
- Favour short, plain sentences; cut clauses that don't carry weight. Bullet lists are welcome for steps, options, or contrasts — keep ideas balanced and skimmable.
- Use GitHub-Flavored Markdown: `> [!NOTE]`/`> [!TIP]`/`> [!IMPORTANT]` alerts for asides and definitions, tables for complex breakdowns, ```mermaid diagrams for relationships, fenced code with a language. No H1 inside chapters.

## Voice

- The seasoned professor: curious, precise, generous. Confident without showing off, never selling. Trust the reader's intelligence; respect their time.
- First person — "I" for the author, "you" for the reader, "we" when reasoning together. Open sections with a short, concrete anecdote where it earns its place.
- Human-centred (愛), disciplined (道). Augmentation, not replacement.
- Methodology over hacks; repeatable patterns over one-off prompts.

## Accuracy

- **Never hallucinate.** No invented facts, stats, dates, or quotes.
- **Always cite sources.** Every claim, figure, or quote links to its origin.
- **Research before writing.** Read official/primary sources first; assume internal knowledge is stale.
- Mark anything uncertain as a draft assumption; do not present it as fact.

## Collaboration

- **Grill the author when unsure.** Ask before guessing intent, scope, or facts.
- Confirm restructuring before renumbering or deleting chapters.

## Sources so far

- @research folder contains research downloaded so far
- @research.md contains links to sources
