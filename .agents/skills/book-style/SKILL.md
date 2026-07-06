---
name: book-style
description: 'Rewrite a section or chapter into the house prose style, then loop a self-check until it stops sounding like AI. Use whenever the user wants a style pass, a de-AI pass, a rewrite "in my voice", or any drafting or revising of chapter prose — or names a chapter/section and asks to fix its tone, readability, or style. The style is modelled on Kernighan & Pike: plain, explanatory, one professional walking another through an idea, with a slight university-professor tone. The loop rewrites, reads the result against the style guide asking "does this sound like AI?", fixes what it finds, and checks again until a pass comes back clean. Also carries the style rules and an advisory prose linter.'
argument-hint: 'A chapter, section, or file to restyle (e.g. "chapter 2", "§3.4", book/01-foundations.md).'
user-invocable: true
---

# House prose style (Kernighan & Pike)

The model is Kernighan & Pike's *The Unix Programming Environment* (a full copy is at `sources/software-engineering/unix-programming-environment.md` — read a few pages when in doubt). Read it for what it actually is: one professional explaining things to another, with the slight tone of a university professor — relaxed, patient, easy to read, and often quite explanatory ("Let's begin with…", "we'll show you how a little later"). **The readability bar: K&P can be read by a high-school student; every paragraph should pass the same test.** Teach, don't summarise; be warm, exact, and happy to explain. No pep, no hype. Natural contractions are welcome. The book's own reference sample is the **Chapter 2 introduction and §2.1**.

> [!WARNING]
> **Do not compress into aphorisms.** The classic failure is turning "plainness" into clipped, quotable pronouncements — abstract nouns doing things, epigram pairs, no reader in the sentence. **Wrong:** "Leverage compounds only if you stop re-deciding everything." **Right:** "Everything this chapter has built — the skills, the loops, the wiki, the Markdown — only pays off if you stop solving the same problems from scratch." If a sentence would look at home on a poster, unpack it.

> [!WARNING]
> **Sweep for AI-writing habits.** Fine once, a fingerprint as a habit: "not X but Y" contrast scaffolding; mirrored triads ("the plays carry your methods, the preferences your taste, the loop the day"); mirror payoffs ("the one you arrive at, not the one you began with"); elegant definite-article packaging ("the one constraint that was missing", "the prompt worth keeping"); self-referential wit ("this is a book and not a footnote"); classifier openings ("prompting is iterative by nature" — describe what happens instead); three-beat imperatives ("start simple, read what comes back, add what was missing"); bombastic abstractions (*leverage*, *compounding*, *friction*, *infrastructure*, *surface/anchor* as verbs); dramatic verbs (*collapses*, *rockets* — say *falls*, *rises*); em-dash chains; a tidy mini-conclusion capping every paragraph. The one test that catches all of these: **would you say this sentence out loud to a colleague across a desk?** It is fine for prose to be a little loose — perfectly balanced rhythm is itself the fingerprint. When a sentence turns abstract, replace it with an example; when it turns grand, shrink it.

## The rules that matter most

