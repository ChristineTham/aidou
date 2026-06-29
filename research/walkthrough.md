# Research Walkthrough — Detailed Per-Source Analysis

Compiled 29 Jun 2026. For every section, each source gets multiple bullets covering its major subjects, what was incorporated, and a justification. Cleaned Markdown in `sources/<section>/`. ★ = cited inline in the book.

## Gaps found on re-review and how they were closed

| Gap | Source | Fix in book |
| --- | --- | --- |
| Ch2 vague "many-fold" productivity | nber: +14% avg, +34% novices, ~0 experts | Replaced with 5,179-agent figures; cited |
| Ch6 "augment not replace" unevidenced | nber novice skew | Gains skew to novices → expertise is moat |
| Ch4 "context rot" generic | NIAH vs NoLiMa semantic recall | Added benchmark detail + Chroma cite |
| Ch1 愛 ungrounded | Tronto care qualities | Added attentiveness/responsibility/competence/responsiveness |
| clock stat mis-sourced | clock-bench is vision-language eval | Re-attributed to HAI |

## Chapter 1 — Foundations

### The Meaning of AI-dō — `sources/01-meaning`

- **judo-wikipedia ★** — Kanō Jigorō, 1882; principles "maximum efficiency, minimum effort" and "mutual welfare"; belt/kata progression encode a lifelong path. *Incorporated:* dō-as-path; jūdōka analogy. *Justification:* model for discipline-not-trick.
- **kendo-wikipedia** — sword "way": etiquette, posture, character over winning. *Incorporated:* dō lineage. *Justification:* shows dō spans crafts.
- **aikido-wikipedia** — harmonise/redirect ki rather than oppose. *Incorporated:* augmentation framing. *Justification:* augment-not-replace.
- **budo-wikipedia** — martial ways stress moral development. *Incorporated:* discipline framing. *Justification:* depth.
- **dojo-wikipedia** — hall of repeated practice. *Incorporated:* none. *Justification:* off-scope.
- **shokunin-kaizen-wikipedia** — kaizen: everyone improves a little, forever. *Incorporated:* discipline over hacks; iterative mastery. *Justification:* core principle.
- **ikigai-wikipedia** — purpose at passion/skill/need overlap. *Incorporated:* none. *Justification:* tangential.
- **care-ethics-wikipedia** — Tronto's four duties of care:
  - *Attentiveness* — noticing need before acting (gather context first).
  - *Responsibility* — owning the outcome, not just the task.
  - *Competence* — knowing where the model is weak.
  - *Responsiveness* — verify and adapt to the end user.
  *Incorporated:* 愛 = concrete duties NOTE. *Justification:* turns "care" from sentiment into testable accountability.
- **intelligence-augmentation-wikipedia** — Engelbart/Ashby IA: extend intellect. *Incorporated:* augmentation pillar. *Justification:* book voice.
- **human-centered-ai-stanford** — HAI: augment humanity. *Incorporated:* human-centred first. *Justification:* purpose.
- **responsible-ai-google** — beneficial/accountable/fair. *Incorporated:* Ch5. *Justification:* cited later.
- **ai-wikipedia** — baseline. *Incorporated:* none. *Justification:* reference.

### Mental Models — `sources/01-mental-models`

- **agent-def-willison ★** — agent = LLM + tools in a loop; computer can't be accountable. *Incorporated:* agent NOTE. *Justification:* settles term.
- **transformer-attention ★** — self-attention; n² token pairs. *Incorporated:* Ch4. *Justification:* mechanism behind limits.
- **context-engineering-anthropic ★** — curate tokens. *Incorporated:* Ch4. *Justification:* loop foundation.
- **hallucination-wikipedia** — fluent falsehoods; partial mitigation. *Incorporated:* verify habit. *Justification:* limits.
- **mental-model / system-thinking / feedback-loop** — input→context→response→refine. *Incorporated:* loop diagram. *Justification:* spine.
- **rag-arxiv** — retrieval grounding. *Incorporated:* Ch2. *Justification:* background.
- **prompt-eng-wikipedia** — prompt craft. *Incorporated:* context-vs-prompt. *Justification:* shift.
- **few-shot / chain-of-thought** — in-context/step reasoning. *Incorporated:* none. *Justification:* technique, off-scope.
- **llm-wikipedia** — baseline. *Incorporated:* none. *Justification:* reference.

