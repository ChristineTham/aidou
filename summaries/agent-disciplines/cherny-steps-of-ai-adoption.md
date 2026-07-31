# Summary — Steps of AI Adoption (Cherny, 2026)

> [!NOTE]
> **Source status: a vendor maturity model, not research.** Written by Boris Cherny, the creator of
> Claude Code, and published 16 July 2026
> ([source](../../sources/agent-disciplines/cherny-steps-of-ai-adoption.md)). It presents no data,
> no study, and no evaluation — it is a well-informed practitioner's map of how organisations adopt
> coding agents.
>
> **Conflict of interest: strong.** Cherny built the product the model recommends. Two of the six
> columns are literally an Anthropic product catalogue, and every named tool is Anthropic's, so the
> ladder doubles as a sales path.
>
> **Access caveat:** the URL is a claude.ai artifact. An automated read on 2026-07-24 was refused
> because the fetch came from a non-member reader, so the link may not resolve for readers without
> a Claude account. Any citation should say so.

## Abstract

Cherny stages organisational adoption of coding agents in five steps, each defined by how many
agents one person runs and what that makes their job. **Step 0 (Gated)** is an organisation that has
not really started: old models approved, access process-heavy, nowhere to deploy what gets built.
**Step 1 (Assisted)**, ~1 agent, is a pair — you review nearly every change, and the work is
synchronous, because you sit and watch. **Step 2 (Parallel)**, ~10 agents, makes you an
*orchestrator*: agents in separate worktrees, self-verification before you look, and you review
final diffs instead of keystrokes. **Step 3 (Supervised autonomy)**, ~100 agents, makes you a
*manager of managers*, where the question shifts from "did you read the code?" to "what context was
the model missing, and how do we fix that for next time?" **Step 4 (AI-native)**, ~1,000+ agents,
has Claude kicking off most of the work while you *steer by intent and monitor by exception*.

## The column that matters: the bottleneck

Read down the bottleneck column and the same answer appears at every rung, which is what makes the
piece worth citing despite its provenance. The limit is never the models:

| Step | Agents | The stated bottleneck |
| --- | --- | --- |
| 1 Assisted | ~1 | "Your attention and the need to inspect each response and code edit" |
| 2 Parallel | ~10 | "Reviewing output… checking six streams of it" |
| 3 Supervised autonomy | ~100 | "Trust in the loop and your team's decision throughput" |
| 4 AI-native | ~1,000+ | "Identifying and automating work at scale, and enforcing the right guardrails" |

Three of the four are human attention, human review, and human trust. Even the trap Cherny names at
step 3 is a human error of judgement: "scaling agent count before the loop has earned widespread
trust."

## Other points worth keeping

- **Each step is unlocked by a verification capability, not a model upgrade.** Getting from 1 to 2
  requires "a self-verification loop you trust (tests + build + lint + e2e testing)"; 2 to 3
  requires context access and code-review speed. The gates are engineering discipline.
- **The role names are the argument**: pair → orchestrator → manager of managers → VP steering by
  intent. Adoption is described as a management progression, not a tooling one.
- **A quality bar worth quoting**: "Hold the same quality bar for human and agent-generated code."
- **Step 0 is a governance diagnosis** — the failure is "focuses on cost-per-token containment vs.
  outcomes" and a "lack of true technical voices in decisionmaking."

## What it does not establish

Nothing empirical. There is no evidence that organisations actually pass through these steps, that
the agent counts are achievable, or that the ordering holds. The unlock claims ("a backlog that used
to take the team weeks becomes one engineer's afternoon") are vendor illustrations, not measurements
— and the book's own §4.3.2 evidence points the other way on review capacity, since validation does
not speed up when generation does.

## Relation to the book

The natural home is **§4.4 The Inversion**, whose thesis is that "the size of the fleet you can run
is set by how much of its output you can actually review". Cherny's table is that claim staged and
costed, with the bottleneck named at every rung — and it is the more striking for coming from the
person who built the tools, who might be expected to say the models were the limit. Cite it as the
vendor's own ladder conceding the book's point, hedged for what it is.

Runner-ups noted, not used: **§4.2.3 Orchestration** (the agent-count progression fits, but the
section already carries the multi-agent org-design research) and **§4.3.2 Delegation and Review**
(the review-capacity bottleneck is there, but Garousi 2026 already makes that point with evidence).
One citation, in §4.4.

Note for placement: the two product-catalogue columns should not go into the book. They are
Anthropic's feature list, they will date within months, and they carry none of the argument.
