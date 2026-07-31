# Summary — Loop engineering: Getting started with loops (Anthropic, 2026)

> [!NOTE]
> **Source status: vendor practitioner guide, not research.** Written by Delba de Oliveira and
> Michael Segner and published on Anthropic's own Claude blog, 30 June 2026
> ([source](../../sources/agent-disciplines/anthropic-getting-started-with-loops.md);
> [original](https://claude.com/blog/getting-started-with-loops)). It reports no experiment, no
> measurement, and no evaluation — every claim is the team's design opinion.
>
> **Conflict of interest: strong and unavoidable.** Anthropic is describing how to use the product
> it sells. Each loop type is introduced together with the Claude Code primitive that implements it
> (`/goal`, `/loop`, `/schedule`, dynamic workflows, auto mode, skills), and the article closes on
> product calls-to-action. Cite it for the *framing* — how a team that builds these tools
> categorises the craft — never as evidence that the framing is correct or that the tools work.

## Abstract

The piece answers a question the field has been arguing about loudly and imprecisely: what is a
"loop", exactly? The Claude Code team's definition is deliberately narrow — **"agents repeating
cycles of work until a stop condition is met"** — and from it they derive a four-rung taxonomy
sorted by how a loop is triggered and how it stops: *turn-based* (you prompt, the agent works until
it judges itself done), *goal-based* (an evaluator model holds the agent to a success criterion you
wrote, capped by a turn limit), *time-based* (an interval triggers a re-run, for recurring work or
for polling an external system), and *proactive* (an event or schedule fires it with no human
present). The most useful idea for a reader is not the taxonomy itself but the axis the article's
closing table reveals: each rung is defined by **what the human hands off** — the check, then the
stop condition, then the trigger, then the prompt itself. The article then argues that loop output
quality is a property of the surrounding system, not the loop, and gives its main quality lever as
giving the agent a way to verify its own work — plus a second agent for review, "less biased and
not influenced by the main agent's reasoning."

## The four loop types

| Loop | Triggered by | Stops when | Best for |
| --- | --- | --- | --- |
| Turn-based | A user prompt | The agent judges the task done or needs more context | Short, one-off tasks |
| Goal-based | A manual prompt | Goal met, or a turn cap is hit | Tasks with verifiable exit criteria |
| Time-based | A time interval | You cancel, or the work completes | Recurring work; polling external systems |
| Proactive | An event or schedule, no human present | Each task exits at its goal; the routine runs until switched off | Recurring streams of well-defined work |

The article's own summary table adds the column that matters most:

| Loop | You hand off |
| --- | --- |
| Turn-based | The check |
| Goal-based | The stop condition |
| Time-based | The trigger |
| Proactive | The prompt |

## Key points

- **The definition is a stop condition.** What makes a loop a loop, in this framing, is not
  repetition but the *criterion that ends it*. That reframes loop design as "decide what done means"
  rather than "let it keep going."
- **Goal-based loops externalise the stop decision.** The stated problem with turn-based work is
  that the agent decides for itself when it is "good enough" and stops early; `/goal` puts an
  evaluator model in the way of that decision. Hence the advice that deterministic criteria (tests
  passed, a score threshold) work best — a claim offered as design experience, not measurement.
- **Escalate deliberately, not by default.** "Not all tasks require complex loops; start with the
  simplest solution and use these patterns selectively." The piece is unusually restrained for
  vendor writing on this point.
- **Quality comes from the system around the loop**: a clean codebase the agent can pattern-match,
  encoded verification, reachable docs, and a second reviewing agent with fresh context. And when
  one output falls short, "don't stop at fixing the individual issue" — fix the system so every
  later iteration benefits.
- **Cost control is loop design.** Match the primitive and model to the task, set explicit stop
  criteria, pilot before a large fan-out, use scripts for deterministic steps, and match a
  routine's interval to how fast the watched thing actually changes.

## What this does *not* establish

No numbers, no baseline, no comparison. There is no evidence here that goal-based loops outperform
turn-based ones, that the taxonomy is complete, or that the recommended practices improve outcomes.
The one empirical-sounding claim — that a second agent reviewing with fresh context "is less
biased" — is asserted, not shown. For measured claims about verification inside loops the book
should keep leaning on its research citations (Suresh Babu & Agrawal 2026; Huang et al. 2023).

## Relation to the book

The natural home is **§4.2.4 Loop Engineering**, which already carries the *research* on control
loops and verification but no practitioner taxonomy of loop kinds. The article's hand-off ladder —
check → stop condition → trigger → prompt — restates this book's central thesis (using AI well is a
delegation skill) in the specific vocabulary of loops, and it comes from the team building the
tools, which makes it a useful outside echo of the argument.

Runner-up placements, noted and not used: **§6.6**, which already cites swix's "loop-stacking" from
the AI Engineer World's Fair — the same step-up-a-rung idea, so citing this there would duplicate a
point the chapter already makes; and **§4.2.3 Orchestration** / **§4.3.2 Delegation**, both of which
touch the fan-out and hand-off themes but are better served by the sources already in place. One
citation, in §4.2.4, cross-referenced to §6.6.
