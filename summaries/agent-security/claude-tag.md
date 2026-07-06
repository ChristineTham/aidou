# Introducing Claude Tag — Summary

> [!NOTE]
> **Source:** [claude-tag.md](../../sources/agent-security/claude-tag.md) · Anthropic, 23 June 2026 · https://www.anthropic.com/news/introducing-claude-tag.
> Study-guide summary of the full document. See the original for exact wording and figures.

## Abstract

Anthropic's product announcement (23 June 2026) introducing **Claude Tag**: a persistent, taggable Claude that joins Slack as a team member, framed as "the beginning of an evolution of Claude Code" — more proactive, and built to work with a full team rather than one user.

**Key points**

- **What it is:** Claude joins Slack channels an administrator grants it access to; anyone in a channel tags `@Claude` to delegate tasks. It connects to chosen tools, data, and codebases, breaks tasks into stages, and replies in a Slack thread when done.
- **Headline figure (verbatim):** "Today, 65% of our product team's code is created by our internal version of Claude Tag." The pattern is spreading beyond engineering — chasing product metrics, working support tickets, root-causing bugs.
- **Multiplayer:** one Claude per channel, shared by everyone — anyone can see what it is working on and pick up the conversation where the last person left off.
- **Learns over time:** it builds context from the channels it follows, and can learn from other channels and data sources *if granted permission*; it does not report from private channels.
- **Takes initiative / works asynchronously:** with "ambient" behaviour enabled it proactively flags relevant information and follows up on stalled threads; it can schedule its own tasks and pursue a project autonomously over hours or days.
- **Permissioned and scoped:** administrators specify which tools and information it can access, per channel — separate Claude identities whose memories stay scoped to their channels (a sales Claude won't pass memories to an engineering one). Admins set token-spend limits (organisation and per-channel) and can view a log of everything @Claude has done and who requested each task.
- **Availability:** beta for Claude Enterprise and Team customers from launch day; it **replaces the existing Claude in Slack app** (admins can opt in to migrate within 30 days); runs on Opus 4.8.

**Takeaways**

- Claude Tag is the shared-agent-as-teammate model: persistent, multiplayer, asynchronous, and proactive — a step beyond single-user chat sessions.
- The security posture is administrator-defined scoping: channel-scoped identities and memories, explicit tool/data grants, spend limits, and an audit log of tasks and requesters.
- The announcement does **not** use the phrase "service accounts" — that framing comes from secondary coverage, not Anthropic's own text.

## Announcement overview

- **Claude Tag** is "a new way for teams to work with Claude", starting on Slack, "which Claude can join as a team member". You grant Claude access to selected channels and connect it to whichever tools, data — "and even codebases" — you choose; then anyone in the channel can tag `@Claude` in and delegate tasks while they focus on other work.
- Claude **builds context** by remembering relevant information from the channels it's in, and can plan out tasks to complete in the future.
- Anthropic positions it as "the beginning of an evolution of Claude Code": it makes the model even more proactive, and it works better with a full team.

> [!IMPORTANT]
> **Internal adoption claim (exact sentence):** "Today, 65% of our product team's code is created by our internal version of Claude Tag." Anthropic says tagging @Claude "is now one of the main ways we get things done at Anthropic", and the pattern is spreading beyond engineering — chasing down product metrics and data, working through support tickets, and helping find the root cause of tricky bugs.

- **Why Slack first:** it's "a natural home for collaborative work between teams and AI" and where much of Anthropic's day-to-day work already happens. Available "today in beta" for Claude Enterprise and Team customers, with a stated goal of expanding "so that teams can tag @Claude in the many other places they work".

## Working with @Claude

Familiar to Claude Code or Cowork users: tag @Claude with a request in simple terms and it breaks the task into stages, works through them with the tools it has access to, and responds in a Slack thread with what it created. Four new properties distinguish it:

| Property | What the announcement says |
|---|---|
| **Multiplayer** | Within a given Slack channel there is *one* Claude that interacts with everyone. Anyone can see what it's working on and pick up the conversation where the last person left off — "much more like interacting collaboratively with a teammate" than a single chat or single task. |
| **Learns over time** | Following its channel builds context, so users needn't re-explain from scratch. It can automatically learn from other Slack channels and data sources *if granted permission* — and "it doesn't report from private channels". This gives it the "tacit knowledge" for its best work. |
| **Takes initiative** | With "ambient" behaviour enabled, Claude proactively keeps you updated on what it thinks you need to know: flagging relevant information across its channels and connected tools, and following up on threads or tasks that have gone quiet without being resolved. |
| **Works asynchronously** | Set a task and focus on other priorities while it works. It can schedule tasks for itself and pursue a project autonomously over hours or days. Anthropic reports spending "much more of our time delegating tasks to many Claudes in parallel". |

- **Direct messages:** you can DM Claude; it responds privately, using the personal tools and connectors you have set up.

## Getting started (access control and administration)

Designed "with teams and organizations in mind": @Claude's access to sensitive data and task-specific tools "can be very tightly controlled".

- **Admin-defined scoping:** system administrators specify which tools and information the model can access, in which channels — framed as "creating separate Claude identities for different uses". Everything, *including its memories*, stays scoped to the channels the administrators define: a model set up for sales won't pass memories to one set up for engineering, nor give engineers access to sales data or tools.
- **Spend limits and auditability:** administrators can set token-spend limits for the organisation and for individual channels, and can view a log of everything @Claude has done, along with who requested each task.
- **Setup steps** (for Enterprise/Team customers, beta from launch day):
  1. Pair Claude Tag with your Slack workspace.
  2. Give Claude access to your tools.
  3. Set a limit on your organisation's monthly spend.
  4. Test Claude in a private channel to confirm it works.
- **Migration:** Claude Tag **replaces the existing Claude in Slack app**; administrators can opt in to migrate within 30 days. Anthropic is issuing an introductory launch credit to eligible Enterprise and Team organisations.
- **Model:** Claude Tag works with **Opus 4.8**.

## What the announcement does not say

> [!WARNING]
> Points sometimes attributed to this announcement that its text does not contain:
>
> - The phrase **"service accounts"** appears nowhere in the announcement — secondary coverage added that framing.
> - No pricing beyond spend limits and the introductory launch credit; no general-availability date; no non-Slack platforms named (expansion is a stated goal only).
> - On private channels, the exact claim is narrow: "It doesn't report from private channels" — said in the context of Claude automatically learning from other channels and data sources.
