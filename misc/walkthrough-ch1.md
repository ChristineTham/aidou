# Chapter 1 — Detailed Source Summaries (maximum detail)

Every source has its own block with full bullet coverage of all major subjects, plus Incorporated / Justification / Decision. ★ = cited inline.

## The Meaning of AI-dō — `sources/01-meaning`

### judo-wikipedia ★

- Founded by Kanō Jigorō in 1882, refining jujutsu into a system safe for full-power randori.
- Name: 柔 (gentle/yielding) + 道 (way) — yielding to overcome force.
- Principles: *seiryoku zen'yō* (maximum efficiency, minimum effort); *jita kyōei* (mutual welfare and benefit).
- Training: randori (free practice) and kata (forms); throws, pins, chokes, joint locks.
- Ranks: kyū → dan with belt colours; rank marks progress, never completion.
- Olympic sport since 1964; international federation; weight classes; rule-bound.
- Pedagogy fuses technique, ethics, and lifelong character formation.
- Incorporated: dō-as-lifelong-path; minimum-effort echoes leverage. Justification: authentic centuries-old model for discipline over hacks. Decision: Enhanced.

### kendo-wikipedia

- "Way of the sword"; from samurai kenjutsu; modernised with shinai (bamboo) and bōgu (armour).
- ki-ken-tai-ichi: spirit, sword, body must unite for a valid strike.
- Mandatory etiquette (rei); bows open/close every match.
- Lifelong cultivation; dan ranks span decades; cultivation outranks scoring.
- Incorporated: dō lineage. Justification: 道 shared across crafts. Decision: Used.

### aikido-wikipedia

- Founder Morihei Ueshiba; "way of harmonising ki"; blend with and redirect force.
- Often non-competitive; aim is to neutralise without injury.
- uchi-deshi live-in apprenticeship; immersion pedagogy.
- ki = unified mental/physical energy; centre and breath.
- Incorporated: augment/redirect framing. Justification: harmony ≈ augment-not-replace. Decision: Used.

### budo-wikipedia

- Umbrella for martial "ways"; -dō (self-cultivation) vs -jutsu (combat technique).
- Moral/spiritual growth inseparable from skill; respect for opponents doctrinal.
- Ranks mark progress, not mastery.
- Incorporated: historic weight for "method endures". Decision: Used.

### dojo-wikipedia

- 道場 = "place of the way" (dō path + jō place): immersive, etiquette-bound practice space; bowing, cleaning, seniority.
- uchi-deshi live-in apprenticeship; embodied knowledge transmitted by repeated daily immersion and observation. Decision: No change (colour).

### shokunin-kaizen-wikipedia

- Kaizen = continuous improvement by everyone, daily, indefinitely; Toyota Production System / lean lineage.
- PDCA cycle; standardise then improve; eliminate waste (muda); small compounding gains beat big leaps.
- Granularity ladder: point (one spot), system (org-level), line (upstream/downstream), plane (value stream across lines), cube (whole org incl. suppliers/customers).
- 5S: seiri (sort), seiton (order), seiso (clean), seiketsu (standardise), shitsuke (discipline); plus quick kaizen and the 7M checklist.
- Bottom-up worker suggestions; respect-for-people pillar.
- Incorporated: discipline-over-hacks; iterative mastery; value-stream framing. Decision: Enhanced.

### ikigai-wikipedia

- 生き甲斐 "reason for being"; intersection of love/skill/need/pay; iki (live) + kai (effect); post-WWII Buddhist-influenced; Okinawan longevity link. Decision: No change (tangential).

### care-ethics-wikipedia

- Feminist normative ethics; Noddings, Tronto, Held, Baier, Ruddick, Slote; relationships/context over abstract rules.
- Tronto's four duties: attentiveness, responsibility, competence, responsiveness; 2013 fifth = solidarity/collective accountability.
- Gilligan care-vs-justice; asks "what is needed?"; interdependence over individualism. Incorporated: 愛 = four duties. Decision: Enhanced.

### intelligence-augmentation-wikipedia

- Ashby (1956): intellectual power amplifiable synthetically; Licklider (1960) man-computer symbiosis; Engelbart (1962) augmenting intellect as a way of life. Tools complement, not replace. Decision: Enhanced.

### human-centered-ai-stanford

- Stanford HAI: augment humanity, oversight, fairness; human-centred first. Decision: Used.

### responsible-ai-google

- Pillars: beneficial impact, responsible development (oversight/safety/privacy), tools for collective benefit; lifecycle governance. Decision: Used (Ch5).

### ai-wikipedia

- Narrow vs general AI; all current = narrow; risks privacy/bias/power/weaponisation; McCarthy 1955, term popular 2022+. Decision: No change (baseline).

## Mental Models — `sources/01-mental-models`

