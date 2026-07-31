# Summary — Karpathy on the growing gap in understanding AI capability (9 April 2026)

> [!NOTE]
> **Source status: a practitioner's argument posted on X, not research.** 505 words from Andrej
> Karpathy, 9 April 2026
> ([source](../../sources/ai-landscape/karpathy-capability-gap-post.md);
> [original](https://x.com/karpathy/status/2042334451611693415)). No data, no measurement, no
> citation — it is an explanation offered from long experience inside the labs.
>
> **Conflict of interest: mild.** Karpathy's standing rises with the field's credibility, and the
> post praises OpenAI Codex and Claude Code by name. Against that, it is also pointedly critical of
> how labs choose what to improve, which is not the usual insider line.

> [!WARNING]
> **Do not quote his phrase "AI Psychosis."** He uses it loosely, for intoxication with the
> technology among heavy technical users. The book uses *AI psychosis* in §4.1.5 in its clinical
> sense — delusional spirals in vulnerable users (Dohnány et al.; Au Yeung et al.; Moore et al.).
> Quoting Karpathy's usage anywhere in the book would collide with an established term and mislead.

## Abstract

Karpathy sets out to explain why people who look at the same technology report wildly different
things. He gives two reasons. The first is simply what people have tried: many formed their view on
a free or deprecated model last year, and are still reasoning from the viral clips of a voice
assistant fumbling a trivial question. The second, and the substantial one, is that capability is
**"peaky"** — the dramatic recent gains are concentrated in narrow technical territory, while
"search, writing, advice" have not moved nearly as much. He offers a two-part mechanism for that
concentration. Technically, programming and mathematics "offer explicit reward functions that are
verifiable" — a unit test passes or it does not — which makes them amenable to reinforcement
learning, whereas writing is "much harder to explicitly judge." Commercially, those same domains
"are a lot more valuable in b2b settings, meaning that the biggest fraction of the team is focused
on improving them." So the two groups end up "speaking past each other": the same month in which a
free voice assistant fumbles a simple question, a top-tier coding model will work for an hour to
restructure an entire codebase.

## The citable core

1. **Capability gains are uneven by domain, not by difficulty.** Coding, maths and research have
   surged; everyday writing, search and advice have not.
2. **Cause one — verifiable rewards.** Domains where success can be checked automatically can be
   trained hard by reinforcement learning. Writing has no such marker.
3. **Cause two — commercial pull.** The checkable domains are also where the business value is, so
   that is where the engineering effort goes.
4. **The consequence for observers.** Two honest people can hold opposite views of AI's capability
   because they are standing in different domains, at different price tiers, in different years.

## What it does not establish

Nothing is measured here. There is no evidence offered for the relative rates of improvement across
domains, no benchmark, and no comparison. The mechanism is plausible and widely believed among
practitioners, but as cited it is an informed explanation, not a finding.

## Relation to the book

The natural home is **§1.5 The Limits That Remain**, at the point where the book explains *why*
competence is jagged. Chapter 1 currently gives one cause — "the model's strength tracks the density
of its training data, not the difficulty we perceive" — illustrated by the Stanford Index's Olympiad
gold against the misread analogue clock. Karpathy supplies a second and more current cause: since
the shift to reinforcement learning on verifiable rewards, strength also tracks whether a domain
*can be automatically checked*, and where the money is. That directly serves this book's readers,
who will have noticed that a coding agent can feel transformative in the same week a writing
assistant feels ordinary. Note that Karpathy is already cited two sentences earlier in §1.5 for
*microGPT* (2026b) — this is a different work making a different point, so it takes its own label
(2026c).

Runner-ups noted, not used: **§6.3 Where AI Is Heading** (frames expert disagreement, but about AGI
timelines and the future, whereas this post is about disagreement over *present* capability); and
**§2.8**, which already carries the jagged-frontier evidence from Dell'Acqua. One citation, in §1.5.
