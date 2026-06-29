# Dossier — Survey on Hallucination in LLMs

> [!NOTE]
> Source: arXiv:2311.05232 v2 (19 Nov 2024), Huang, Yu, Ma, Zhong, Feng, Wang, Chen, Peng, Feng, Qin, Liu (HIT/Huawei). Accepted ACM TOIS, DOI 10.1145/3703155. Full HTML read. ~290 references; the field map below is a direct distillation, not the abstract.

## Core reframing

- NLG-era definition was intrinsic (contradicts source) vs extrinsic (unverifiable from source). LLMs are open-ended → that split is too narrow.
- New top split: **factuality** (vs real-world facts) and **faithfulness** (vs user input / self-consistency).

## Taxonomy

- **Factuality**: factual contradiction (entity-error, relation-error); factual fabrication (unverifiability, overclaim).
- **Faithfulness**: instruction inconsistency; context inconsistency; logical inconsistency (steps vs final answer).

## Causes (data / training / inference)

- **Data**: misinformation + biases (imitative falsehood, duplication bias, societal bias e.g. "Kim"→South Korea); knowledge boundary (long-tail, up-to-date, copyright-sensitive); inferior alignment data (new-knowledge SFT *increases* hallucination — Gekhman 2024).
- **Training**: pre-training (unidirectional repr, soft-attention dilution, exposure bias snowball); SFT (forced completion, no rejection); RLHF (sycophancy — sells truth for approval).
- **Inference**: stochastic decoding/likelihood trap; over-confidence + local attention; softmax bottleneck; reasoning failure (Reversal Curse: A-is-B ≠ B-is-A).

## Detection

- **Factuality**: fact-checking (external retrieval FACTSCORE; internal CoVe, p(True)); uncertainty estimation (internal states: token prob/entropy; behaviour: SelfCheckGPT sampling consistency, LMvLM cross-exam).
- **Faithfulness**: fact-based (n-gram/entity/relation), classifier (NLI), QA-based, uncertainty, LLM-as-judge.

## Benchmarks (Table 4 sample)

| Benchmark | Size | Type |
| --- | --- | --- |
| TruthfulQA | 817 | imitative falsehood |
| HalluQA | 450 | Chinese adversarial |
| HaluEval 2.0 | 8,770 | 5 domains |
| FreshQA | 600 | temporal |
| SelfCheckGPT-Wikibio | 1,908 | detection |
| FELM | 3,948 | cross-domain |

## Mitigation

- Data: filtering/dedup (MinHash, SemDeDup), model editing (ROME/MEMIT/MEND), RAG.
- Training: bidirectional/encoder-dec, attention-sharpen, factuality-enhanced; sycophancy via synthetic data + activation steering.
- Inference: factual-nucleus, ITI, DoLa; context-aware decoding, SymbCoT.

## RAG still hallucinates

- Retrieval failure: blind retrieval, ambiguous/complex queries, AIGC-polluted sources, chunking/embedding.
- Generation bottleneck: noisy context, knowledge conflict (prior vs evidence), lost-in-the-middle, attribution/faithful decoding.

## Open questions → book use

- LVLM hallucination; **knowledge-boundary self-awareness** (models can't reliably tell what they don't know). Anchors Ch1 verify-at-boundaries and Ch5 governance.
