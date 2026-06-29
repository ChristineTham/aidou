# IDD vs SDD — Series Summary

**Author:** Kapil Viren Ahuja (Activated Thinker / howtoarchitect.io), May–Jun 2026.
**Sources:** five-part series (links in [research.md](../research.md)). Personas (Ira, Zia, Nyra, Anya) are composite/de-identified; conversations reported as they happened.
**Compiled:** 29 Jun 2026.

> One connected argument: vibe coding already collapsed; spec-driven development (SDD) collapses next; what replaces it is **IDSD** — intent-driven software development — built on **ICE** (Intent, Context, Expectations). The method is the product, not the harness.

---

## TL;DR
- **Vibe vs SDD is the wrong fight.** Vibe has *no contract*; SDD has *three contracts pretending to be one* — intent, spec, and implementation jammed into a single document. Same root failure, opposite compressions.
- **Fix = separation of concerns** one layer up: keep **intent → expectations → implementation** distinct. Humans own intent + expectations; the harness owns context + execution.
- **Agents are goal-seeking.** A rigid spec fights what the model was built for; specs always have holes, and the agent fills them — confidently, sometimes wrong.
- **A complete spec works, but almost nobody can write one.** OpenAI's Symphony spec (~1,400–2,169 lines) was reverse-engineered *after* the system ran; deep specs are retrospective documentation, not a starting point.
- **The real cost lever is tokens + cognition.** Bad methodology burns both. The durable skill is the value question — "who is this for, why build it?" — the one thing the machine won't ask.
- **Maturity ladder:** Vibe → SDD → IDD/IDSD → Autonomous → Dark Factory. Use SDD when starting out; it breaks at enterprise scale.

---

## 1. The Trap SDD Is Setting (17 May 2026)
**Thesis:** building is now near-free, and both brakes on the "is this worth building?" decision are gone — cost stopped forcing it, and SDD (meant to ask it) collapsed.

- **Fast ≠ build fast.** Thirty years of methodologies sold "speed" and quietly redefined it as *produce* fast, not *deliver value* fast. Production is now solved; value validation is neglected, yet dashboards still measure output.
- **Three deferred debts** that accrue while tokens are cheap and come due on enterprises:
  - **Skill debt** — unexercised judgment atrophies; a team that hasn't made a hard build/don't-build call can't when it matters.
  - **Dependence debt** — workflows assume free generation; degradation is invisible. Anthropic's Sept 2025 postmortem: ~30% of Claude Code users hit ≥1 degraded response over ~5 weeks, most unaware.
  - **Carry debt** — unneeded software becomes inventory: maintained, secured, repriced when access reprices.
- **Pricing isn't stable.** Per-token cost is low and falling, but all-in economics are capital-funded and negative; prices reprice toward heavy use (Cursor's flat→metered shift, 2025). The question isn't today's cost but "what will the org become by the time it costs what it costs?"
- **Discipline only survives where structure forces it.** Reckless building happens in autonomous senior pockets with free tokens; the slow enterprise bureaucracy is the only accidental brake. CXO questions: who needs this and what breaks without it? would we build it if it cost a week not an afternoon? who owns saying no?

## 2. SDD Isn't Broken — It Collapsed (4 May 2026)
**Thesis:** both camps fail by compressing three layers into one. Vibe = no spec; SDD = everything is spec.

