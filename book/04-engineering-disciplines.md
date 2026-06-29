# Chapter 4 — Engineering Disciplines (the climb)

The previous chapter described what good AI software looks like; this one is about the disciplines that produce it. They form a ladder — crafts, context, harness, loops, orchestration, substrate — and the consistent theme is that as models improve, the human's job climbs from writing prompts to designing the systems that run them.

## The Four Crafts

Prompting has not vanished; it has split into four skills — intent, spec, context, and prompt — and the useful question is who owns each.

| Craft | Owner | What it produces |
| --- | --- | --- |
| Intent | Human | The goal, constraints, failure conditions |
| Spec / expectations | Human | The evaluable definition of done |
| Context | Harness | The tokens the model sees at each step |
| Prompt | Harness | The reusable interaction patterns (plays) |

Clear ownership is what stops drift, and it has a sharp security edge: compartment the evaluations so the builder cannot see the tests it will be judged on, or it will optimise for the checks instead of the outcome. The harder discipline is presence. It is tempting to step out and bless a diff at the end, but a drifted result is worse than no result because it lies with confidence; staying in the loop while the work runs beats approving it at the gate ([idd-vs-sdd summary](../research/idd-vs-sdd.md)).

## Context Engineering

Anthropic describes context engineering as the natural successor to prompt engineering: less about finding the right words and more about curating the optimal set of tokens an agent sees at each step ([Anthropic 2025](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)). It matters because attention is finite. Chroma's "context rot" study of 18 models shows recall degrades as the window fills, and that the reassuring needle-in-a-haystack benchmark only tests lexical lookup; once a needle requires a semantic inference, accuracy falls further with length — every extra token spends an attention budget, a consequence of the transformer's n² token-to-token cost ([Chroma 2025](https://research.trychroma.com/context-rot)). Context is a scarce resource, not a free dumping ground; the aim is the smallest set of high-signal tokens that gets the job done.

That principle yields concrete techniques. Compaction summarises a near-full conversation and reopens a fresh window with the essentials; structured note-taking lets an agent persist a NOTES.md and read it back after a reset; sub-agents explore on clean contexts and return distilled summaries; and "just-in-time" retrieval keeps lightweight references — file paths, queries — and loads detail only when needed, so naming and folder structure become signal in themselves. Structure can be injected too: lightweight call/inheritance tags placed inline give a grep-first agent +2.2pp localisation, shorter trajectories, and roughly half the run-to-run variance — helping less by making agents smarter than by making navigation disciplined and reproducible ([2606.26979](../research/papers/2606.26979-static-anchoring.md)). The recurring waste is re-reading the whole store every turn and paying for it in tokens; the discipline is to feed context progressively and retrieve only the section that answers the question.

## Harness Engineering

A harness is the runtime around the model: tool use, planning, retries, sandboxes. The reliable design is to let the program own control flow and call the model only for judgement, so that token explosion and erratic stopping stop being mysteries and become engineering ([2606.15874](../research/papers/2606.15874-llm-as-code.md)). Decomposing tasks at runtime, so only the failed step reruns rather than the whole pipeline, cuts retry cost by half or more in measured workloads ([2605.15425](../research/papers/2605.15425-runtime-decomposition.md)). The fragile alternative is handing all the looping and branching to a probabilistic system and hoping a better prompt rescues it.

## Loopcraft

The craft of the moment is stacking self-correcting cycles and watching their trajectories, since non-deterministic loops break ordinary unit tests and leverage comes from loops, not prompts. The practitioners are blunt about it — Steinberger says design the loops that prompt your agents; Cherny says he writes loops, not prompts; Karpathy says arrange things so they run autonomously and hit go ([Loopcraft](https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking)). The skill is knowing when to drop a loop for reliability and when to climb one for leverage. The trap is fixing things by hand as you always have, instead of building systems that scale with more agents.

## Meta-Harnesses & Orchestration

Above the harness sit harnesses that orchestrate other harnesses — coordinating agents, selecting models, enforcing governance. Leverage now scales with agents rather than your own speed, which makes standard primitives for identity, memory, and orchestration worth real investment. The danger is multi-agent sprawl with no shared identity and no audit trail, where the leverage you bought turns into liability you did not.

## The Substrate Stack & Memory

It helps to locate yourself on a ladder of maturity, where each rung is a genuine technological bet rather than a slogan:

| Level | Substrate | Reality |
| --- | --- | --- |
| Vibe | Model + IDE | Fine solo; fragile at scale |
| Spec | Structured tooling | Step two; collapses on big systems |
| Intent | Plays + memory + crafts | Where serious tools head |
| Autonomous | Shared guardrails | Theory for most |
| Dark factory | Self-running pipeline | Aspirational |

Memory is the prerequisite for the upper rungs, because continuity needs an empirical record to reason over, and most teams are honestly nearer the middle than they admit. Name your level before committing to the next; claiming a rung whose substrate you have not built is how certainty gets sold that no one has earned.
