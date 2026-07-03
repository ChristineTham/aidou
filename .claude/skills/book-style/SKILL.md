---
name: book-style
description: 'Write and revise the book in its house prose style — modelled on Kernighan & Pike''s The Unix Programming Environment: plain short sentences, mechanism over metaphor, understatement, worked examples, numbered enumerations. Includes an advisory prose linter for over-long, clause-stuffed sentences. Use when drafting or editing chapter prose, or doing a style pass.'
---

# House prose style (Kernighan & Pike)

The model is Kernighan & Pike's *The Unix Programming Environment* (a full copy is at `research/the-unix-programming-environment-kernighan-pike.md` — read a few pages when in doubt). Teach, don't summarise; be a professor who is warm and exact but never chatty. No pep, no hype. Natural contractions are welcome.

## The rules that matter most

- **One idea per sentence; keep sentences short.** Two clauses is usually the limit. Break any sentence that stacks three-plus clauses with dashes and semicolons. This is the single biggest lever.
- **Explain the mechanism, plainly**, before the evidence: the idea, the intuition for why it holds, then the example or number that proves it.
- **Metaphor is rare and functional** — a phrase, not a set piece. Cut showy closings ("eager courtier", "parlour game"). State the point and stop.
- **Understatement over flourish.** Make the claim and let it stand. Be frank about limits; never sell.
- **Plainest precise word** — "explains" not "glosses", "the main limit" not "the binding constraint". Keep real technical terms; drop ornament.
- **Numbered enumerations** for summaries and principles ("First… Second… Third…").
- **Pose a question, then answer it.** Close a dense stretch with a brief look back.
- **Let real, tested examples carry the argument.** Give the specifics.
- **Short paragraphs** (three to five sentences, one idea each). Build ideas in order; define a term before using it. Credit people by name.
- Use GFM: `> [!NOTE]`/`> [!TIP]`/`> [!IMPORTANT]` for asides and definitions, tables for breakdowns, ```mermaid for relationships. No H1 inside chapters.

Full authoring rules (audience, voice, accuracy, structure) live in `AGENTS.md`.

## Advisory linter

`scripts/prose_lint.py` flags sentences that drift from the style — over-long or clause-stuffed — so you can break them up. It is advisory; it edits nothing.

```bash
python scripts/prose_lint.py book/0[1-6]*.md
python scripts/prose_lint.py --max-words 40 book/01-foundations.md
```

Not every flag is wrong — a dense mechanism sentence may earn its length. Use it to find candidates, then apply judgement.

> [!TIP]
> Related skills: [[apa-citations]] for sourcing, [[heading-numbering]] for structure. Mirror changes to `.github/skills` and `.claude/skills`.
