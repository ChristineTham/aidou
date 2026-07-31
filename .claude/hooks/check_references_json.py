#!/usr/bin/env python3
"""PostToolUse hook: sanity-check references.json after an edit.

references.json is the book-wide citation map (~300 entries). It gets appended
to by hand and by scripts using json.dump, which rewrites the WHOLE file - so a
formatting slip silently reflows all 300 entries, and a bad write corrupts the
one file every citation depends on.

After any edit that touches it, this checks three things:
  1. it still parses as JSON;
  2. every entry has the expected keys;
  3. the change against HEAD is a small append, not a whole-file reflow.

Non-blocking: it reports on stderr with exit 2 so Claude sees the warning and
can react, but nothing is reverted automatically.
"""
from __future__ import annotations

import json
import os
import subprocess
import sys

TARGET = "references.json"
REQUIRED = {"urls", "intext", "reference"}


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0

    ti = payload.get("tool_input") or {}
    path = ti.get("file_path") or ti.get("path") or ""
    if not path:
        return 0
    rel = os.path.relpath(path, os.getcwd()).replace(os.sep, "/")
    if rel != TARGET:
        return 0

    problems = []

    try:
        data = json.load(open(TARGET, encoding="utf-8"))
    except Exception as e:
        print(f"{TARGET} NO LONGER PARSES: {e}\n"
              "Every citation in the book depends on this file. Restore it with "
              "`git checkout references.json` and redo the edit.", file=sys.stderr)
        return 2

    if not isinstance(data, list):
        problems.append("top level is not a list")
    else:
        for i, e in enumerate(data):
            missing = REQUIRED - set(e or {})
            if missing:
                problems.append(f"entry {i} missing {sorted(missing)}")
                if len(problems) > 5:
                    break

    # Duplicate URLs mean a source got cited twice under different labels.
    seen, dupes = set(), set()
    if isinstance(data, list):
        for e in data:
            for u in (e or {}).get("urls", []):
                (dupes if u in seen else seen).add(u)
    if dupes:
        problems.append(f"duplicate URL(s): {sorted(dupes)[:3]}")

    # A whole-file reflow shows up as a large diff on both sides.
    r = subprocess.run(["git", "diff", "--numstat", "--", TARGET],
                       capture_output=True, text=True)
    if r.returncode == 0 and r.stdout.strip():
        added, removed = r.stdout.split()[0], r.stdout.split()[1]
        if added.isdigit() and removed.isdigit() and int(removed) > 12:
            problems.append(
                f"diff is +{added}/-{removed} lines - that looks like a whole-file "
                "reformat, not an append. Check `git diff references.json`.")

    if problems:
        print(f"{TARGET}: " + "; ".join(problems), file=sys.stderr)
        return 2

    print(f"{TARGET} ok: {len(data)} entries, parses, append-shaped diff.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
