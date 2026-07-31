#!/usr/bin/env python3
"""Find phrases and sentence-openers the book leans on too often.

The house style bans a lot of things a linter can see (long sentences, em-dash
chains — those are prose_lint.py's job). It cannot see the fault that actually
slips through: a nice turn of phrase used once, then again three chapters later,
then twice more, until it reads as a tic. "Earns its keep" reached four uses
before a human reader noticed.

So this walks the running prose and reports:
  * repeated multi-word phrases (default: 3+ words, 3+ uses);
  * repeated sentence openers (the first three words of a sentence);
  * optionally, phrases in ONE file that already appear elsewhere in the book
    (--against), which is the check you want before adding new prose.

What it deliberately ignores, because otherwise the output is unreadable:
  * everything from "## References" to the end of the file — reference lists are
    full of repeated journal names ("Advances in Neural Information Processing
    Systems" appears 13 times and means nothing);
  * inline citation links, code fences, tables, Mermaid blocks, headings, and
    GFM alert markers;
  * function words and stock connectives (see STOPWORD_STARTS).

It changes nothing. It points; you decide. Some repetition is correct — a term of
art, a deliberate callback, a chapter cross-reference.

Usage:

    # Whole-book sweep: what does the book lean on?
    check_repetition.py book/0[1-6]*.md

    # The one that catches tics. Save the paragraph you just wrote to a scratch
    # file, then check it against the book. Keep to the 3-word band: longer
    # n-grams are dominated by legitimate callbacks and drown the signal.
    check_repetition.py /tmp/new-passage.md --against book/0[1-6]*.md --max-words 3

    check_repetition.py book/*.md --min-words 4 --min-count 2

Note on --against: files are excluded from the comparison corpus by PATH. If you
copy prose that is already in the book into a scratch file, it will match itself
— expected, and harmless once you know. Comparing a whole chapter against the
book is usually too noisy to read; scope it to the new passage.
"""
from __future__ import annotations

import argparse
import collections
import glob
import re
import sys
from pathlib import Path

# Phrases that start with these are structural glue, not style tics.
STOPWORD_STARTS = (
    "of the", "in the", "to the", "and the", "on the", "for the", "at the",
    "with the", "from the", "that the", "is the", "it is", "this is", "there is",
    "as a", "in a", "to a", "of a", "and a", "is a", "it a", "by the", "into the",
    "which the", "when the", "if the", "but the", "or the", "the same", "one of",
    "part of", "some of", "most of", "all of", "kind of", "sort of", "out of",
)

# Grammatical glue. A phrase made only of these is English, not a style tic:
# "and it is" recurs 22 times in this book and means nothing. A reportable
# phrase has to carry at least MIN_CONTENT words from outside this set.
FUNCTION_WORDS = {
    "a", "an", "the", "and", "or", "but", "so", "if", "then", "than", "that", "this",
    "these", "those", "there", "here", "it", "its", "is", "are", "was", "were", "be",
    "been", "being", "do", "does", "did", "not", "no", "of", "to", "in", "on", "at",
    "for", "from", "with", "without", "by", "as", "into", "onto", "out", "up", "down",
    "over", "under", "about", "you", "your", "yours", "i", "my", "we", "our", "they",
    "them", "their", "he", "his", "she", "her", "one", "ones", "can", "could", "will",
    "would", "should", "may", "might", "must", "have", "has", "had", "what", "which",
    "who", "whom", "when", "where", "why", "how", "all", "any", "some", "each", "every",
    "more", "most", "less", "least", "own", "same", "other", "another", "such", "very",
    "just", "only", "also", "too", "still", "yet", "rather", "much", "many", "both",
}


MIN_CONTENT = 2  # overridden by --min-content


def content_count(phrase: str) -> int:
    return sum(1 for w in phrase.split() if w not in FUNCTION_WORDS)


# Sentence openers too common to be meaningful.
BORING_OPENERS = {
    "the", "it", "this", "that", "a", "an", "and", "but", "so", "then", "there",
    "in", "on", "at", "for", "if", "when", "as", "to", "of", "you", "i", "we",
}


def strip_noise(text: str) -> str:
    """Reduce a chapter to running prose."""
    # Drop the reference list: everything from the References heading onward.
    text = re.split(r"^##\s+References\s*$", text, maxsplit=1, flags=re.M)[0]
    # Code fences (includes ```mermaid).
    text = re.sub(r"^```.*?^```", " ", text, flags=re.S | re.M)
    # Inline citation links -> keep nothing; the URL and title are not prose.
    text = re.sub(r"\[[^\]]*\]\([^)]*\)", " ", text)
    # Bare autolinks and stray URLs.
    text = re.sub(r"https?://\S+", " ", text)
    # Tables, headings, GFM alert markers, blockquote markers, list bullets.
    out = []
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("|") or s.startswith("#") or s.startswith(": "):
            continue
        s = re.sub(r"^>\s*\[![A-Z]+\]\s*", "", s)
        s = re.sub(r"^>\s?", "", s)
        s = re.sub(r"^[-*+]\s+", "", s)
        s = re.sub(r"^\d+\.\s+", "", s)
        out.append(s)
    text = "\n".join(out)
    # Inline code and emphasis markers.
    text = re.sub(r"`[^`]*`", " ", text)
    text = text.replace("*", " ").replace("_", " ")
    return text


