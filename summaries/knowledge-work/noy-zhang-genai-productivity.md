# Experimental Evidence on the Productivity Effects of Generative Artificial Intelligence — Summary

> [!NOTE]
> **Source:** [noy-zhang-genai-productivity.pdf](../../sources/knowledge-work/noy-zhang-genai-productivity.pdf) · Shakked Noy & Whitney Zhang (MIT), 2 March 2023 · **This local PDF is the working paper** (not peer-reviewed; 444 participants; headline effects reported as time −0.8 SD, quality +0.4 SD).
> **Cite the peer-reviewed version:** Noy, S., & Zhang, W. (2023). Experimental evidence on the productivity effects of generative artificial intelligence. *Science, 381*(6654), 187–192. https://doi.org/10.1126/science.adh2586 (453 participants; time **−40%**, quality **+18%** ≈ 0.45 SD).
> Study-guide summary of the full document. See the original for exact wording and figures.

> [!CAUTION]
> **Two figure sets — do not mix them.** The working paper abstract rounds the effects to "time −0.8 SDs, quality +0.4 SDs" (N=444). The paper's own *body* already reports the sharper numbers the Science version publishes: **time −10 min (−37%)** off a 27-min control mean, and **grades +0.45 SDs**. When citing in the book, use the **Science** figures — **453 participants, time −40%, quality +18% (≈0.45 SD)** — with the DOI above. The other numbers below (job satisfaction, inequality, task-structure shares, WTP, follow-up rates) come only from this working paper.

## Abstract

A preregistered online randomised controlled trial testing whether ChatGPT raises productivity on realistic mid-level professional **writing** tasks. Half of 444 (Science: 453) college-educated professionals were given ChatGPT for the second of two incentivised tasks; the tool cut time and raised graded quality, compressed inequality, and mostly **substituted for effort** rather than complementing skill.

**Key points**

- **Large productivity gains.** Treatment cut task time by ~10 minutes (**−37%** off a 27-min control mean) and raised average evaluator grades by **0.45 SDs**. (Working-paper abstract rounds these to −0.8 SD time / +0.4 SD quality; **Science publishes −40% time / +18% quality**.)
- **Inequality compresses.** ChatGPT helps low-ability workers most. The first-task→second-task grade correlation falls from **0.49 (control) to 0.25 (treatment)** — initial inequality roughly half-erased.
- **Effort substitution, not complementarity.** **68%** of treated participants submitted ChatGPT's initial output with no editing; they were active only ~3 min after pasting AI text; edited essays scored no higher than raw ChatGPT output. No evidence human editing adds value.
- **Tasks restructure.** Time on **rough-drafting falls by more than half**; time on **editing more than doubles**; brainstorming steady (~25%). Work shifts toward idea-generation and editing.
- **No skill-substitution heterogeneity.** Poor relative writers gain no more than good ones; willingness-to-pay is flat at ~0.5% of monthly salary across writing-skill terciles.
- **Subjective effects positive.** Job satisfaction +0.40 SD; self-efficacy +0.20 SD (imprecise). Both **worry** (+0.26 SD) and **excitement** (+0.39 SD) about automation rise; net optimism +0.20 SD.
- **Sticks in real jobs.** Two weeks later, **33%** of former treated vs **18%** of control had used ChatGPT at work in the past week.

**Takeaways**

- This is among the first causal (RCT) evidence that generative AI substantially raises white-collar knowledge-work productivity — the go-to citation for the "writing-task productivity" claim.
- The *mechanism* matters: because the tool substitutes for effort rather than complementing skill, gains flow to a compressed distribution and may reduce labour demand — an ambiguous, potentially adverse distributional signal, not an unqualified win.
- Generalise with care: tasks were short, self-contained, and light on context-specific knowledge — the very limitation non-adopters cite in real jobs — which likely inflates the estimated benefit.

## Introduction

Generative AI (ChatGPT, DALL-E) is **qualitatively unlike prior automation**. Earlier waves automated *routine*, codifiable tasks (Autor & Dorn 2013; Autor 2015); creative, hard-to-codify tasks like writing and image generation had largely escaped automation — a pattern deep learning may now change.

