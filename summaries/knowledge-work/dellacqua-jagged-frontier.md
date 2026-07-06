# Navigating the Jagged Technological Frontier — Summary

> [!NOTE]
> **Source:** [dellacqua-jagged-frontier.pdf](../../sources/knowledge-work/dellacqua-jagged-frontier.pdf) · Dell'Acqua, McFowland III, Mollick, Lifshitz-Assaf, Kellogg, Rajendran, Krayer, Candelon & Lakhani, 2023 · Harvard Business School Working Paper No. 24-013 (SSRN [4573321](https://ssrn.com/abstract=4573321); dated 22 Sept 2023). Now also published in *Organization Science* (2026). [HBS listing](https://www.hbs.edu/faculty/Pages/item.aspx?num=64700).
> Study-guide summary of the full 58-page working paper. See the original for exact wording, regression tables, and figures.

## Abstract

A pre-registered randomised field experiment run with Boston Consulting Group (BCG) on **758 consultants** (about 7% of BCG's global individual-contributor cohort), testing how access to **GPT-4** changes the productivity and quality of realistic, complex knowledge work. The central idea is a **"jagged technological frontier"**: AI does some tasks easily and others — seemingly of similar difficulty — poorly, and the boundary is uneven and hard to see.

**Key points**

- Three arms after a no-AI baseline: **control (no AI)**, **GPT Only** (GPT-4 access), and **GPT + Overview** (GPT-4 plus a prompt-engineering overview with instructional videos/documents).
- **Inside the frontier** (a creative product-innovation task, 18 subtasks): AI users completed **12.2% more tasks**, worked **25.1% faster**, and produced **>40% higher quality** than the control. (Headline abstract figures; regression means are somewhat higher — see body.)
- **Skill levelling:** below-average performers gained **43%**, above-average performers gained **17%** — AI both raised and compressed the skill distribution.
- **Outside the frontier** (a business-problem-solving task deliberately designed so GPT-4 would err): AI users were **19 percentage points less likely** to reach the correct answer (control 84.5% correct vs. AI arms 60–70%).
- Two successful human-AI working styles emerged: **Centaurs** (divide-and-delegate between human and AI) and **Cyborgs** (tightly interleave with AI at the sub-task level).

**Takeaways**

- For tasks squarely inside AI's frontier, GPT-4 delivers large, robust gains for even elite professionals — and helps weaker performers most.
- The same tool degrades performance when applied to tasks outside the frontier, because users tend to adopt plausible-but-wrong AI output uncritically; human judgement and validation remain essential.
- The adopt-or-not framing is the wrong question: organisations should decide task-by-task within a workflow, and cultivate the navigation skills (Centaur/Cyborg practices) that separate effective AI use from harmful over-reliance.

## 1 Introduction

The paper studies human–AI integration in knowledge-intensive work via randomised controlled field experiments with highly skilled professionals. Its core claim: AI capability covers an expanding but **uneven** set of work — a "jagged technological frontier."

- **Inside** the frontier, AI can complement or displace human work; **outside** it, AI output is "inaccurate, less useful, and degrades human performance."
- Because the frontier is rapidly evolving and poorly understood, professionals struggle to locate its boundary. Those who navigate it skilfully gain large benefits; those who misapply AI to out-of-frontier work lose performance.
- Earlier AI mostly automated lower-skilled/routine work, leaving hard-to-codify non-routine tasks seemingly protected (Autor et al. 2003; Acemoglu & Restrepo 2019). ChatGPT (Nov 2022) changed this — LLMs proved unexpectedly capable at creative, analytical, and writing tasks and scored highly on professional exams, a new category of automation whose reach overlaps the most creative, educated, and highly paid workers (Eloundou et al. 2023).

Three features of LLMs make their impact faster and broader than prior AI:

| Feature | What it means |
| --- | --- |
| **Surprising, growing capabilities** | General models exhibit specialist knowledge and abilities they weren't explicitly built for; these grow with model size/quality. |
| **Direct worker uplift, no infrastructure** | LLMs raise worker performance directly, without major organisational or technical investment (writing, programming, ideation). |
| **Opacity / unclear failure points** | They produce plausible-but-wrong output (hallucinations/confabulations), err on maths and citations, and their best use is learned by trial-and-error and community sharing, not vendor guidance. |

> [!IMPORTANT]
> Together these create the "jagged frontier": tasks of *apparently similar difficulty* can fall on opposite sides — idea generation (easy for AI) vs. basic maths (hard for some LLMs). A single knowledge workflow can straddle both sides. Understanding *where* a task sits, and how humans interact with AI accordingly, is the paper's focus.

## 2 Methods

Two pre-registered randomised experiments (OSF pre-registration; IRB23-0392) assessed the causal impact of **GPT-4** (the most capable model at the time, Spring 2023) on high-human-capital professionals. BCG individual-contributor consultants worldwide were offered ~5 hours to participate. Of 852 survey respondents, **758 (≈89%) completed the experiment** — about 7% of BCG's global IC consultant cohort.

**Three phases:**

1. **Enrolment survey** — demographics (office, tenure, gender, native language, education), role, and psychological assessments: Big 5 personality, innovativeness, self-perceived creativity, paradox mindset, plus reading habits (incl. familiarity with AI in fiction). Used for stratified random assignment and as regression controls.
2. **Main experimental phase** — pre-task survey → tasks → post-task survey.
3. **Interview** — perspectives on AI in their profession.

**Two experiments, no overlap between subjects:**

- **385 consultants** — creative product-innovation/development ("inside the frontier").
- **373 consultants** — quantitative business problem-solving with a persuasive-writing component ("outside the frontier").

Tasks were co-designed with BCG to mirror real IC work; a senior executive called them "very much in line with" the subjects' daily activities. Similar tasks are used to screen elite job applicants (including PhDs).

**Structure of each experiment:** subjects first did an unaided **assessment task** (baseline / within-subject skill measure — a predictor of experimental-task performance), then were randomised into three conditions:

| Condition | Description |
| --- | --- |
| **Control** | No AI support. |
| **GPT Only** | Access to a GPT-4-based AI tool (company platform on the OpenAI API, ChatGPT-like). |
| **GPT + Overview** | Same tool **plus** a prompt-engineering overview: instructional videos and documents on effective usage. |

- **Incentives:** diligent participation earned an "office contribution" recognition tied to annual bonuses; top 20% got extra recognition; top 5% a small gift (shared with career-development committees).
- **Tooling:** the platform used GPT-4 as of end-April 2023, default system prompts and temperature, and logged all prompts/responses.
- **Timing:** inside-frontier — assessment 30 min, main task 90 min (subjects had to stay the full time, so timing analysis is limited); outside-frontier — 60 min each, could finish early.
- The inside-frontier task was chosen to sit **within** GPT-4's frontier; the outside-frontier task was designed so **GPT-4 would make an error**, placing it just outside.

## 3 Results

### 3.1 Quality and Productivity Booster — Inside the Frontier

**Task:** creative product innovation. Assessment = brainstorm a new beverage; main task = conceptualise a footwear idea for a niche market and work end-to-end (prototype → segmentation → market entry), across **18 subtasks** spanning four types: **creativity**, **analytical thinking**, **writing proficiency**, and **persuasiveness**. A footwear-industry executive verified the task covered the real ideation-to-launch process.

**Grading:** each answered question scored 1–10 by **two human graders** (BCG staff or MBA students), averaged into a composite **Quality** score (18 dependent variables → one composite). GPT-4 also scored responses independently ("Quality (GPT)").

**Quality (Table 1, control mean 4.099 on human grades):**

| Treatment | Human-grade effect (Col 1) | % increase | GPT-grade effect (Col 4) | % increase |
| --- | --- | --- | --- | --- |
| **GPT + Overview** | +1.746 | **42.5%** | +1.349 | 18.6% |
| **GPT Only** | +1.556 | **38%** | +1.216 | 16.8% |

- All effects significant at p < 0.01; results robust across specifications (assessment-task controls, demographic controls). Merging AI treatments across all pre-registered quality variables gave **108 regressions, all significant**.
- Mean effect of AI vs. control: **+1.69 (46.6%)** on human evaluations, **+1.36 (20.2%)** on GPT evaluations (Figures 3 & 4, 54 regressions each).
- **GPT + Overview consistently beat GPT Only** on quality (F-test p ≈ 0.03–0.05). Caveat: the overview raised "retainment" (copy-pasting GPT output), and retainment correlated with better performance.

> [!NOTE]
> GPT-graded percentage gains look smaller partly because GPT-4 is a **more lenient grader** and scores the control baseline higher (control mean 7.207 on GPT grades vs. 4.099 on human grades).

**Task completion (Table 2, control mean 0.824):** both treatments significant (p < 0.01), averaging a **12.2% increase** in completion. Control completed ~82% of tasks; GPT + Overview ~93%; GPT Only ~91%.

**Timing (Table 3, control mean 5023 s):** measured on time to reach the final (17-questions-done) point:

- **GPT + Overview:** −1129 s (18.8 min, **22.5% faster**).
- **GPT Only:** −1388 s (23.13 min, **27.63% faster**).

**Skill levelling (Figure 5):** splitting AI-using subjects by assessment-task skill:

| Group | Performance gain from AI |
| --- | --- |
| **Bottom-half skill** | **+43%** |
| **Top-half skill** | **+17%** |

Both gained significantly, but the bottom half gained far more — AI **levels performance differences across ability** while raising overall quality. (The authors stress "lower-skill" is relative; all subjects are extremely high-skill in general terms.)

**Idea diversity (Figure 6, Appendix D):** using Google's Universal Sentence Encoder (512-dim embeddings), AI-using subjects produced **higher-quality but less variable** ideas — greater semantic similarity across subjects, i.e. more **homogenised** output. A simulated "GPT No Human" condition (100 independent ChatGPT sessions) showed the *highest* similarity, indicating AI's own idea variation is narrower than humans'.

### 3.2 Quality Disruptor — Outside the Frontier

**Task:** business problem-solving on fictional apparel company "Kleding." Assessment = pick the best **distribution channel** (owned stores / franchise / online) for profit growth; main task = pick the best **brand** (Man / Woman / Kids) for revenue growth and suggest improvements. Each drew on an Excel data sheet **plus** insider interview notes. Crucially, the spreadsheet alone looked comprehensive, but the interviews held decisive details — combining both led to a **different (correct) conclusion than AI would give** when fed the instructions, data, and interviews directly. Designed so consultants would excel but AI would struggle.

**Primary metric: correctness** (binary). **Figure 7 / Table 4** (control mean 0.844):

| Group | Correct % | Effect on correctness |
| --- | --- | --- |
| **Control** | **84.5%** | — |
| **GPT Only** | ~70% | **−13 pp** (−0.139) |
| **GPT + Overview** | ~60% | **−24 pp** (−0.245) |

- Combined, AI users were **~19 percentage points less likely** to be correct than the control. Both treatments significant at p < 0.01.
- The overview arm did **worse** (−24 vs. −13 pp) — extra prompting familiarity increased reliance and error here; difference significant at the 10% level.

> [!WARNING]
> Outside the frontier, AI *degrades* performance: subjects tended to **blindly adopt plausible AI output** ("unengaged interaction with AI," Lebovitz et al. 2022) rather than interrogate it. More prompt training made this worse, not better, on the out-of-frontier task.

**Timing (Table 5, control mean 2260 s):** AI still saved time — GPT + Overview −689 s (~11 min, ~30% faster), GPT Only −407 s (~6 min, ~18% faster).

**Recommendation quality (Table 6, control mean 5.856, 1–10 scale):** independent of correctness, AI *raised the quality* of the recommendation write-up — GPT + Overview +1.475 (**25.1%**), GPT Only +1.046 (**17.9%**). This held for **both** subjects who answered correctly and incorrectly (Figure 8): AI polished the presentation even when the underlying strategic answer was wrong.

> [!CAUTION]
> A dangerous combination: outside the frontier, AI makes answers **more polished yet more often wrong** — a well-written, persuasive, incorrect recommendation.

### 3.3 Navigating the Frontier

Not all users navigated the jagged frontier equally well. Analysing the strategies of those who *did* succeed on the out-of-frontier task (244 professionals analysed at sub-task level, per Appendix E), the authors identify two models:

| Model | Metaphor | Strategy |
| --- | --- | --- |
| **Centaur** | Half-human/half-horse (Kasparov's chess term) | **Strategic division of labour** — attuned to the frontier's jaggedness, they split a task into sub-tasks and route each to human or AI by comparative strength, but still use AI to refine even human-led sub-tasks. |
| **Cyborg** | Sci-fi human-machine hybrid (Clynes & Kline 1960) | **Intricate integration** — no clean division of labour; they interleave with AI at the sub-task level (e.g. starting a sentence for AI to finish), so it can be hard to tell which output is human vs. AI. |

## 4 Discussion

- AI is both **booster** (efficiency/quality inside the frontier) and **disruptor** (degraded performance outside it).
- **Inside the frontier, across 18 realistic tasks:** speed up **>25%**, human-rated quality up **>40%**, completion up **>12%**; benefits weighted toward bottom-half performers — AI both **levels ability differences** and raises quality.
- Performance **decreased only** on tasks identified as outside the frontier; this underscores the need to **validate and interrogate AI** and keep applying expert judgement. Those who did worst blindly adopted AI output; Appendix C's "retainment" score measures how common this was.
- **Organisational implications:** move past the binary adopt/don't-adopt debate toward evaluating **each task in a workflow** for the right human-AI configuration; rethink collaboration, roles, and training.
- **Training deficit risk:** if firms stop delegating inside-frontier work to junior staff, long-term skill development suffers (Beane 2019). Navigating the frontier requires expertise built via education, on-the-job training, and upskilling.
- **Idea homogenisation:** AI raising individual quality but reducing collective idea diversity poses firm-level risk; firms may need multiple/varied models or protected human-only work. Optimal strategy depends on whether the firm prioritises consistent average output or maximum exploration.
- **General-equilibrium note:** when everyone uses AI, distinctive non-AI output may stand out.
- **Interpretation:** results support optimism about AI for high-end tasks (idea generation, writing, persuasion, strategic analysis, creative innovation) — it was hard to design a task where high-skill humans consistently beat AI. But the frontier's boundary is not obvious even to experienced professionals and keeps expanding, often exponentially. Like the internet lowered the marginal cost of information sharing, AI may lower the cost of human thinking and reasoning, with broad transformative effects.

## Appendices

### A — Tasks
Full task text for both experiments. Outside-frontier: Kleding channel (assessment) and brand (experimental) analysis, each a 500–750-word CEO note drawing on interviews + Excel data. Inside-frontier: beverage (assessment) and footwear (experimental) new-product development, the footwear task running to **18 numbered questions** ending in an outline for a ~2,500-word HBR-style article.

### B — Recommendation-quality rubric
Rubric (1–10) used by two grader sets (BCG consultants + business-school students) for the out-of-frontier recommendation quality (full rubric is a figure/table in the source).

### C — Retainment
**Retainment** = how much of the AI's output a subject keeps verbatim, measured via Restricted Damerau-Levenshtein (RDL) edit distance between a submitted answer and the closest GPT response (normalised 0–1; conservative measure).

- Most AI-access subjects retained a **very high** amount of AI output — modal average retainment ≈ **0.87**, i.e. effectively "copy-pasting" with minor edits.
- Retainment was **more extreme in the trained (overview) group**.
- Higher retainment correlated with **higher answer quality** on the creative task (regression intercept ≈ 7.55, retainment coefficient ≈ 1.21, both highly significant). The authors caution this could reflect either abdication of judgement *or* high-quality iterative prompting followed by retention — their data can't distinguish the two.

### D — Collective Variation
Semantic-similarity analysis (USE embeddings) of the "10 shoe ideas" question. AI access **reduced** idea variation (higher between-subject similarity), and a simulated GPT-only condition (100 sessions) was the most homogeneous — AI's own output is less varied than humans'. Yet AI-assisted idea lists were rated **significantly higher quality**. Net: higher quality but more redundant/convergent ideas — a firm-level trade-off warranting deeper study.

### E — Centaur and Cyborg Practices
Detailed typology from studying **244** consultants at the sub-task level.

- **Centaur practices** — switching human↔AI by comparative strength across the workflow. Examples: **mapping the problem domain** (ask AI for general domain info), **gathering methods information**, **refining human-generated content**. (Example: user BA1 did the analysis/recommendation themselves, then had AI draft the CEO memo.)
- **Cyborg practices** — use AI throughout, tightly integrated, applying prompting know-how and continual iteration. Examples: **assigning a persona** (e.g. "act as a consultant"; user BA3), **requesting editorial changes**, **teaching through examples**, **modularising tasks**, **validating** (asking AI to check its work), **demanding logic explanation**, **exposing contradictions**, **elaborating**, **directing a deep dive**, **adding the user's own data** iteratively, and **pushing back** on outputs.
- The same individual may act as a Centaur for one task type and a Cyborg for another; skill level, hands-on AI practice, and beliefs about human-AI relations likely shape which practices they use.
