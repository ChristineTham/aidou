# Generative AI at Work — Summary

> [!NOTE]
> **Source:** [brynjolfsson-li-raymond-genai-at-work.pdf](../../sources/ai-futures/brynjolfsson-li-raymond-genai-at-work.pdf) · Erik Brynjolfsson, Danielle Li & Lindsey R. Raymond, 2023/2025 · NBER Working Paper 31161 (April 2023, revised Nov 2023); published in *Quarterly Journal of Economics* 140(2), 889–942 (2025), [doi:10.1093/qje/qjae044](https://doi.org/10.1093/qje/qjae044).
> Study-guide summary of the full NBER working-paper text. See the original for exact wording, tables, and figures.

## Abstract

The first at-scale field study of a generative-AI assistant in a real workplace: 5,179 customer-support agents at a Fortune 500 software firm gaining staggered access to a GPT-based tool that gives real-time chat suggestions. Access raises productivity (issues resolved per hour) by ~14% on average — but the gains are highly uneven, concentrated on novice and low-skill workers, with little or no benefit (and slightly *worse* chat quality) for the most experienced. The mechanism: the AI captures and broadcasts the tacit best practices of top performers to everyone else, compressing the skill distribution.

**Key points**

- **Average productivity gain ~14%** (0.30 more resolutions per hour, +13.8%) with agent and tenure fixed effects; raw/uncontrolled estimates run higher (~22%), and the published QJE version reports ~15%.
- **Skill heterogeneity is the headline:** lowest-skill quintile gains **+34%** (0.29 log points); the highest-skill workers see **no productivity gain** and small *declines* in resolution rate and customer satisfaction.
- **Experience heterogeneity mirrors it:** agents with <1 month tenure gain **+46%** (0.38 log points); agents with >1 year of tenure show no effect. Treated 2-month agents match untreated 6-month+ agents.
- **Reverses the historical pattern:** prior IT/computerisation waves were *skill-biased*, complementing high-skill workers and widening gaps; generative AI here *narrows* the gap.
- **Mechanism — dissemination of tacit knowledge:** AI is trained on top agents' conversations and surfaces their patterns; text analysis shows low-skill agents' language converging toward high-skill agents' (cosine similarity 0.55 → 0.61).
- **Durable learning:** during AI outages, previously-exposed workers still outperform their pre-AI baseline, more so with more exposure and higher adherence — suggesting real human-capital gains, not just reliance.
- **Better experience of work:** customer sentiment +0.18 (≈½ SD), requests to escalate to a manager down ~25%, attrition down ~40% among newest agents.
- **Adherence is partial and selective:** agents follow ~38% of suggestions on average (IQR 23–50%); returns rise with adherence (lowest quintile ~10% gain, highest ~25%); adherence rises over time, fastest among initially-skeptical and senior workers.

**Takeaways**

- Generative AI can act as a **skill-equaliser** in codifiable, tacit-knowledge-heavy work — a documented counter-case to the fear that AI mainly amplifies elite advantage.
- The upside is real but **bounded and context-specific**: a stable product with a large corpus of past resolved chats is what lets the model encode best practice; rapidly-changing domains may see different (or negative) effects.
- Raises unresolved questions: top performers generate the training data but capture little of the gain (and may lose relative pay), and the study cannot speak to aggregate wages, employment, or long-run skill demand.

## Introduction

Generative AI has drawn huge attention but little rigorous economic study; lab results are promising but real-world efficacy was unknown (unfamiliar problems, organisational resistance, hallucination in consequential settings). This paper is, to the authors' knowledge, **the first study of generative AI deployed at scale in an actual workplace**.

The conceptual argument for why AI differs from prior computing:

- **Traditional software codifies** — it needs explicit, ordered instructions, so it automates *routine* tasks well but cannot touch work relying on **tacit knowledge** (Polanyi, 1966; Autor, 2014) — writing emails, analysing data, judgement-heavy work.
- **Machine learning infers instructions from examples** rather than being programmed, so it can perform tasks *no one can fully specify* — including tacit-knowledge tasks previously gained only through lived experience.
- Because ML is **trained on human-worker data of varying quality**, it can implicitly learn what distinguishes high from low performers — and thus expose lower-skill workers to skills they lacked, producing *differential* productivity effects by worker ability.

**Three sets of findings:**

1. **Productivity** rises 14% (resolutions per hour), via shorter handle time, more concurrent chats, and a small rise in resolution share — but the gains are **highly uneven**, +34% for the least-skilled/least-experienced, minimal (even slightly negative on quality) for the most skilled. Treated agents with 2 months' tenure match untreated agents with 6+ months. This **contrasts with skill-biased technical change** in earlier computing waves.
2. **Mechanism:** recommendations are useful (higher adherence → higher gains; adherence rises over time, especially for skeptics); learning is **durable** (gains persist during AI outages, more so with prior exposure); and text analysis shows **communication convergence** — low-skill agents start writing like high-skill agents.
3. **Experience of work:** customer sentiment improves markedly, customers less often ask for a supervisor, and **worker attrition drops substantially**, driven by retention of newer workers.

The authors stress the paper is **not** about aggregate employment or wages: firms might respond by hiring more novices, de-skilling roles, or building AI to replace low-skill workers outright; the data cannot observe wages, labour demand, or hiring composition. They also flag an **incentive problem**: top workers supply the training data that makes the AI valuable but are not compensated for it.

> [!NOTE]
> **Definitions.** *AI* = umbrella for systems exhibiting intelligent behaviour (learning, reasoning, problem-solving). *ML* = branch of AI that learns from data without explicit programming. *LLMs* = neural models trained to predict the next token; tools built on them (ChatGPT) generate new content, hence *generative AI*. *Tacit knowledge* = skills people possess but cannot articulate, acquired through experience (Polanyi, 1966).

**Relation to prior literature.** Much IT research finds technology *complements high-skill workers* (Bartel et al., 2007; Acemoglu & Restrepo, 2020 on robots hurting less-educated workers most). Evidence on AI's productivity effects is mixed and hard to identify at the macro level because adopters differ from non-adopters. Lab studies of generative AI — Peng et al. (2023) on GitHub Copilot (task done twice as fast), Noy & Zhang (2023) on writing, Choi & Schwarcz (2023) on a law exam — consistently find AI **compresses the productivity distribution**, with lower-skill workers benefiting most. This paper is the first to examine **longer-term, real-world** effects including learning, customer-side outcomes, and the experience of work.

## 1 · Generative AI and Large Language Models

### 1.1 Technical primer

LLMs are neural networks for sequential data, trained to predict the next word over a large corpus; the same technique extends to protein sequences, code, audio, or chess moves. Four drivers of recent progress:

- **Scale** — quality depends on compute, parameters, and data (Kaplan et al., 2020). GPT-3: 175B parameters, 300B tokens, ~$5M compute; GPT-4 (estimated): 1.8T parameters, 13T tokens, rumoured ~$65M compute.
- **Architecture** — positional encoding (word order) and self-attention (importance weighting across the whole input) capture long-range meaning (Vaswani et al., 2017).
- **Pre-training** on abundant *unlabelled* data (Reddit, Wikipedia), learning semantic/grammatical relationships without explicit guidance.
- **Fine-tuning** to a setting's priorities, including RLHF-style ranking of outputs by human evaluators (Ouyang et al., 2022) to reduce toxic/incorrect responses.

### 1.2 The economic impacts of generative AI

Historically, computerisation reduced demand for **routine** tasks (data entry, bookkeeping, assembly) and raised demand for complementary high-skill work (programming, analysis), widening wage inequality. Generative AI is different: it needs **no explicit instructions** and can display tacit skills (e.g. writing a "professional and conciliatory" email) it was never programmed to define. This expands machines into **non-routine, judgement-based** tasks.

Crucially, because these models train on human-worker data spanning good and poor performance, they can **implicitly identify what distinguishes top performers** and reproduce those behaviours. Firms could use this to replace low-skill workers, or to *lift* them toward best practice — so effects may differ by worker ability even for the same task.

> [!CAUTION]
> Real-world challenges the authors flag: LLMs can produce **false/misleading output** unpredictably; real problems are broader and less predictable than lab tasks, and workers may not know when the tool is unreliable; efficacy depends on complementary **organisational** investments and process redesign.

## 2 · Our Setting: LLMs for Customer Support

### 2.1 Customer support and generative AI

Customer service is a top AI-adoption sector with high productivity variance, costly turnover (~60% of contact-centre agents leave yearly, at $10k–$20k per agent), and heavy coaching burden (supervisors spend 20+ hours/week coaching). It suits current LLMs: conversations are pattern-matching over recorded, digitised text, and top agents' behaviours (e.g. asking more diagnostic questions up front) can be inferred from training data and encoded as best practice.

### 2.2 Data-firm background

A **Fortune 500 enterprise-software company** serving US small/medium businesses. Chat-based technical support agents work directly and via third parties; **majority based in the Philippines** (89% of the sample outside the US). Chats are **randomly assigned**; sessions average **40 minutes**. Three standard productivity metrics: **average handle time (AHT)**, **resolution rate (RR)**, and **net promoter score (NPS)**. Agents work individually on hourly wages plus performance-relative bonuses; managers give weekly one-on-one coaching.

### 2.3 AI system design

A recent **GPT** version plus ML fine-tuned on customer service, further trained on labelled customer-agent conversations (resolved?, handle time, top-performer status) to find patterns predictive of resolution and speed, and RLHF-style tuned to favour empathy, correct documentation, and professional language. It outputs **real-time response suggestions** and **links to internal documentation**, based on conversation history. It is designed to **augment, not replace** — output is shown only to the agent, who has full discretion; the system stays silent when it lacks sufficient training data for a situation.

## 3 · Deployment, Data, and Empirical Strategy

### 3.1 Deployment

Gradual, **staggered agent-level rollout** after a seven-week randomised pilot of 50 agents; most adoption occurred **Nov 2020–Feb 2021**, largely uniform across in-house and outsourced agents.

### 3.2 Summary statistics

- **3 million chats by 5,179 agents**; 1.2 million post-AI chats by 1,636 agents. (The published QJE version reports 5,172 agents.)
- Groups: *never treated*, *treated-pre*, *treated-post*.
- Primary productivity measure = **resolutions per hour (RPH)**, decomposable into AHT, chats per hour (CPH), and RR. AHT and CPH observed for all agents; RR and NPS (hence RPH) only for a subset, since subcontractors hold quality data.
- Raw distributions: never-treated resolve **1.7** chats/hr, treated-post **2.5** (treated-pre already higher at 2.0, so selection matters); handle time falls from ~40 to ~35 minutes post-treatment.

### 3.3 Empirical strategy

A **difference-in-differences** design: `y_it = δ_t + α_i + β·AI_it + γX_it + ε_it`, with year-month fixed effects, agent fixed effects, and time-varying tenure; standard errors clustered at the agent level. Because two-way fixed-effects can be biased under heterogeneous/time-varying treatment effects, they also use the **Sun & Abraham (2021) interaction-weighted event-study estimator** and confirm robustness across de Chaisemartin–D'Haultfœuille, Borusyak et al., and Callaway–Sant'Anna estimators (which mostly give *larger* effects).

## 4 · Main Results

### 4.1 Productivity metrics

Effect on RPH shrinks as controls are added — evidence that treated agents were positively selected:

| Specification | Effect on resolutions per hour |
|---|---|
| Time + location FE (Col 1) | +0.47 chats, **+22.2%** (base 2.12) |
| + agent FE, + tenure FE (Col 3, preferred) | +0.30 chats, **+13.8%** |

Event studies show an **immediate** jump in the first month, growing slightly in month two, then stable and persistent. Component effects (preferred spec):

- **Average handle time:** −3.8 minutes, a ~9% decline.
- **Chats per hour:** +0.37 (~14% over base 2.6) — larger than the AHT effect, so agents both speed up *and* multitask better.
- **Resolution rate:** +1.3 pp (base 82%), significant only at 10% — quality is not sacrificed for speed.
- **Net promoter score:** no significant change (−0.13 pp on a mean of 79.6%).

### 4.2 Impacts by agent skill and tenure

This is the paper's central and most-cited result.

**By pre-treatment skill** (quintiles from pre-AI call efficiency, resolution rate, and satisfaction):

- **Lowest skill quintile: +0.29 log points ≈ +34%** in resolutions per hour.
- **Highest skill quintile: no productivity gain**, and small but statistically significant **decreases** in resolution rate and customer satisfaction — AI may distract top performers or nudge them toward the faster suggested option instead of their own better response.

**By pre-treatment experience** (tenure at AI introduction):

- **<1 month tenure: +0.38 log points ≈ +46%.**
- **>1 year tenure: no effect.** Clear monotonic gradient.

**Moving down the experience curve (Figure 8):** all agents start at ~2.0 RPH. Never-treated agents reach ~2.5 only after 8–10 months; always-treated agents reach 2.5 after **two months** and exceed 3.0 by month five. Agents who gain access in month five jump onto the always-treated trajectory at that point. Net: **treated agents with ~2 months' tenure perform as well as untreated agents with 6+ months.**

> [!IMPORTANT]
> The distributional result inverts the historical norm. Where earlier IT waves were skill-biased (helping high-skill workers most and widening gaps), this generative-AI tool **compresses the skill distribution** — the least-skilled and least-experienced improve most, the most-skilled barely at all. Verbatim: *"these gains accrue disproportionately to less-experienced and lower-skill workers"* and *"AI assistance does not lead to any productivity increase for the most skilled workers."*

## 5 · Adherence, Learning, and Conversational Change

### 5.1 Adherence to AI recommendations

Agents are selective: average adherence **~38%** (IQR 23–50%), comparable to GitHub Copilot's reported 27–46% acceptance. **Returns rise monotonically with adherence** — lowest-adherence quintile ~10% productivity gain, highest ~25%. Adherence **grows over time** for all groups, fastest for the initially least-compliant (bottom tercile: <20% → ~50% by month five) and for senior workers (30% for >1yr tenure vs 37% for <3mo, converging by month five). Within-agent analysis (residualised by agent FE) confirms the rise is not purely selection/attrition — agents come to value the tool, especially initial skeptics.

### 5.2 Worker learning

Do gains reflect **durable human capital** or mere reliance? Using **AI outages** (technical failures leaving some agents without suggestions; normally 30–40% of chats get no suggestion, spiking to ~100% during a documented 10 Sept 2020 load-test crash):

- During non-outage post-adoption periods, chat duration drops ~10–15% (consistent with main results).
- During outage periods, previously-exposed workers **still perform better than their pre-AI baseline**, and this benefit **grows with cumulative exposure** — an outage after 3 months shows bigger gains than one after 1 month.
- The learning effect is concentrated in **high-adherence** workers; those who deviate show no outage-period improvement.

Interpretation: AI supplements weak existing coaching (managers can only review a fraction of chats and often just flag weak metrics rather than teaching strategy) by giving **specific, actionable, real-time** guidance — and workers retain some of it.

### 5.3 Conversational change

Using sentence embeddings (`all-MiniLM-L6-v2`) and cosine similarity:

- **Within-worker:** after AI deployment, agents' language becomes **less similar to their own pre-AI language** (stable before rollout, drops after) — they write *different* things, not the same things faster. The shift is **larger for low-skill agents**.
- **Across-worker:** without AI, high- vs low-skill similarity is stable at **0.55**. With AI, it rises to **0.61** (against a high-skill within-person ceiling of ~0.67) — a substantial **narrowing of the language gap**, with low-skill agents converging *toward* high-skill agents, consistent with AI disseminating top-performer behaviour.

## 6 · Effects on the Experience of Work

### 6.1 Customer sentiment

Sentiment scored −1 to 1 via **SiEBERT**. Baseline: customers mildly positive (mean 0.14), agents overwhelmingly positive (0.89, since trained to be polite). Post-AI, **customer sentiment improves +0.18 (≈ half a standard deviation)** — immediate and persistent; agent sentiment barely moves (+0.02). Improvement is largest for lower-to-lower-middle skill and tenure agents; smallest for top/most-experienced — consistent with the productivity pattern.

### 6.2 Customer confidence and managerial escalation

Requests to speak to a manager (proxy for lost confidence in the agent) fall **~25%** from a ~6 pp baseline after AI introduction, disproportionately for less-skilled/less-experienced agents.

### 6.3 Attrition

Comparing treated vs untreated agents of the same tenure: attrition falls most for **newer agents (<6 months)** — a ~10 pp drop, a **~40% decrease** off a 25% baseline. Significant reductions across all skill groups with no clear skill gradient.

> [!WARNING]
> The attrition results warrant more caution than the productivity results: agent fixed effects cannot be included (attrition happens once per person), so estimates may overstate the effect if firms grant AI access to agents already more likely to stay.

## 7 · Conclusion

First real-world evidence that a generative-AI tool **raises productivity, improves customer sentiment, and reduces turnover**. The proposed mechanism: the AI **embodies and disseminates the tacit best practices of high-skill workers**, lifting the newer and less-skilled most while barely helping (and sometimes slightly hurting the chat quality of) top performers; text convergence and persistent outage-period gains support both dissemination and durable learning.

**Limitations and open questions the authors raise:**

- No evidence on **long-run skill demand, job design, wages, or customer demand**; if support demand is inelastic, productivity gains could reduce demand and wages for the role.
- **Redefines productivity:** a worker's value now includes the training examples they contribute; top performers supply the data but capture little gain and, under relative-bonus pay, may even *lose* pay — raising the question of how to compensate workers for their data.
- **Generalisation is uncertain:** the setting has a *stable* product and a well-defined problem space. In fast-changing environments, AI recommendations could either synthesise new best practices faster or **impede learning by promoting outdated historical practices**.

> [!NOTE]
> **NBER working paper vs published QJE version.** This summary is built from the readable **NBER Working Paper 31161** text (headline: 5,179 agents, 14% average gain). The peer-reviewed **QJE 140(2), 889–942 (2025)** version reports lightly revised headline figures (≈5,172 agents, ≈15% average gain); the qualitative findings — especially the ~34% low-skill / near-zero high-skill heterogeneity — are unchanged. Cite the QJE 2025 version; note the working-paper numbers where the exact 14% figure is quoted.

## Relation to the book

This is the empirical anchor for §6.5's **counter-case**: the recurring worry through the book is that AI *widens* advantage — amplifying the already-skilled and hollowing out the ladder novices climb. Brynjolfsson, Li & Raymond document the opposite in one large, well-identified field setting: generative AI **narrowed the skill gap**, handing the biggest gains to novices and low performers (~34% / +46%) while leaving experts flat, because the tool works by broadcasting experts' tacit best practices to everyone else. It is the strongest single piece of evidence that "using AI well" can be *levelling* rather than *concentrating* — and it does so honestly, with the boundary conditions the book needs: the effect depends on a stable domain rich in recorded best practice, the durable-learning result is real but adherence-dependent, and the top performers who seed the training data capture little of the value. It pairs naturally as the optimistic bookend against sources arguing generative AI degrades novice learning or entrenches elites.
