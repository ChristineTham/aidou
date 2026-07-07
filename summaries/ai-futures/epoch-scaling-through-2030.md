# Can AI Scaling Continue Through 2030?

> [!NOTE]
> Source: [epoch-scaling-through-2030.md](../../sources/ai-futures/epoch-scaling-through-2030.md) — Jaime Sevilla et al. (Epoch AI), *Can AI Scaling Continue Through 2030?*, epoch.ai, 20 August 2024. https://epoch.ai/blog/can-ai-scaling-continue-through-2030
> This is a research report from Epoch AI, an independent research institute that tracks AI trends and compute. It is NOT a frontier lab, and not a vendor pitch — but it is a *feasibility projection* built on extrapolated trends and Monte Carlo estimates, so the headline numbers are the authors' modelled projections (with wide confidence intervals they state plainly), not observed facts.

## Abstract

The report asks a narrowly technical question: is it physically and industrially feasible for AI training compute to keep growing at its recent pace — roughly 4× per year — all the way through 2030? Epoch analyses four candidate bottlenecks (power, chips, data, and a "latency wall") and concludes that training runs of around **2e29 FLOP are likely feasible by 2030**, a roughly **10,000× scale-up over current frontier models** and enough to let the historical scaling trend continue uninterrupted. The single most citable framing: by 2030 "it is likely feasible … for an AI lab to train a model that would exceed GPT-4 in scale to the same degree that GPT-4 eclipses GPT-2 in training compute." The constraints most likely to bind first are power, then chip manufacturing; data is the most uncertain (its range spans four orders of magnitude); latency is the most distant. The report deliberately brackets the economic question — whether anyone *will* spend the hundreds of billions of dollars required is "beyond the scope" — and only argues that it is technically possible and at least plausible.

## Framing: the 4×/year trend

Training compute has been expanding at roughly **4× per year**, faster than the peak growth rates of some of the fastest historical technology expansions: mobile phone adoption (2×/year, 1980–1987), solar capacity installation (1.5×/year, 2001–2010), and human genome sequencing (3.3×/year, 2008–2015). For reference, GPT-4 was likely trained at around **2e25 FLOP**; the largest runs to date are on the order of 5e25 FLOP. Six more years of 4×/year growth from GPT-4 lands at ~2e29 FLOP. The report assumes training runs lasting **two to nine months**, and that a single developer can muster only about **10–40% (central ~26%)** of the available power/chip supply for one run (the rest split between competitors and between training and inference).

## The four constraints, in order of bindingness

Each constraint is modelled as the largest training run it would allow (conservative estimates). Summary of the headline ceilings:

| Constraint | Largest run it allows (approx.) | Notes |
|---|---|---|
| **Power** | 2e28 – 2e30 FLOP | Likely binds *first* |
| **Chip manufacturing** | 1e29 – 5e30 FLOP (median ~9e29) | Binds *second* |
| **Data** | 6e28 – 2e32 FLOP | Most *uncertain* (4 orders of magnitude) |
| **Latency wall** | ~3e30 – 1e32 FLOP | Most *distant* |
| **Combined feasibility** | **~2e29 FLOP by 2030** | The headline conclusion |

### 1. Power (most binding)