### The 2026 Landscape — `sources/01-landscape`

- **hai-2026-index ★** — 88% adoption; SWE-bench 60→100%; gap ~2.7%; jagged frontier; incidents up. *Incorporated:* table. *Justification:* primary.
- **mckinsey ★** — broad use, ~39% any EBIT; redesign matters. *Incorporated:* value-scarce. *Justification:* counter-figure.
- **swebench** — live scores + cost. *Incorporated:* capability/cost. *Justification:* verifiable.
- **stateofai / epoch / ourworld / oecd** — frontier review, compute, adoption, policy:
  - 44% of US businesses pay for AI (5% in 2023); avg contract ~$530k; 95% of practitioners use AI.
  - Training compute ~5×/yr; inference cost roughly halving; power is the new constraint.
  *Incorporated:* commercial-traction table row. *Justification:* concrete corroboration of adoption.
- **eu-ai-act / foundation-model / genai** — regulation, open weights. *Incorporated:* Ch5/open-weight. *Justification:* governance.

### Capabilities & Limitations — `sources/01-capabilities`

- **microgpt ★** — 200-line GPT; predictor; hallucination = completion. *Incorporated:* core. *Justification:* mechanism.
- **context-rot-chroma** — 18 LLMs; NIAH vs NoLiMa; semantic recall drops. *Incorporated:* Ch4. *Justification:* verifiable.
- **hallucination-survey / world-models / emergent / reasoning-o1** — limits, scale, effort. *Incorporated:* jagged frontier, verify. *Justification:* support.
- **swebench-paper / scaling-laws / multimodal / limits-llm** — eval, technical, background. *Incorporated:* mostly none. *Justification:* off-scope/technical.
- **clock-bench** — vision-language eval, not clocks. *Incorporated:* none. *Justification:* clock stat via HAI.

## Chapter 2 — Personal Productivity

### Ambient Teammate — `sources/02-ambient`

- **loopcraft ★** — design loops not prompts; remove yourself as bottleneck; throughput. *Incorporated:* thesis. *Justification:* primary.
- **bottleneck-theory / flow-throughput** — constraint sets pace; throughput vs latency. *Incorporated:* rate-limiter. *Justification:* frames delegation.
- **ai-teammate / ambient-computing / async-agents** — agents as colleagues, background, async. *Incorporated:* definition. *Justification:* support.
- **agents-willison / copilot-agent / automation-aug / delegation-hbr** — loop, examples, augment, scope-review. *Incorporated:* practice. *Justification:* support.
- **task-mgmt** — GTD. *Incorporated:* none. *Justification:* background.

### Knowledge Work — `sources/02-knowledge-work`

- **genai-productivity-nber ★** — 5,179 agents; +14% avg, +34% novices, ~0 experts; spreads best-worker know-how. *Incorporated:* figure. *Justification:* concrete evidence.
- **hai / codex-usage** — gains in knowledge work. *Incorporated:* framing. *Justification:* primary.
- **automation-bias / productivity-paradox** — over-trust; output≠value. *Incorporated:* pitfall. *Justification:* risk.
- **copilot-study / decision-support / synthesis / notebooklm** — surfaces. *Incorporated:* uses. *Justification:* support.
- **knowledge-work-wiki / gpt-wiki** — background. *Incorporated:* none. *Justification:* reference.

### Personal Operating Models — `sources/02-operating-models`

- **pkm-wiki / zettelkasten** — externalise + link. *Incorporated:* compounding. *Justification:* core.
- **claude-md / reusable-prompts / templates** — encode once. *Incorporated:* plays. *Justification:* direct.
- **habit-loop / gtd / workflow** — daily compounding. *Incorporated:* loop. *Justification:* support.
- **memory-anthropic / spaced** — persistence. *Incorporated:* Ch4. *Justification:* cross-ref/background.

### LLM Wiki — `sources/02-llm-wiki`

- **llm-wiki ★** — accumulate vs RAG; raw→wiki→schema; ingest/query/lint. *Incorporated:* whole section + mermaid. *Justification:* flagship.
- **memex / as-we-think** — Bush's curated trails. *Incorporated:* lineage. *Justification:* heritage.
- **rag-wiki / vector-db / okf** — retrieval, scaling, schema. *Incorporated:* contrast/scale. *Justification:* support.
- **obsidian / wiki / knowledge-base / note-taking / agent-memory / context-eng** — tooling, drift. *Incorporated:* support. *Justification:* support.

