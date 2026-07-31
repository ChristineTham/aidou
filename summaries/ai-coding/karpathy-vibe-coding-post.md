# Summary — Karpathy's original "vibe coding" post (2 February 2025)

> [!NOTE]
> **Source status: an offhand practitioner observation on X, not research.** 185 words, posted by
> Andrej Karpathy on 2 February 2025
> ([source](../../sources/ai-coding/karpathy-vibe-coding-post.md);
> [original](https://x.com/karpathy/status/1886192184808149383)). It contains no data, no
> evaluation, and makes no claim to generality — it describes one person's weekend habit, in an
> amused register.
>
> **Conflict of interest: mild but real.** Karpathy is a prominent AI figure whose standing rises
> with enthusiasm for AI coding, and the post names commercial products approvingly (Cursor
> Composer, Sonnet, SuperWhisper). More importantly for citation: he has since abandoned the term,
> calling vibe coding *passé* in favour of "agentic engineering" — so quoting the post as his
> current position would misrepresent him.

## Abstract

This is the post that named the practice. Karpathy describes building software by "fully giving in
to the vibes": talking to the editor by voice, asking for "the dumbest things", accepting every
diff without reading it, pasting error messages back with no comment, and working around bugs the
model cannot fix by asking for random changes until they go away. The striking thing on a careful
read is how heavily *bounded* the claim is. He says plainly that "the code grows beyond my usual
comprehension", and he scopes the whole practice to "throwaway weekend projects" — adding that it
is "still quite amusing", the language of someone reporting a curiosity rather than proposing a
method. The industry adopted the phrase and discarded both qualifications, which is what makes the
full text worth reproducing: the caveats later research would confirm were in the original.

## What the post actually says

- **The definition**: hand the code entirely to the model and "forget that the code even exists".
- **The workflow**: voice input to the editor; "Accept All" always; no reading of diffs; errors
  copy-pasted back with no comment; unfixable bugs worked around or dissolved by asking for random
  changes.
- **The two limits, stated by the author**: the code passes beyond his own comprehension; and it is
  "not too bad for throwaway weekend projects" — not a claim about production software.
- **The register**: amused, self-deprecating ("I'm too lazy", "the dumbest things"), and closing on
  the modest "it mostly works".

## Why the full text matters

Quoted in fragments, "vibe coding" reads as an endorsement of not reading your code. Quoted whole,
it reads as a person noticing something odd about a weekend and saying so — with the scope
condition attached. The gap between those two readings is much of what the chapter's later evidence
is about: the security audit of deployed vibe-coded apps, the survey finding planning and
verification uniformly weak, the visualisation study where users judged output by eyeballing the
render. Those studies did not refute Karpathy. They measured what happened when the practice was
taken past the boundary he drew.

## Relation to the book

Already cited, once, in **§3.4 Spec vs Vibe** — correctly, in first-mention-with-title form, as the
coinage of the term. The right action is not a second citation but to *reproduce the post in full*
at that existing citation, so the reader can see the built-in caveats before the section's evidence
about vibe coding's limits arrives. This strengthens an argument §3.4 already makes rather than
adding a new one.

Runner-up placements considered and rejected: **§3.1.3** (VantageMap, "vibe-coded across a dozen
phases") — the term is used there but the coinage belongs where it is defined; and the **§3.4
definition alert**, which already defines the term crisply and should not be bloated with a long
quotation. One placement, in the paragraph that already cites it.
