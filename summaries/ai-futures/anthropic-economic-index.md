# The Anthropic Economic Index

> [!NOTE]
> Source: [anthropic-economic-index.md](../../sources/ai-futures/anthropic-economic-index.md) — Anthropic (Societal Impacts / Economic Research team), *Introducing the Anthropic Economic Index*, Anthropic company announcement, 10 February 2025. https://www.anthropic.com/news/the-anthropic-economic-index
> **Vendor data.** This is a first-party report from a frontier AI lab, derived from millions of anonymised Claude.ai conversations. It measures how ONE lab's model is being used by ONE segment of that lab's users (Free and Pro plans on Claude.ai), not AI use across the market. Anthropic itself cautions that Claude is marketed as a state-of-the-art coding model, so coding is likely overrepresented, and that "we don't argue that the uses in our dataset are a representative sample of AI use in general." Read the headline numbers as a snapshot of Claude.ai usage, not of the economy.

## Abstract

This is the launch announcement and initial report of the Anthropic Economic Index, an Anthropic initiative to track AI's effects on labour markets over time using direct usage data rather than surveys or forecasts. The central claim is that AI is being diffused unevenly across occupational *tasks* rather than wholesale replacing jobs: usage concentrates in software and writing/technical tasks, leans slightly toward augmenting rather than automating human work, and clusters in mid-to-high-wage occupations. The single most citable finding is the augmentation-versus-automation split: "we saw a slight lean towards augmentation, with 57% of tasks being augmented and 43% of tasks being automated." The report also finds that AI use maps to a minority of occupations doing many of their tasks with AI rather than most occupations doing a few — roughly 36% of occupations show AI use in at least a quarter of their tasks, while only about 4% show it across three-quarters. It matters for a chapter on AI's future because it is one of the earliest large-scale empirical looks at how a frontier model is actually being used in real-world work, and because Anthropic open-sourced the underlying dataset.

## What the document is and its method

Anthropic launched the Index as an ongoing initiative to understand AI's effects on the labour market and economy over time. The stated approach is deliberately empirical: "We don't survey people on their AI use, or attempt to forecast the future; instead, we have direct data on how AI is actually being used."

The unit of analysis is the **occupational task**, not the occupation, drawing on the economics literature that certain tasks (the report's example: visual pattern recognition, shared by designers, photographers, security screeners, and radiologists) lend themselves to automation/augmentation more than others.

**Methodology (O*NET mapping via Clio):**
- Analysis ran on a dataset of approximately **one million conversations** with Claude — specifically **Free and Pro conversations on Claude.ai** (not API, Team, or Enterprise users).
- Conversations were analysed with **Clio** ("Claude insights and observations"), an automated privacy-preserving tool that aggregates conversations into higher-level categories without human researchers seeing the original conversations.
- Each conversation was matched to the O*NET task (from the U.S. Department of Labor's Occupational Information Network, ~20,000 specific work-related tasks) that best represented the AI's role in the conversation.
- Tasks were then grouped into occupations and into a small set of overall categories per the O*NET scheme.
- A language model was used to filter out non-work conversations so the data would contain only conversations relevant to an occupational task.

## Main findings

**Concentration by job type.** Usage concentrates in software development and technical writing tasks. The largest category was "computer and mathematical" (largely software engineering roles) at **37.2% of queries**, covering tasks like software modification, code debugging, and network troubleshooting. The second largest was "arts, design, sports, entertainment, and media" at **10.3% of queries**, mainly writing and editing. Physical-labour occupations were least represented — "farming, fishing, and forestry" was **0.1% of queries**. The report also compares these rates against each occupation's share of the actual U.S. workforce.

**Depth of AI use within occupations (a minority go deep).** "Very few occupations see AI use across most of their associated tasks: only approximately 4% of jobs used AI for at least 75% of tasks. However, more moderate use of AI is much more widespread: roughly 36% of jobs had some use of AI for at least 25% of their tasks." Anthropic reads this as no evidence of jobs being *entirely* automated; instead AI is diffused across many tasks, with stronger impact on some task groups than others. This is the finding that AI use maps to a minority of occupations doing many tasks with AI rather than most occupations doing a few.

**Augmentation versus automation (~57% / ~43%).** "Overall, we saw a slight lean towards augmentation, with 57% of tasks being augmented and 43% of tasks being automated." Automation = AI directly performs a task (e.g. formatting a document); augmentation = AI collaborates with a user. The report notes that in just over half of cases AI worked *with* people via validation (double-checking work), learning (helping acquire knowledge/skills), and task iteration (brainstorming or repeated generative work). Paper-defined subtypes: **Directive** (complete task delegation, minimal interaction); **Feedback Loop** (guided by environmental feedback); **Task Iteration** (collaborative refinement); **Learning** (knowledge acquisition); **Validation** (work verification and improvement). The first two subtypes fall under automation, the latter three under augmentation.

**AI use and salary (mid-to-high, not the extremes).** Using O*NET median U.S. salary per occupation, the report finds "both low-paying and very-high-paying jobs had very low rates of AI use" (examples of low-usage roles involving manual dexterity: shampooers and obstetricians). The heaviest users were specific mid-to-high median-salary occupations like computer programmers and copywriters. Anthropic attributes the drop-off at the extremes to both current AI capability limits and practical barriers to adoption.

## Limitations the authors state

Anthropic lists several caveats explicitly:
- They cannot know whether a given Claude use was for work (e.g. writing help could be for a hobby novel), nor how users used the responses (copy-pasting code, fact-checking versus accepting uncritically).
- Some apparent automation may actually be augmentation — e.g. a user asks Claude to write a full memo (looks like automation) then edits it themselves (augmentation).
- Only Claude.ai Free and Pro data was analysed — not API, Team, or Enterprise.
- Clio may have misclassified some conversations given the number of distinct tasks (validation detailed in the full paper, Appendix B).
- Claude cannot generate images (except indirectly via code), so some creative uses are absent from the data.
- Because Claude is advertised as a state-of-the-art coding model, coding is likely overrepresented; the dataset is explicitly **not** claimed to be a representative sample of AI use in general.

## Framing and future work

Anthropic frames the work against a long history of technology and labour (from the Spinning Jenny to car-manufacturing robots) and commits to repeating the analyses over time, releasing results and datasets longitudinally, to track whether jobs *evolve* rather than disappear and whether the automation-to-augmentation ratio shifts. The report states its research gives data on how AI is used but "doesn't provide policy prescriptions" — those "can't come directly from research in isolation" but from a combination of evidence, values, and experience. The dataset was open-sourced for other researchers, with an accompanying call for input from economists and policy experts.