### agent-def-willison ★

- Consensus: agent = LLM runs tools in a loop to a goal; bounded, terminating.
- Conversation = short-term memory; long-term needs tools.
- Accountability stays human; OpenAI conflates three defs; only tools-in-a-loop is grounded. Decision: Enhanced.

### transformer-attention ★

- Self-attention; every token attends to every other; O(n²) cost → context is finite. Decision: Used (Ch4).

### context-engineering-anthropic ★

- Curate tokens, not just words; attention budget. Decision: Used (Ch4).

### hallucination-wikipedia

- Plausible-but-false; root = next-token prediction; types factual/faithfulness/reasoning; mitigation partial. Decision: Enhanced.

### mental-model-wikipedia

- Mental model = internal representation of the external world; "image of the world carried in the head" (Forrester, 1971); theory developed by Johnson-Laird and Byrne.
- Reasoning works by holding a subset of possible models; a conclusion is valid if it holds across all; counter-examples refute.
- Ease depends on age and working-memory capacity; expressed via causal-loop, structure, and stock-flow diagrams.
- Single-loop learning changes decisions but keeps the model; double-loop learning revises the model itself — slower but adaptive. Decision: Used (loop diagram + double-loop framing).

### system-thinking-wikipedia

- Examines complex systems as wholes; a system = interconnected parts producing their own behaviour pattern over time.
- Lineage: Watt governor → 1940s cybernetics → Forrester system dynamics → complexity theory.
- Bounded with inputs/outputs; behaviour emerges from structure, not parts; far-from-equilibrium, edge-of-chaos.
- Frameworks: DSRP, viable-system-model (5 subsystems), double-diamond. Decision: Used (system framing).

### feedback-loop-wikipedia

- Current status shapes future status; centrifugal governor (Watt 1788), cybernetics 1940s.
- Negative feedback corrects deviation (cruise control); positive amplifies (audio howl), risks runaway.
- Real systems mix both at different frequencies; applies to biology, climate (ice-albedo), control (PID), code review. Decision: Used (loop convergence).

### rag-arxiv

- Lewis et al., arXiv:2005.11401 (2020); retrieve relevant documents, condition generation on them; grounds output, cuts hallucination, updates knowledge without retraining. Decision: Used (Ch4 RAG).

### prompt-eng-wikipedia

- Structuring input for generative AI; profession emerged 2022, faded as models improved; techniques: multi-shot, CoT, tree-of-thought, role, RAG, GraphRAG; prompt injection a security risk. Decision: Used (craft splits into four).

### few-shot-arxiv

- Brown et al., arXiv:2005.14165 (GPT-3); models learn tasks from minimal in-context examples, no parameter updates. Decision: Used (in-context).

### chain-of-thought-arxiv

- Wei et al., arXiv:2201.11903; intermediate reasoning steps elicit reasoning; human-legible paths; basis of reasoning-effort knob. Decision: Used.

### llm-wikipedia

- Transformer (2017); compute 5×/yr, cost 3.5×/yr since 2020; byte-pair tokenisation; GPT-2 $50k → PaLM $8M; RLHF, RAG, tool use, CoT; limits = hallucination, bias, sycophancy, injection; perplexity benchmark. Decision: Used (baseline).

## The 2026 Landscape — `sources/01-landscape`

### hai-2026-index ★

- 10 takeaways: (1) capability accelerating, 88% org adoption, SWE-bench Verified 60→~100%, 4/5 students use genAI; (2) US–China gap closed to 2.7%, DeepSeek-R1 briefly matched Feb 2025; (3) US 5,427 data centres (10× next), TSMC fabs nearly all chips; (4) jagged frontier — IMO gold yet analog clock 50.1%, OSWorld 12→66%; (5) incidents 233→362, RAI lags, safety–accuracy tradeoff; (6) US private investment $285.9B vs China $12.4B, inbound researchers −89% since 2017; (7) 53% adoption in 3yr, US ranks 24th at 28.3%, consumer value $172B; (8) 80%+ students use AI, 6% teachers clear policy; (9) sovereignty rising, open-source redistributes; (10) experts 73% vs public 23% positive on jobs. Decision: Enhanced.

### mckinsey ★

- Broad use, ~39% any EBIT; redesign matters. Decision: Enhanced.

### stateofai

- 44% US pay (5% in 2023); $530k avg contract; 95% practitioners; power is the constraint.
- Eighth annual; sections: research, industry, politics, safety, survey, predictions; OpenAI narrow lead, China (DeepSeek/Qwen/Kimi) #2.
- "Reasoning year": RL + verifiable rewards; AI-first startups grow 1.5× faster; 76% pay out of pocket; Stargate multi-GW; AI Act stumbled. Decision: Enhanced.

### deloitte

