#!/usr/bin/env python3
"""Bump the book's edition and add a Changelog entry in one command.

The version string "Edition X.Y" lives in four hand-synced places (see
project-versioning-changelog memory). This updates all of them:
  1. quarto/typst-show.typ   — the PDF copyright-page edition line
  2. quarto/index.qmd        — the web landing `.edition` line
  3. quarto/index.qmd        — the ePub colophon edition line
  4. quarto/changelog.qmd    — a NEW entry prepended at the top (newest first)

Editorial notes are optional here: pass --note (repeatable) for changelog
bullets, or add them to quarto/changelog.qmd afterwards.

Usage:
  bump_version.py --version 1.1 --date "15 August 2026" \
      [--note "Added the glossary" --note "Fixed …"] [--repo .]
"""
import argparse, os, re, sys


def sub_once(path, pattern, repl, label):
    s = open(path, encoding="utf-8").read()
    new, n = re.subn(pattern, repl, s, count=1)
    if n != 1:
        sys.exit(f"ERROR: expected exactly one match for {label} in {path} "
                 f"(found {n}); the file's format may have drifted — update "
                 f"bump_version.py to match.")
    open(path, "w", encoding="utf-8").write(new)
    print(f"  updated {label}")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--version", required=True, help='new edition, e.g. "1.1"')
    ap.add_argument("--date", required=True, help='release date, e.g. "15 August 2026"')
    ap.add_argument("--note", action="append", default=[],
                    help="changelog bullet for this edition (repeatable)")
    ap.add_argument("--repo", default=".", help="repo root (default: cwd)")
    a = ap.parse_args()
    q = os.path.join(a.repo, "quarto")
    ed, date = a.version, a.date

    # 1. PDF copyright block
    sub_once(os.path.join(q, "typst-show.typ"),
             r'#text\(font: "Raleway", weight: 800\)\[Edition [0-9.]+\] — released [^\n.]+\.',
             f'#text(font: "Raleway", weight: 800)[Edition {ed}] — released {date}.',
             "PDF copyright edition line")

    # 2. web landing .edition line
    sub_once(os.path.join(q, "index.qmd"),
             r'Edition [0-9.]+ · released [^\n·]+ · \[Changelog\]',
             f'Edition {ed} · released {date} · [Changelog]',
             "web landing edition line")

    # 3. ePub colophon line
    sub_once(os.path.join(q, "index.qmd"),
             r'\*\*Edition [0-9.]+\*\* — released [^\n*]+\.',
             f'**Edition {ed}** — released {date}.',
             "ePub colophon edition line")

    # 4. prepend a Changelog entry (newest first)
    cl = os.path.join(q, "changelog.qmd")
    s = open(cl, encoding="utf-8").read()
    m = re.search(r'(?m)^\*\*Edition ', s)
    if not m:
        sys.exit(f"ERROR: no existing '**Edition …' entry to prepend before in {cl}.")
    bullets = "".join(f"\n- {n}" for n in a.note)
    entry = f"**Edition {ed}** — released {date}.{bullets}\n\n"
    open(cl, "w", encoding="utf-8").write(s[:m.start()] + entry + s[m.start():])
    print(f"  prepended Changelog entry for Edition {ed}")

    print(f"Bumped to Edition {ed} ({date}).")
    if not a.note:
        print("note: no --note bullets given — add a short summary of what "
              "changed to quarto/changelog.qmd.")


if __name__ == "__main__":
    main()
