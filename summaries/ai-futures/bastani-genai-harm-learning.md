# Generative AI Can Harm Learning

> [!NOTE]
> Source: [bastani-genai-harm-learning.pdf](../../sources/ai-futures/bastani-genai-harm-learning.pdf) — Hamsa Bastani, Osbert Bastani, Alp Sungu, Haosen Ge, Özge Kabakcı & Rei Mariman, *Generative AI without guardrails can harm learning: Evidence from high school mathematics*, PNAS, 2025 (vol. 122, issue 26). https://doi.org/10.1073/pnas.2422633122
> The downloaded PDF is the earlier **working-paper version** titled *"Generative AI Can Harm Learning"* (also on SSRN, abstract id 4895486). The work was **published in PNAS 2025** under the fuller title above. **Cite the published PNAS 2025 form.** This is a **peer-reviewed, pre-registered randomised controlled trial (RCT)** — primary empirical research, not vendor data, a survey, or an opinion essay. The authors are academics at the University of Pennsylvania (Wharton / CIS) with a co-author at a school in Budapest.

## Abstract

This is a pre-registered field RCT measuring how access to generative AI (OpenAI's GPT-4) affects *learning* — not just task performance — in the context of high-school mathematics. Nearly 1,000 Turkish high-school students (9th, 10th, 11th grade) worked through in-class practice sessions under one of three randomly assigned conditions: an unrestricted ChatGPT-style interface ("GPT Base"), a guardrailed tutor prompted to give hints but never the answer ("GPT Tutor"), or a no-AI control. The central finding is a sharp split between assisted performance and retained learning: during practice, AI access dramatically improved scores (48% for GPT Base, 127% for GPT Tutor), but on a subsequent closed-book exam *without* AI, GPT Base students scored **17% worse than control**, while GPT Tutor students were statistically indistinguishable from control. In the authors' words: "access to GPT-4 can harm educational outcomes" — students use unrestricted AI as a "crutch," and "when successful, perform worse on their own." The single most citable result is that unrestricted generative AI *harmed* learning (–17% on the unassisted exam) whereas a guardrailed version did not, showing that guardrails, not access per se, determine whether AI helps or hurts skill acquisition.

## Why the learning question matters (Introduction)

The authors frame the study against prior work showing generative AI raises *productivity*, and ask the further question of how it affects *human capital development* — the acquisition of skills that underpins long-term productivity. They argue this matters especially because generative AI is unreliably capable across tasks (the "jagged frontier"): workers must vigilantly check AI outputs, but cannot do so if they never learned the underlying skills. They draw the analogy to autopilot, noting the FAA recommended pilots minimise its use to preserve manual flying skill for when the technology fails.

## Experimental design

- **Setting:** a large high school in Turkey, Fall semester 2023–2024. Pre-registered on AsPredicted (aspredicted.org/4DL_Q3J).
- **Scale:** four 90-minute sessions across about fifty 9th, 10th, and 11th-grade classes, comprising **nearly 1,000 students**. The sessions collectively made up about **15% of the math curriculum** for each grade.
- **Underlying model:** OpenAI's GPT-4 (the authors distinguish ChatGPT, the interface, from GPT-4, the model).
- **Three arms** (randomised at the classroom level; honors classrooms excluded from the main sample because they are not populated randomly):
  1. **GPT Base** — a plain ChatGPT-like chat interface; the system prompt gives the current problem and tells GPT-4 to act as a tutor. Students got a laptop.
  2. **GPT Tutor** — same interface, but the prompt adds two safeguards: (a) it includes the correct solution(s) plus teacher notes on common student mistakes (so the model does not give incorrect feedback), and (b) it instructs the model to give incremental **hints without revealing the answer**. Students got a laptop.
  3. **Control** — business-as-usual: course book and notes, no devices, no AI.
- **Session structure (three parts):** (1) a normal teacher-led lecture reviewing a previously covered topic (e.g. combinatorics), identical across arms; (2) an **assisted practice period** — the *only* part the intervention affects; (3) an **unassisted, closed-book, closed-laptop exam**, identical across arms. Each exam problem was paired with a conceptually very similar practice problem. Both the practice and exam parts counted toward final grades (for incentive compatibility).
- **Data & rigour:** a start-of-semester demographic survey; performance graded by **independent hired graders** (to avoid teacher bias) using a teacher-designed rubric; and full logs of all student–GPT messages in the two AI arms. A teacher and staff member were present to prevent off-task use of the laptops.

## Main results

Estimates are intention-to-treat, from a regression of normalised grade (0–1) on treatment dummies, controlling for previous-year GPA, with session/grader/grade-level/teacher fixed effects and standard errors clustered by classroom (n = 2,848 for the student-level regression).

**Assisted practice (AI available):**
- Control-arm mean practice score: **0.284**.
- GPT Base raised the practice score by **0.137** (out of 1) → **≈ 48%** above control.
- GPT Tutor raised it by **0.361** → **≈ 127%** above control.
- Both coefficients significant at p < 0.01. The larger GPT Tutor effect is attributed to the problem-specific teacher input in its prompt.

**Unassisted exam (no AI):**
- Control-arm mean exam score: **0.321**.
- GPT Base **reduced** exam performance by **0.054** (out of 1) relative to control → a **≈ 17% reduction** (significant at p < 0.05).
- GPT Tutor's effect was **−0.004** — an order of magnitude smaller, **statistically indistinguishable from control**. The negative learning effect is "essentially eradicated" by the guardrails, though GPT Tutor produced **no positive** learning effect either.

Verbatim: "students in the GPT Base arm perform statistically significantly worse than students in the control arm by 17%; this negative effect is essentially eradicated in the GPT Tutor arm, though we still do not observe a positive effect."

**Student perception (miscalibration):** self-reported perceptions were "overly optimistic." GPT Base students performed worse but did not perceive that they had performed worse or learned less; GPT Tutor students did not perform better but perceived that they had performed significantly better.

**Grade dispersion:** both tools reduced dispersion (HHI) in the *assisted* sessions — matching prior findings that AI narrows the skill gap by helping the weakest students most — but there was **no significant effect on exam dispersion**, i.e. the narrowing did not persist once AI was removed.

**Robustness:** intention-to-treat preserves randomisation despite five non-compliant sessions (e.g. laptops not delivered); omitting non-compliers, running pre-registered t-tests, and testing heterogeneous effects all gave qualitatively similar results, and there was no differential attrition across arms.

## Mechanism: the "crutch" hypothesis

The authors weigh two ways GPT Base could hurt exam performance: (1) students are misled by GPT Base's *errors*, or (2) students use it as a *crutch*, never engaging with the material. GPT Tutor avoids both by design (it rarely errs because it has the solution, and it withholds answers). Two analyses point to the crutch explanation:

- **GPT Base error rates:** querying GPT Base ten times each on all **57 practice problems** with the most common student message ("What is the answer?"), it gave a **correct answer only 51%** of the time — **logical errors 42%**, **arithmetic errors 8%** — with large problem-to-problem variation.
- **Error spillover (against the "misled" story):** GPT Base's logical errors hurt *practice* performance but showed **no statistically significant spillover** onto the paired exam problems — inconsistent with students being misled. Also, arithmetic and logical errors had *similar* effects on practice performance; if students were reading and understanding the solutions, they should have caught the arithmetic slips more easily. Both patterns suggest students were **simply copying answers**.
- **Engagement (for the "crutch" story):** GPT Tutor students sent **significantly more messages** per problem (rising with experience) and spent **13% more time** with the tool than GPT Base students. Using NLP clustering, GPT Base conversations were mostly "superficial" (restating the question / asking for the answer), whereas a substantially larger fraction of GPT Tutor conversations were "non-superficial" (attempting answers, asking for help). The vast majority of GPT Base students used it to obtain solutions.

## Discussion

The authors call the result "a cautionary tale" for deploying GPT-based tutors, noting similar anecdotal concerns about tools like Khanmigo. They acknowledge that earlier technologies also traded skill for convenience (typing vs. handwriting, calculators vs. arithmetic) but argue ChatGPT differs on two counts: its capabilities are far **broader and more intellectual**, and it is **highly unreliable**, often giving incorrect answers that students proved unable or unwilling to check. GPT Tutor's guardrails largely neutralise the harm, but "substantial work is required to enable generative AI to positively enhance rather than diminish education." The overarching lesson for the book: generative AI tools "must be deployed with appropriate guardrails when learning is important."

### Limitations noted by the authors
- Single school, single subject (mathematics), single semester — generalisability is bounded.
- GPT Tutor removes the *negative* effect but delivers **no positive** learning gain, so guardrails prevent harm rather than actively teaching better than the status quo.
- Findings reflect GPT-4 as of the 2023–2024 study window; model reliability differs across tasks and over time.
