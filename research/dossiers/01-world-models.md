# Dossier — Implicit Software World Models in Coding LLMs

> [!NOTE]
> Source: arXiv:2606.27406, *Towards Evaluation of Implicit Software World Models in Coding LLMs*, Egor Bogomolov & Yaroslav Zharov (JetBrains Research), submitted 25 Jun 2026, accepted DL4Code workshop @ ICML 2026. Full HTML read, not abstract. Data: HuggingFace JetBrains-Research/dl4c26; code: github.com/JetBrains-Research/cwm-execution-tracer.

## Thesis

- A *software world model* is the internal model — human or AI — of how software behaves: build/dependency resolution, test/CI behaviour, runtime errors, deployment, concurrency, repo-level patch interaction.
- Existing execution benchmarks (CRUXEval, REval, ThrowBench, BigO(Bench), CodeMind, RE2-Bench) cover only **control flow** on isolated, often synthetic functions — one slice.
- This paper widens the slice to **execution resources** at library scale: peak memory, wall-clock, profiler rankings — closer to real SE.

## Method

- **Data:** SWE-bench Verified (500 issues, 12 Python repos) → keep cases <500K chars context → downsample Django-heavy set to **435 examples** preserving repo diversity. Inject `sys.settrace`/`sys.monitoring` tracer in SWE-bench Docker; run tests before+after gold patch; record top-20 profiler rows (time, memory) × (method, line).
- **Outputs predicted:** outcome (pass/fail/error), failure_line, exception_type, peak_bytes, wall_ms, and four ranked lists (hot_methods/lines × time/alloc), as one JSON object with reasoning.
- **Metrics:** outcome = precision/recall/F1; memory+time = log10 linear calibration (slope, bias, MAE — ideal slope 1, bias 0); profiler = Recall@5, NDCG@5, plus execution rate.
- **12 models:** Anthropic haiku-4-5/sonnet-4-6/opus-4-7; OpenAI gpt-5-mini/5.2/5.4/5.5; open: gpt-oss-120b, Qwen3.5-397B, Qwen3-235B, Qwen3-30B, FAIR CWM.

## Results

| Task | Best | Score | Worst |
| --- | --- | --- | --- |
| Test-failure F1 | gpt-5.5 | 0.842 | Qwen3-30B 0.049 |
| Peak-mem MAE (log10) | gpt-5.4 | 0.567 | gpt-5-mini 1.188 |
| Wall-time MAE (log10) | gpt-5.4 | 0.578 | CWM 1.816 |
| Profiler Recall@5 | — | <0.20 (all) | — |

- All models, frontier included, score low; outcome recall low (bias toward "pass"); resources systematically over-estimated with slope compression; best Recall@5 never reaches 0.2.
- Correct ordering of predictions lifts NDCG@5 ×1.5 (method) / ×2 (line) → ranking is hard, not just scope hallucination.
- Trace-trained **CWM** (32B) falls behind same-size Qwen3-30B → code-gen skill doesn't transfer to execution understanding.

## Key cited works (level 1–2 recursion)

- **CWM** (2510.02387, FAIR, 58pp): 32B open-weights, mid-trained on Python interpreter + Docker observation-action trajectories; SWE-bench Verified 65.8% pass@1, LiveCodeBench 68.6%, Math-500 96.6%, AIME24 76.0%. Releases mid-train/SFT/RL checkpoints. → CWM brittle on resources despite this.
- **CodeCrash** (2504.14119, NeurIPS 2025): 1,279 Q from CruxEval+LiveCodeBench; misleading NL → 23.2% avg output-prediction drop, 13.8% even with CoT; "Reasoning Collapse" — wrong hints cause 2–3× tokens, QwQ-32B cognitive dissonance. Explains world-model paper's "models follow NL semantics not structure".
- **ThrowBench** (2503.04241): 2,400+ short programs, 4 languages; predict if/which exception; 6 SOTA code LLMs only 19–38% F1; execution-derived ground truth = no leakage.
- **SWE-bench** (ICLR 2024): real GitHub issue/patch resolution benchmark — the data spine for Verified.

## Use in book

- Ch1 capabilities/limits; Ch4 execution-understanding gap. Frontier models reason about *how code reads*, not *how it runs* — supports verify-at-boundaries discipline.
