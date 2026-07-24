# Summary — Qwen 3.6 (Alibaba)

> [!NOTE]
> **Source status:** Primary company source (Alibaba/Qwen GitHub README + official Hugging Face model cards). All specs and benchmark scores are self-reported by the Qwen team and have not been independently verified. This is a fast-moving space — the closed "Max" tier and a previewed 2.4T Qwen3.8-Max shifted within months of the 3.6 launch.

## Abstract

Qwen3.6 is Alibaba's April 2026 generation of open-weight large language models,
released under an Apache-2.0 licence and aimed squarely at agentic coding. It ships
as two open models: the **dense Qwen3.6-27B** flagship (22 April 2026) and the
efficient **Qwen3.6-35B-A3B** Mixture-of-Experts model with ~3B active parameters
(16 April 2026). Both use a hybrid architecture that blends Gated DeltaNet linear
attention with conventional gated self-attention, are multimodal (text, image,
video), and support a native 262,144-token (256K) context extensible to ~1M via
YaRN. A new "Thinking Preservation" feature carries reasoning context across turns.
On the Qwen team's own benchmarks the small open models post strong agentic-coding
numbers — the 27B claims SWE-bench Verified 77.2 and SWE-bench Pro 53.5 — with
Alibaba framing the 27B dense model as beating its own 397B-A17B Qwen3.5 predecessor
on coding tasks. Notably, the same generation marks Alibaba beginning to hold back a
closed, API-only "Max" flagship tier alongside the open releases.

## Key points

- **Variants.** Two open models: **Qwen3.6-27B** (dense, 22 Apr 2026) and
  **Qwen3.6-35B-A3B** (MoE, 35B total / ~3B active, 16 Apr 2026). The MoE uses 256
  experts (8 routed + 1 shared).
- **Licence.** **Apache-2.0** for all open-weight models — a genuinely permissive
  open licence (unlike some "open" LLM licences with use restrictions).
- **Context.** Native **262,144 tokens (256K)**, extensible to **~1,010,000 (1M)**
  via YaRN scaling.
- **Architecture.** Hybrid **Gated DeltaNet (linear attention) + Gated Attention**,
  MoE backbone for the A3B model; multimodal with a vision encoder. "Thinking
  Preservation" retains reasoning context across a conversation.
- **Benchmark standing (self-reported).** 27B: SWE-bench Verified 77.2, SWE-bench
  Pro 53.5, Terminal-Bench 2.0 59.3. 35B-A3B: SWE-bench Verified 73.4, SWE-bench Pro
  49.5. These are Alibaba's own figures, using an internal agent scaffold and, for
  SWE-bench Pro, a vendor-"refined" task set — treat as marketing-grade, not
  independently reproduced.
- **Open-vs-closed split in the family.** Qwen3.5 and Qwen3.6 families are
  open-weight (Apache-2.0). In parallel Alibaba introduced a **closed, API-only
  "Max" tier** (a Qwen3.6-Max-Preview around the 3.6 launch; a closed Qwen3.7-Max
  ~May 2026) — its first closed-weight flagships. A ~**2.4T-parameter
  Qwen3.8-Max-Preview** was previewed on **19 July 2026** with no model card,
  licence, or benchmark table (2.4T is an unconfirmed vendor claim).

## Relation to the book

A clean exemplar for **§1.2 (the AI landscape)** of a **Chinese open-weight frontier
model from a major lab**: a well-resourced commercial lab (Alibaba) shipping capable
coding models under a truly permissive **Apache-2.0** licence, downloadable and
self-hostable, while competing on the same agentic-coding benchmarks (SWE-bench,
Terminal-Bench) used to rank the closed Western frontier. It illustrates two themes
worth drawing out: (1) the **open-weight track is credible and fast-moving**, with
small dense/MoE models claiming to rival far larger predecessors; and (2) even
open-first labs are **hedging toward a closed "Max" tier** for their largest models,
so "open vs closed" is a spectrum within a single vendor rather than a clean divide.
Use the benchmark numbers only with the self-reported caveat, and cite the primary
GitHub README / Hugging Face model cards rather than secondary write-ups.
