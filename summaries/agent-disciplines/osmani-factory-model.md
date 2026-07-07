# The Factory Model: How Coding Agents Changed Software Engineering — Summary

> [!NOTE]
> **Source:** [osmani-factory-model.md](../../sources/agent-disciplines/osmani-factory-model.md) · Addy Osmani, 25 February 2026 · blog post, https://addyosmani.com/blog/factory-model/.
> Osmani is an engineering and evangelism leader with over 14 years at Google leading developer experience across Chrome and, more recently, AI (Gemini, coding agents, agentic engineering), most recently a Director at Google Cloud AI. The essay expands on remarks by Michael Truell (Cursor).
> Study-guide summary of the full document. See the original for exact wording and figures.

## Abstract

An essay arguing that agentic coding is a step change in abstraction — from writing code to orchestrating systems that write code — and that the developer's job is becoming **building the factory that builds the software**, while the core of software engineering (requirements, architecture, tests, judgment) remains human and matters more than before.

**Key points**

- **Two ideas in tension:** coding has changed dramatically; software engineering, at its core, has not. The gap between the two is where the story lives.
- **Arc of abstractions:** bits → instructions → functions → objects → services → distributed systems; assembly → C → managed languages → frameworks/cloud. Agentic coding is the next step, what Grady Booch calls software's **third age** — the developer's job shifts from writing instructions to defining intent.
- **Three generations of AI coding tools:** (1) accelerated autocomplete; (2) synchronous agents you supervise step by step; (3) **autonomous agents** that take a spec and run for thirty minutes, hours, "and increasingly days" — setting up environments, writing tests, researching failures, producing pull requests — while you define outcomes and review results. Swarms and self-improving agents sit here.
- **Factory model:** fleets of parallel agents, each with a task, a toolbelt, context, and a feedback loop. The factory analogy carries: quality control, process documentation, precisely specified inputs, and stalls when the environment is unreliable. In aggressive adopters, "a substantial portion of merged pull requests now originate from agents running autonomously in cloud environments".
- **The spec is the leverage:** at 20–50 parallel agents, ambiguity multiplies — vague specs propagate error across the whole fleet. "The spec is not a prompt anymore. The spec is the product thinking made explicit." Strong engineers therefore get *more* leverage from these tools, not less.
- **What stays human:** clear requirements, strong abstractions, reliable tests, careful tradeoffs, and human oversight — agents "make confident mistakes" good enough to pass casual review, so the review bar rises.
- **Red/green TDD becomes close to mandatory:** post-hoc tests confirm what the implementation happens to do; agents optimising to pass tests will game them. Telling an agent to use red/green TDD is "one of the highest-leverage instructions you can give".
- **The unsolved problem is verification, not generation:** brittle UI verification, context-window blind spots, and flaky environments that become systemic blockers at fleet scale. Until verification catches up, human review is the safety system, not optional overhead.
- **Adoption metrics:** new website creation up 40% year over year; new iOS apps up nearly 50%; US GitHub code pushes up 35% — all flat for years before late 2024. Quantity does not necessarily mean quality, but the barrier to creating software has genuinely dropped.

**Takeaways**

- Invest where the factory analogy points: better specs, test infrastructure, documentation and commit history an onboarding engineer (or agent) could learn from, and reliable environments.
- The high-leverage skills are systems thinking, problem decomposition, architectural judgment, specification clarity, output evaluation, and orchestration — old skills whose *relative importance* has jumped.
- "The era of programming as primarily a keystroke activity is over"; the factory model "is not a metaphor about losing control of software. It is a metaphor about building leverage."

## Introduction: two ideas in tension

Something shifted with agentic engineering that feels like the level of abstraction changed again — not a gradual tool improvement but "a step change"; veteran developers describe "the center of gravity of the craft" moving. Osmani's framing device: hold two ideas simultaneously — **coding has changed dramatically; software engineering, at its core, has not** — because understanding that gap "is the difference between engineers who thrive in this era and engineers who get left behind by it". He writes to expand on Michael Truell's (Cursor) thoughts.

## The arc of abstractions

- The history of software engineering is the history of raising abstraction: bits → instructions → functions → objects → services → distributed systems; assembly → C → managed languages/garbage collection → frameworks, package ecosystems, cloud. Each jump made individuals more productive and enlarged the population who could build software; each felt disruptive at the time and looks in hindsight like the next step in one consistent arc.
- The current step: **moving from writing code to orchestrating systems that write code**.
- **Grady Booch** calls this software's **third age** — a new golden era of rising abstraction in which the developer's job shifts from writing instructions to **defining intent**. The framing matters because "it tells you what to hold onto and what to let go of".