- State of AI in Enterprise 2026: 3,235 leaders, 24 countries, 7-year series; 69% run autonomous agents, only 22% have advanced governance; 72% weigh country-of-origin; productivity gains common but only ~30% redesign work. Decision: Used (Ch5 governance gap).

### epoch

- Training compute 5×/yr (doubling 5.2mo); inference price halving every 2mo; context windows 30×/yr; gigawatt data centre ~$38B; Meta Hyperion ~3.7M H100-eq by 2028. Decision: Used (scale signal).

### ourworld

- Our World in Data AI hub (Roser/Giattino/Mathieu/Samborska); 56 charts; training compute exponential since 2010; >90% chips from US/Taiwan/China/Korea/Japan; GPT-4 MMLU 86% vs 34.5% non-expert; genAI 53% adoption in 3yr; investment ~30× a decade. Decision: Used.

### oecd

- OECD.AI Observatory; AI Incidents Monitor (AIM); Tools & Metrics catalogue; Hiroshima reporting 2.0; sandboxes; agentic-AI security/prompt-injection focus. Decision: Used (Ch5).

### ai-index-econ / hai-pdf

- Local HAI 2026 PDF backs the inline figures; economy chapter = $285.9B US investment, $172B consumer value. Decision: Used.

### swebench

- Real GitHub issue-resolution benchmark; repo + tests; SWE-bench Verified spine for coding capability claims. Decision: Used (60→100% jump).

### eu-ai-act

- First comprehensive AI law; risk tiers unacceptable/high/limited; GPAI transparency by Aug 2026; sandboxes per state; Code of Practice. Decision: Used (regulated tech).

### foundation-model-wiki

- Broad-data, general-output, adaptable; frontier subset = dangerous capabilities; transformers + MoE; scaling laws; API vs open release. Decision: Used.

### genai-wiki

- New content across modalities; GANs/VAE/transformer/diffusion; risks: copyright, slop, deepfakes, model collapse. Decision: Used (background).

## Capabilities & Limitations — `sources/01-capabilities`

### microgpt ★

- 200-line GPT: dataset (BOS-wrapped) → char tokenizer (27) → Value autograd → 1-layer GPT-2 → Adam; 4,192 params; chat = document completion; hallucination = completion. Decision: Enhanced.

### context-rot-chroma

- Chroma technical report; evaluates 18 LLMs including GPT-4.1, Claude 4, Gemini 2.5, Qwen3.
- Models do not use context uniformly; reliability falls as input length grows even on simple tasks.
- NIAH (needle-in-a-haystack) tests only lexical retrieval; misleadingly says "long context solved".
- NoLiMa raises the bar with latent associations (e.g. Kiasma→Helsinki); 72.4% need external knowledge.
- Task complexity held constant so length is the only variable; degradation is non-uniform, not a clean cliff. Decision: Used (Ch4 limits).

### hallucination-arxiv-survey

- Huang et al., ACM TOIS; "Survey on Hallucination in LLMs: Principles, Taxonomy, Challenges, Open Questions".
- Defines hallucination as plausible-yet-nonfactual; reframes from task-specific to open-ended LLM setting.
- Innovative taxonomy; analyses contributing factors; surveys detection methods and benchmarks; catalogs mitigation methods.
- Examines RAG's limits against hallucination; flags vision-language hallucination and knowledge-boundary understanding as open. Decision: Enhanced (verify-at-boundaries).

### reasoning-o1

- OpenAI o1 System Card; o1 trained with large-scale RL to reason via chain-of-thought.
- Reasoning enables deliberative alignment — reasoning over safety policy in context; SOTA on illicit-advice/stereotype/jailbreak resistance.
- Heightened intelligence raises new risks; report covers safety evals, external red-teaming, Preparedness Framework. Decision: Used (reasoning-effort knob).

### world-models — `2606.27406`, full paper (JetBrains Research; DL4Code @ ICML 2026)