The paper frames the classic automation dichotomy:

| If AI mostly… | Then… |
|---|---|
| **Displaces** workers | Unemployment can rise; aggregate productivity gains may be small; income redistributes from labour to capital (Acemoglu & Restrepo 2018/2020). |
| **Complements** workers | Productivity, wages and employment can rise while prices fall — benefiting workers, capital owners, and consumers (Kleinberg et al. 2018; Hoffman et al. 2018; Agrawal et al. 2019). |

A generative writing tool could either **replace** certain writers (grant writers, marketers) or **raise their productivity** by automating routine subcomponents (e.g. turning ideas into a rough draft), potentially expanding demand. Inequality could fall (if low-ability workers gain more) or rise (if high-ability workers exploit the tool better).

**Research questions.** How does generative AI affect productivity on existing tasks? Does it work by *substituting* for effort or *complementing* skill? Does it differentially affect low- vs high-ability workers or different skill profiles? Does it affect enjoyment of work?

> [!NOTE]
> **Design in brief.** 444 experienced, college-educated professionals (marketers, grant writers, consultants, data analysts, HR professionals, managers) each do **two** occupation-specific, incentivised 20–30 min writing tasks (press releases, short reports, analysis plans, delicate emails). Most participants report doing similar tasks before and rate them realistic. High-powered bonus incentives reward quality.
> - **Treatment (random 50%):** sign up for ChatGPT between tasks, are shown how to use it, and may use it on task 2. **Control:** sign up for the LaTeX editor Overleaf instead.
> - Combines **within-person** (task 1 vs task 2) and **between-person** (treatment vs control) variation; task-1 performance is the baseline-ability measure for inequality analysis.
> - **Quality** graded by three blinded, incentivised professional evaluators per output (overall + writing quality + content quality + originality; average within-essay cross-evaluator correlation 0.44).
> - A per-minute **snapshot** of each participant's output gives an objective "time active" measure and detects ChatGPT use in the control group.

**Robustness.** Attrition: 5% control, 10% treatment. Across 13 pre-treatment characteristics, treatment/control differ significantly on only **two** (employment status; being an HR professional). The within-person design (controlling for task-1 performance), Lee (2009) bounds, and controls for employment/occupation all confirm results are robust to selective attrition. Preregistered at the AEA RCT Registry (AEARCTR-0010882).

## Results

### Take-up of ChatGPT

- **92%** of treated participants successfully signed up; **81%** chose to use it on task 2; self-assessed usefulness **4.4 / 5**.
- Pre-treatment: ~**70%** had heard of ChatGPT, ~**30%** had used it.
- Only **10–20%** of the control group used ChatGPT on the tasks → at least a **60-percentage-point** experimentally-induced usage gap. Because some controls used it, estimates are **lower bounds** on the true effect.

### Productivity

Productivity measured as **earnings per minute**. Figure 1:

| Outcome (task 2, treatment vs control) | Effect |
|---|---|
| **Time taken** | Control mean **27 min** → treatment mean **17 min**: **−10 min (−37%)**, −0.83 SD (95% CI [−0.63, −1.03]), p = 0.000 |
| **Average grade** | Control mean **3.79** → treatment mean **4.54**: **+0.45 SD** (95% CI [0.27, 0.63]), p = 0.000 |

- Gains span the **whole distribution**: the entire time distribution shifts left (faster) and the entire grade distribution shifts right (higher quality) — not confined to pockets (Fig 1 panels c–d).
- Similar increases across the sub-grades (writing quality, content quality, originality).
- Results near-identical across the two main incentive schemes (80% of respondents): a **linear** scheme ($1 per grade point, 1–7 scale) and a **convex** scheme (+$3 for a grade of 6 or 7).

**Two supplementary arms:**

- **Fixed-effort arm (20% of participants):** both groups required to spend exactly 15 min per task, holding effort constant → any grade difference is a pure effect on *productive capacity*. Treatment raised grades by a similar **0.39 SD** (p = 0.13; imprecise, slight pre-treatment imbalance).
- **Edit-your-old-work arm (30% of treatment):** after task 2, shown their task-1 output and allowed to edit/replace it with ChatGPT. **23%** replaced their response with ChatGPT's output; **25%** used ChatGPT to edit it — participants see ChatGPT as improving quality, not just saving time.