- **Three-layer schematic:** **Intent** (user authors goals, constraints, scale, success/failure conditions; NFRs live here) → **Spec** (evaluable, test-shaped contract — passes/fails, doesn't describe) → **Implementation** (architecture; owned by the system with empirical memory, not pre-locked in the spec).
- **Four Crafts** (vocabulary from Nate B. Jones, 2026): Intent, Spec, Context, Prompt. Human performs Intent + Spec; system performs Context + Prompt (plays/playbooks). Plays are scaffolding to bridge the model-maturity gap; they thin as models resolve intent directly.
- **Substrate Stack** (maturity model): L1 Vibe (model + IDE; collapsed at scale) → L2 SDD (Kiro, spec-kit, Tessl; collapsing) → L3 Intent-driven (plays + knowledge base + four crafts) → L4 Autonomous (shared substrate) → L5 Dark Factory. **Memory is the prerequisite** for continuity. Author confesses being at ~L2.5, not L3.
- **Math:** a promised 50% delivery gain gives ~30% back to drift recovery → ~20% real. A drifted spec is worse than none — it lies with confidence. "Methodology is the product." Stop taking method advice from greenfield 3-engineer demos.

## 3. The Method That Replaces SDD — IDSD (20 May 2026)
**Thesis:** SDD leaves holes; the agent fills them. The fix is ICE with the human owning intent and expectations.

- **ICE = Intent, Context, Expectations**, each human-owned; harness owns the loop. **No spec craft** — the bloated spec becomes short **Expectations** (boundary/definition of done in user terms); context comes progressively from the harness; intent is the primitive.
- **Symphony proof:** OpenAI built it under "no human-written code," then distilled a 2,169-line / 18-section RFC-grade spec *from running software*, then reimplemented in 6 languages to shake out ambiguity. Deep specs are retrospective; you can't write them up front.
- **Author's own $985 mistake:** stepped out of the loop, agent drifted, 3 days rework at ~150–200M tokens/day. Lesson: **presence in the loop > approval at the gate**.
- **Economics:** code is cheap to run, agents fast to author but expensive — gap-filling burns tokens; the cost lands on the client. SDD adopted without the method (because the harness has a download button) reproduces the failure at client scale. Build/Boost/Buy shifts.

## 4. The Anatomy of Intent — ICE (27 May 2026)
**Thesis:** SDD tools are leashes; intent done right lets the goal-seeking model do its job.

- **Their own files contradict:** Spec Kit tells the model to "make informed guesses," cap NEEDS CLARIFICATION at 3, and ships *non-negotiable*, *optional*, and *mandatory* TDD orders together. Manifesto: "How Structure Constrains LLMs."
- **Intent = Goal + Constraints + Failure conditions.**
  - **Goal:** one sentence, no "and." Test: could two different implementations satisfy it? If only one, it's a spec in disguise (don't pre-pick Go/gRPC/Postgres).
  - **Constraints:** 5–7 directional non-functional qualities in business language (1,000 MAU; p99 < 200ms; 99.99% uptime; WCAG 2.1 AA; OWASP ASVS L2). No tools/patterns; stop when the list grows.
  - **Failure conditions:** binary, observable, post-output evals owned by the *validator* (build fails, coverage < 90%, lint errors, secret leak, API change without version bump).
  - **Decision rule:** does it change how the builder designs? → constraint; else → failure condition. Compartment them so the builder can't reward-hack.
- Same anatomy works outside coding (red shoe < $30). Dropped fields: Connections (real but managed separately) and Scenarios (success scenarios moved to Expectations). SDD is correct as step 2 after vibe; it breaks beyond. Intent is the part nobody/nothing can write for you; the harness (Garura) earns the discipline.

## 5. Breaking the Fifty-Year Iron Triangle (4 Jun 2026)
**Thesis:** agentic coding broke the iron triangle; SDD inverts the only lever left.

- **Old triangle (time/cost/quality):** speed → table stakes (agents ship in hours); quality → welded floor (evals/Sonar hold it without reading every diff); **cost = the live lever, split into tokens + cognition**.
- **Agentic Iron Triangle:** speed is bought by parallelism, capped by attention; "how many agents before your head can't hold them?" not "how fast is one model." Fast models are the trap.
- **Cost is not what clients expect:** human headcount drops but per-head rises; tokens climb; discipline is the service sold. Uber exhausted its 2026 AI budget in ~4 months (84% Claude Code, $500–2,000/eng/mo; COO: value link "not there yet"); a Microsoft division dropped Claude Code on cost; Steinberger's 603B tokens/$1.3M month (OpenAI paid).
- **$96k spec vs $16k question:** 5 people × 3 months of specs answered nothing; one "why are we building this?" collapsed it to ~10 days. SDD spikes both levers and cracks the floor; IDSD reverses them. Don't measure by tokens burned. CTO: own the why, measure value not output, build skills that review intent. Each method decays (Agile → spec process); discipline outlives the label.

---

## Implications for AI-dō
- Reinforces **Ch. 3** (spec vs vibe, three-layer schematic) and **Ch. 4** (four crafts, substrate stack, memory).
- ICE ≈ intent→spec→implementation; add **expectations-as-contract** and the goal/constraint/failure-condition decision rule.
- Discipline > method; harnesses (spec-kit, BMAD, Garura) are not the methodology. Memory is the L3 prerequisite. Stay present in the loop; measure value, not output.