## Chapter 3 — Software Development

### Modern Dev Stack — `sources/03-stack`

- **claude-config ★** — config files are top architectural lever in 300+ projects. *Incorporated:* stack. *Justification:* empirical.
- **build-agents / mcp / agent-sdk** — workflows vs agents; tool protocol. *Incorporated:* harness def. *Justification:* canonical.
- **copilot-harness / agent-orchestration / memory-arch / eval** — value above model. *Incorporated:* stack. *Justification:* support.
- **swebench / cursor / devops / copilot** — context. *Incorporated:* mostly none. *Justification:* background.

### Coding Patterns — `sources/03-coding-patterns`

- **build-agents ★** — chaining/routing/parallel/orchestrator/eval-opt; ACI; multi-agent ~15× token cost. *Incorporated:* table. *Justification:* canonical.
- **refactoring/pair/debugging/tdd/review** — surfaces. *Incorporated:* uses. *Justification:* support.
- **swe-agent/static-anchor/copilot-study** — evidence. *Incorporated:* reliability. *Justification:* support.
- **prog-arch/vibe-coding/prompt-guide** — background. *Incorporated:* none. *Justification:* reference.

### Spec vs Vibe — `sources/03-spec-vibe`

- **spec-kit ★** — spec = executable contract; specify/plan/tasks/implement. *Incorporated:* pro case. *Justification:* fairness.
- **sdd-collapse/sdd-trap/idsd/ice ★** — three layers collapse; Symphony 2k lines reverse-engineered. *Incorporated:* reframing. *Justification:* thesis.
- **spec-growth/waterfall/agile/req-eng/spec-wiki** — lineage/counterpoint. *Incorporated:* support. *Justification:* support.
- **vibe-wiki/karpathy** — origin. *Incorporated:* none. *Justification:* background.

### ICE — `sources/03-ice`

- **intent ★** — goal+constraints+failure; one-sentence goal; decision rule. *Incorporated:* core. *Justification:* primary.
- **sep-concerns/contract/reward-hack** — separate, contract, compartment. *Incorporated:* structure. *Justification:* basis.
- **nfr/acceptance/user-story/eval/symphony/verifast/latent-req/iron-tri** — qualities, checks, fidelity. *Incorporated:* support. *Justification:* support.

### Quality over Slop — `sources/03-quality`

- **frontiercode ★** — mergeability > pass-rate; leaders ~50%. *Incorporated:* thesis. *Justification:* primary.
- **slop-wiki/tech-debt/maintainability/code-quality** — slop cost. *Incorporated:* pitfall. *Justification:* support.
- **eye-track-review/quant-repair/unit-test-llm** — review effort/cost. *Incorporated:* evidence. *Justification:* support.
- **clean-code/review/swebench/tdd** — background. *Incorporated:* some. *Justification:* support.

### Agents in Channel — `sources/03-channel`

- **secure-agent/agent-identity/least-priv/capability-sec** — service accounts, least privilege. *Incorporated:* IMPORTANT alert. *Justification:* primary.
- **multi-agent ★** — sub-agents. *Incorporated:* Ch4. *Justification:* cross-ref.
- **oauth/copilot-bg/async-agent/web4/devin/slack-bot** — production agents. *Incorporated:* support. *Justification:* support.

## Chapter 4 — Engineering Disciplines

### Four Crafts — `sources/04-crafts`

- **intent-ice ★ / 4-skills / ownership** — four crafts; human vs harness ownership. *Incorporated:* table. *Justification:* primary.
- **reward-hack / hitl** — compartment evals; presence. *Incorporated:* discipline. *Justification:* direct.
- **context-eng/spec-kit/build-agents/eval/orchestration/sep-concerns/prompt-eng** — support. *Incorporated:* support. *Justification:* support.

### Context Engineering — `sources/04-context`

- **context-eng ★** — finite attention; compaction/notes/sub-agents/just-in-time. *Incorporated:* rewrite. *Justification:* primary.
- **context-rot / attention** — recall decay; n². *Incorporated:* budget. *Justification:* evidence.
- **compaction/rag/vector-db/prog-disclosure/mcp/long-context/static-anchor** — techniques. *Incorporated:* support. *Justification:* support.
- **working-mem** — analogy. *Incorporated:* none. *Justification:* background.