- Bogomolov & Zharov define the *software world model*: the internal model that lets a human or AI reason about how software behaves; existing execution benchmarks (CRUXEval, REval, ThrowBench, BigO(Bench), CodeMind) cover only the control-flow slice on isolated, often synthetic functions.
- They shift the observable axis to **execution resources**, predicting four things beyond return value: test outcome + exception class, peak memory, wall-clock time, and ranked profiler outputs at method and line granularity.
- **Data:** built from SWE-bench Verified (500 issues, 12 Python repos); keep cases <500K chars context; downsample Django-heavy set to 435 examples; inject sys.settrace/sys.monitoring tracer in the SWE-bench Docker container, run designated tests before+after patch; record top-20 profiler rows for time and memory at method+line level.
- **Metrics:** outcome = precision/recall/F1; memory+time = log10 linear calibration (slope, bias, MAE); profiler = Recall@5 and NDCG@5 plus execution rate (fraction of predicted names actually run).
- **Models (12):** Anthropic haiku-4-5 / sonnet-4-6 / opus-4-7; OpenAI gpt-5-mini / 5.2 / 5.4 / 5.5; open-weight gpt-oss-120b, Qwen3.5-397B-A17B, Qwen3-235B, Qwen3-30B, FAIR CWM. Context = executed code slice + windowed test file; output a 10-field JSON.
- **Test-failure F1 (Table 1):** gpt-5.5 0.842 best; gpt-oss-120b 0.604; sonnet-4-6 0.545; opus-4-7 0.486; CWM 0.316; Qwen3-30B 0.049 worst — low recall throughout (bias toward "pass").
- **Peak memory (Table 2):** all biased; best MAE gpt-5.4 0.567; CWM 1.004, gpt-5-mini 1.188 worst; universal slope compression + overestimation.
- **Wall-time (Table 3):** best gpt-5.4 MAE 0.578; CWM under-predicts (247 cases at 0 ms). **Profiler:** best Recall@5 never reaches 0.2 — models rarely find the heaviest method/line; correct ordering gives ×1.5 (method) / ×2 (line) lift.
- **Key finding:** trace-trained CWM falls behind same-size Qwen3-30B → code-generation skill doesn't transfer to execution understanding; frontier models brittle on "how software runs" vs "how source reads". Decision: Used (Ch1/Ch4 limits, world-model gap evidence).
- **Recursive refs to follow:** CodeCrash 2504.14119 (NL-semantics fragility), CWM 2510.02387, SWE-bench 2024 ICLR, CRUXEval, ThrowBench 2503.04241.

### swebench-paper

- Jimenez et al., ICLR 2024; 2,294 real GitHub issues + gold patches across 12 repos; verified subset = 500; the field's repo-fix yardstick. Decision: Used (capability accel).

### scaling-laws

- Power-law: loss falls predictably with compute/data/params; predicts capability from scale; underpins frontier race. Decision: Background.

### multimodal-wiki

- Models spanning text/image/audio/video; jagged competence across modalities; clock-reading weakness an example. Decision: Background.

### limits-llm

- Known ceilings: arithmetic, counting, recall decay, planning; brittleness named, motivates verify-at-boundaries. Decision: Used.

### capabilities-emergent

- Abilities absent at small scale appearing at large; contested as metric artefact; jagged frontier. Decision: Background.

### clock-bench

- File is a vision-language eval (2305.18786), not the analog-clock benchmark; clock stat cited from HAI. Decision: No change.

## Revised Analysis — Changes to Chapter 1 & Justification

Each book section below lists what the sources supported, what was written into [01-foundations.md](../book/01-foundations.md), and why.

### The Meaning of AI-dō

- **Change:** dō framed as lifelong path; 愛 made concrete as Tronto's four care duties (attentiveness, responsibility, competence, responsiveness); augmentation lineage (Ashby/Licklider/Engelbart).
- **Source basis:** judo/kendo/aikido/budo (dō = practice never finished), care-ethics (duties), IA (complement not replace).
- **Justification:** authentic centuries-old discipline anchors "methodology over hacks"; care-ethics turns "love" from sentiment into accountability; IA grounds augment-not-replace. Tools commoditise, methods endure.

### Mental Models

- **Change:** model reframed oracle→loop; agent defined as LLM+tools+loop; accountability stays human.
- **Source basis:** Willison agent def; transformer-attention (finite context); feedback-loop.
- **Justification:** loop framing carries through whole book; Willison is the grounded consensus; conflating fluency with truth is the named failure mode.

### The 2026 Landscape

- **Change:** model-no-longer-the-product thesis; signals table (88% adoption, SWE-bench 60→100%, 5→44% pay, 2.7% US–China gap); fallback-model tip.
- **Source basis:** HAI 2026, McKinsey, State of AI 2025.
- **Justification:** compete on harness/workflow/memory, not the model; geopolitical gating justifies multi-model fallback.

### Capabilities & Limitations (most enhanced)

- **Change:** added two-axis hallucination taxonomy + knowledge boundary; 12-model execution result (F1 0.842, recall@5 <0.2); context-rot decay.
- **Source basis:** Huang ACM TOIS (full paper), Bogomolov & Zharov 2606.27406 (full paper, tables), Chroma, microgpt.
- **Justification:** brittleness must be evidenced, not asserted — full-paper data shows models reason about how source *reads* not how it *runs*; "verify at boundaries" is now backed by measured failure rates.

### Net

- Sections Enhanced: Meaning, Capabilities (substantial); Landscape, Mental Models (moderate). All claims trace to archived full-text dossiers in `research/papers/`.
