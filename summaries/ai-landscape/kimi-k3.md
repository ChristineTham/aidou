# Summary — Kimi K3 (Moonshot AI)

> [!NOTE]
> **Source status:** Secondary reputable tech press (VentureBeat, Michael Nuñez, 16 July 2026), built on Moonshot AI's own technical materials plus a private evaluation by analytics firm Artificial Analysis; cross-checked against Moonshot's HuggingFace model-card teaser and Simon Willison's practitioner write-up. Moonshot's own primary blog is no longer reachable, and the full model card/weights are not due until 27 July 2026. Model specs are largely self-reported and benchmark rankings are benchmark- and date-dependent — a fast-moving claim, not independently confirmed. The open-weight licence name was still "TBD" at announcement.

## Abstract

On 16 July 2026 Moonshot AI, the Alibaba-backed Beijing startup behind the Kimi models, announced Kimi K3 — a 2.8-trillion-parameter Mixture-of-Experts model it calls the largest open-weight ("open 3T-class") model in the world, with full weights scheduled for 27 July. The company positions K3 as approaching the top proprietary systems from Anthropic and OpenAI: self-reported and Artificial-Analysis benchmarks put it roughly third on real-world-task and agentic leaderboards (behind Claude Fable 5 and GPT-5.6 Sol) while topping Arena.AI's Frontend Code Arena. It is a strategic comeback bid after DeepSeek's 2025 rise eroded Kimi's market position, and a geopolitical statement about Chinese open-weight AI.

## Key points

- **Parameters / architecture:** 2.8T total parameters, Autoregressive Mixture-of-Experts transformer with native vision; ~50B active-equivalent (16 of 896 experts per token). Two internal innovations — Kimi Delta Attention (hybrid linear attention) and Attention Residuals — both previously open-published on GitHub. Trained with MXFP4 weights / MXFP8 activations via quantization-aware training.
- **Context / features:** 1,000,000-token context window, native visual understanding, always-on "thinking mode" reasoning; OpenAI-SDK compatible.
- **Open weights:** Announced as open-weight, largest open model to date; weights due 27 July 2026 on HuggingFace. Licence name not yet stated ("TBD with weight release") as of announcement — so "open" is asserted but the exact terms were unconfirmed.
- **Benchmark standing (self-reported / Artificial Analysis, benchmark-dependent):** GDPval-AA v2 third (1,687) behind Claude Fable 5 Max and GPT-5.6 Sol Max, ahead of Claude Opus 4.8; AA-Briefcase second (1,527); BrowseComp state-of-the-art 91.2/100; No. 1 on Arena.AI Frontend Code Arena (1,679); top-three across six coding benchmarks. Willison and others stress these are largely self-reported and await independent verification.
- **Pricing:** $3 / million input tokens, $15 / million output, $0.30 / million cached input — roughly Claude Sonnet parity, notably high for a Chinese lab. Usable now at kimi.com.
- **Caveats (practitioner):** verbose reasoning (thousands of reasoning tokens even for short answers) makes it costly for simple tasks; single reasoning-effort level; self-hosting a 2.8T model needs substantial GPU infrastructure.

## Relation to the book

A timely exemplar of a Chinese open-weight frontier model for §1.2's AI-landscape section — evidence that open-weight systems have closed much of the gap to proprietary U.S. frontier models, while illustrating how such claims rest on self-reported, fast-moving benchmarks and as-yet-unconfirmed licence terms.
