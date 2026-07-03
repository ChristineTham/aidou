# Chapter 5 — Responsibility & Governance (the duty)

The first time I gave an agent my own login so it could "just get things done," it worked beautifully — until I realised every action it took wore my name, with no way to tell mine from its. Capability without responsibility is how organisations get hurt, and 2026 supplied the cautionary tales.

This chapter is the duty half of the discipline: securing agents, owning what they say, and governing access in a world where the model you depend on may be pulled or repriced overnight. It is the 愛 in the method made concrete — care expressed as guardrails.

## 5.1 Safety & Red-Teaming

Agent security is not cybersecurity with AI bolted on; it is a new attack surface — agent sessions, browser-extension takeovers, prompt-data exfiltration — that older controls never anticipated. This is not only a developer's concern: the moment you let an agent read your inbox, browse on your behalf, or open a client's files, you have exposed the same surface. The trend is unflattering: documented AI incidents rose from 233 to 362 in a year, and responsible-AI reporting still trails capability reporting, so the gap between what models do and what we measure widens ([Stanford HAI, *The AI index 2026 annual report*, 2026](https://hai.stanford.edu/ai-index/2026-ai-index-report)).

The response is structural: least-privilege access per agent, deliberate red-teaming of sessions, and control loops that monitor an agent's own decisions ([Wang et al., *Reflection-driven control for trustworthy code agents*, 2025](https://arxiv.org/abs/2512.21354)). Those loops can in principle watch the model's internal state, not only its outputs: Anthropic's interpretability team found that internal representations of "desperation" causally raise the rate of agentic misalignment — blackmail, and reward-hacking under pressure — while "calm" suppresses it, and they propose monitoring such activations as a runtime warning sign ([Sofroniew et al., *Emotion concepts and their function in a large language model*, 2026](https://transformer-circuits.pub/2026/emotions/index.html)). In multitenant settings it is sharper still — retrieval ranks by relevance, not authorization, so ungated RAG leaks cross-tenant data in 98–100% of probes. Gate at retrieval, enforce server-side, never trust the client ([Arceo & Narsing, *Securing the agent: Vendor-neutral, multitenant enterprise retrieval and tool use*, 2026](https://arxiv.org/abs/2605.05287)).

> [!NOTE]
> Security terms used here, in plain English:
>
> - **RAG (retrieval-augmented generation)** — fetching relevant documents from a store and feeding them to the model as context, so its answer is grounded in your data rather than its training alone.
> - **Multitenant / cross-tenant** — one system serving many customers (tenants); a cross-tenant leak is one customer's query pulling back another's data.
> - **Red-teaming** — deliberately attacking your own system, under rules, to find weaknesses before a real attacker does.

> [!IMPORTANT]
> Give each agent its own **service-account identity** with **least-privilege** tokens scoped per tool, not a human's broad credentials. Impersonation grants capability without protection and erases the audit trail.

```mermaid
flowchart LR
    U[Human owner] -->|delegates| A
    subgraph TB [Trust boundary]
      A["Agent · own service account"] -->|least-privilege tokens| T[Scoped tools]
      A --> R[Retrieval]
      R -->|authorization check| D[(Per-tenant data)]
    end
    A -.->|every action logged| L[Audit trail]
    X(("Attacker:<br/>prompt injection")) -.->|blocked at boundary| A
    classDef danger fill:#fee,stroke:#c33
    class X danger
```

The OWASP Top 10 for LLM applications names the surface concretely, and each entry maps to a control:

| Risk | Control |
| --- | --- |
| Prompt injection | Segregate system/user input; gate untrusted content |
| Insecure output handling | Validate/escape before downstream use |
| Excessive agency | Least-privilege, scoped tools, human checkpoints |
| Sensitive-info disclosure | Redaction; per-tenant isolation |
| Overreliance | Verification + reviewer judgement in the loop |

Source: [OWASP, *OWASP top 10 for large language model applications*, n.d.](https://owasp.org/www-project-top-10-for-large-language-model-applications/). Red-teaming under documented rules of engagement turns these from a checklist into a practice.

## 5.2 Liability & Provenance

Once a model speaks for your organisation, its output is your first-party statement, and errors or infringements land on you, not the vendor — a principle courts have begun to enforce. That turns governance into a contract problem as much as a technical one: indemnity, provenance, and transparency belong in every agreement and every pipeline, so you can show where a claim came from and who is answerable for it. Provenance has a standard — C2PA content credentials cryptographically bind origin and edit history to media ([C2PA, *Overview*, n.d.](https://c2pa.org/)) — so adopt it rather than improvising. Provenance matters precisely because audiences cannot supply it themselves: in a 606-reader study, people rated AI- and human-written text as equally credible — and the AI version as *clearer and more engaging* — so the burden of disclosure falls on the publisher, not the reader ([Huschens et al., *Do you trust ChatGPT? Perceived credibility of human and AI-generated content*, 2023](https://arxiv.org/abs/2309.02524)). Treating AI text as someone else's problem is how the liability arrives unannounced.

## 5.3 Overreliance & Convergence

Overreliance is the quiet entry on every risk register, and at the scale of a whole organisation it takes a particular shape. Frontier models do not merely sound confident; they converge. Asked for strategy across many business contexts, they cluster on the same fashionable answers — in one study choosing "differentiate" over "compete on cost" 96% of the time, with richer context moving the answer by only 11% and better prompting by just 2% ([Romasanta et al., *Researchers asked LLMs for strategic advice. They got “trendslop” in return*, 2026](https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return)). The researchers call it *trendslop*: advice that sounds tailored but steers every company toward the same crowded position.

The danger is in how convergence meets confidence. An organisation corrects itself through friction — Sales says compete on cost, Product says differentiate, and the argument surfaces what either side missed. When everyone consults the same models and arrives, confidently, at the same answer, that friction vanishes, and the agreement reads as validation rather than the artefact it is. Nobody asks "are you insane?" because everyone is seeing the same thing ([Johnson Spink, *The AI jester: How AI makes you confident and wrong*, 2026](https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/)).

Convergence at the moment of decision is not the only way a model steers a view; the tool reshapes opinions as people merely write with it. In a controlled experiment, a writing assistant tuned to one side of a contested question moved both what participants wrote and the attitudes they reported holding afterwards — a quiet, scalable nudge the authors argue must be monitored and engineered rather than left to chance ([Jakesch et al., *Co-writing with opinionated language models affects users’ views*, 2023](https://arxiv.org/abs/2302.00560)). For governance that means treating the opinions built into a vendor's model as a managed dependency, with the same scrutiny you would give any other input to a decision.

The governance response is to protect divergence deliberately. Reserve genuinely consequential decisions for human reasoning before any chat window is opened; treat agreement among AI-assisted analyses as a weaker signal, not a stronger one; and keep a multi-model bench so that, at the least, the models differ. Convergence is cheap to buy and expensive to discover.

## 5.4 The Deferred Ledger

The cheapest way to mismanage AI is to read today's price as the real one. Producing things — a report, a financial model, an analysis, a working application — has fallen close to free, so we now make them because we can, not because a need cleared any bar. When creation costs almost nothing, it is tempting to treat the result as disposable: software you can regenerate or refactor at will, a deck you can rebuild from a prompt, an analysis you can re-run tomorrow. But the artefact is only the cheap part, and the bill is deferred, not escaped. Per-token inference is genuinely cheap and getting cheaper; the exposure is that the all-in economics are capital-funded and negative. OpenAI reportedly lost around five billion dollars in 2024 on roughly a ten-per-cent gross margin, and its own chief executive said even the two-hundred-dollar tier loses money because "people use it much more than we expected." Capital-funded prices do not hold still: in mid-2025 Cursor quietly turned a flat plan into metered credits because newer models spent more tokens per request than the price could carry ([Ahuja, *The trap spec-driven development is setting*, 2026e](https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d)). The question for a leader is not what this costs today, but what the organisation will have become by the time it costs what it truly costs.

Kapil Viren Ahuja names three debts that accrue while the meter is cheap and come due on enterprises, not hobbyists ([Ahuja, 2026e](https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d)):

| Debt | What accrues | When it comes due |
| --- | --- | --- |
| Skill | Judgement that is never exercised atrophies | The quarter a hard build-or-don't-build call finally matters |
| Dependence | Workflows assume generation is free and reliable | When the tool degrades or reprices under you |
| Carry | Anything built without need becomes inventory — code, models, decks, analyses | Maintained, secured, and repriced for its whole life |

The Carry debt is the one the moment most wants to wave away. If a system can be regenerated from a prompt, the reasoning goes, it is disposable — recreate it, refactor it, throw it away and build again. But disposability is mostly an illusion. Whatever ships still has to be understood, secured, kept correct, and trusted by the people who depend on it, and none of that is regenerated along with the code. The same holds for knowledge work: an analysis nobody validated is not an asset you can re-run at will but a liability wearing the costume of one. Cheap to make is not the same as cheap to own.

Dependence debt is the easiest to miss, because degradation is invisible: Anthropic's own September 2025 postmortem admitted that for about five weeks roughly 30% of Claude Code users received at least one degraded response, and most never knew the instrument was quietly wrong ([Ahuja, 2026e](https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d)). The governance answer is not to build less but to restore the brake that cheap building removed. On every initiative, name the person whose job is to ask three questions — who needs this and what breaks for them if it never exists; would we still build it if it cost a week of skilled work rather than an afternoon of tokens; and who owns saying no — and make that same person supply the intent. A decision with no owner is where the value question quietly disappears ([Ahuja, *Spec-driven development is also breaking the fifty-year-old iron triangle*, 2026c](https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06)).

## 5.5 Governed Access

Governance has to cover access, not just usage. Deloitte finds nearly seven in ten organisations running autonomous agents while barely a fifth have mature governance for them, and country-of-origin is now a deciding factor in vendor choice as sovereign-AI concerns grow ([Deloitte, *State of AI in the enterprise*, 2026](https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html)). A common spine for the work is NIST's AI Risk Management Framework, which organises it into four functions so risk is designed for rather than discovered ([NIST, *AI risk management framework (AI RMF 1.0)*, 2023](https://www.nist.gov/itl/ai-risk-management-framework)):

| Function | Question it answers |
| --- | --- |
| Govern | Who is accountable, and under what policy? |
| Map | Where could this system cause harm? |
| Measure | How do we quantify those risks? |
| Manage | How do we mitigate and monitor them? |

The useful frame is to govern the place the work lands rather than the agent — a code repository is the studied case, but the same logic covers a shared drive or a system of record: control the ecosystem the work enters, where risk is measurable, instead of policing each model ([Russo, *Govern the repository, not the agent: Ecosystem-level risk in AI-native software*, 2026](https://arxiv.org/abs/2606.28235)) — and to keep a multi-model fallback, including open weights, ready.

The config layer that steers agents is itself unmanaged supply chain: a study of 10,008 repos found 10% of agent-config paths are exact duplicates across orgs and under 1% declare permission boundaries. Governance must be deterministic and tool-agnostic, not delegated to more LLM orchestration ([Madatha, *A deterministic control plane for LLM coding agents*, 2026](https://arxiv.org/abs/2606.26924)). Single-vendor dependence under geopolitical release risk is the exposure to retire first — the cheapest outage is the one you planned for.

## 5.6 The Duty, Made Accountable

Pull the five threads together and they are one duty. Securing an agent, owning what it says, guarding against convergence, pricing the deferred bill, governing access — each is a way of keeping a human answerable for what the machine does. The failure mode is the same throughout: capability arrives faster than responsibility for it, and the gap between the two is where organisations get hurt.

That gap is now written into law. The European Union's AI Act requires high-risk systems to be built so that a named person can effectively oversee them — understand the system's limits, monitor its operation, resist the pull to over-rely on plausible output, which the Act names *automation bias*, and decide, in any given case, to override the system or not use it at all ([European Union, *Article 14: Human oversight*, 2024](https://artificialintelligenceact.eu/article/14/)). It is this chapter's argument made statutory: oversight is not a courtesy the confident may skip, and "the model did it" is not a defence anyone will accept.

None of this is a brake on building. It is the 愛 made concrete — care expressed as guardrails, and a person who stays answerable at every boundary the work crosses. Capability is something you buy; responsibility is something you keep. Hold the second as deliberately as the first, and the question the next chapter turns to — what stays distinctly yours — has an answer worth protecting.

## References

Ahuja, K. V. (2026c). *Spec-driven development is also breaking the fifty-year-old iron triangle*. Activated Thinker (Medium). [https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06](https://howtoarchitect.io/78431acba162?sk=cd2a36f452af96ccbfbcfcdeaa92ec06)

Ahuja, K. V. (2026e). *The trap spec-driven development is setting*. Activated Thinker (Medium). [https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d](https://howtoarchitect.io/48b2ad4f9cdc?sk=e6bd922772cb6798056d597886ec108d)

Arceo & Narsing. (2026). *Securing the agent: Vendor-neutral, multitenant enterprise retrieval and tool use*. Proceedings of ACM CAIS ’26. [https://arxiv.org/abs/2605.05287](https://arxiv.org/abs/2605.05287)

Coalition for Content Provenance and Authenticity. (n.d.). *Overview*. [https://c2pa.org/](https://c2pa.org/)

Deloitte. (2026). *State of AI in the enterprise*. [https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html](https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html)

European Union. (2024). Article 14: Human oversight. In *EU Artificial Intelligence Act (Regulation (EU) 2024/1689)*. [https://artificialintelligenceact.eu/article/14/](https://artificialintelligenceact.eu/article/14/)

Huschens, M., Briesch, M., Sobania, D., & Rothlauf, F. (2023). *Do you trust ChatGPT? Perceived credibility of human and AI-generated content*. arXiv. [https://arxiv.org/abs/2309.02524](https://arxiv.org/abs/2309.02524)

Jakesch, M., Bhat, A., Buschek, D., Zalmanson, L., & Naaman, M. (2023). *Co-writing with opinionated language models affects users’ views*. Proceedings of the 2023 CHI Conference on Human Factors in Computing Systems. [https://arxiv.org/abs/2302.00560](https://arxiv.org/abs/2302.00560)

Johnson Spink, D. (2026). *The AI jester: How AI makes you confident and wrong*. LinkedIn. [https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/](https://www.linkedin.com/pulse/ai-jester-how-makes-you-confident-wrong-johnson-spink-gg3df/)

Madatha, P. (2026). *A deterministic control plane for LLM coding agents*. arXiv. [https://arxiv.org/abs/2606.26924](https://arxiv.org/abs/2606.26924)

National Institute of Standards and Technology. (2023). *AI risk management framework (AI RMF 1.0)*. [https://www.nist.gov/itl/ai-risk-management-framework](https://www.nist.gov/itl/ai-risk-management-framework)

OWASP. (n.d.). *OWASP top 10 for large language model applications*. [https://owasp.org/www-project-top-10-for-large-language-model-applications/](https://owasp.org/www-project-top-10-for-large-language-model-applications/)

Romasanta, A., Thomas, L. D. W., & Levina, N. (2026). *Researchers asked LLMs for strategic advice. They got “trendslop” in return*. Harvard Business Review. [https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return](https://hbr.org/2026/03/researchers-asked-llms-for-strategic-advice-they-got-trendslop-in-return)

Russo, D. (2026). *Govern the repository, not the agent: Ecosystem-level risk in AI-native software*. arXiv. [https://arxiv.org/abs/2606.28235](https://arxiv.org/abs/2606.28235)

Sofroniew, N., Kauvar, I., Saunders, W., Chen, A., et al. (2026). *Emotion concepts and their function in a large language model*. Transformer Circuits Thread. [https://transformer-circuits.pub/2026/emotions/index.html](https://transformer-circuits.pub/2026/emotions/index.html)

Stanford Institute for Human-Centered AI. (2026). *The AI index 2026 annual report*. Stanford University. [https://hai.stanford.edu/ai-index/2026-ai-index-report](https://hai.stanford.edu/ai-index/2026-ai-index-report)

Wang, Quan, Yu, Hu, & Tsang. (2025). *Reflection-driven control for trustworthy code agents*. arXiv. [https://arxiv.org/abs/2512.21354](https://arxiv.org/abs/2512.21354)
