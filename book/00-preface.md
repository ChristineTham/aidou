# Preface — Why This Book Exists

## Why this book

Working with artificial intelligence has become strangely easy to do and strangely hard to do well. Anyone can open a chat window and get an answer in seconds; far fewer can rely on output that is accurate, consistent, and worth using.

We all tend to use the same handful of frontier models, so it is not the model that separates good quality from slop. The *method* matters — the practised habits by which an experienced person turns a capable tool toward a dependable result, in the same way that a chef and a novice handed the same kitchen produce very different dinners. This book is about that method: a structured way of working with AI, grounded in human intent and refined through iteration.

A quick word on the terms, since they move quickly. When I say *artificial intelligence*, I mean the present generation of large language models — systems trained on enormous quantities of text, and increasingly images and sound, that respond to plain-language requests with fluent prose, working code, and structured analysis (["Large language model," n.d.](https://en.wikipedia.org/wiki/Large_language_model)). The most capable are called *frontier models*: the handful of largest, most general systems from a few well-resourced labs, the ones that set the pace and that everyone else measures against ([Anderljung et al., *Frontier AI regulation: Managing emerging risks to public safety*, 2023](https://arxiv.org/abs/2307.03718)). ChatGPT, Claude, and Gemini are the familiar names; behind them sits a *foundation model*, a single large network trained once at great expense and then adapted to countless tasks ([Bommasani et al., *On the opportunities and risks of foundation models*, 2021](https://arxiv.org/abs/2108.07258)).

> [!NOTE]
> A few terms used throughout, defined plainly:
>
> - **Large language model (LLM)** — a network trained to predict the next word, which in scale yields fluent prose, code, and analysis.
> - **Foundation model** — one large model trained once, then adapted to many tasks.
> - **Frontier model** — the largest, most general foundation models that set the pace (ChatGPT, Claude, Gemini).

## Why I wrote it

A few words about me. My name is Chris Tham. I run a boutique strategy consulting company, **Hello Tham**, and I also teach technology and information systems to undergraduate and master's students at **Torrens University Australia**.

This book grew out of my recent experiences using AI in my work, and documents what I have learnt. I had just finished delivering an AI strategy for a global client, and I was also teaching AI to my students. Consulting stretches my experience; teaching lets me hand the lessons on. Writing it down is a third way to do the same thing: to set down a practice worth keeping, and pass it on.

## Why now, and won't it date?

Why write this in 2026? Because the ground has shifted in a way that rewards method over tooling. Adoption is broad but shallow — most organisations have AI somewhere in the building, yet few can point to value won rather than effort spent ([Stanford HAI, *The AI index 2026 annual report*, 2026](https://hai.stanford.edu/ai-index/2026-ai-index-report); [McKinsey & Company, *The state of AI*, 2025](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai)) — and as capability climbed, the model alone stopped being the product. The advantage moved into everything built around it: the workflow, the context, the checks.

That is also why the book should outlast its examples. The field moves in weeks, and a book of prompts and tool tips would be stale a model release later. This one rests on a steadier layer — *how* the models work, not which model leads this quarter — and those properties have held across generations of models. Where a point is tied to a 2026 product or figure, I mark it as such; the way of working around it is meant to last.

## Who it is for

This book is for the thoughtful professional — a leader, a consultant, an analyst, a builder — who wants structured, effective use of AI rather than a bag of prompts. I assume

- you are numerate and can read a chart, a code snippet, or a research paper when it helps;
- that you have already used these tools and felt both edges, the power and the unreliability;
- and that you want to *use* AI well, not to build models.

Using AI well is its own discipline, and the one we pursue here. My promise is modest and practical: an approach you can apply tomorrow and keep sharpening for years.

## How to read it

The book is six chapters, and they build. The first lays the foundations — what AI is, how it works, and what it cannot do. The middle chapters climb from personal productivity, to building software, to the disciplines that keep that work sound, then to responsibility and governance. The last turns to mastery — what stays human when the tools are this good.

| Chapter | Theme | The question it answers |
| --- | --- | --- |
| 1 | Foundations | What is AI, what is it not, where do we stand? |
| 2 | Productivity | How does it change individual knowledge work? |
| 3 | Software | How does it change building software? |
| 4 | Disciplines | What keeps that work sound at scale? |
| 5 | Responsibility | How do we govern it safely and fairly? |
| 6 | Mastery | What stays distinctly human? |

Read it once in order, to see how the ideas rest on one another, then come back for the parts you need. Every claim is cited inline to a primary source, so you can follow the trail yourself; where the evidence is thin, I say so.

## References

Anderljung, M., et al. (2023). *Frontier AI regulation: Managing emerging risks to public safety*. arXiv. [https://arxiv.org/abs/2307.03718](https://arxiv.org/abs/2307.03718)

Bommasani, R., et al. (2021). *On the opportunities and risks of foundation models*. arXiv. [https://arxiv.org/abs/2108.07258](https://arxiv.org/abs/2108.07258)

Large language model. (n.d.). In *Wikipedia*. [https://en.wikipedia.org/wiki/Large_language_model](https://en.wikipedia.org/wiki/Large_language_model)

McKinsey & Company. (2025). *The state of AI*. [https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai)

Stanford Institute for Human-Centered AI. (2026). *The AI index 2026 annual report*. Stanford University. [https://hai.stanford.edu/ai-index/2026-ai-index-report](https://hai.stanford.edu/ai-index/2026-ai-index-report)
