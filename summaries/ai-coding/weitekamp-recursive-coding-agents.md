# Recursive Coding Agents — Raymond Weitekamp — Summary

> [!NOTE]
> Source (one talk, two forms): [weitekamp-recursive-coding-agents-talk.md](../../sources/ai-coding/weitekamp-recursive-coding-agents-talk.md) (video transcript, https://www.youtube.com/watch?v=3hXJI2q0Jz8) and [weitekamp-recursive-coding-agents-slides.md](../../sources/ai-coding/weitekamp-recursive-coding-agents-slides.md) (slides, https://recursivecodingagents.com) — Raymond Weitekamp (RAW.works / OpenProse), *Recursive Coding Agents*, AI Engineer World's Fair, 2026.
>
> **Practitioner conference talk, not research or established practice**, and self-interested — Weitekamp promotes his own OpenProse tooling. The video text is an **auto-generated transcript** (unreliable punctuation, no speaker labels; it mis-hears his own name as "Raymond Whitcomb" — verified name Raymond Weitekamp from oEmbed and the slides site). The slides give the clean wording for anything quoted. This is **one source in two forms**: cite once, with the video and slides as companion references, not two separate injections.

## Abstract

Weitekamp applies the idea of **Recursive Language Models** (Zhang, Kraska & Khattab, arXiv 2512.24601 — already cited in the book) to *coding agents*. His motivating claim: we all want reliable agents that deliver outcomes while we are "out on a hike", but "the bottleneck is not intelligence — it's reliability, it's trust." His own example: one day an agent builds a full SaaS app from a single prompt; the next, Claude Code "empties the entire contents of my Solana wallet." The intelligence is clearly there; what fails is dependability.

## The thesis: "mismanaged geniuses"

The talk's central framing is **"today's agents are mismanaged geniuses"** (he calls it the "Mismanaged Geniuses Hypothesis"): "The intelligence is there. The missing layer is how we specify, manage, reuse, and verify the work." His prescription borrows the RLM structure and points it at coding:

- **Externalize** — the full prompt lives in a REPL, not the context window.
- **Operate** — the model writes code to inspect, slice, and transform it.
- **Recurse** — it sub-queries itself over the slices, forming a tree of RLMs and LLMs at increasing depth (root → sub-RLM → LLM, depth 0/1/2).

"Context itself is the object of computation." He argues a coding agent (e.g. Claude Code) can be turned into an RLM through dynamic workflows, unifying tool-calling and reasoning, where one available tool is calling another agent on a sub-task. He closes on responsibility ("recurse responsibly") and the slogan "stop babysitting agents, start authoring outcomes."

## Relation to the book

Two threads meet here, which is why one placement is enough:

1. It **builds directly on the RLM paper already cited in §4.2.2 (Context and Memory)** — same authors' idea (externalize / operate / recurse; context as the object of computation), now applied to coding agents. So the natural home is right after the RLM paragraph in §4.2.2, as the practitioner application of that research.
2. Its "mismanaged geniuses" framing — the bottleneck is management and verification, not raw intelligence — is a vivid practitioner statement of **Chapter 4's central thesis** (delegating to agents is a management job; the better the agents, the more the human disciplines matter). That makes it a fitting one-sentence echo, not a second citation to open elsewhere.

Cite once in §4.2.2 (video + slides as companion references), flagged as a self-interested conference talk. Do not also cite it in the chapter intro or §4.1 — that would repeat the same point; the intro already carries the management thesis with its own framing.
