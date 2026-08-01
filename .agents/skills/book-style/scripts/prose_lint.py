#!/usr/bin/env python3
"""Advisory prose linter for the author's house voice.

Flags sentences that stray from "plain, short, one idea each":
  * over-long sentences (default > 45 words);
  * clause-stuffed sentences (>= 3 dashes/semicolons combined);
  * any em dash at all - the author's own corpus contains none, so each one
    is a machine fingerprint rather than a stylistic choice (--allow-em-dash
    turns this off when checking quoted source text).

Skips code fences, headings, tables, blockquotes/alerts, and list markers so it
looks only at running prose. It changes nothing: it points, you decide.

Usage:
    prose_lint.py book/0[1-6]*.md
    prose_lint.py --max-words 40 book/01-foundations.md
    prose_lint.py --allow-em-dash book/03-software.md   # quoting source text
"""
import re, argparse

SENT_SPLIT = re.compile(r"(?<=[.!?])\s+(?=[A-Z0-9\"“‘])")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("files", nargs="+")
    ap.add_argument("--max-words", type=int, default=45)
    ap.add_argument("--allow-em-dash", action="store_true",
                    help="skip the em-dash check (for quoted source text)")
    a = ap.parse_args()
    flagged = 0
    em_total = 0
    for path in a.files:
        infence = False
        for lineno, raw in enumerate(open(path, encoding="utf-8"), 1):
            s = raw.strip()
            if s.startswith("```") or s.startswith("~~~"):
                infence = not infence
                continue
            if infence or not s:
                continue
            if s.startswith(("#", "|", ">", "-", "*", "!", "```")):
                continue
            for sent in SENT_SPLIT.split(s):
                words = len(re.findall(r"\S+", sent))
                dashes = sent.count("—")
                breaks = dashes + sent.count(";")
                # The em dash is not a matter of degree: the author's own corpus
                # has none, so any occurrence is a finding, not a style choice.
                if dashes and not a.allow_em_dash:
                    em_total += dashes
                    print(f"{path}:{lineno} [em dash x{dashes}] {sent[:100]}…")
                    flagged += 1
                elif words > a.max_words or breaks >= 3:
                    why = f"{words}w" if words > a.max_words else f"{breaks} clause-breaks"
                    print(f"{path}:{lineno} [{why}] {sent[:100]}…")
                    flagged += 1
    if em_total:
        print(f"\n{em_total} em dash(es). The author uses none: replace with a spaced "
              f"hyphen ( - ), a comma, a colon, or a second sentence.")
    print(f"\n{flagged} sentence(s) to reconsider." if flagged else "\nClean.")


if __name__ == "__main__":
    main()
