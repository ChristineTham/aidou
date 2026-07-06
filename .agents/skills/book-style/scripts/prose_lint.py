#!/usr/bin/env python3
"""Advisory prose linter for the Kernighan & Pike house style.

Flags sentences that stray from "plain, short, one idea each":
  * over-long sentences (default > 45 words);
  * clause-stuffed sentences (>= 3 em-dashes/semicolons combined).

Skips code fences, headings, tables, blockquotes/alerts, and list markers so it
looks only at running prose. It changes nothing — it points; you decide.

Usage:
    prose_lint.py book/0[1-6]*.md
    prose_lint.py --max-words 40 book/01-foundations.md
"""
import re, argparse

SENT_SPLIT = re.compile(r"(?<=[.!?])\s+(?=[A-Z0-9\"“‘])")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("files", nargs="+")
    ap.add_argument("--max-words", type=int, default=45)
    a = ap.parse_args()
    flagged = 0
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
                breaks = sent.count("—") + sent.count(";")
                if words > a.max_words or breaks >= 3:
                    why = f"{words}w" if words > a.max_words else f"{breaks} clause-breaks"
                    print(f"{path}:{lineno} [{why}] {sent[:100]}…")
                    flagged += 1
    print(f"\n{flagged} sentence(s) to reconsider." if flagged else "\nClean.")


if __name__ == "__main__":
    main()
