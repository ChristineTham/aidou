#!/usr/bin/env python3
"""Check that a style pass preserved what it must not change.

A style pass rewrites prose only. Citations, tables, diagrams, alerts, code
fences and headings must come through untouched — and a rewrite that quietly
drops a citation link is the most expensive mistake a style pass can make,
because nothing else will catch it. This script compares the file against a
baseline (git HEAD by default) and reports:

- markdown link URLs gained or lost (as a multiset, so a dropped duplicate
  first-mention still shows up);
- changes in the counts of mermaid blocks, GFM alerts, headings, table rows,
  and fenced code blocks.

Usage:
    check_preservation.py book/02-productivity.md
    check_preservation.py book/02-productivity.md --against HEAD~1
    check_preservation.py book/02-productivity.md --against /path/to/backup.md

Exit 0 when everything is preserved; exit 1 with a report when not. A reported
difference is not always an error — a run that also added a citation on purpose
will show it — but every difference should be one you can explain.
"""
import argparse
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path


def urls(text: str) -> Counter:
    return Counter(re.findall(r"\]\((https?://[^)\s]+)\)", text))


def structure(text: str) -> dict:
    return {
        "mermaid blocks": text.count("```mermaid"),
        "GFM alerts": len(re.findall(r"^> \[!", text, re.M)),
        "headings": len(re.findall(r"^#{1,6} ", text, re.M)),
        "table rows": len(re.findall(r"^\|", text, re.M)),
        "code fences": len(re.findall(r"^```", text, re.M)) // 2,
    }


def load_baseline(path: str, against: str) -> str:
    baseline = Path(against)
    if baseline.is_file():
        return baseline.read_text(encoding="utf-8")
    # otherwise treat as a git revision
    result = subprocess.run(
        ["git", "show", f"{against}:{path}"], capture_output=True, text=True
    )
    if result.returncode != 0:
        sys.exit(f"error: cannot read {path} at {against}: {result.stderr.strip()}")
    return result.stdout


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("file", help="the file after the style pass")
    ap.add_argument(
        "--against",
        default="HEAD",
        help="baseline: a git revision (default HEAD) or a file path",
    )
    args = ap.parse_args()

    now = Path(args.file).read_text(encoding="utf-8")
    before = load_baseline(args.file, args.against)

    ok = True

    gained = urls(now) - urls(before)
    lost = urls(before) - urls(now)
    if gained or lost:
        ok = False
        for u, n in sorted(gained.items()):
            print(f"URL GAINED (x{n}): {u}")
        for u, n in sorted(lost.items()):
            print(f"URL LOST   (x{n}): {u}")
    else:
        print("URLs: identical")

    s_before, s_now = structure(before), structure(now)
    for key in s_before:
        if s_before[key] != s_now[key]:
            ok = False
            print(f"STRUCTURE CHANGED: {key}: {s_before[key]} -> {s_now[key]}")
    if s_before == s_now:
        print(f"Structure: identical ({', '.join(f'{v} {k}' for k, v in s_now.items())})")

    if ok:
        print("PRESERVED — prose-only change confirmed.")
        return 0
    print("DIFFERENCES FOUND — explain each one, or fix the pass.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
