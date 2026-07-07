# Factory 2.0: From Coding Agents to Software Factories

> [!NOTE]
> Source: [factory-2-0-software-factory.md](../../sources/agent-disciplines/factory-2-0-software-factory.md) — Matan Grinberg & Eno Reyes, *Factory 2.0: From coding agents to software factories*, Factory.ai company blog, 15 June 2026. https://factory.ai/news/software-factory
>
> **This is a vendor announcement.** Factory.ai is selling the platform it describes; every capability claim, customer claim, and prediction below is the company's own marketing assertion, not independently verified evidence. Useful as a primary source for how a vendor *defines and positions* the "software factory" concept, not as proof that the concept works.

## Abstract

Factory.ai's announcement marks what the company calls the next phase of its mission: moving from autonomous coding agents ("Droids") for individual engineers to an organisation-wide "software factory". Key points:

- **The claim of a shift**: improving individual engineer productivity "is no longer enough"; organisation-wide productivity requires "an interconnected, agent-native, end-to-end system" whose incremental units are AI agents — this system is the software factory.
- **The factory as a feedback loop**: outside-world signals (bug reports, internal conversations, customer feedback, business requirements) are triaged into planned changes, which are "built, tested, reviewed, secured, shipped, and monitored"; monitoring generates new signals. Factory claims "almost no one has meaningfully instrumented this loop to be fully AI-driven."
- **Three stated requirements** for a robust software factory: model independence (multi-model, with a Router selecting per task), sovereign intelligence (customer-controlled deployment and a self-learning system whose accumulated capability "stays with you, inside your walls"), and continual learning/self-improvement (every SDLC stage instrumented on one platform sharing agent core, router, and organisational context).
- **Named customers** (company's own claim): software factories "already in production" at NVIDIA, EY, Adobe, Palo Alto Networks, Adyen, Blackstone, Wipro, Comarch "and more".
- **Autonomy is explicitly gradual, not total**: "No organization starts with a fully autonomous software factory." Factory offers a spectrum — simple Droid agents/skills, Automations, Droid Computers (remote/persistent execution), and multi-agent "Missions" running hours or days — chosen by required human guidance, information sensitivity, and "Agent Readiness".
- **What stays human**: engineers stop being "the sole custodians of building the software" and instead become "responsible for building the factories that build the software", retaining "governance, safety, and the ownership of business outcomes".

Takeaway for the book: this is the clearest vendor articulation of the coding-agent → factory framing — software engineering recast as designing, instrumenting, and governing an agent production system, with the human role moving up a level of abstraction rather than disappearing.

## 1. The pivot: from coding agents to a factory

Factory launched in 2023 "to bring autonomy to software engineering", positioning itself against tools that merely "speed up coding" by deploying "autonomous Droids across the enterprise software development lifecycle". Factory 2.0 declares individual-engineer productivity insufficient and defines the successor system. The definition, verbatim (the announcement's own emphasis was a standalone sentence):

> "Unlocking organization-wide productivity requires an interconnected, agent-native, end-to-end system. This system must improve over time by observing itself. The incremental units of this system are AI agents. This system will be built by engineers, and in turn will build their software. This system is the software factory."

## 2. The factory as a continuous feedback loop

The factory "starts with signals from the outside world: bug reports, internal conversations, customer feedback, business requirements". Signals are triaged into planned changes; changes are "built, tested, reviewed, secured, shipped, and monitored"; monitoring of deployed software generates more signals. "The entire system is a continuous feedback loop." The company's market claim: "Almost no one has meaningfully instrumented this loop to be fully AI-driven. We are still early, but the proliferation of software factories is going to happen very quickly" — a prediction, and the vendor's own.

## 3. Three requirements for a robust software factory

1. **Model independence.** No single model fits every enterprise need on cost/performance/speed; the factory must let organisations choose models deliberately or use a Router to select automatically or by rule ("best" configurable by cost, performance, speed, or a combination). Factory expects models to commoditise, with falling cost and rising speed/performance.
2. **Sovereign intelligence.** Deployment choices span fully hosted, bring-your-own-key, self-hosted data plane, EU-specific, or fully air-gapped. But sovereignty is framed as more than hosting: "owning a system that learns from itself, feeding every agent session, code review, and resolved incident back into the loop", with the accumulated capability staying "inside your walls, under your control".
3. **Continual learning and self-improvement.** Every SDLC stage instrumented on one platform: code review, security analysis, documentation, QA, and incident response "share the same agent core, the same model router, the same organizational context". Claimed cross-stage effects: a security finding informs code review; a deployment triggers a documentation update; an incident correlates with the causing PR. "The assembly line should span the full floor of the software factory."

## 4. Customer claims

Factory says it has "been building software factories with our customers for the last few months" and that they are "already in production across the world's largest organizations including NVIDIA, EY, Adobe, Palo Alto Networks, Adyen, Blackstone, Wipro, Comarch and more." No case-study detail, metrics, or customer statements accompany the list in this announcement — it is an unaudited vendor claim.

## 5. The autonomy spectrum — what stays human

The announcement is explicit that autonomy is a maturation process, not a switch:

- "No organization starts with a fully autonomous software factory. Autonomy is a maturation process that is gradual and specific to every organization's readiness and comfort level," advanced "through deliberate engineering effort to codify workflows and standardize processes."
- Factory offers graduated mechanisms because "not every process should use long-horizon autonomous tasks": well-defined measurable tasks run on simple Droid agents or skills; **Automations** coordinate recurring workflows with shared objective and memory; **Droid Computers** provide remote, persistent execution for long-running or local agents; **Missions** are multi-agent autonomous execution solving complex tasks "over hours or days by decomposing work into parallel tracks".
- Selection among these depends on "the level of human guidance required, the information sensitivity, and the level of Agent Readiness".

On the human role: "The role of engineers is all the more important in this new era. No longer will they be the sole custodians of building the software. Instead, they will be responsible for building the factories that build the software. With this comes the responsibility of governance, safety, and the ownership of business outcomes." The company predicts the next era will be "engineering-led", with engineering responsibilities expanding "across the business itself".

## 6. Product note

The announcement's concrete product change is modest relative to the framing: Factory adds "visibility to manage your software factory directly in the Factory desktop app". The rest is positioning and a call to contact sales — consistent with reading this as a marketing milestone rather than a technical report.