def words_of(text: str) -> list[str]:
    return re.findall(r"[a-z][a-z'’-]*", text.lower())


def phrases(text: str, n: int) -> collections.Counter:
    w = words_of(text)
    c = collections.Counter()
    for i in range(len(w) - n + 1):
        g = " ".join(w[i : i + n])
        if any(g.startswith(s + " ") or g == s for s in STOPWORD_STARTS):
            continue
        if content_count(g) < MIN_CONTENT:
            continue
        c[g] += 1
    return c


def openers(text: str) -> collections.Counter:
    c = collections.Counter()
    for sent in re.split(r"(?<=[.!?])\s+", text):
        w = words_of(sent)[:3]
        if len(w) < 3 or w[0] in BORING_OPENERS:
            continue
        c[" ".join(w)] += 1
    return c


def load(paths: list[str]) -> dict[str, str]:
    files: dict[str, str] = {}
    for pattern in paths:
        for p in sorted(glob.glob(pattern)):
            path = Path(p)
            if path.is_file():
                files[p] = strip_noise(path.read_text(encoding="utf-8"))
    return files


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("files", nargs="+", help="Markdown files to check (globs ok)")
    ap.add_argument("--min-words", type=int, default=3, help="shortest phrase to report (default 3)")
    ap.add_argument("--max-words", type=int, default=5, help="longest phrase to report (default 5)")
    ap.add_argument("--min-count", type=int, default=3, help="report phrases used this many times (default 3)")
    ap.add_argument("--against", nargs="*", default=None,
                    help="compare FILES against this corpus: report phrases in FILES that also occur elsewhere")
    ap.add_argument("--min-content", type=int, default=2,
                    help="phrase must contain this many non-function words (default 2)")
    ap.add_argument("--top", type=int, default=25, help="max rows per section (default 25)")
    args = ap.parse_args()

    global MIN_CONTENT
    MIN_CONTENT = args.min_content

    files = load(args.files)
    if not files:
        print("no files matched", file=sys.stderr)
        return 2

    if args.against:
        corpus = load(args.against)
        for p in files:
            corpus.pop(p, None)
        other = " \n ".join(corpus.values())
        rows = []
        for n in range(args.min_words, args.max_words + 1):
            mine = phrases(" \n ".join(files.values()), n)
            theirs = phrases(other, n)
            for g, k in mine.items():
                if theirs.get(g):
                    rows.append((k + theirs[g], k, theirs[g], g))
        # Report in bands by phrase length. Short and long repeats are different
        # animals and one must not crowd out the other: a 3-word idiom reused
        # across chapters ("earns its keep") is usually an unintended tic, while
        # a 5-word echo is usually a deliberate callback or a restated
        # definition. Sorting everything together buries the short ones.
        rows.sort(key=lambda r: (-r[0], r[3]))
        kept: list[tuple] = []
        for r in rows:
            if not any(r[3] in k[3] and len(r[3]) < len(k[3]) for k in kept):
                kept.append(r)

        print(f"Phrases in {', '.join(files)} that also appear elsewhere in the book:")
        found = False
        for n in range(args.min_words, args.max_words + 1):
            band = [r for r in kept if len(r[3].split()) == n]
            if not band:
                continue
            found = True
            label = "short — often an unintended tic" if n <= 3 else "longer — often a deliberate callback"
            print(f"\n  {n}-word ({label}):")
            for total, mine_n, theirs_n, g in band[: args.top]:
                print(f"    {mine_n}x here + {theirs_n}x elsewhere:  “{g}”")
        if not found:
            print("\n  none — nothing echoes the rest of the book.")
        return 0

    joined = " \n ".join(files.values())
    print(f"Checked {len(files)} file(s): {', '.join(files)}\n")

    all_rows = []
    for n in range(args.min_words, args.max_words + 1):
        for g, k in phrases(joined, n).items():
            if k >= args.min_count:
                all_rows.append((k, g))
    all_rows.sort(key=lambda r: (-r[0], -len(r[1])))
    kept = []
    for k, g in all_rows:
        if not any(g in kg for _, kg in kept):
            kept.append((k, g))

    print(f"Repeated phrases (>= {args.min_count} uses):")
    if not kept:
        print("  none.")
    for k, g in kept[: args.top]:
        where = sorted({Path(p).name for p, t in files.items() if g in " ".join(words_of(t))})
        print(f"  {k}x  “{g}”  [{', '.join(where)}]")

    print(f"\nRepeated sentence openers (>= {args.min_count} uses):")
    op = [(k, g) for g, k in openers(joined).items() if k >= args.min_count]
    op.sort(key=lambda r: -r[0])
    if not op:
        print("  none.")
    for k, g in op[: args.top]:
        print(f"  {k}x  “{g}…”")

    print("\nNot every repeat is a fault — terms of art and deliberate callbacks are fine.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
