#!/usr/bin/env python3
"""Audit Markdown citations for common problems. Advisory; changes nothing.

Flags, per file (body = everything before "## References"):
  * internal-download links  — hrefs to local files (`](../x.md)`, `](foo.pdf)`)
    instead of an original source (URL/DOI/arXiv);
  * in-text citations whose URL has no entry in the References section;
  * References entries never cited in the body (orphans);
  * square brackets inside a link's visible text (breaks Markdown links).

Usage:
    audit_citations.py chapters/*.md
    audit_citations.py --heading References chapters/*.md
"""
import re, argparse

LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
CITE = re.compile(r"\[([^\]]*)\]\((https?://[^)]+|[^)]+\.md|[^)]+\.pdf)\)")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--heading", default="References")
    ap.add_argument("files", nargs="+")
    a = ap.parse_args()
    problems = 0
    for path in a.files:
        text = open(path, encoding="utf-8").read()
        marker = f"## {a.heading}"
        body, _, refs = text.partition(marker)
        body_urls = set(re.findall(r"\]\((https?://[^)]+)\)", body))
        ref_urls = set(re.findall(r"\]\((https?://[^)]+)\)", refs))

        for m in re.finditer(r"\[[^\]]*\]\((\.\.?/[^)]+|[^)]+\.md|[^)]+\.pdf)\)", body):
            print(f"{path}: internal link (cite an original source): {m.group(1)}")
            problems += 1
        for m in re.finditer(r"\[[^\]]*\[[^\]]*\]\((https?://[^)]+)\)", body):
            print(f"{path}: square brackets in link text near {m.group(1)}")
            problems += 1
        if marker in text:
            for u in sorted(body_urls - ref_urls):
                print(f"{path}: cited in body but missing from References: {u}")
                problems += 1
            for u in sorted(ref_urls - body_urls):
                print(f"{path}: in References but never cited: {u}")
                problems += 1
        else:
            print(f"{path}: no '## {a.heading}' section")
            problems += 1
    print(f"\n{problems} issue(s) found." if problems else "\nNo issues found.")
    return 1 if problems else 0


if __name__ == "__main__":
    raise SystemExit(main())