## Three generations of AI coding tools

Osmani insists on precision here because "conflating the generations leads to underestimating how much has actually changed".

| Generation | What it is | Autonomy / workflow |
|---|---|---|
| **First: accelerated autocomplete** | Predicts the next line, fills boilerplate, saves keystrokes | You drove, the tool assisted; the write–run–debug loop unchanged, just with less friction |
| **Second: synchronous agents** | You describe a task in natural language; the model generates code; you review, correct, iterate | Less typing, more describing intent — but you are present for every step, holding context and catching mistakes in real time; the agent is a collaborator, not an autonomous worker |
| **Third: autonomous agents** | Take a specification and run with it for thirty minutes, an hour, several hours, "and increasingly days" | They set up environments, install dependencies, write tests, hit failures, research solutions online, fix them, implement, retest, set up services, and produce reviewable artifacts. You hand off a task, move on, and come back to logs, previews, and pull requests — "defining outcomes and reviewing results", not interacting line by line. Swarms of agents and self-improving agents enter here |

- The cadence change is hard to communicate until experienced: "Tasks that were weekend projects three months ago are now something you kick off and check on thirty minutes later."

## The Factory Mental Model

> [!IMPORTANT]
> The essay's central claim: "you are no longer just writing code. You are building the factory that builds your software."

- The factory consists of **fleets of agents**, each with: a **task**, a **toolbelt** (repositories, test runners, deployment scripts, documentation), **context** (specs, architecture decisions, prior constraints), and a **feedback loop**. Instead of hand-holding one agent through one task, you spin up many in parallel — one on backend refactors, one on a feature, one on integration tests, one on documentation — then review outputs, give feedback, refine specs, and redeploy.
- The analogy runs deep and points at the investments that matter: a factory has **quality control**, **process documentation**, **inputs that must be precisely specified** or outputs come out wrong, and it **stalls when the environment is unreliable** — all of which "map directly onto agentic software development".
- Evidence of adoption: inside teams that adopted the model aggressively, "a substantial portion of merged pull requests now originate from agents running autonomously in cloud environments... not theoretical anymore... production reality for a growing number of engineering organizations".
- He endorses two Cursor sentiments: "The developer's job is becoming building the system that builds the software, the factory, not just the product" and "reviewing ideas is a lot more fun than reviewing code".

## There's an onboarding parallel here

- Agent behaviour mirrors onboarding a new engineer: hand them a spec → they break it into subtasks → explore the codebase → when stuck, search commit history and run `git blame` → escalate to the appropriate human for domain knowledge via Slack or similar → iterate until the output meets acceptance criteria.
- Implications: **Slack and email are becoming interfaces between humans and agents**, not just humans and humans; **git history is evolving into a knowledge graph** agents navigate to understand architectural decisions; **documentation is becoming training material for autonomous execution**.

> [!TIP]
> The codebase-investment test: "could a new engineer, given only the documentation and commit history available, understand why the code is structured this way? If the answer is no, agents will struggle there too."

## Your Spec is the Leverage

- Orchestrating twenty, thirty, fifty parallel agents, "the difference between mediocre output and exceptional output comes down almost entirely to the quality of your specification". At that scale vague thinking doesn't just slow you down — it **multiplies**: ambiguous requirements propagate through dozens of parallel runs, "each one going slightly wrong in a slightly different direction"; poor upfront architectural decisions propagate across the entire fleet.
- Writing a spec that survives that environment requires deep understanding of the architecture, integration boundaries, edge cases, failure modes, and invariants. "The spec is not a prompt anymore. The spec is the product thinking made explicit."
- Consequence: **strong engineers get more leverage from these tools than weak ones, not less** — the mechanical work of typing is automated, the cognitive work of understanding systems is amplified, and every hour of genuine architectural understanding "pays dividends across an entire fleet of autonomous workers".

## What hasn't really changed

Against the hype impression that traditional skills are deprecated, agentic development still requires:

- **Clear requirements** — if you cannot articulate evaluable success, autonomy won't produce it; agents fill unstated gaps with assumptions, and "those assumptions compound".
- **Strong abstractions** — agents amplify the properties of the system they work in: clean module boundaries and coherent interfaces yield better agent output than a tangled codebase, so clean architecture becomes *more* valuable, not less.
- **Reliable tests** — important enough to get its own section (below).
- **Careful tradeoffs** — agents optimise the stated objective; they don't naturally balance competing concerns, anticipate second-order effects, or flag when a technically correct solution is the wrong product decision. "That judgment still lives with you."
- **Human oversight** — agents "make confident mistakes", and output quality "is high enough to get past casual review, which means the bar for your review skills actually increases, not decreases".

