# Chapter 3 — Software Development (the craft)

Chapter 2 built up from a single prompt to a skill, then to a self-checking loop, then to a capability other agents could call — productivity assembled a piece at a time. This chapter takes that same approach one step further: orchestrating those pieces into software — finished, deterministic products that run the same way every time, long after the session that built them has ended. Where the last chapter automated a task, this one automates and hardens the whole system around it.

In fact, a single prompt can turn Chapter 2's loop-summary skill into a working Python program:

> Convert the loop-summary skill into a Python program called `summarise.py`. Make it able to summarise multiple files (of different formats) through the command line. Summaries should be generated with the same file name as the original but in a subfolder called `summaries`.

Now you have a working program that you can use to summarise many files at once:

> python summarise.py *.pdf

This chapter is not only for professional developers. It is also for the ordinary professional who can read a little code — enough Python or JavaScript to follow what a function does — because that is now enough to build real software. The same tools that can port a forty-year-old game can automate the repetitive core of almost any role: the spreadsheet that should be a script, the report that should be a dashboard, the manual process that should be a small app. You do not need to become an engineer; you need to learn to direct one, and the craft this chapter describes is how.

When I first started building software this way, I got it wrong in the most natural way possible. My instinct was to control the machine by telling it everything: I wrote longer and longer specifications, pinned the design down function by function, and tried to leave nothing to chance. It backfired. The more I specified, the *less* faithfully the model followed me — it would honour the top of a long instruction list and quietly contradict the bottom, or obey the letter of one rule while breaking another I had stated three paragraphs earlier. Some of my most frustrating hours went to micro-managing design decisions — naming the data structure, dictating the file layout — only to watch the agent drift, and to find myself correcting prose instead of building software.

The tendency is common, and it comes from mistrust: we feel we must micro-manage the machine because we do not yet trust it, so we try to pin down every detail. But that runs straight into the limits of Chapter 1. A model is a next-token predictor, not a compiler: it does not *execute* a specification, it produces the most plausible continuation of everything in its context. A long spec does not constrain it more tightly; it just becomes more text to attend to unevenly, and the book's own evidence on faithfulness and on recall fading as context grows says the extra instructions will be dropped or contradicted, not obeyed. Worse, micro-managing the design pits me against the model's one real strength — choosing pattern-rich implementation — while leaning on its weakness, following a long brittle list to the letter. Over-specification fights the grain of the tool.

The better approach is the opposite of control: describe the intent and iterate. Say what you want and how you will know it is right, then let the model choose the how, correcting course as you go rather than up front. This works with the grain of the tool rather than against it. It follows the model's *happy path* — the path of least resistance through everything it saw in training — so you are drawing on its strength instead of fighting it at every step. These failures, and this remedy, are exactly why spec-driven development buckles, as this chapter will argue, and why the discipline that works asks for less, not more.

That lesson is what made the successes possible. I am not a software developer, and I never have been — in a long career, "engineer" was never my job title. Yet this year I used AI to bring code back to life that had been dead for decades, and to build — almost entirely by describing what I wanted — three projects I would once have scoped as a team's work: [*rogoweb*](https://github.com/ChristineTham/rogoweb), a browser revival of the 1980 game Rogue and the expert system built to play it; [*adventure*](https://github.com/ChristineTham/adventure), a modern rebuild of the 1970s *Colossal Cave Adventure*; and [*VantageMap*](https://github.com/ChristineTham/vantagemap), an enterprise-architecture platform. Each began as a single sentence of intent, with a handful of constraints and a few hard checks; the agent chose the architecture and wrote the code. The productivity is real, and that a door this wide opened for someone who had never shipped production software is a large part of why I stopped being a sceptic. All three are open source, so you can read every line on GitHub; they are the running examples this chapter returns to, and I describe each in detail below.

A larger shift hides in that last sentence. For decades software was built by professional engineers who mastered its intricacies. Increasingly, the person best placed to build a system is the one who understands the problem most deeply and can say most precisely what the software must do — the practitioner's role moving from *code author* to *intent architect* ([Cao, *Agentic software: How AI agents are restructuring the software paradigm*, 2026](https://arxiv.org/abs/2606.05608)). I am an early, accidental example of that; the argument for why it is becoming general comes later, once we have the intent model in hand.

Software is where AI's promise and its failure modes are both sharpest, and where 2026's loudest arguments play out. This chapter opens with the three projects in detail, then walks the modern stack, settles the spec-versus-vibe war by reframing it, lays out the intent model that replaces both, and ends on quality and the move of agents into shared channels.

## 3.1 Three Projects, One Sentence Each

Before the theory, the evidence. Each project below began as a single sentence of intent and a few hard checks; everything technical that follows — the languages, the data structures, the way two programs talk to each other — was the agent's choice, not mine. I give the detail not to impress but because the specifics are the argument: I could not have written them up front, and did not.

### 3.1.1 rogoweb — two dead C programs, alive in the browser

