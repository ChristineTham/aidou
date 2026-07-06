#!/usr/bin/env python3
"""Number Markdown section headings as N.M / N.M.K, one file per chapter.

  ## Foo   -> ## <chapter>.<section> Foo
  ### Bar  -> ### <chapter>.<section>.<subsection> Bar

The chapter number N comes from the first run of digits in the filename
(`01-foundations.md` -> 1); use --sequential to number files 1..n in argument
order instead. The `# ` chapter title and a named back-matter section
(default "References") stay unnumbered. Headings inside ``` / ~~~ code fences
are skipped. Existing numbers are stripped first, so it is idempotent and safe
to re-run after inserting, removing, or reordering sections.

Usage:
    number_headings.py book/0[1-6]*.md
    number_headings.py --sequential --skip References part*/*.md
"""
import re, argparse, os


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("files", nargs="+")
    ap.add_argument("--skip", default="References", help="section title to leave unnumbered")
    ap.add_argument("--sequential", action="store_true",
                    help="number files by argument order rather than filename digits")
    a = ap.parse_args()

    for i, path in enumerate(a.files, 1):
        if a.sequential:
            chap = i
        else:
            m = re.search(r"\d+", os.path.basename(path))
            chap = int(m.group(0)) if m else i
        lines = open(path, encoding="utf-8").read().split("\n")
        out, infence, sec, sub = [], False, 0, 0
        for ln in lines:
            s = ln.lstrip()
            if s.startswith("```") or s.startswith("~~~"):
                infence = not infence
                out.append(ln)
                continue
            m = None if infence else re.match(r"^(#{2,3}) (.*)$", ln)
            if not m:
                out.append(ln)
                continue
            hashes = m.group(1)
            title = re.sub(r"^\d+(?:\.\d+)*\s+", "", m.group(2))
            if len(hashes) == 2:
                if title.strip() == a.skip:
                    out.append(f"## {title}")
                    continue
                sec += 1
                sub = 0
                out.append(f"## {chap}.{sec} {title}")
            else:
                sub += 1
                out.append(f"### {chap}.{sec}.{sub} {title}")
        open(path, "w", encoding="utf-8").write("\n".join(out))
        print(f"{path}: chapter {chap} numbered ({sec} sections)")


if __name__ == "__main__":
    main()