## Why tests matter more than ever

- Red/green TDD — write tests first, confirm they fail (red), then iterate the implementation until they pass (green) — was already good practice; in an agentic workflow it "becomes something close to mandatory".
- Single-developer costs of skipping test-first are real but manageable. With a fleet of agents across dozens of parallel tasks the costs **compound severely**: an agent optimising for passing tests will find ways to pass them, and tests written after implementation "are likely testing what the implementation happens to do rather than what it should do" — leaving "a large surface area of code with a test suite that confirms the wrong thing".
- A comprehensive test-first suite is "by far the most effective lever" for ensuring autonomous output is correct and protecting existing functionality as the codebase grows.

> [!TIP]
> "Red/green TDD" is a shorthand every good model understands — write tests first, confirm they fail, make them pass through correct implementation rather than gaming the test. "Telling an agent to use red/green TDD is one of the highest-leverage instructions you can give at the start of a task."

## The unsolved problem is verification, not generation

> [!WARNING]
> "Generation is not the bottleneck anymore. Verification is." Agents produce impressive output; the hard part is knowing with confidence that it is correct.

Factors that make verification hard:

- Tests passing before a change doesn't mean they will catch the regressions the change introduces; agent-written tests can be technically valid yet miss the cases that matter.
- **UI verification remains brittle** — visual and behavioural regressions slip through because automated tools aren't yet reliable enough.
- **Context-window limitations** mean agents on large codebases can miss constraints or patterns outside the window they are reasoning over.
- **Flaky environments** that one developer works around become **systemic blockers** when forty agents hit the same flaky test simultaneously: "The factory stalls."

Infrastructure still needed at scale (active investment areas, "not solved"): better automated regression detection, artifact-level validation beyond diffing changed lines, reliable and fast environment provisioning, guardrails that hold up under parallel workloads.

> [!IMPORTANT]
> "Until verification catches up with generation, human review is not optional overhead. It is the safety system." The right response to impressive output is not trust-because-it-looks-good but the architectural understanding and testing discipline to evaluate it rigorously.

## The new shape of high-leverage engineering

The most impactful engineers won't be distinguished by typing speed or syntax recall but by:

| Capability | What it means in the agentic era |
|---|---|
| **Systems thinking** | Hold a complex architecture in mind, understand component interactions, anticipate ripple effects — essential when integrating a fleet's outputs |
| **Problem decomposition** | Break large ambiguous goals into well-scoped subtasks an agent can execute reliably; too-large tasks go off-track, poorly scoped ones get misinterpreted; verifying the decomposition is part of the craft |
| **Architectural judgment** | Know why a system is designed as it is and what tradeoffs were made; "Agents can implement. They cannot judge whether what they are implementing is the right design." |
| **Specification clarity** | Unambiguous requirements, complete on the important edge cases, structured for easy evaluation; "Precise specs multiply into precise implementations." |
| **Output evaluation** | The taste to spot the looks-correct-but-isn't, the solution that creates a new problem, the mismatch with the surrounding architecture; "This judgment is not automatable." |
| **Orchestration skill** | Manage multiple parallel workstreams, give effective feedback, know when to redirect vs. retask an agent, keep a fleet coherent |

None of these are new skills — "Good engineers have always needed them. What has changed is their relative importance." The mechanical parts of development are increasingly machine-handled; the cognitive parts are amplified.

## What's the bigger picture?

- Adoption metrics: **new website creation up 40% year over year; new iOS apps up nearly 50%; GitHub code pushes up 35% in the US** — all flat for years before late 2024; "The graphs look like hockey sticks." People who have never written a line of code are building and launching software.
- Caveat Osmani flags himself: "more quantity does not necessarily mean better quality" — but the barrier to creating software has genuinely dropped, and for professionals the skills that matter have shifted up the stack, as in every previous transition.
- Historical analogy: the developers who thrived after assembly→C weren't the cleverest assembly writers but those who could express intent clearly at the higher level; those who thrived after managed languages weren't the ones resisting garbage collection but those who used the freed cognitive capacity on harder problems.
- Prescription for the agentic era: neither resist the tools nor defer to them uncritically — develop the judgment, clarity, and systems thinking that make them maximally effective: write better specs, invest in test infrastructure, build genuine architectural understanding, cultivate rigorous evaluation taste, practise problem decomposition.
- Closing: "The era of programming as primarily a keystroke activity is over. The era of programming as primarily a thinking and judgment activity... just shifted into a higher gear." The factory model "is not a metaphor about losing control of software. It is a metaphor about building leverage."