### Productivity Inequality

- **Control:** persistent inequality — task-1 and task-2 grades correlate **0.49** (Fig 2a).
- **Treatment:** correlation falls to **0.25** (p on difference in slopes = 0.004) — **initial inequality roughly half-erased**.
- Driven by **lower-scoring participants benefiting more**: the treatment–control gap is largest at the low-grade (left) end.
- Fig 2b: task-2 time falls across the whole task-1 grade distribution (control slope 0.802 → treatment slope −0.198).

### Human–Machine Complementarity

Two mechanisms could raise productivity:

- **Substitution for effort** — ChatGPT produces satisfactory output that workers submit directly, cutting time.
- **Complementarity** — human + ChatGPT together exceed the sum of parts (e.g. AI drafts, human edits/improves).

Evidence for complementarity would be (a) treated workers spending significant time editing/re-prompting for higher grades, or (b) treated essays scoring above raw ChatGPT output. **Neither is observed:**

- **68%** of treated participants report submitting ChatGPT's initial output **without editing**.
- On average, treated participants stay active only **~3 minutes** after pasting in a large block of (ChatGPT) text.
- **No correlation** between post-paste active time and final grade.
- Treated essays receive **no higher** grades than raw ChatGPT output shown to evaluators — even under the convex incentive that pays extra for top grades.

> [!IMPORTANT]
> The paper concludes ChatGPT raises productivity **primarily by substituting for worker effort**, not by complementing skill. This is the finding with the sharpest labour-market implication: substitution can *reduce* worker demand and shift returns from labour to capital.

### Task Structure

Fig 3 Panel A — self-reported time allocation across three components:

| Component | Pre-treatment (control) | Post-treatment (treatment) |
|---|---|---|
| Brainstorming | ~25% | ~25% (steady) |
| Rough-drafting | ~50% | **falls by more than half** |
| Editing | ~25% | **more than doubles** |

ChatGPT **restructures the task toward idea-generation and editing and away from rough-drafting**.

### Skill Demand

Hypothesis: ChatGPT especially helps those with **poor writing skills relative to their other skills**, which would expand occupational choices and raise earnings of strong idea-generators who struggle to write.

Two skill measures × two benefit measures:

- **Skill:** (1) self-ranking (1–3) of communication vs problem-solving vs creativity; (2) gap between task-1 *overall* score and *writing* score.
- **Benefit:** (1) willingness-to-pay for monthly ChatGPT access; (2) grade gain from task 1 → task 2.

**Finding: no clear heterogeneity.** WTP is flat across writing-skill terciles at ~**0.5% of monthly salary**; grade gains are roughly flat too — comparatively poor writers do **not** gain unusually much (Fig 3 Panel B). (Skill categories: "Good" writers ≈30%, "Medium" ≈50%, "Bad" ≈20%, by whether writing score exceeds/equals/trails overall score.)

### Job Satisfaction and Self-Efficacy

Measured after each task on 1–10 Likert scales (enjoyment; felt skill/effectiveness), normalised to SDs (Fig 4a–b):

| Outcome | Effect | p |
|---|---|---|
| **Job satisfaction** | **+0.40 SD** | 0.000 |
| **Self-efficacy** | **+0.20 SD** (mild, imprecise) | 0.060 |

Self-efficacy rises despite ChatGPT being used mostly to substitute for effort. Open-text feedback: many enjoy discovering and working with the tool.

### Beliefs About Automation

Most participants meet ChatGPT for the first time (30% never heard of it, 70% never used it) — effectively a crash course. Three beliefs elicited on 1–10 scales (Fig 4c):

| Belief | Effect | p |
|---|---|---|
| **Worry** about being replaced by AI | **+0.26 SD** | 0.006 |
| **Excitement** about AI enhancing productivity | **+0.39 SD** | 0.000 |
| **Net optimism** about future AI | **+0.20 SD** | 0.037 |

Exposure **raises both worry and excitement** simultaneously.