The constraint likely to bind first. Single-campus data centres of **1–5 GW** are considered feasible by 2030 (spanning Amazon's 960 MW nuclear contract in Pennsylvania to the rumoured OpenAI/Microsoft "Stargate" 5 GW campus for ~2028), supporting **1e28–3e29 FLOP**. Geographically distributed training across multiple regions/grids could tap **2–45 GW**, supporting **2e28–2e30 FLOP**; inter-data-centre bandwidth of 4–20 Pbps is on-trend and would not itself be the binding limit.

Concrete anchors: an on-trend 2e29 FLOP run in 2030 is projected to need ~**6 GW** of power — because although the run is ~5,000× larger than Llama 3.1 405B (a 4e25 FLOP run that used 16,000 H100s at 27 MW), power efficiency is expected to improve ~24× (4× hardware efficiency × 2× from FP8 precision × 3× longer duration), so power scales only ~200×. Six GW is small against total US generating capacity (~1,200 GW installed, ~477 GW average in 2023) but large against all US data centres today (~20 GW, mostly non-AI). US data-centre capacity is projected to grow ~15%/year (range 10–30%), from ~40 GW to ~90 GW by 2030, leaving ~30 GW for AI — a ~10× expansion. Building the power is judged affordable (power would be ~40% of GPU cost by 2030), but **grid-level bottlenecks** are the real limiters: transmission lines take ~10 years, interconnection queues ~5 years, transformers up to 2 years; plus carbon commitments (US 100% clean by 2035; Google/Microsoft/Amazon carbon-neutral pledges) and political/regulatory friction. Epoch conservatively assumes power will *not* scale beyond utility/analyst forecasts.

### 2. Chip manufacturing capacity (second most binding)

A 2e29 FLOP run needs ~**20M H100-equivalent GPUs**; if one lab nets ~20% of production, global capacity must reach ~**100M H100-equivalents by 2030**. Median projection: enough capacity for ~100M H100-equivalents dedicated to training → a **9e29 FLOP** run. But the uncertainty is large: **20M to 400M** H100-equivalents, i.e. **1e29 to 5e30 FLOP** (5,000× to 300,000× GPT-4). The near-term bottlenecks are **not** wafer supply (data-centre GPUs use only ~5% of TSMC's 5nm capacity) but **advanced packaging** (TSMC's CoWoS process) and **high-bandwidth memory (HBM)**. TSMC's CoWoS capacity is scaling (14–15k wafers/month in Dec 2023 → 33–35k by end-2024; planned +60%/year through 2026); HBM is nearly sold out to 2026. GPU die production is projected to grow **30–100%/year**. Expanding fabs demands huge capex and specialised labour, which is why chips are judged harder to make malleable than power.

### 3. Data scarcity ("the data wall", most uncertain)

The largest known training datasets are ~**15 trillion tokens**; the deduplicated indexed web holds ~**500 trillion tokens** (range 100T–3,000T), projected to grow ~50% by 2030. Under Chinchilla scaling, using the whole indexed web (~30× more data) would allow ~**8e28 FLOP** — and continuing 4×/year would hit this text "data wall" in about five years. **Multimodal data** (image, video, audio) could roughly triple effective data; image and video might each contribute about as much as text (~400T tokens added at ~22 tokens/image or video-second). After accounting for quality, epochs, and tokeniser efficiency, Epoch estimates **400 trillion to 20 quadrillion effective tokens** available by 2030, allowing **6e28 to 2e32 FLOP** — the widest range of any constraint. **Synthetic data** could in principle lift the ceiling indefinitely (verification is often easier than generation; precedent in AlphaZero/AlphaProof), but roughly *doubles* the compute cost of training and risks model collapse; the evidence is nascent and mixed, so the report conservatively **excludes synthetic data** from its mainline numbers. Copyright is judged unlikely to sharply cut total volume, though it may reduce access to the highest-quality sources (books, reputable news).

### 4. Latency wall (most distant)

A "speed limit" from the minimum time for forward/backward passes: as models grow they need more sequential operations, and beyond a "critical batch size" enlarging batches gives diminishing returns, forcing more sequential batches. Estimated ceiling: **3e30 to 1e32 FLOP** on modern GPU setups (with a batch size of ~60M tokens, speculated to match GPT-4's). Intranode analysis gives ~110 µs latency per layer → up to a 700T-parameter, ~6e31 FLOP Chinchilla-optimal model in nine months; internode communication raises latency (e.g. a 300M-H100 cluster with 2,000-way tensor parallelism → ~400 µs/layer → ~7e30 FLOP). Scaling past ~**1e32 FLOP** would require alternative network topologies (e.g. mesh), lower communication latency, larger pods, or more aggressive batch-size scaling.

## Synthesis: which binds first, and the bottom line

Taken together the four constraints imply **~2e29 FLOP feasible by 2030** — ~10,000× current models — keeping the 4×/year trend unbroken. The order of bindingness: **power first, then chips**, with **data the most uncertain** and **latency the most distant**. Power is judged the more *malleable* of the top two (the energy industry is less concentrated; there is precedent for ~100 GW expansions, e.g. the US added ~250 GW of natural gas over 2000–2010, ~25 GW/year, if planned 3–5 years ahead). Chips are harder because packaging is already allocated to AI GPUs and new fabs are capital- and labour-intensive.

## Will labs actually attempt it? (explicitly out of scope)

The report separates *technical feasibility* from *investment willingness*. The cluster for a 2e29 FLOP run would cost on the order of **hundreds of billions of dollars**; spending on training runs has been growing ~2.5×/year. It cites the reported "Stargate" project (Microsoft/OpenAI, up to ~$100 billion, ~2028) as a sign that industry is preparing for such scales, and notes that if AI can automate a large share of economic tasks, investing trillions against a ~$60T/year global labour-compensation flow could be economically justified. But it stresses that whether anyone *will* invest at this level is beyond the article's scope — the claim is only that it is technically possible and "at least plausible."

## Stated limitations

The authors flag their own uncertainty repeatedly: figures come from a Monte Carlo simulation over parameter ranges (with 10th/median/90th-percentile inputs), not point predictions. Power and chip manufacturing are singled out as the most uncertain and are flagged for future work; the data range spans four orders of magnitude; synthetic data is promising but unproven at frontier-pretraining scale and is excluded from the mainline; and grid, carbon, and political constraints could bind power well below what the engineering allows.
