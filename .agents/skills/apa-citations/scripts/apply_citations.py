#!/usr/bin/env python3
"""Apply APA-7 hyperlinked citations and per-chapter References to Markdown.

Data-driven and portable: the source list lives in a JSON file (see
`references.json`), so this engine works for any book/project.

Each source entry: {"urls": [...], "intext": "Author, Year",
"reference": "<full APA entry, title in *italics*>", "title_authored": bool}.

Behaviour, per file:
  * The FIRST mention of a source gets author + *title* + year (drawn from the
    reference's first italic span); LATER mentions get the plain `intext` label.
  * Title-authored works (e.g. Wikipedia, "title_authored": true) keep the short
    form on every mention.
  * Several URLs may share one reference (deduped in the list).
  * A trailing "## References" section is regenerated: the cited sources,
    alphabetised.

Only the visible text of `[...](url)` links is rewritten; the URL is untouched,
so run it repeatedly (idempotent).

Usage:
    apply_citations.py --refs references.json chapters/*.md
"""
import re, json, argparse


def sortkey(s):
    return re.sub(r'[*_\[\]"“”]', "", s).lstrip().lower()


def long_label(short, reference, title_authored):
    if title_authored:
        return short
    m = re.search(r"\*(.+?)\*", reference)
    if not m:
        return short
    author, sep, year = short.rpartition(", ")
    if not sep:
        return short
    return f"{author}, *{m.group(1)}*, {year}"


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--refs", required=True, help="path to references JSON")
    ap.add_argument("--heading", default="References", help="references section title")
    ap.add_argument("files", nargs="+", help="Markdown files to process")
    a = ap.parse_args()

    entries = json.load(open(a.refs, encoding="utf-8"))
    url2 = {}
    for e in entries:
        for u in e["urls"]:
            url2[u] = (e["intext"], e["reference"], e.get("title_authored", False))

    for path in a.files:
        text = open(path, encoding="utf-8").read()
        marker = f"## {a.heading}"
        if marker in text:
            text = text[: text.index(marker)].rstrip() + "\n"
        used = set()
        for url, (short, reference, ta) in url2.items():
            longlbl = long_label(short, reference, ta)
            pat = re.compile(r"\[[^\]]*\]\(" + re.escape(url) + r"\)")
            cnt = {"n": 0}

            def repl(m, url=url, short=short, longlbl=longlbl, cnt=cnt):
                cnt["n"] += 1
                used.add(url)
                return f'[{longlbl if cnt["n"] == 1 else short}]({url})'

            text = pat.sub(repl, text)
        if used:
            refs = sorted({url2[u][1] for u in used}, key=sortkey)
            text = text.rstrip() + f"\n\n## {a.heading}\n\n" + "\n\n".join(refs) + "\n"
        open(path, "w", encoding="utf-8").write(text)
        n_refs = len({url2[u][1] for u in used})
        print(f"{path}: {len(used)} sources, {n_refs} references")


if __name__ == "__main__":
    main()
