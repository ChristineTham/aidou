---
name: book-style
description: 'Rewrite a section or chapter into the author''s own voice, then loop a self-check until it stops sounding like AI. Use whenever the user wants a style pass, a de-AI pass, a rewrite "in my voice", or any drafting or revising of chapter prose, or names a chapter/section and asks to fix its tone, readability, or style. The target is Chris Tham''s measured voice: personal experience carrying the argument, concrete specifics, candour, dry understatement, uneven paragraph lengths, endings that turn rather than recap, and never an em dash. Kernighan & Pike are a secondary reference for the explanatory passages only. The loop rewrites, reads the result asking "does this sound like AI?", fixes what it finds, and checks again until a pass comes back clean. Carries the style rules, a prose linter, and a repetition check.'
argument-hint: 'A chapter, section, or file to restyle (e.g. "chapter 2", "§3.4", book/01-foundations.md).'
user-invocable: true
---

# House prose style: the author's own voice

**The target is Chris's voice, not a literary model.** It is specified in `AGENTS.md` under **The author's own voice**, measured from four of her own pieces (253 sentences), and it governs everything below. Read that section before a drafting session, and read one of the four pieces in full before a long one. A description of a voice is far weaker calibration than the voice itself.

What matters most, in order of how much damage it does to get it wrong: personal experience carries the argument rather than illustrating it; concrete specifics (a VAX 11/780, ten dollars an hour, not "an early minicomputer"); candour that does not protect her own image; dry understatement said flat and then left alone; short paragraphs of uneven length; and an ending that turns rather than recaps.

Kernighan & Pike are a **secondary reference, for the explanatory passages only** — how to walk a reader through an idea patiently at book length, which her own four pieces do not demonstrate. Use them for that and nothing else. On punctuation, paragraph rhythm, endings, and how much of the author shows up, her voice wins: K&P run 17 em dashes per 10,000 words and she uses none. **The readability bar does come from K&P: a high-school student can read them, and every paragraph here should pass the same test.** The book's own best sample is the **Chapter 2 introduction and §2.1**, which is Chris writing well.

> [!WARNING]
> **Do not compress into aphorisms.** The classic failure is turning "plainness" into clipped, quotable pronouncements — abstract nouns doing things, epigram pairs, no reader in the sentence. **Wrong:** "Leverage compounds only if you stop re-deciding everything." **Right:** "Everything this chapter has built — the skills, the loops, the wiki, the Markdown — only pays off if you stop solving the same problems from scratch." If a sentence would look at home on a poster, unpack it.

> [!CAUTION]
> **Never use an em dash (—).** The author's own writing contains none: 253 sentences measured across four pieces, zero occurrences. She uses a spaced hyphen ( - ), a comma, a colon, or a new sentence. This is the single most reliable tell that a machine wrote a passage in her name, and it is not inherited from the model either: K&P run 17 em dashes per 10,000 words, while drafts of this book have run at 148. A sentence reaching for a dash usually wants to be two sentences. Full detail, plus the six constants of her voice and the measured baselines, is in `AGENTS.md` under **The author's own voice** — read it before a drafting session.
>
> Three consequences that follow from the same analysis, and that this loop must check:
>
> - **Endings turn; they never recap.** A closing paragraph listing what the section covered is the strongest signal she did not write it. Mid-section look-backs are fine.
> - **Paragraph lengths must be lumpy.** One idea each, around 72 words in the middle, and some allowed to run to a single sentence at a turn. Evenly sized paragraphs are themselves a tell.
> - **Keep the person in it.** Her argument is carried by personal experience and unflattering candour, not by illustration bolted onto an abstract claim. Stripping the tells out of a passage that has no personal stake still leaves it reading as machine-made.

> [!WARNING]
> **Sweep for AI-writing habits.** Fine once, a fingerprint as a habit: "not X but Y" contrast scaffolding; mirrored triads ("the plays carry your methods, the preferences your taste, the loop the day"); mirror payoffs ("the one you arrive at, not the one you began with"); elegant definite-article packaging ("the one constraint that was missing", "the prompt worth keeping"); self-referential wit ("this is a book and not a footnote"); classifier openings ("prompting is iterative by nature" — describe what happens instead); three-beat imperatives ("start simple, read what comes back, add what was missing"); bombastic abstractions (*leverage*, *compounding*, *friction*, *infrastructure*, *surface/anchor* as verbs); dramatic verbs (*collapses*, *rockets* — say *falls*, *rises*); any em dash at all (see above); stacked hedging; bold inside running prose; a tidy mini-conclusion capping every paragraph. The one test that catches all of these: **would you say this sentence out loud to a colleague across a desk?** It is fine for prose to be a little loose — perfectly balanced rhythm is itself the fingerprint. When a sentence turns abstract, replace it with an example; when it turns grand, shrink it.

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

Now read the result with fresh eyes. **Use the `book-style-checker` subagent** (`.claude/agents/book-style-checker.md`) — it carries this skill's brief, checks accuracy against `sources/` as well as style, and is told to say CLEAN plainly so the loop can end. Where subagents are unavailable, do it as a separate pass after the writing is done. Go paragraph by paragraph and ask one question of each: **"Does this sound like AI?"** Judge it against the two WARNING lists above and the rules, and apply the two quick tests — could you say the sentence out loud to a colleague, and could a high-school student read it without stumbling. Also run the mechanical checks:

- `scripts/prose_lint.py <file>` — flags over-long, clause-stuffed sentences (advisory; some earn their length).
- `scripts/check_repetition.py <file>` — catches phrases and openers the book already leans on. Before adding new prose, save just the new passage to a scratch file and run `check_repetition.py <scratch> --against book/0[1-6]*.md --max-words 3`; a vivid three-word phrase that already appears elsewhere is how a tic starts (*"earns its keep"* reached four uses before anyone noticed).
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
