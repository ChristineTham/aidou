# Chapter 5 — Responsibility & Governance (the duty)

Capability without responsibility is how organisations get hurt, and 2026 supplied the cautionary tales. This chapter is the duty half of the discipline: securing agents, owning what they say, and governing access in a world where the model you depend on may be pulled or repriced overnight. It is the 愛 in the method made concrete — care expressed as guardrails.

## Safety & Red-Teaming

Agent security is not cybersecurity with AI bolted on; it is a new attack surface — agent sessions, browser-extension takeovers, prompt-data exfiltration — that older controls never anticipated. The trend line is unflattering: documented AI incidents rose from 233 to 362 in a year, and reporting on responsible-AI benchmarks still lags reporting on capability, so the gap between what models can do and what we measure about their behaviour is widening ([HAI 2026](https://hai.stanford.edu/ai-index/2026-ai-index-report)). The response is structural: capability-based, least-privilege access for every agent, deliberate red-teaming of sessions, and reflection or control loops that monitor an agent's own decisions and keep it auditable ([2512.21354](../research/papers/2512.21354-reflection-control.md)). In multitenant settings the lesson is sharper still: retrieval ranks by relevance, not authorization, so ungated RAG leaks cross-tenant data in 98–100% of probes — gate at retrieval and enforce server-side, never trust the client ([2605.05287](../research/papers/2605.05287-securing-agent.md)).

> [!IMPORTANT]
> Give each agent its own **service-account identity** with **least-privilege** tokens scoped per tool, not a human's broad credentials. Impersonation grants capability without protection and erases the audit trail.

The OWASP Top 10 for LLM applications names the surface concretely, and each entry maps to a control:

| Risk | Control |
| --- | --- |
| Prompt injection | Segregate system/user input; gate untrusted content |
| Insecure output handling | Validate/escape before downstream use |
| Excessive agency | Least-privilege, scoped tools, human checkpoints |
| Sensitive-info disclosure | Redaction; per-tenant isolation |
| Overreliance | Verification + reviewer judgement in the loop |

Source: [OWASP LLM Top 10](https://owasp.org/www-project-top-10-for-large-language-model-applications/). Red-teaming under documented rules of engagement turns these from a checklist into a practice.

## Liability & Provenance

Once a model speaks for your organisation, its output is your first-party statement, and errors or infringements land on you, not the vendor — a principle courts have begun to enforce. That turns governance into a contract problem as much as a technical one: indemnity, provenance, and transparency belong in every agreement and every pipeline, so you can show where a claim came from and who is answerable for it. Provenance has a standard — C2PA content credentials cryptographically bind origin and edit history to media ([C2PA](https://c2pa.org/)) — so adopt it rather than improvising. Treating AI text as someone else's problem is how the liability arrives unannounced.

## Governed Access

Governance has to cover access, not just usage. Deloitte finds nearly seven in ten organisations running autonomous agents while barely a fifth have mature governance for them, and country-of-origin is now a deciding factor in vendor choice as sovereign-AI concerns grow ([Deloitte 2026](https://www.deloitte.com/au/en/issues/generative-ai/state-of-ai-in-enterprise.html)). A common spine for the work is NIST's AI Risk Management Framework, which organises it into four functions so risk is designed for rather than discovered ([NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)):

| Function | Question it answers |
| --- | --- |
| Govern | Who is accountable, and under what policy? |
| Map | Where could this system cause harm? |
| Measure | How do we quantify those risks? |
| Manage | How do we mitigate and monitor them? |

The useful frame is to govern the repository rather than the agent — controlling the ecosystem the work lands in, where risk is measurable, instead of policing each model ([2606.28235](../research/papers/2606.28235-govern-repository.md)) — and to keep a multi-model fallback, including open weights, ready to go. The config layer that steers agents is itself unmanaged supply chain: a study of 10,008 repos found 10% of agent-config paths are exact duplicates across orgs and under 1% declare permission boundaries, which is why governance must be deterministic and tool-agnostic, not delegated to more LLM orchestration ([2606.26924](../research/papers/2606.26924-control-plane.md)). Single-vendor dependence under geopolitical release risk is the exposure to retire first, because the cheapest outage is the one you planned for.
