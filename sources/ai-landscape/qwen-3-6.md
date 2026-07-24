---
title: "Qwen3.6 — Alibaba's open-weight coding model generation (27B dense; 35B-A3B MoE)"
source_url: https://github.com/QwenLM/Qwen3.6
supplementary_urls:
  - https://huggingface.co/Qwen/Qwen3.6-27B
  - https://huggingface.co/Qwen/Qwen3.6-35B-A3B
  - https://qwen.ai/blog?id=qwen3.6-27b
  - https://qwen.ai/blog?id=qwen3.6-35b-a3b
author: "Qwen Team, Alibaba Group"
publisher: "Alibaba Group (Qwen)"
date: 2026-04-22
type: "Official repository README + model cards (primary company source)"
benchmark_note: "All benchmark figures are self-reported by the Qwen team on their own model cards/blog; not independently verified. Fast-moving space."
retrieved: 2026-07-24
---

# Qwen3.6 (Alibaba) — primary-source extract

## What it is

Qwen3.6 is the latest addition to the Qwen model family from Alibaba Group's Qwen
team, released April 2026 under an Apache-2.0 licence. It builds on Qwen3.5 and
prioritises "stability and real-world utility", with the headline improvements
aimed at coding:

- **Agentic Coding** — handles front-end workflows and repository-level reasoning
  "with greater fluency and precision."
- **Thinking Preservation** — a new feature that retains thinking context across
  conversation history, streamlining iterative development and reducing overhead.

## Variants and release dates (from the official GitHub README "News")

- **Qwen3.6-27B** (dense) — released **2026-04-22**. Positioned as "Flagship-Level
  Coding in a 27B Dense Model."
- **Qwen3.6-35B-A3B** (Mixture-of-Experts, ~3B active) — released **2026-04-16**.
  Positioned as "Agentic Coding Power, Now Open to All."

Both are on Hugging Face Hub and ModelScope. Earlier context from the same README:
Qwen3.5 first release (2026-02-16) was a 397B-A17B MoE model; mid/small Qwen3.5
sizes followed in Feb–Mar 2026.

## Architecture

Hybrid architecture blending **Gated DeltaNet (linear attention)** with traditional
**Gated (self-)attention**, on top of an MoE backbone for the A3B model.

**Qwen3.6-27B (dense):**
- Pattern: 16 × (3 × (Gated DeltaNet → FFN) → 1 × (Gated Attention → FFN))
- Gated DeltaNet: 48 linear-attention V-heads, 16 QK-heads
- Gated Attention: 24 Q-heads, 4 KV-heads
- Model type: causal language model with a vision encoder (multimodal: text, image, video)

**Qwen3.6-35B-A3B (MoE):**
- 40 layers; pattern 10 × (3 × Gated DeltaNet → MoE + 1 × Gated Attention → MoE)
- Gated DeltaNet: 32 V-heads, 16 QK-heads, head dim 128
- Gated Attention: 16 Q-heads, 2 KV-heads, head dim 256
- 256 total experts; 8 routed + 1 shared expert activated
- Total params 35B; ~3B activated per token; hidden dim 2048

## Context window

- Native: **262,144 tokens** (256K) — confirmed by deployment flags in the README
  (`--context-length 262144`, `--max-model-len 262144`).
- Extensible to **~1,010,000 tokens** (1M) via YaRN scaling (per model cards).

## Licence

All Qwen3.6 open-weight models are licensed under **Apache-2.0**. From the README:
"All our open-weight models are licensed under Apache 2.0."

## Benchmark claims (SELF-REPORTED by Qwen; not independently verified)

From the official Hugging Face model cards:

**Qwen3.6-27B (dense):**
| Benchmark | Score |
|-----------|-------|
| SWE-bench Verified | 77.2 |
| SWE-bench Pro | 53.5 |
| Terminal-Bench 2.0 | 59.3 |
| SkillsBench (Avg5) | 48.2 |
| MMLU-Pro | 86.2 |
| AIME26 | 94.1 |
| GPQA Diamond | 87.8 |
| MMMU | 82.9 |
| MMMU-Pro | 75.8 |
| VideoMME | 87.7 |

**Qwen3.6-35B-A3B (MoE):**
| Benchmark | Score |
|-----------|-------|
| SWE-bench Verified | 73.4 |
| SWE-bench Pro | 49.5 |
| Terminal-Bench 2.0 | 51.5 |
| MMLU-Pro | 85.2 |
| GPQA | 86.0 |
| AIME26 | 92.7 |
| MMMU | 81.7 |
| RealWorldQA | 85.3 |
| OmniDocBench1.5 | 89.9 |
| VideoMMU | 83.7 |

Marketing framing (per press coverage of the release): the dense open Qwen3.6-27B is
claimed to outperform the 397B-A17B Qwen3.5 predecessor on agentic-coding tasks.
For SWE-bench evaluation the Qwen team states it used an internal agent scaffold
(bash + file-edit tools) and "corrected some problematic tasks in the public set of
SWE-bench Pro" then re-evaluated baselines on the refined benchmark — i.e. the
harness and, for SWE-bench Pro, the task set are the vendor's own.

## Open-vs-closed split in the family (context)

- **Open weights (Apache-2.0):** the Qwen3.5 and Qwen3.6 model families (this source).
- **Closed / API-only:** "Qwen3.x Max" tier. Press coverage reports a **Qwen3.7-Max**
  released ~May 2026 as a closed model, and a **Qwen3.6-Max-Preview** around the 3.6
  launch — Alibaba's first closed-weight flagships, a pivot from the fully-open
  strategy.
- **Qwen3.8-Max-Preview:** a ~**2.4-trillion-parameter** sparse-MoE model *previewed*
  on **2026-07-19** via Alibaba Token Plan / Qoder. As of that date there was no
  official blog post, model card, licence, or benchmark table — the 2.4T figure is
  Alibaba's own, unconfirmed claim; "open weights coming soon" with no date.

The Qwen API is served via Alibaba Cloud Model Studio and is described as compatible
with both OpenAI and Anthropic API specifications.

## Citation (from the README)

```bibtex
@misc{qwen3.6-27b,
    title = {{Qwen3.6-27B}: Flagship-Level Coding in a {27B} Dense Model},
    author = {{Qwen Team}}, year = {2026}, month = {April},
    url = {https://qwen.ai/blog?id=qwen3.6-27b}
}
@misc{qwen3.6-35b-a3b,
    title = {{Qwen3.6-35B-A3B}: Agentic Coding Power, Now Open to All},
    author = {{Qwen Team}}, year = {2026}, month = {April},
    url = {https://qwen.ai/blog?id=qwen3.6-35b-a3b}
}
```

## Provenance note

The qwen.ai release blogs are client-side rendered and did not yield plain text via
curl/WebFetch on retrieval. The extract above is drawn from the primary raw GitHub
README (github.com/QwenLM/Qwen3.6) and the two official Hugging Face model cards,
which are all Alibaba/Qwen-authored primary sources. Benchmark numbers are
self-reported by the vendor and have not been independently reproduced.