### Two-Week Follow-up Survey

Resurvey two weeks after the main experiment (still in progress at writing): **82% response** among 423 invited, no differential response by treatment.

- **33%** of former treated vs **18%** of control used ChatGPT at work in the past week.
- Among those who had **not** used ChatGPT before the experiment: **26% treated vs 9% control** now use it at work (p = 0.048).
- Real-job usefulness score **3.65 / 5** — lower than the in-experiment 4.4, likely because real tasks are longer and more complex.
- **Reported uses:** recommendation letters, customer-service responses, brainstorming, search queries, rough-drafting emails, etc.
- **Non-adopters' reason:** ChatGPT lacks **context-specific knowledge** central to their writing ("tailored to [their] customers", "specific to [their] company products").
- **No** treatment-control difference in *overall job satisfaction* at follow-up (usage is recent; effects may need longer).

> [!WARNING]
> The context-specific-knowledge limitation is inherent to the experiment: tasks are small and self-contained, so they under-represent the tacit, firm-specific knowledge real jobs demand — likely **inflating** the estimated benefit. That real workers still adopt it, and that treatment adopts more than control, suggests real-world diffusion is still very early.

## Discussion

Core conclusion: college-educated professionals doing mid-level writing tasks see **substantial productivity gains** from ChatGPT. Low-ability workers gain quality while cutting time; high-ability workers hold quality while getting much faster; the productivity distribution **compresses** (less inequality). The tool is already used in real jobs.

Because gains come mainly from **effort substitution** rather than skill complementarity, the tool may **reduce demand for workers**, with adverse distributional effects (capital gains at labour's expense).

**Limitations enumerated:**

1. **Short, self-contained tasks** lacking context-specific knowledge → may inflate usefulness estimates. Satisfaction/self-efficacy effects reflect enjoyment of a small task, not a whole job (no real-job satisfaction difference at two weeks).
2. **Experiments capture only direct, immediate effects** on selected occupations — many indirect / general-equilibrium effects will follow as labour markets and production adapt; effects will vary by occupation, task, and skill level.

Closing: only time and future research will show the full labour-market impact, but the evidence indicates generative AI will — and has already begun to — noticeably affect workers.

## Key references cited

- Acemoglu & Restrepo (2018, *AER*; 2020, *JPE*) — displacement vs the man/machine race.
- Autor (2015, *JEP*); Autor & Dorn (2013, *AER*) — automation of routine tasks / labour-market polarisation.
- Agrawal, Gans & Goldfarb (2019, *JEP*) — ambiguous labour impact of automating prediction.
- Kanazawa et al. (2022, NBER) — AI, skill, and productivity among taxi drivers.
- Hoffman, Kahn & Li (2018, *QJE*); Kleinberg et al. (2018, *QJE*) — machine prediction in hiring/decisions.
- Lee (2009, *RES*) — sharp bounds under sample selection (used for attrition robustness).
- Schwabe & Castellacci (2020, *PLoS ONE*) — automation, skills, and job satisfaction.

## Table 1 — Descriptive statistics & balance (selected)

Sample skews toward **managers** (~41–42%); other occupations 6–17% each. Groups are well balanced; only employment status and HR-professional share differ significantly.

| Characteristic | Control (mean) | Treatment (mean) | Difference |
|---|---|---|---|
| Annual salary ($) | 71,808 | 76,267 | 4,458 |
| Years tenure in occupation | 10.63 | 10.07 | −0.564 |
| Employed | 0.90 | 0.96 | 0.052** |
| College degree | 1.00 | 1.00 | −0.000 |
| HR professional (share) | 0.06 | 0.11 | 0.046* |
| Manager (share) | 0.42 | 0.41 | −0.014 |
| Time spent, task 1 (min) | 26.22 | 26.59 | 0.374 |
| Grade, task 1 (1–7) | 3.72 | 3.89 | 0.172 |
| Job satisfaction, task 1 (1–10) | 6.32 | 6.34 | 0.019 |
| Self-efficacy, task 1 (1–10) | 6.89 | 6.91 | 0.020 |

Significance: * 10%, ** 5%, *** 1%.
