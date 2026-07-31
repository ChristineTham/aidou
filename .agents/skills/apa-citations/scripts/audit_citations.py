#!/usr/bin/env python3
"""Audit Markdown citations for common problems. Advisory; changes nothing.

Flags, per file (body = everything before "## References"):
  * internal-download links  — hrefs to local files (`](../x.md)`, `](foo.pdf)`)
    instead of an original source (URL/DOI/arXiv);
  * in-text citations whose URL has no entry in the References section;
  * References entries never cited in the body (orphans);
  * square brackets inside a link's visible text (breaks Markdown links).

Some findings are long-standing and deliberate — this book cites the author's own
project repos inline, which look like uncited URLs. Those fire on every run and
make it easy to miss a NEW problem in the noise, so `--baseline` re-runs the same
audit against a git revision and reports only what the working tree added.

Usage:
    audit_citations.py chapters/*.md
    audit_citations.py --heading References chapters/*.md
    audit_citations.py --baseline HEAD book/*.md      # only NEW issues
"""
import re, argparse, subprocess

LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
CITE = re.compile(r"\[([^\]]*)\]\((https?://[^)]+|[^)]+\.md|[^)]+\.pdf)\)")


def audit_text(path, text, heading):
    """Return this file's findings as a list of strings. Pure — prints nothing,
    so the same code can audit the working tree and a git revision."""
    found = []
    marker = f"## {heading}"
    body, _, refs = text.partition(marker)
    body_urls = set(re.findall(r"\]\((https?://[^)]+)\)", body))
    ref_urls = set(re.findall(r"\]\((https?://[^)]+)\)", refs))

    # `(?<!!)` skips Markdown image embeds — `![alt](../images/x.svg)` is a
    # figure, not a citation, so a relative image path must not be flagged.
    for m in re.finditer(r"(?<!!)\[[^\]]*\]\((?!https?://)([^)]*\.(?:md|pdf)|\.\.?/[^)]+)\)", body):
        found.append(f"{path}: internal link (cite an original source): {m.group(1)}")
    for m in re.finditer(r"\[[^\]]*\[[^\]]*\]\((https?://[^)]+)\)", body):
        found.append(f"{path}: square brackets in link text near {m.group(1)}")
    if marker in text:
        for u in sorted(body_urls - ref_urls):
            found.append(f"{path}: cited in body but missing from References: {u}")
        for u in sorted(ref_urls - body_urls):
            found.append(f"{path}: in References but never cited: {u}")
    else:
        found.append(f"{path}: no '## {heading}' section")
    return found


def git_show(rev, path):
    """File contents at a git revision, or None if it does not exist there."""
    r = subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else None


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--heading", default="References")
    ap.add_argument("--baseline", metavar="REV",
                    help="report only issues that are NOT already present at this "
                         "git revision (e.g. HEAD) — hides long-standing findings")
    ap.add_argument("files", nargs="+")
    a = ap.parse_args()

    findings = []
    for path in a.files:
        findings += audit_text(path, open(path, encoding="utf-8").read(), a.heading)

    if a.baseline:
        baseline = set()
        for path in a.files:
            old = git_show(a.baseline, path)
            if old is not None:
                baseline.update(audit_text(path, old, a.heading))
        new = [f for f in findings if f not in baseline]
        for f in new:
            print(f)
        carried = len(findings) - len(new)
        note = f" ({carried} pre-existing at {a.baseline}, not shown)" if carried else ""
        print(f"\n{len(new)} new issue(s) found{note}." if new else f"\nNo new issues{note}.")
        return 1 if new else 0

    for f in findings:
        print(f)
    print(f"\n{len(findings)} issue(s) found." if findings else "\nNo issues found.")
    return 1 if findings else 0


if __name__ == "__main__":
    raise SystemExit(main())
