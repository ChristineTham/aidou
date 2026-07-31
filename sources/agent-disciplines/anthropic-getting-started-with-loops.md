# Loop engineering: Getting started with loops

- Source URL: https://claude.com/blog/getting-started-with-loops
- Authors: Delba de Oliveira and Michael Segner (stated in the article: "This article was
  written by Delba de Oliveira and Michael Segner")
- Publisher: Anthropic — Claude blog (claude.com/blog), category "Claude Code"
- Date: 30 June 2026
- Reading time given on page: 5 min
- Type: **Vendor engineering blog post / practitioner guide — not peer-reviewed.**
  **Conflict of interest: strong.** Anthropic is describing its own product. Every primitive
  named (`/goal`, `/loop`, `/schedule`, dynamic workflows, auto mode, skills, `/code-review`,
  `/usage`) is a Claude Code feature the company sells, and the piece ends in product
  calls-to-action. Read it as how one vendor's team frames the craft, not as evidence.

---

## Getting started with loops

There's a lot of talk right now about loop engineering or "designing loops" instead of prompting
your coding agent. If you spend some time on X trying to pin down what a loop actually is, you'll
come across multiple different answers.

On the Claude Code team, we define loops as **agents repeating cycles of work until a stop
condition is met**. We categorize a few different types of loops based on:

- How they are triggered
- How they are stopped
- What Claude Code primitive is used
- What type of task is most appropriate for each.

We'll cover the main loop types, when to use each, and how to maintain code quality while managing
token usage. Not all tasks require complex loops; start with the simplest solution and use these
patterns selectively.

## Turn-based loops

- **Triggered by**: A user prompt.
- **Stop criteria**: Claude judges it has completed the task or needs additional context.
- **Best used for**: Shorter tasks that are not part of a regular process or schedule.
- **Managed usage by**: Write specific prompts and improve verification using skills to reduce the
  number of turns.

Every prompt you send starts a manual loop with you directing each turn. Claude gathers context,
takes action, checks its work, repeats if needed, and responds. We call this the agentic loop.

For example, ask Claude to create a like button. It reads your code, makes the edit, runs the
tests, and hands back something it believes works. You then manually check the work, and write the
next prompt.

You can improve the verification step by encoding your manual steps as a SKILL.md so Claude can
check more of its own work, end-to-end. This should include tools or connectors to allow Claude to
see, measure or interact with the result. The more quantitative the checks are, the easier it is
for Claude to self-verify.

(The article then gives an example `verify-frontend-change` SKILL.md: start the dev server, open
the edited page, interact with the change and screenshot before/after, check the browser console
for zero new errors, run a performance trace — and "If any step fails, fix the issue and rerun from
step 1 — do not hand back partially verified work.")

## Goal-based loop (/goal)

- **Triggered by**: A manual prompt in real-time.
- **Stop criteria**: Goal achieved OR maximum number of turns reached.
- **Best used for**: Tasks that have verifiable exit criteria.
- **Managed usage by**: Setting a specific completion criteria and explicit turn caps, "stop after
  5 tries."

Sometimes, a single turn is not enough, especially for more complex tasks. Agents do better when
they can iterate. You can extend how long Claude keeps iterating by defining what done looks like
with `/goal`.

When you define the success criteria, Claude doesn't have to make a determination on what is "good
enough" and end the loop early. Each time Claude tries to stop, an evaluator model checks your
condition and sends it back to work until the goal is met or a number of turns you define is
reached.

This is why deterministic criteria, such as number of tests passed or clearing a certain score
threshold, are so effective. For example:

    /goal get the homepage Lighthouse score to 90 or above, stop after 5 tries.

## Time-based loop (/loop and /schedule)

- **Triggered by**: A specified time interval.
- **Stop criteria**: You cancel it, or the work completes (the PR merges, the queue is empty).
- **Best used for**: For recurring work, or interfacing with external environments / systems.
- **Managed usage by**: Set longer intervals or react based on events rather than time.

Some agentic work is recurring: the task stays the same and only the inputs change. For example,
summarizing Slack messages every morning. Other work depends on external systems, and a simple way
to interface with one is to check it on an interval and react to what changed. For example, a PR
which may receive code reviews or fail CI.

For these, you can trigger when Claude runs with `/loop` which re-runs a prompt on an interval:

    /loop 5m check my PR, address review comments, and fix failing CI

`/loop` runs on your computer, so if you turn it off, it stops. You can move the loop to the cloud
by creating a routine with `/schedule`.

## Proactive loops

- **Triggered by**: An event or schedule, with no human in real time.
- **Stop criteria**: Each task exits when its goal is met. The routine itself runs until you turn
  it off.
- **Best used for**: Recurring streams of well-defined work: bug reports, issue triage,
  migrations, dependency upgrades, etc.
- **Managed usage by**: Routing routines to smaller, faster models and using the most capable model
  for judgment calls.

The primitives above, along with other Claude Code features like auto mode and dynamic workflows
(research preview) can be composed into a loop for long-running work. For example, to handle
incoming feedback, you can use `/schedule` to run a routine that checks for new reports; `/goal` to
define what done looks like and skills to document how to verify it; dynamic workflows to
orchestrate agents that triage each report, fix it, and review the fix; and auto mode so the
routine runs without stopping to ask for permission.

## Maintaining code quality

The quality of a loop's output depends on the system around it. When designing the system:

- **Keep the codebase itself clean**: Claude follows patterns and conventions that already exist in
  your codebase.
- **Give Claude a way to verify its own work**: Encode what good looks like for you and your team
  with skills.
- **Make docs easy to reach**: Frameworks and libraries docs have up-to-date best practices.
- **Use a second agent for code reviews**: A reviewer with fresh context is less biased and not
  influenced by the main agent's reasoning.

When an individual result doesn't meet the standard, don't stop at fixing the individual issue, try
to encode it to improve the system for all future iterations.

## Managing token usage

To manage token usage, loops should have clear boundaries:

- Choose the right primitive and model for the job: Smaller tasks don't need multiple agents or
  loops. Some tasks can use cheaper and faster models.
- Define clear success and stop criteria: Be specific about what done looks like so Claude can
  arrive at the solution sooner (but not too soon).
- Pilot before a large run: Dynamic workflows can spawn hundreds of agents. Gauge usage on a
  smaller slice of the work first.
- Use scripts for deterministic work: Running a script is cheaper than reasoning through the steps.
- Don't run routines more often than you need to: Match the interval to how often the thing you're
  watching changes.
- Review usage: the `/usage` command breaks down recent usage by skills, subagents, and MCPs.

"Your model and effort level choices are among the biggest levers on what a loop costs."

## Getting started (the summary table)

| Loop | You hand off | Use it when | Reach for |
| --- | --- | --- | --- |
| Turn-based | The check | You're exploring or deciding | Custom verification skills |
| Goal-based | The stop condition | You know what done looks like | `/goal` |
| Time-based | The trigger | The work happens outside your project on a schedule | `/loop`, `/schedule` |
| Proactive | The prompt | The work is recurring and well-defined | All of the above, and dynamic workflows |

To get started with loops, look at the work you already do. Pick one task where you're the
bottleneck and ask which piece you could hand off: can you write the verification check? Is the
goal clear enough? Does the work arrive on a schedule?

Once you have an idea, run the loop, observe the results like where it stalls or over-reaches, and
don't be afraid to iterate on it.