### Harness — `sources/04-harness`

- **llm-as-code ★ / runtime-decomp ★** — program owns control; rerun failed step. *Incorporated:* section. *Justification:* primary.
- **build-agents/control-plane/agent-sdk/react/reflexion/sandbox/retries/deterministic/copilot-harness** — runtime. *Incorporated:* support. *Justification:* support.
- **tool-use** — background. *Incorporated:* none. *Justification:* reference.

### Loopcraft — `sources/04-loopcraft`

- **loopcraft ★** — loops not prompts; throughput. *Incorporated:* section. *Justification:* primary.
- **observability/trajectory** — observe over test. *Incorporated:* practice. *Justification:* direct.
- **self-refine/reflexion/eval-opt/bitter-lesson/control-theory/feedback/runtime-decomp/autonomy** — loops/scale. *Incorporated:* support. *Justification:* support.
- **karpathy** — bio. *Incorporated:* none. *Justification:* background.

### Meta-Harnesses — `sources/04-meta`

- **multi-agent ★** — orchestrator+sub-agents. *Incorporated:* section. *Justification:* primary.
- **orchestration/orchestrator/model-routing/sakana/capsules/governance** — coordinate/route/govern. *Incorporated:* support. *Justification:* support.
- **mas/a2a/mcp/agent-identity/databricks** — coordination. *Incorporated:* mostly background. *Justification:* support.

### Substrate Stack — `sources/04-substrate`

- **idsd ★** — 5 levels vibe→dark-factory. *Incorporated:* ladder table. *Justification:* primary.
- **agent-memory/empirical-mem** — memory prerequisite. *Incorporated:* direct. *Justification:* direct.
- **maturity-model/tech-readiness/dark-factory/autonomy-levels/context-mem/llm-wiki/vibe/substrate/agentic** — levels. *Incorporated:* support. *Justification:* support.

## Chapter 5 — Governance

### Safety & Red-Teaming — `sources/05-safety`

- **nist-rmf ★** — govern/map/measure/manage. *Incorporated:* table. *Justification:* primary.
- **hai-incidents ★** — 233→362. *Incorporated:* figure. *Justification:* primary.
- **reflection-ctrl ★ / owasp-llm / prompt-injection** — control loops, attack surface. *Incorporated:* auditable + alert. *Justification:* direct.
- **least-priv/capability-sec/mitre-atlas/red-team/adversarial/sandbox/vuln-patch** — defence. *Incorporated:* support. *Justification:* support.

### Liability & Provenance — `sources/05-liability`

- **product-liability/defamation/copyright-ai** — deployer liable. *Incorporated:* first-party. *Justification:* direct.
- **c2pa/provenance/watermark** — origin/marking. *Incorporated:* provenance. *Justification:* direct.
- **eu-act/gdpr/transparency/indemnity/audit-trail** — obligations/contracts. *Incorporated:* support. *Justification:* support.

### Governed Access — `sources/05-access`

- **deloitte ★** — 69% agents, 22% governance; sovereign AI. *Incorporated:* figures. *Justification:* primary.
- **govern-repo ★ / nist-rmf** — govern repo; spine. *Incorporated:* frame. *Justification:* direct.
- **vendor-lock/openrouter/open-weight/multi-tenant/sovereign/export/eu-act/data-sov/resilience** — fallback. *Incorporated:* support. *Justification:* support.

## Chapter 6 — Mastery

### Human Edge — `sources/06-human-edge`

- **tacit-knowledge/expertise** — untrainable know-how. *Incorporated:* moat. *Justification:* core.
- **nber labor-mkt/dilution/hai-jobs** — gains skew novice; experts scarce. *Incorporated:* augment-not-replace. *Justification:* evidence.
- **augmentation/centaur/craftsmanship/skill-atrophy/future-work** — pipeline risk. *Incorporated:* support. *Justification:* support.

### Continuous Refinement — `sources/06-refinement`

- **pilot-prod ★ / mckinsey** — pilots→production. *Incorporated:* thesis. *Justification:* primary.
- **kaizen/cip/continuous-improve/shuhari** — iterate, stages. *Incorporated:* loop. *Justification:* direct.
- **goodhart** — metric gaming. *Incorporated:* measure value. *Justification:* direct.
- **lean/value-stream/metrics/okrs/feedback/retro** — measurement. *Incorporated:* support. *Justification:* support.