- **Explain, don't pronounce.** Walk the reader through, step by step, each sentence following from the last. Two easy sentences beat one compressed one.
- **Keep people in the sentences.** "I", "you", "we", or a named researcher does the things — not *leverage*, *quality*, or *the compounding*. Abstract nouns make poor protagonists.
- **Easy to follow beats short.** Break any sentence that stacks three-plus clauses with dashes and semicolons — but don't chop prose into staccato fragments either. The test: readable once, aloud, without backtracking.
- **Explain the mechanism, plainly**, before the evidence: the idea, the intuition for why it holds, then the example or number that proves it.
- **Metaphor should be homely, not literary** — "a USB-C port for AI", "an onboarding guide for a new hire". If you'd say it across a desk, keep it; if it belongs in a novel, cut it.
- **No hype, no selling — but understatement is not compression.** Make the claim and let it stand; be frank about limits; don't squeeze the explanation out. Dry, quiet wit is welcome.
- **Plainest precise word** — "explains" not "glosses", "the main limit" not "the binding constraint". Keep real technical terms; drop ornament.
- **Numbered enumerations** for summaries and principles ("First… Second… Third…").
- **Pose a question, then answer it.** Close a dense stretch with a brief look back.
- **Let real, tested examples carry the argument.** Give the specifics.
- **Short paragraphs** (three to five sentences, one idea each). Build ideas in order; define a term before using it. Credit people by name.
- Use GFM: `> [!NOTE]`/`> [!TIP]`/`> [!IMPORTANT]` for asides and definitions, tables for breakdowns, ```mermaid for relationships. No H1 inside chapters.

Full authoring rules (audience, voice, accuracy, structure) live in `AGENTS.md`.

## The workflow: rewrite, check, repeat

Given a chapter, a section, or a file, run three movements — the same shape as [[summarise-source]]'s loop. The reason for the loop is simple: the first rewrite always keeps some of the old habits, and the writer is the worst person to spot them. A separate reading pass catches what the writing pass missed.

### Movement 1 — Rewrite

Read the whole target first for sense; you cannot fix the prose of a section without knowing where its argument is going. Then rewrite the prose against the rules above. What you must **not** change:

- **Citations** — every in-text citation stays verbatim, in order, with its exact URL and its first-mention-with-title vs later-mention form. A style pass never adds, drops, or reworders a citation.
- **Facts and numbers** — every figure, finding, and quoted phrase stays exactly what the source supports.
- **Structure** — tables, ```mermaid blocks, GFM alerts, code fences, headings and their numbering all stay as they are (their surrounding prose is fair game).
- **The author's own voice.** Passages that already read like the reference sample (Ch2 intro/§2.1) are left alone. The job is to remove drift, and rewriting good prose is drift of its own.

### Movement 2 — Check

Now read the result with fresh eyes — as a subagent where the environment allows, otherwise as a separate pass after the writing is done. Go paragraph by paragraph and ask one question of each: **"Does this sound like AI?"** Judge it against the two WARNING lists above and the rules, and apply the two quick tests — could you say the sentence out loud to a colleague, and could a high-school student read it without stumbling. Also run the mechanical checks:

- `scripts/prose_lint.py <file>` — flags over-long, clause-stuffed sentences (advisory; some earn their length).
- `scripts/check_preservation.py <file>` — confirms the citations and structure survived Movement 1 untouched (compares against git HEAD; see `--help` for other baselines).
- The Australian-spelling check if available (`.agents/skills/review-chapter/scripts/check_australian_spelling.py`).

Write down every issue found, each with its location and what is wrong ("§2.3 ¶4: mirror payoff", "§2.6 ¶2: *leverage*"). No fixing during this movement — a checker who is also editing stops reading.

### Movement 3 — Fix, then check again

Fix every issue on the list, then run Movement 2 again on the result. The skill finishes when a check pass comes back with **no issues**. Cap the loop at five rounds; if issues persist at the cap, stop and report what remains and why it is stubborn rather than looping forever. In practice one or two rounds is normal — needing more usually means Movement 1 was too timid.

## Verify (every run)

- `scripts/check_preservation.py` passes: no citation URL gained or lost, structural counts identical.
- The final check pass found no issues.
- For a whole-chapter pass, build: `cd quarto && ./build.sh` → "Output created".

## Report

Say what was rewritten (which sections), how many check rounds it took, the kinds of issues each round caught (with two or three before/after examples), and confirm the preservation checks passed. If anything was deliberately left alone — the author's own passages, a load-bearing contrast — say so.

## Advisory linter

`scripts/prose_lint.py` flags sentences that drift from the style — over-long or clause-stuffed — so you can break them up. It is advisory; it edits nothing.

```bash
python scripts/prose_lint.py book/0[1-6]*.md
python scripts/prose_lint.py --max-words 40 book/01-foundations.md
```

Not every flag is wrong — a dense mechanism sentence may earn its length. Use it to find candidates, then apply judgement.

> [!TIP]
> Related skills: [[apa-citations]] for sourcing, [[heading-numbering]] for structure, [[review-chapter]] for the full seven-check publication pass (which calls this skill for its readability step).
