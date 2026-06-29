# Chapter 2 — Personal Productivity (愛 in practice)

If Chapter 1 set the stance, this chapter is where it touches the desk. Productivity is the most personal use of AI and the easiest to do superficially, so the aim here is to move from chatting to delegating, to put the gains where they actually are, and to build a personal system that compounds rather than resets every morning.

## From Chat Assistant to Ambient Teammate

Most people meet AI as a chat box, and that framing quietly caps what they get from it. A conversation is synchronous: you ask, you wait, you steer, you ask again, and your attention is the rate limiter. An ambient teammate works differently. You hand it a bounded task, it works asynchronously, and you return to a result rather than a transcript.

> [!NOTE]
> An **ambient teammate** is an agent that runs asynchronously in the background — given a scoped task and the tools to finish it — rather than waiting on each instruction. You delegate the task, not the keystrokes.

The shift sounds small and is not, because it changes who the bottleneck is. As Karpathy argues, the goal is to remove yourself from the loop and maximise token throughput rather than supervising every step ([Loopcraft](https://www.latent.space/p/ainews-loopcraft-the-art-of-stacking)). The OpenAI internal figures make the leverage tangible: agent output grew many-fold across functions once people stopped babysitting and started delegating. The practice is to scope work tightly, fire it off, and review the outcome; the temptation worth resisting is hovering over each keystroke, which pins your leverage to your own typing speed.

## Knowledge Work, Not Just Code

The surprising lesson of 2026 is that the biggest agent gains are in knowledge work — research, writing, synthesis, decision support — not in code. These are bounded, high-feedback tasks where a model can draft, compare, and summarise faster than any human, and where production was never the slow part. The effect is unevenly distributed: a study of 5,179 customer-support agents found AI assistance raised resolved-issues-per-hour by 14% on average but 34% for novices, with little gain for experts — the tool spreads the best workers' tacit know-how to everyone else ([Brynjolfsson, Li & Raymond 2023](https://www.nber.org/papers/w31161)). What stays expensive is judgement: deciding whether the work was worth doing at all. So the rule is to delegate the drafting and the bookkeeping freely while keeping the "why" for yourself. McKinsey's high performers do exactly this, treating AI as a catalyst for redesigned work rather than faster typing ([McKinsey 2025](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai)). The reach extends to elicitation itself: an LLM reading stakeholder interviews not only extracted explicit needs at 84.4% F1 but inferred *latent* ones experts judged useful 75% of the time — surfacing opportunities humans had not voiced ([LENS](../research/papers/2606.25867-latent-requirements.md)). The failure that shadows the gain is producing more while validating less — confident output at volume that nobody has checked.

## Personal Operating Models

Leverage compounds only if you stop re-deciding everything. A personal operating model is a small, reusable kit: plays you can rerun, preferences encoded once so you never re-explain them, and a daily workflow that feeds itself. The point is to turn scattered prompting into a system, the same instinct the book applies everywhere — repeatable patterns over one-off prompts. The waste it removes is re-solving the same problem from scratch each session, which feels productive and is not.

## Building an LLM Wiki

The clearest example of compounding is Karpathy's LLM Wiki, and it deserves a careful look because it inverts the usual pattern. Most document workflows are retrieval: you upload files, the model fetches chunks at query time, answers, and forgets, so it rediscovers knowledge on every question and nothing is built up. A wiki accumulates instead. When you add a source, the model reads it once, extracts what matters, and integrates it into interlinked markdown pages — updating entity pages, flagging where new data contradicts old, strengthening the synthesis — so the cross-references and contradictions are resolved ahead of the next question rather than reconstructed each time ([llm-wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)).

Three layers make it work: read-only raw sources you never let the model edit, an LLM-owned wiki of summaries and concept pages, and a schema file — CLAUDE.md or AGENTS.md — that tells the agent how the wiki is structured and how to maintain it.

```mermaid
flowchart LR
    R[Raw sources: read-only] --> I[Ingest]
    I --> W[LLM-owned wiki]
    W --> Q[Query] --> W
    W --> L[Lint: drift + contradictions] --> W
    S[Schema: CLAUDE.md / AGENTS.md] -.governs.-> W
```

The loop is ingest, query, lint: drop in a source and it touches a dozen pages; ask a question and good answers get filed back as new pages; periodically health-check for contradictions and stale claims. The reason it holds where human wikis rot is that the tedious part is bookkeeping, and the model does not get bored. The pitfall, which practitioners running it for months confirm, is confident-but-stale pages hardening into truth — which is why the lint pass that hunts drift is not optional but central.