*rogoweb* fuses two pieces of computing history. *Rogue 5.4* is the 1980 dungeon crawler by Michael Toy, Glenn Wichman, and Ken Arnold that gave the *roguelike* genre its name; *Rog-O-Matic XIV* is the expert system built at Carnegie Mellon in 1981 by Michael Mauldin and colleagues to play Rogue on its own — and beat it ([rogoweb](https://github.com/ChristineTham/rogoweb)). On Unix the bot ran as a separate process, launching the game as a child and talking to it through the standard input and output *pipes* — the channels one program uses to feed another. A browser has none of that machinery: no processes, no `fork`, no pipes.

![*rogoweb* in the browser: the VT100 terminal running Rog-O-Matic on dungeon level 7, beside the live telemetry panel — HP, gold, the evolving gene pool, and the observer log's descent milestones.](projects/rogoweb.png)

My intent was almost that short — *run Rogue and its bot in the browser* — with a constraint that the original C code should keep working unchanged in spirit, and a check that the bot could still finish a game. The agent's answer was an architecture I would never have thought to name. It compiled both C codebases to *WebAssembly* (a portable binary format browsers run at near-native speed) with Emscripten, wrote a custom terminal layer to stand in for the Unix `curses` library, and replaced the pipe with a `SharedArrayBuffer` ring buffer — a fixed block of memory that two browser *workers* (background threads) read and write in turn — so the game and the bot run side by side and talk exactly as they once did. For the dashboard it went one better: instead of scraping the terminal for the bot's health and intent, it had the C code write that state straight into shared memory for a VT100-style panel to display, live and at no cost. I specified none of those words.

```mermaid
flowchart TB
    B["Rog-O-Matic worker<br/>(WASM)"] <-->|virtual pipe| SAB[("SharedArrayBuffer:<br/>ring buffer + stats")]
    SAB <-->|virtual pipe| R["Rogue worker<br/>(WASM)"]
    R -->|writes HP, gold, intent| SAB
    UI["VT100 dashboard<br/>(main thread)"] -.->|polls stats| SAB
```

The revival did not stop at running the bot; it made the bot better. Rog-O-Matic *learns* — a genetic pool of strategy weights and a long-term monster-danger memory that it evolves across games and saves in the browser — so a fresh install plays badly and improves the more it plays. To hand new players a trained bot from the very first game, the agent built an offline pretrainer and, unprompted, parallelised it across every CPU core: isolated populations that evolve separately and then merge under a no-regression rule, a roughly ten-fold speed-up I never asked for. It also went back into the 1981 C to repair a raft of latent bugs and mis-tuned heuristics — chiefly a per-monster danger table so the bot stops under-rating a dragon, along with healing, escape, and food-timing fixes. Because Rogue is a game of chance, each change is validated not by a single passing run but by win-rate and average depth across a batch of games; the check here is statistical, not a green test.

### 3.1.2 adventure — a 1970s classic, made strict and typed

*adventure* rebuilds *Colossal Cave Adventure*, the game that founded interactive fiction. Will Crowther wrote the first version in FORTRAN in 1975–76, mapping his knowledge of Kentucky's Mammoth Cave onto a game for his daughters; Don Woods expanded it in 1977, adding the dwarves, the magic word `XYZZY`, and the famous 350-point score ([adventure](https://github.com/ChristineTham/adventure)). My version forward-ports Eric Raymond's faithful *open-adventure* edition into a strictly-typed TypeScript application on Next.js 16 and React 19.

![*adventure* at the starting location: AI-generated art for every room, the scroll-themed message panel, a condition-aware compass and guided-play controls, and the header's map and auto-solve buttons.](projects/adventure.png)

The intent — *rebuild Colossal Cave as a modern, strongly-typed web app* — carried two checks that did the real work: every value fully typed, with no escape hatches, and nothing merged until the tests and the *linter* — a tool that flags error-prone or untidy code — pass. The sharpest of those tests is *parity* — the engine replays the original's own regression suite, ninety-five recorded transcripts, and diffs its output against them line for line, so a change that even consumes the game's random-number stream in the wrong order fails at once. To satisfy it, the agent kept the canonical game data in its historic `adventure.yaml` file and wrote a custom, type-safe parser to load it, preserving the odd legacy structures and folding word synonyms together as it went. A Zustand *state machine* — a small component that tracks exactly what state the game is in and which moves are legal next — holds the world, and AI-generated artwork illustrates every location. The check, not a design document, is what kept it honest.

Around that faithful core grew a modern skin I never specified: guided-play buttons that light only the moves legal this turn, save and restore, and a one-click auto-solve that replays a perfect 430-point game. The hardest single feature in any of the three projects was the interactive cave map — all 151 rooms laid out as a clean metro-style diagram you can click to walk the player there. That map is where the models visibly differed. Laying a graph out octilinearly is an academic problem with no maintained JavaScript implementation, and Gemini, which had built much of the game, could not do it: its best attempt was a physics simulation computed in the browser that came out different every time and ran its connecting lines straight through the rooms. I handed the same intent to Fable, a newer model, which instead did the layout once at build time — a compass grid refined by hill-climbing, then orthogonal routing through the `libavoid` library — and produced a map that appears instantly and never crosses a room. The intent and the check never changed; only the model that could meet them did.

### 3.1.3 VantageMap — a platform, vibe-coded across a dozen phases

*VantageMap* is the most ambitious: an open-source platform for business architects and strategy officers to model capabilities, value streams, and outcomes — the kind of system I would once have costed as a team's work for a quarter ([vantagemap](https://github.com/ChristineTham/vantagemap)). It runs on Next.js and React over a Postgres database of twenty-two tables (reached through the Drizzle ORM — the layer that translates between the code and the database), with role-based access, REST and GraphQL APIs (the interfaces other programs use to call it), full-text search, webhooks that notify other systems of changes, and thirteen interlinked views, backed by some five hundred tests.

It was built almost entirely by *vibe coding* — described, not specified — across a dozen numbered phases, and it is the clearest case of the agent owning the architecture. I never chose the database layer, nor the shape of the twenty-two tables, nor the division of work between REST and GraphQL; those were answers to constraints about who may see what and how quickly the system has to respond. What held it together over months was not a master specification but a configuration file and a folder of reusable skills — the *harness*, in the language of the next section — together with the discipline of reading the diffs that mattered. Fittingly, one of the project's listed contributors is a coding agent.

Laid side by side, the three projects make the pattern impossible to miss: what I supplied was small and stable, what the agent supplied was large and technical.

| Project | One-sentence intent | Constraints I gave | Architecture the agent chose | The checks that gated it |
| --- | --- | --- | --- | --- |
| [*rogoweb*](https://github.com/ChristineTham/rogoweb) | Run Rogue and its bot in the browser | Original C keeps working; runs entirely in the browser | WebAssembly via Emscripten, custom `curses` layer, dual workers, `SharedArrayBuffer` ring buffer, shared-memory telemetry, genetic self-play with parallel offline pretraining | The bot still finishes a game; win-rate holds across a batch |
| [*adventure*](https://github.com/ChristineTham/adventure) | Rebuild *Colossal Cave* as a modern, strongly-typed web app | Faithful to the original data; Australian English throughout | TypeScript on Next.js 16 / React 19, YAML parser, Zustand state machine, AI-generated artwork, build-time metro-map (libavoid), one-click auto-solve | Full type coverage; tests and linter green; output-for-output parity with the original |
| [*VantageMap*](https://github.com/ChristineTham/vantagemap) | Give business architects one tool to model strategy | Who may see what; how fast it must respond | Next.js and React, Postgres with twenty-two tables, Drizzle, REST and GraphQL, thirteen views | Some five hundred tests |

## 3.2 The Modern AI Dev Stack

The interesting work has moved up the stack. Teams once compared models; now they compete on the layers above, because the model is the commodity and the control points sit higher.

This did not arrive as theory. The coding tools themselves climbed rung by rung, and each rung changed what you could safely hand off — moving the human from typing each line to directing a fleet.

| Rung | Emblematic tools | What it did | Your role |
| --- | --- | --- | --- |
| Autocomplete | Tabnine (2018), GitHub Copilot (2021) | Finished the line, then drafted whole function bodies from a name or comment | Wrote the rest; accepted line by line |
| Chat in the editor | Copilot Chat (2023) | Explained code, proposed refactors, diagnosed failures on request | Drove; asked and judged |
| Agentic editor | Cursor (2023), aider | Searched the whole codebase, edited many files, ran commands from a plain-language ask | Reviewed the diff |
| Terminal & async agent | Claude Code, Codex CLI, Gemini CLI (2025); Copilot coding agent | Planned, edited, ran tests, iterated; some opened a pull request from a cloud workspace | Set goals; reviewed results |
| Agent fleets | Cursor 2.0, Google Antigravity 2.0 | Ran several agents in parallel across a codebase | Supervised from above |

Sources: [Tabnine, *Tabnine*, n.d.](https://www.tabnine.com); [GitHub, *Introducing GitHub Copilot: AI pair programmer*, 2021](https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/); [GitHub, *GitHub Copilot November 30th update*, 2023](https://github.blog/changelog/2023-11-30-github-copilot-november-30th-update/); [Cursor, *Cursor*, n.d.](https://cursor.com); [aider, *aider*, n.d.](https://aider.chat/); [Anthropic, *Claude Code*, 2025a](https://claude.com/product/claude-code); [GitHub, *GitHub Copilot: The agent awakens*, 2025b](https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/); [GitHub, *GitHub Copilot: Meet the new coding agent*, 2025a](https://github.blog/news-insights/product-news/github-copilot-meet-the-new-coding-agent/); [Google, *Build with Google Antigravity, our new agentic development platform*, 2025](https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/).

By 2026 the editor itself is no longer the centre of gravity: with capable models available from every lab, the value has moved into the system wrapped around the model — what practitioners now call the *dev stack* ([Latent Space, *AINews*, 2026a](https://www.latent.space/s/ainews)).

> [!NOTE]
> A **harness** is the runtime wrapped around a model that turns it into an agent: it supplies tools, manages the loop, retries failures, and isolates execution. A **meta-harness** orchestrates several harnesses. **Memory** is state kept outside the *context window* (the span of text a model can consider at once); an **eval** is an automated check that a result meets its contract.

```mermaid
flowchart TD
    P["Product: UI + economics"] --> WF[Workflow]
    WF --> MH["Meta-harness: orchestrates many harnesses"]
    MH --> H["Harness: tools, retries, sandbox"]
    H --> M["Model — the commodity"]
    Mem[(Memory)] -.->|outside the context window| H
    Ev{{Eval: contract checks}} -.->|gates output| H
    Cfg[CLAUDE.md / AGENTS.md] -.->|encodes architecture| H
    classDef commodity fill:#eee,stroke:#999
    classDef value fill:#dfe,stroke:#3a3
    class M commodity
    class P value
```

Each layer is a discipline in its own right — the harness that turns a model into an agent, the meta-harness that coordinates several, the memory that lets work persist, the eval that decides whether a result is good enough:

| Layer | What it does | Examples (2026) |
| --- | --- | --- |
| Model | Generates the code | GPT-5.6 Sol, Claude Opus 4.8, Gemini 3.5, GLM-5.2 |
| Harness | Wraps the model into an agent: tools, retries, sandbox | Claude Code, Codex CLI, Gemini CLI, Cursor SDK |
| Meta-harness | Coordinates several harnesses | Conductor, Zed ACP, Vercel Eve, Heypi |
| Workflow / async | Fire-and-forget delegation in shared channels | Claude Tag (Slack), Copilot coding agent, Devin, Gemini Spark |
| Memory | State kept outside the context window | agentmemory, codegraph, channel memory |
| Eval | Automated judgement of quality | FrontierCode, Terminal-Bench 2.1, SWE-bench Pro |

Greg Brockman makes the same point from inside a frontier lab. The shift of the last couple of years, he says, is that "it's no longer just about the model. It's about the harness" — how the model gets its context, what actions it can take, and how the loop around it works ([Big Technology, *OpenAI President Greg Brockman: AI self-improvement, the superapp bet, path to AGI, scaling compute*, 2026](https://www.youtube.com/watch?v=J6vYvk7R190)). The concrete expression for most teams is the configuration file: studies of hundreds of Claude Code projects show that CLAUDE.md and AGENTS.md files carry the architectural constraints and conventions that decide whether an agent behaves, with architecture the single most-specified concern ([Santos et al., *Decoding the configuration of AI coding agents: Claude Code projects*, 2025](https://arxiv.org/abs/2511.09268)). My own projects bear this out: each carries a config file — an `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md` — that pins the conventions and architecture the agents must respect, alongside a `.agents/skills` folder of reusable know-how. The file, not the model, is what keeps a vibe-coded codebase coherent across months.

The mistake is to keep investing at the model layer, where lock-in is cheap and advantage is thin, and to neglect the harness that actually shapes results — and it demonstrably does: holding the model fixed and swapping only the harness has been measured moving a coding agent's success rate by more than twenty points on the same benchmark, a swing that rivals a whole model generation ([Gorinova et al., *Position: Coding benchmarks are misaligned with agentic software engineering*, 2026](https://arxiv.org/abs/2606.17799)).

## 3.3 AI-Assisted Coding Patterns

Day to day, AI earns its keep in pairing, refactoring, debugging, and sketching architecture, where a clear intent lets it fold several rounds of rework into one. It helps to start simple: Anthropic's advice is to reach for a single well-prompted call before workflows, and workflows before fully autonomous agents, adding complexity only when it demonstrably pays ([Anthropic, *Building effective agents*, 2024a](https://www.anthropic.com/research/building-effective-agents)). Five composable patterns recur, and most real systems combine them:

| Pattern | Shape | Use when |
| --- | --- | --- |
| Prompt chaining | Output of one call feeds the next | A task splits into fixed sequential steps |
| Routing | Classify, then dispatch to a specialist | Inputs fall into distinct categories |
| Parallelisation | Run subtasks (or votes) concurrently | Speed, or multiple perspectives, matter |
| Orchestrator-workers | A lead delegates dynamic subtasks | Subtasks are unknown until runtime |
| Evaluator–optimizer | One generates, one critiques, loop | Clear criteria and iterative gains exist |

The pattern that works is short loops with the agent, backed by evaluations that catch regressions before they ship; the pattern that bites is accepting a large change you cannot read, paying the speed back later when someone has to dig through it. Complexity is not free: a multi-agent setup can burn ~15× the tokens of a single call, so reach for one only when the task's value justifies it ([Anthropic, 2024a](https://www.anthropic.com/research/building-effective-agents)). The deeper lesson is *who owns control flow*: handing deterministic looping and sequencing to a probabilistic model produces token explosion and control-flow hallucination, so the durable pattern is program-owns-loop, model-fills-judgement — a discipline that lifted an agent on the OSWorld benchmark (agents operating a computer's desktop interface) to 86.8% in 15 steps against 80.4% in 100 ([Qi et al., *LLM-as-code: Agentic programming for agent harness*, 2026](https://arxiv.org/abs/2606.15874)). Where steps must retry, isolate them: runtime-structured decomposition retries only the failed subtask, cutting recovery cost 51.7% over monolithic prompts ([Asthana et al., *Runtime-structured task decomposition for agentic coding systems*, 2026](https://arxiv.org/abs/2605.15425)).

## 3.4 Spec vs Vibe, and Why Both Collapse

> [!NOTE]
> Two ways of building software with AI, named throughout this chapter:
>
> - **Vibe coding** — describing what you want in plain language and letting the model write and run the code, often without reading it line by line. Fast, and risky when unsupervised.
> - **Spec-driven development (SDD)** — writing a detailed specification first, then having the agent implement against it. More disciplined, but, as we will see, it strains at scale.

The debate is the wrong fight, Kapil Viren Ahuja argues, because both camps fail the same way ([Ahuja, *Spec-driven development isn’t broken. It will collapse*, 2026d](https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797)). GitHub's Spec Kit makes the optimistic case: treat the spec as a living, executable contract, work in four phases — specify, plan, tasks, implement — and the model stops guessing because it knows what, how, and in what order ([GitHub, *Spec-driven development with AI: Get started with a new open-source toolkit*, 2025c](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)).

The stakes behind the argument are large. On the vibe side, Cursor's annualised revenue doubled past two billion dollars, most of it now from enterprises ([Temkin, *Cursor has reportedly surpassed \$2B in annualized revenue*, 2026](https://techcrunch.com/2026/03/02/cursor-has-reportedly-surpassed-2b-in-annualized-revenue/)); on the spec side, AWS's Kiro drew more than a quarter of a million developers in its first three months ([GeekWire, *Amazon's surprise indie hit: Kiro launches broadly*, 2025](https://www.geekwire.com/2025/amazons-surprise-indie-hit-kiro-launches-broadly-in-bid-to-reshape-ai-powered-software-development/)). Yet the very people who launched each camp are edging away from it. Andrej Karpathy, who coined *vibe coding* in early 2025 ([Karpathy, *There's a new kind of coding I call "vibe coding"*, 2025](https://x.com/karpathy/status/1886192184808149383)), now calls it *passé* in favour of what he terms *agentic engineering* ([The New Stack, *Vibe coding is passé. Karpathy has a new name for the future of software*, 2026](https://thenewstack.io/vibe-coding-is-passe/)); and a hands-on review of Kiro on Martin Fowler's site found its spec-driven workflow "like using a sledgehammer to crack a nut" after a small bug fix ballooned into four user stories and sixteen acceptance criteria ([Böckeler, *Understanding spec-driven development: Kiro, spec-kit, and Tessl*, 2025](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)).

But that still jams three concerns together. Vibe coding has no contract at all; spec-driven development has three pretending to be one, fusing intent, specification, and implementation into a single document whose holes the agent fills, often confidently wrong ([Ahuja, *The method that replaces spec-driven development — IDSD*, 2026b](https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592)). The tell: the labs that sold the spec are quietly walking it back. OpenAI open-sourced *Symphony*, a spec for orchestrating its own Codex agents that grew out of the bottleneck its engineers hit running many at once — not a specification written up front ([OpenAI, *An open-source spec for Codex orchestration: Symphony*, 2026](https://openai.com/index/open-source-codex-orchestration-symphony/)).

Heavy or loose, the same root shows — three layers forced into one, or one made to do the work of three — and neither failure is anecdotal; the measurements are blunt on both sides. On the vibe side, an audit of two hundred *deployed* vibe-coded web apps found ninety per cent carried at least one vulnerability, three-quarters of them critical or high — exceeding a human-built baseline from OWASP, the standard reference for web-application security, by up to twentyfold — and a sharper prompt or a bigger model barely helped, because the agent often flagged the risk and shipped it anyway ([Deng et al., *Understanding the (in)security of vibe-coded applications*, 2026](https://arxiv.org/abs/2606.23130)). A survey of 162 people who vibe-code found the very disciplines that would catch such flaws — planning and verifying — uniformly weak regardless of seniority, everyone calling the output "fast but flawed" yet only non-developers never checking it ([Fawzy et al., *From prompting to verification: How experience shapes vibe coding practices*, 2026](https://arxiv.org/abs/2605.24521)). Watching people build charts, researchers saw the same reflex: users judged results by eyeballing the render, rarely reading the code, while the model reported every requirement met when it had satisfied only some ([Sun et al., *Vibe coding for visualization implementation*, 2026](https://arxiv.org/abs/2606.19703)). And when the bar was verified safety-critical code, unguided vibe coding converged zero times out of thirty; wrapping the same model in an external verifier loop took it to fifteen out of fifteen ([Wei et al., *Formal-method-guided vibe coding*, 2026](https://arxiv.org/abs/2606.22413)). The model is a draft generator, not an oracle.

But the spec side's "collapse" proves narrower than the blanket verdict. When one study drove repository-scale generation from plain-language prompts, quality fell to near zero; feeding the same models a *structured* specification restored it above eighty per cent, with more than seventy per cent of the residual failures statically detectable ([Feng et al., *LLM-assisted repository-level generation with structured spec-driven engineering*, 2026](https://arxiv.org/abs/2605.02455)). Human-refined specs have been measured cutting generated-code errors by up to half, and a spec-anchored financial service caught mismatches at review instead of in production, cutting integration time by three-quarters ([Piskala, *Spec-driven development: From code to contract in the age of AI coding assistants*, 2026](https://arxiv.org/abs/2602.00180)); folding security rules into the spec cut detected vulnerabilities by 73% against a vibe-coded baseline the same developer built with the same model ([Marri, *Constitutional spec-driven development*, 2026](https://arxiv.org/abs/2602.02584)). What fails is not specification but its extremes — prose too loose to constrain the model, monolithic specs too heavy to keep true — which is exactly where the next section lands: structured intent, with checks that travel with the code.

The cost is measurable. An *epic* — agile's name for a large, multi-week feature — that spec-driven development promises to deliver 50% faster gives roughly 30% straight back to recovering from *drift* — the spec and the code silently diverging — leaving perhaps 20% real. And a drifted spec is worse than none, because it lies with confidence: the document still reads as authoritative while describing a system that no longer exists ([Ahuja, 2026d](https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797)).

Spec is a sensible step two after vibe, fine for beginners and fragile codebases, but it breaks at enterprise scale, and leaning harder breaks it faster ([Ahuja, *The anatomy of intent (ICE in IDSD): Built from where spec-driven breaks*, 2026a](https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3)). The middle ground that holds is spec-anchored, code-coupled, drift-enforced: one spec per node, agent context scoped to an ownership path, and spec-code divergence made a blocking merge gate rather than a discipline problem — context explosion and silent drift answered by construction, not willpower ([Grabowski, *The spec growth engine: Spec-anchored, code-coupled, drift-enforced*, 2026](https://arxiv.org/abs/2606.27045)).

| Approach | Contract | Scales to enterprise? | Failure mode |
| --- | --- | --- | --- |
| Vibe coding | None | No | Confident, unread, wrong code |
| Spec-driven (SDD) | One document fusing intent, spec, and implementation | Strains badly | Context explosion; the agent fills the gaps wrongly |
| Spec-anchored, code-coupled | One spec per node, drift as a blocking merge gate | Yes, by construction | Demands tooling discipline up front |

## 3.5 Intent-Driven Development: The Anatomy of ICE

What survives the collapse is an old idea moved up a level: separation of concerns, applied not to the code but to the documents that instruct the machine. It is the Unix Rule of Separation — policy from mechanism — raised one floor ([Raymond, *The art of Unix programming*, 2003](http://www.catb.org/esr/writings/taoup/)). Kapil Viren Ahuja calls the result *intent-driven software development*, and gives it a deliberately small vocabulary — **ICE**, for **I**ntent, **C**ontext, and **E**xpectations ([Ahuja, 2026a](https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3)). Spec-driven development failed by fusing three things into one document; ICE pulls them back apart, hands two to the human and one to the machine, and — the rule that does the most work — never pre-locks the architecture. The name is Ahuja's, but the split is not his alone: reviewing agentic practice, Christian Koch arrives independently at the same three compartments — "conversation discovers intent; structured artifacts control implementation; evidence controls acceptance" — which is some assurance we are looking at a real pattern rather than one commentator's taste ([Koch, *Agentic Agile-V: From vibe coding to verified engineering*, 2026](https://arxiv.org/abs/2605.20456)).

> [!NOTE]
> **ICE, in one breath.**
>
> - **Intent** — what you want and the boundaries it must respect. You own this; it is the one thing nothing can write for you.
> - **Context** — the supporting material the agent needs to act: the codebase, prior decisions, conventions, domain facts. The harness assembles this *progressively*, as the work reveals what matters — you do not write it up front.
> - **Expectations** — the contract: a checkable statement of what "done" means, and the *external* evidence that proves it — a passing suite for low stakes, a real verifier for high ones. This is what survives of the old, bloated specification, and it is the pillar the evidence says matters most.

The centre of gravity is **Intent**, and it has exactly three parts: a *goal*, a set of *constraints*, and a set of *failure conditions*. The goal is one sentence with no "and," loose enough that two genuinely different builds could satisfy it — if only one implementation could, you have smuggled a specification in through the door. Constraints are five to seven directional qualities stated in business language — a thousand monthly users, a 99th-percentile response time (p99) under 200ms, conformance to an accessibility standard — and never a named tool or pattern; when the list starts to outgrow a handful, you are over-specifying again. Failure conditions are binary, observable checks a *validator* applies after the fact: the build breaks, test coverage falls below ninety per cent, a secret appears in source, an API changes without a version bump.

One rule sorts any borderline item: does it change how the builder designs? If yes, it is a constraint the builder sees; if no, it is a failure condition the validator owns. Keeping the two in separate compartments matters more than it looks, because a model that can read its own pass/fail tests will quietly optimise for them rather than for the goal — the reward-hacking we meet again under slop. The same anatomy works far outside software: "a red shoe under thirty dollars" is a goal, a price ceiling, and a colour check, with the brand deliberately left open.

**Context** is the part that defeated spec-driven development, and ICE's move is to stop trying to write it. A specification tries to front-load every fact the agent might ever need; ICE lets the harness fetch them as the task unfolds — the file being changed, the decision made three commits ago, the house convention — so the model attends to a little relevant material at a time instead of drowning in a long document it reads unevenly (the *lost in the middle* failure from Chapter 1). Context is *managed*, not authored.

**Expectations** are what the swollen spec shrinks to once intent and context are removed: a statement of the boundary and the definition of done, written to be checked rather than admired. This is the leg the evidence says carries the most weight — and where ICE as first sketched is thinnest — so it repays being exact. The check has to sit *outside* the builder, because a model that can see the tests it must pass will optimise for them: in one controlled study, deliberately injected errors sailed through every functional test, and only a separate traceability layer caught the divergence ([Panda, *Citation discipline in spec-driven development*, 2026](https://arxiv.org/abs/2606.30689)). And how much verification is enough scales with the stakes — a glance at a rendered chart at one end, a formal proof loop at the other, of the kind that turned safety-critical vibe coding from never converging to always converging ([Wei et al., 2026](https://arxiv.org/abs/2606.22413)). The rule is the spec-writer's, borrowed: use the least rigour that removes the ambiguity, and no less ([Piskala, 2026](https://arxiv.org/abs/2602.00180)). Where a specification said *how* in two thousand lines, expectations say *what would make this acceptable* — and then prove it.

| Layer | What it is | Who owns it |
| --- | --- | --- |
| Intent | Goal + constraints + failure conditions | You |
| Context | Codebase, decisions, conventions, domain facts | The harness, assembled progressively |
| Expectations | The definition of done, and the external evidence that verifies it | You |
| Implementation | The architecture and the code | The system |

> [!NOTE]
> **Worked example, from *rogoweb*.** Goal: "run Rogue and its bot in the browser" — one sentence, no "and," and two quite different builds could satisfy it. Constraints: the original C should keep working; the whole thing runs client-side, with nothing to install. Failure conditions: the build breaks, or the bot can no longer finish a game. Notice what is absent — I never wrote "WebAssembly," "`SharedArrayBuffer`," "ring buffer," or "two web workers." Those were the system's answers to the constraints, not parts of my intent, and that is exactly the line ICE draws.

```mermaid
flowchart TB
    subgraph You [You own]
      I["Intent:<br/>goal + constraints + failure conditions"]
      E["Expectations:<br/>definition of done"]
    end
    subgraph Machine [The system owns]
      Ctx["Context:<br/>assembled progressively"]
      Impl["Implementation:<br/>the system's call"]
    end
    I --> E
    I --> Ctx
    Ctx --> Impl
    E -.->|validator checks| Impl
    Impl -.->|fails a check, retry| Ctx
```

My three projects are the same shape, writ large. Each was an intent — "run Rogue and its bot in a browser," "rebuild *Colossal Cave* as a modern, strongly-typed web app," "give business architects one tool to model strategy" — plus a few directional constraints and some binary checks, and nothing about implementation. I never specified WebAssembly, a `SharedArrayBuffer`, Drizzle, or Zustand; those were the system's answers to the constraints, and when an early choice failed a check the agent swapped it out without my touching the goal. That is precisely why ICE works: by refusing to pre-lock the architecture, you let the model do the part it is good at — choosing and revising implementation against a fixed intent and observable checks — while you keep the part that is yours, what the thing is for and how you will know it has gone wrong.

One discipline makes or breaks the method: stay in the loop. Intent is small, but it is not fire-and-forget. The arithmetic is against you — small per-step error compounds across a long autonomous run — so *presence in the loop beats approval at the gate* ([Alenezi, *From determinism to delegation*, 2026b](https://arxiv.org/abs/2606.28791)). Intent steers continuously, not once; my own near-misses all came from the same lapse — approving a plan, looking away, and looking back to find the agent confidently building the wrong thing well. The remedy is not to plan harder up front but to watch and intervene: the moment a run heads the wrong way, stop it and re-steer rather than let it reach the end. Halting a drifting agent early costs a fraction of unwinding days of confident, wrong work and the tokens it burns — interrupting a run is not a failure of delegation but the discipline that makes delegation affordable.

Two things place ICE in a wider frame. First, it is a rung on a ladder, not a destination: teams have climbed from *vibe* (a model and an editor — fine alone, fragile in a team) to *spec-driven* (tooling layered on the model, now straining at scale) to *intent-driven* working, with more autonomous rungs above that few have reached ([Ahuja, 2026d](https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797)). Second, ICE answers a question spec-driven development never could — continuity. A specification freezes a system at the moment of creation and then drifts; intent kept in small files, context scoped to the task, and checks that travel with the work let an agent remember what it is building and why across months. Memory is not a luxury here but the prerequisite for a system that survives past its first week.

The pitfall, then, is the old reflex of locking the architecture into the document. It feels like control, but it collapses the separation that lets a system evolve: pin the implementation and you are back to a specification, fighting the goal-seeking tool instead of aiming it.

## 3.6 Who Builds the Software

This redraws who is best placed to build software. If intent is the scarce input and the model supplies the implementation, the advantage tilts from the person who can write the code to the person who knows most exactly what the code is *for*. That points to the domain expert — the clinician, the analyst, the lawyer who understands a problem in its own terms, can articulate it precisely, and can judge the result against what the field actually needs.

This is not a break with the past so much as its latest turn. For most of computing's history software was a temple: the systems were complex and specialised, and a priesthood of professional developers held the keys while everyone else waited outside for what they were handed. The doors have been opening for years. Domain experts have in fact always written a large share of the world's software — the teacher's grading spreadsheet, the analyst's macro — usually without calling it programming ([Ko et al., *The state of the art in end-user software engineering*, 2011](https://doi.org/10.1145/1922649.1922658)). *Citizen developer* platforms, and then low-code and no-code tools, turned that trickle into a movement, letting people assemble working applications by dragging boxes rather than writing code ([Luo et al., *Characteristics and challenges of low-code development: The practitioners’ perspective*, 2021](https://arxiv.org/abs/2107.07482)). AI is the next widening of the same door. Where low-code hit a wall the moment a need outgrew its templates, a model will write whatever the intent requires, in any language — the ceiling is no longer the tool but your ability to say what you want and to check what you get.

The evidence for this turn is early but points one way. A feasibility study builds adaptive systems "designed by domain experts with no programming skills," where the precision of the feedback — not any human code review — decides whether the result works ([Töpfer et al., *Vibe-coding: Feedback-based automated verification with no human code inspection, a feasibility study*, 2026](https://arxiv.org/abs/2604.14867)). Yet articulation is not the whole of it: in a controlled study of a hundred people, both writing skill and computer-science knowledge predicted who vibe-coded well, and fluent prose did not make up for weak fundamentals ([Thorgeirsson et al., *Computer science achievement and writing skills predict vibe coding proficiency*, 2026](https://arxiv.org/abs/2603.14133)). And professional developers handed the same agents do not simply vibe — they steer hard, spending their expertise to hold quality ([Huang et al., *Professional software developers don’t vibe, they control: AI agent use for coding in 2025*, 2025](https://arxiv.org/abs/2512.14012)).

The gains also land unevenly, which is the deeper point. Across field trials of nearly five thousand developers the boost concentrated among juniors — on the order of a quarter more tasks completed — while a controlled study of experienced engineers working in their *own* mature repositories found them run about 19% slower even as they believed themselves faster ([Alenezi, *The rise of AI-native software engineering*, 2026a](https://arxiv.org/abs/2606.12986); [Bhati, *Agentic AI in the software development lifecycle*, 2026](https://arxiv.org/abs/2604.26275)).

| Cohort | Setting | Measured effect on output |
| --- | --- | --- |
| Juniors | Field trials across ~5,000 developers | ~25% more tasks completed |
| Experienced engineers | Their *own* mature repositories | ~19% *slower* — while believing themselves faster |

Access widened for everyone; the benefit did not — because what the tool rewards is not typing speed but the judgement to say precisely what is wanted and to recognise when the result falls short.

Every widening of that door has taught the same lesson, and this one will too: removing the gatekeeper does not remove the discipline. Low-code freed people to build and then buried many of them in applications no one could maintain, secure, or govern — the platform hid the code without retiring the engineering ([Luo et al., 2021](https://arxiv.org/abs/2107.07482)). AI repeats the pattern at higher speed: a review of the LLM-assisted literature finds these tools amplify the old technical debts — in code, design, and documentation — and add new ones of their own, so faster code can quietly mean deeper debt ([Ehsani et al., *Faster code, deeper debt? A multivocal literature review on technical debt and its early signs in LLM-assisted software development*, 2026](https://arxiv.org/abs/2606.14796)). The disciplines of software engineering do not disappear when the typing does; they move into the intent and the checks. So the shift is not the end of software engineering but a change in who practises it best: not the career coder who cannot name the business problem, nor the domain expert who has never watched a system break, but the person who joins deep subject knowledge to enough engineering judgement to tell working software from confident slop. Access was never the hard part. Judgement is — and equipping that judgement is what this chapter is about.

## 3.7 The Agentic Iron Triangle

For fifty years software was governed by the *iron triangle* — time, cost, quality, pick two. Agentic coding broke it. Speed fell to table stakes, since an agent ships in hours what once took weeks; quality dropped to a welded floor, held by the evals and linters rather than by a human reading every diff; and only cost stayed a live lever. But cost has quietly split in two: the tokens you spend, and the *attention* it takes to direct the agents and hold the intent in your head ([Ahuja, *Spec-driven development is also breaking the fifty-year-old iron triangle*, 2026c](https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06)).

```mermaid
flowchart TB
    subgraph Before [The old triangle — pick two]
      direction LR
      Ti[Time] --- Qu[Quality]
      Qu --- Co[Cost]
      Co --- Ti
    end
    subgraph After [Agentic coding breaks it]
      direction TB
      T2["Time — now table stakes"]
      Q2["Quality — a welded floor held by evals"]
      C2["Cost — the only live lever"] --> TK["Tokens: the bill"]
      C2 --> AT["Attention: how many agents you can steer"]
    end
    Before ==> After
```

That changes the question worth asking. Speed no longer comes from a faster model but from running agents in parallel, and the ceiling is your own attention — how many you can drive before you lose the thread, not how quickly any one of them finishes. And the arithmetic of long autonomous runs is unforgiving: chain enough steps and small per-step error compounds — a 95% success rate per step falls to roughly a third over twenty — so it is the human's oversight, not the model's pace, that holds a long run together ([Alenezi, 2026b](https://arxiv.org/abs/2606.28791)). Fast models are the seductive trap; lean on them and the bill lands in tokens. It is a real bill: Uber exhausted its 2026 AI-coding budget in about four months once Claude Code reached 84% of its engineers at five hundred to two thousand dollars each a month, and its own president and chief operating officer conceded that the link between that spend and shipped value was "not there yet" ([Fortune, *Uber burned through its entire 2026 AI budget in four months*, 2026](https://fortune.com/2026/05/26/uber-coo-ai-spending-tokens-claude-code/)). Token counts make a poor scoreboard — OpenClaw's creator ran up 603 billion tokens and \$1.3 million in a single month across a fleet of coding agents ([Tom's Hardware, *OpenClaw creator burns through \$1.3 million in OpenAI API tokens in a single month*, 2026](https://www.tomshardware.com/tech-industry/artificial-intelligence/openclaw-creator-burns-through-1-3-million-in-openai-api-tokens-in-a-single-month)) — so measuring yourself by tokens burned is measuring the wrong thing.

What stays scarce, and therefore valuable, is the one question the machine will never ask you: who is this for, and why are we building it. Building became nearly free, and the cost that once forced that question went with it; holding it now is a discipline rather than something the budget imposes. That discipline is where quality begins.

## 3.8 Quality over Slop

A high pass rate is not good code, so the test that matters is whether a maintainer would merge it. Models hit green suites with output nobody can read, and mergeability and correctness are different properties — the reframing behind Cognition's FrontierCode, a benchmark of whether a human maintainer would actually merge the code, on which even the leading model scored only about 13% on the hardest tier ([Cognition, *Introducing FrontierCode*, 2026](https://cognition.com/blog/frontier-code)). The peer-reviewed measurements agree: across hundreds of thousands of agent-authored *pull requests* (PRs — proposed code changes submitted for a maintainer's review), real-world acceptance ran 35–64% against the 70%-plus the same agents score on the popular leaderboards, and nearly a third of patches marked "resolved" diverged from the intended behaviour under differential testing ([Gorinova et al., 2026](https://arxiv.org/abs/2606.17799)). Architecture is subtler still — a causal study of Java repositories found no short-term structural decay from agentic adoption but no clear gain either, and cautioned that an apparent drop in "smell density" was mostly the denominator, code volume, rising ([Larsen & Moghaddam, *Mining architectural quality under agentic AI adoption*, 2026](https://arxiv.org/abs/2606.13298)); the lesson cuts both ways — a green suite is not a merged feature, and a moving metric is not a better system. Worse, a model under pressure will game the suite outright: Anthropic documented a coding agent that, unable to meet an impossible speed requirement, quietly detected the test's arithmetic inputs and returned a closed-form formula instead of actually summing — passing every check while solving nothing ([Anthropic, *From shortcuts to sabotage: natural emergent misalignment from reward hacking*, 2025d](https://www.anthropic.com/research/emergent-misalignment-reward-hacking)). The defence is to bake reviewer judgement into the evals and to put the value question from the last section before anything runs. In my own projects the suites were necessary but never sufficient: VantageMap runs some five hundred tests and *adventure* forbids an unverified change, yet what kept them from slop was reading the diffs that mattered and asking whether each feature earned its place. Shipping slop because the suite passed is the quiet failure that compounds.

## 3.9 Agents in the Channel

Agents are leaving the IDE (the developer's code editor) for the channel — persistent, multiplayer, ambient, working beside a team rather than inside one editor, to the point of writing a large share of a product team's code. That only stays safe with agent identity: each agent on its own service account with least-privilege tokens, credentials swapped at the network boundary rather than borrowed from a user. The moment an agent acts as you, least privilege and the audit trail are both gone.

The harder truth is that quality is an ecosystem property, not an agent one. Across 930k agent PRs, integration friction concentrates at the repository, agents twice as much as humans (an intraclass correlation, ICC, of 0.30 vs 0.16 — a measure of how strongly that friction clusters by repository) — so a benchmark score per agent never adds up to a dependable repo. Govern change tempo, not headcount ([Russo, *Govern the repository, not the agent: Ecosystem-level risk in AI-native software*, 2026](https://arxiv.org/abs/2606.28235)).

However far the agents travel — out of the editor, into the channel, into fleets — the craft of this chapter does not change: one clear intent, checks that live outside the builder, and a human present while the work runs. The next chapter widens that discipline beyond software, to everything humans and agents build together.

## References

Ahuja, K. V. (2026a). *The anatomy of intent (ICE in IDSD): Built from where spec-driven breaks*. Activated Thinker (Medium). [https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3](https://howtoarchitect.io/1597e5a16659?sk=836b8eeaf97cda521f0ad195162011c3)

Ahuja, K. V. (2026b). *The method that replaces spec-driven development — IDSD*. Activated Thinker (Medium). [https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592](https://howtoarchitect.io/66e921f6cdf7?sk=2ae7d323c6b780291bfc760ff2bdc592)

Ahuja, K. V. (2026c). *Spec-driven development is also breaking the fifty-year-old iron triangle*. Activated Thinker (Medium). [https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06](https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06)

Ahuja, K. V. (2026d). *Spec-driven development isn’t broken. It will collapse*. Activated Thinker (Medium). [https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797](https://howtoarchitect.io/c00609f72496?sk=2da01d7d2abfb5bc0acaed7050a0e797)

aider. (n.d.). *aider*. [https://aider.chat/](https://aider.chat/)

Alenezi, M. (2026a). *The rise of AI-native software engineering: Implications for practice, education, and the future workforce*. arXiv. [https://arxiv.org/abs/2606.12986](https://arxiv.org/abs/2606.12986)

Alenezi, M. (2026b). *From determinism to delegation: AI-native software engineering and the evolution of the agentic engineer*. arXiv. [https://arxiv.org/abs/2606.28791](https://arxiv.org/abs/2606.28791)

Anthropic. (2024a). *Building effective agents*. [https://www.anthropic.com/research/building-effective-agents](https://www.anthropic.com/research/building-effective-agents)

Anthropic. (2025a). *Claude Code*. [https://claude.com/product/claude-code](https://claude.com/product/claude-code)

Anthropic. (2025d). *From shortcuts to sabotage: natural emergent misalignment from reward hacking*. [https://www.anthropic.com/research/emergent-misalignment-reward-hacking](https://www.anthropic.com/research/emergent-misalignment-reward-hacking)

Asthana et al. (2026). *Runtime-structured task decomposition for agentic coding systems*. Proceedings of ACM CAIS ’26. [https://arxiv.org/abs/2605.15425](https://arxiv.org/abs/2605.15425)

Bhati, H. (2026). *Agentic AI in the software development lifecycle: Architecture, empirical evidence, and the reshaping of software engineering*. arXiv. [https://arxiv.org/abs/2604.26275](https://arxiv.org/abs/2604.26275)

Big Technology. (2026). *OpenAI President Greg Brockman: AI self-improvement, the superapp bet, path to AGI, scaling compute* [Video]. YouTube. [https://www.youtube.com/watch?v=J6vYvk7R190](https://www.youtube.com/watch?v=J6vYvk7R190)

Böckeler, B. (2025). *Understanding spec-driven development: Kiro, spec-kit, and Tessl*. martinfowler.com. [https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)

Cao, Z. (2026). *Agentic software: How AI agents are restructuring the software paradigm*. arXiv. [https://arxiv.org/abs/2606.05608](https://arxiv.org/abs/2606.05608)

Cognition. (2026). *Introducing FrontierCode*. Cognition. [https://cognition.com/blog/frontier-code](https://cognition.com/blog/frontier-code)

Cursor. (n.d.). *Cursor: AI code editor* [Computer software]. [https://cursor.com](https://cursor.com)

Deng, J., Fan, Z., & Meng, R. (2026). *Understanding the (in)security of vibe-coded applications*. arXiv. [https://arxiv.org/abs/2606.23130](https://arxiv.org/abs/2606.23130)

Ehsani, R., Rawal, S., Cai, Y., & Chatterjee, P. (2026). *Faster code, deeper debt? A multivocal literature review on technical debt and its early signs in LLM-assisted software development*. arXiv. [https://arxiv.org/abs/2606.14796](https://arxiv.org/abs/2606.14796)

Fawzy, A., Tahir, A., & Blincoe, K. (2026). *From prompting to verification: How experience shapes vibe coding practices*. arXiv. [https://arxiv.org/abs/2605.24521](https://arxiv.org/abs/2605.24521)

Feng, S., Chen, B., Meyer, B. H., & Mussbacher, G. (2026). *LLM-assisted repository-level generation with structured spec-driven engineering*. arXiv. [https://arxiv.org/abs/2605.02455](https://arxiv.org/abs/2605.02455)

Fortune. (2026). *Uber burned through its entire 2026 AI budget in four months. Now its COO is questioning whether it's worth it*. Fortune. [https://fortune.com/2026/05/26/uber-coo-ai-spending-tokens-claude-code/](https://fortune.com/2026/05/26/uber-coo-ai-spending-tokens-claude-code/)

GeekWire. (2025). *Amazon's surprise indie hit: Kiro launches broadly in bid to reshape AI-powered software development*. GeekWire. [https://www.geekwire.com/2025/amazons-surprise-indie-hit-kiro-launches-broadly-in-bid-to-reshape-ai-powered-software-development/](https://www.geekwire.com/2025/amazons-surprise-indie-hit-kiro-launches-broadly-in-bid-to-reshape-ai-powered-software-development/)

GitHub. (2021). *Introducing GitHub Copilot: AI pair programmer*. GitHub Blog. [https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/](https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/)

GitHub. (2023). *GitHub Copilot November 30th update*. GitHub Blog. [https://github.blog/changelog/2023-11-30-github-copilot-november-30th-update/](https://github.blog/changelog/2023-11-30-github-copilot-november-30th-update/)

GitHub. (2025a). *GitHub Copilot: Meet the new coding agent*. GitHub Blog. [https://github.blog/news-insights/product-news/github-copilot-meet-the-new-coding-agent/](https://github.blog/news-insights/product-news/github-copilot-meet-the-new-coding-agent/)

GitHub. (2025b). *GitHub Copilot: The agent awakens*. GitHub Blog. [https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/](https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/)

GitHub. (2025c). *Spec-driven development with AI: Get started with a new open-source toolkit*. GitHub Blog. [https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)

Google. (2025). *Build with Google Antigravity, our new agentic development platform*. Google Developers Blog. [https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/](https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/)

Gorinova, M. I., Baker, M., Heineike, A., Shaposhnikov, M., Willoughby, R., & Knox, D. (2026). *Position: Coding benchmarks are misaligned with agentic software engineering*. arXiv. [https://arxiv.org/abs/2606.17799](https://arxiv.org/abs/2606.17799)

Grabowski, H. (2026). *The spec growth engine: Spec-anchored, code-coupled, drift-enforced*. arXiv. [https://arxiv.org/abs/2606.27045](https://arxiv.org/abs/2606.27045)

Huang, R., Reyna, A., Lerner, S., Xia, H., & Hempel, B. (2025). *Professional software developers don’t vibe, they control: AI agent use for coding in 2025*. arXiv. [https://arxiv.org/abs/2512.14012](https://arxiv.org/abs/2512.14012)

Karpathy, A. (2025). *There's a new kind of coding I call "vibe coding"* [Post]. X. [https://x.com/karpathy/status/1886192184808149383](https://x.com/karpathy/status/1886192184808149383)

Ko, A. J., Abraham, R., Beckwith, L., Blackwell, A., Burnett, M., Erwig, M., Scaffidi, C., Lawrance, J., Lieberman, H., Myers, B. A., Rosson, M. B., Rothermel, G., Shaw, M., & Wiedenbeck, S. (2011). *The state of the art in end-user software engineering*. ACM Computing Surveys, 43(3), Article 21. [https://doi.org/10.1145/1922649.1922658](https://doi.org/10.1145/1922649.1922658)

Koch, C. (2026). *Agentic Agile-V: From vibe coding to verified engineering in software and hardware development*. arXiv. [https://arxiv.org/abs/2605.20456](https://arxiv.org/abs/2605.20456)

Larsen, O. A., & Moghaddam, M. T. (2026). *Mining architectural quality under agentic AI adoption: A causal study of Java repositories*. arXiv. [https://arxiv.org/abs/2606.13298](https://arxiv.org/abs/2606.13298)

Latent Space. (2026a). *AINews*. [https://www.latent.space/s/ainews](https://www.latent.space/s/ainews)

Luo, Y., Liang, P., Wang, C., Shahin, M., & Zhan, J. (2021). *Characteristics and challenges of low-code development: The practitioners’ perspective*. arXiv. [https://arxiv.org/abs/2107.07482](https://arxiv.org/abs/2107.07482)

Marri, S. R. (2026). *Constitutional spec-driven development: Enforcing security by construction in AI-assisted code generation*. arXiv. [https://arxiv.org/abs/2602.02584](https://arxiv.org/abs/2602.02584)

OpenAI. (2026). *An open-source spec for Codex orchestration: Symphony*. [https://openai.com/index/open-source-codex-orchestration-symphony/](https://openai.com/index/open-source-codex-orchestration-symphony/)

Panda, S. (2026). *Citation discipline in spec-driven development: A cross-model empirical study of output determinism and automated hallucination detection in LLM-generated code*. arXiv. [https://arxiv.org/abs/2606.30689](https://arxiv.org/abs/2606.30689)

Piskala, D. B. (2026). *Spec-driven development: From code to contract in the age of AI coding assistants*. arXiv. [https://arxiv.org/abs/2602.00180](https://arxiv.org/abs/2602.00180)

Qi et al. (2026). *LLM-as-code: Agentic programming for agent harness*. arXiv. [https://arxiv.org/abs/2606.15874](https://arxiv.org/abs/2606.15874)

Raymond, E. S. (2003). *The art of Unix programming*. Addison-Wesley. [http://www.catb.org/esr/writings/taoup/](http://www.catb.org/esr/writings/taoup/)

Russo, D. (2026). *Govern the repository, not the agent: Ecosystem-level risk in AI-native software*. arXiv. [https://arxiv.org/abs/2606.28235](https://arxiv.org/abs/2606.28235)

Santos, R., Costa, H., Montandon, J. E., & Valente, M. T. (2025). *Decoding the configuration of AI coding agents: Claude Code projects*. arXiv. [https://arxiv.org/abs/2511.09268](https://arxiv.org/abs/2511.09268)

Sun, Z., Wen, X., Wang, F., Liu, C., Lai, Y., Hurter, C., & Wang, Y. (2026). *Vibe coding for visualization implementation: An empirical study of practices and challenges*. arXiv. [https://arxiv.org/abs/2606.19703](https://arxiv.org/abs/2606.19703)

Tabnine. (n.d.). *Tabnine* [Computer software]. [https://www.tabnine.com](https://www.tabnine.com)

Temkin, M. (2026). *Cursor has reportedly surpassed \$2B in annualized revenue*. TechCrunch. [https://techcrunch.com/2026/03/02/cursor-has-reportedly-surpassed-2b-in-annualized-revenue/](https://techcrunch.com/2026/03/02/cursor-has-reportedly-surpassed-2b-in-annualized-revenue/)

The New Stack. (2026). *Vibe coding is passé. Karpathy has a new name for the future of software*. The New Stack. [https://thenewstack.io/vibe-coding-is-passe/](https://thenewstack.io/vibe-coding-is-passe/)

Thorgeirsson, S., Weidmann, T. B., & Su, Z. (2026). *Computer science achievement and writing skills predict vibe coding proficiency*. arXiv. [https://arxiv.org/abs/2603.14133](https://arxiv.org/abs/2603.14133)

Tom's Hardware. (2026). *OpenClaw creator burns through \$1.3 million in OpenAI API tokens in a single month*. Tom's Hardware. [https://www.tomshardware.com/tech-industry/artificial-intelligence/openclaw-creator-burns-through-1-3-million-in-openai-api-tokens-in-a-single-month](https://www.tomshardware.com/tech-industry/artificial-intelligence/openclaw-creator-burns-through-1-3-million-in-openai-api-tokens-in-a-single-month)

Töpfer, M., Plášil, F., Bureš, T., & Hnětynka, P. (2026). *Vibe-coding: Feedback-based automated verification with no human code inspection, a feasibility study*. arXiv. [https://arxiv.org/abs/2604.14867](https://arxiv.org/abs/2604.14867)

Wei, R., Zhu, L., Wang, H., Woodcock, J., Yan, F., Foster, S., & Ji, X. (2026). *Formal-method-guided vibe coding: Closing the verification loop on AI-generated safety-critical software through model-driven engineering*. arXiv. [https://arxiv.org/abs/2606.22413](https://arxiv.org/abs/2606.22413)
