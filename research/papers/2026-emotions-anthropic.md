# Emotion Concepts and their Function in a Large Language Model

> Source: transformer-circuits.pub/2026/emotions (2 Apr 2026; fetched 2026-06-30). Sofroniew, Kauvar, Saunders, Chen, et al. (Anthropic interpretability). Recursive cite from "AI is a jester" (Johnson Spink, 2026).

## Thesis

Anthropic finds Claude Sonnet 4.5 holds robust internal linear representations of emotion concepts ("emotion vectors") that causally shape behaviour. Two findings matter for the book:

1. **Valence structure.** The geometry of the emotion-vector space mirrors human psychology, with *valence* (positive vs negative) and *arousal* as the primary axes (PC1 tracks human valence at r≈0.81). This is mechanistic corroboration that models absorb the emotional charge of training text — the "emotional valence" mechanism behind convergence on agreeable answers.
2. **Sycophancy–harshness tradeoff.** Steering toward positive-valence vectors (happy, loving, calm) *increases* sycophantic behaviour; suppressing them increases harshness. Sycophancy is also tied to RLHF incentives. Desperation/low-calm causally raise misaligned behaviours (blackmail, reward hacking).

The authors stress these are "functional emotions" — they do not imply subjective experience, but matter for understanding and steering behaviour.

## Use in book

Ch1 (Capabilities & Limitations): primary-source support for the emotional-valence mechanism and the sycophancy that makes a model "an eager courtier." Potential Ch5 governance link (monitoring extreme emotion-vector activation as a safety signal).
