#!/usr/bin/env python3
"""Flag likely American spellings in a book chapter, with line numbers.

The review-chapter spelling pass must not be eyeballed — a reviewer scanning
prose reliably misses `judgment` for `judgement` or `toward` for `towards`.
This script greps for the high-signal American forms so nothing slips through.

It reports *candidates*, not verdicts: matches inside fenced code are skipped,
but matches inside quoted paper titles or proper names (e.g. Rosenblatt's
"…organization in the brain", an API name) are still reported — the reviewer
judges those and leaves them verbatim. Better a false positive the human
dismisses than a real slip that ships.

Usage: python check_australian_spelling.py book/01-foundations.md
Exit code 0 always; the finding list is the output.
"""
import re
import sys

# Explicit American -> Australian/British forms this book standardises on.
WORD_MAP = {
    "judgment": "judgement", "judgments": "judgements",
    "toward": "towards", "afterward": "afterwards", "backward": "backwards",
    "forward": None,  # 'forward' is fine; only 'toward/afterward/backward' take the s
    "color": "colour", "colors": "colours", "colored": "coloured", "coloring": "colouring",
    "behavior": "behaviour", "behaviors": "behaviours", "behavioral": "behavioural",
    "favor": "favour", "favors": "favours", "favored": "favoured", "favorite": "favourite",
    "honor": "honour", "labor": "labour", "neighbor": "neighbour", "flavor": "flavour",
    "humor": "humour", "rumor": "rumour", "harbor": "harbour", "endeavor": "endeavour",
    "center": "centre", "centers": "centres", "centered": "centred",
    "meter": "metre", "meters": "metres", "liter": "litre", "theater": "theatre",
    "fiber": "fibre", "caliber": "calibre",
    "defense": "defence", "offense": "offence", "license": "licence (noun) / license (verb)",
    "practice": "practise (verb) / practice (noun)",
    "gray": "grey",
    "catalog": "catalogue", "catalogs": "catalogues", "dialog": "dialogue", "analog": "analogue",
    "traveler": "traveller", "traveling": "travelling", "traveled": "travelled",
    "modeling": "modelling", "modeled": "modelled",
    "labeling": "labelling", "labeled": "labelled",
    "canceled": "cancelled", "canceling": "cancelling",
    "fulfil": "fulfil", "enrollment": "enrolment",
    "artifact": "artefact", "artifacts": "artefacts",
    "maneuver": "manoeuvre",
}
# 'forward' is legitimate; drop the placeholder.
WORD_MAP = {k: v for k, v in WORD_MAP.items() if v is not None}

# -ize/-yze family: this book uses -ise/-yse. Match the suffix, allow genuine -ize words.
IZE_RE = re.compile(r"\b([A-Za-z]{3,}?(?:iz|yz)(?:e|es|ed|ing|ation|ations|er|ers))\b", re.I)
IZE_ALLOW = {
    "size", "sizes", "sized", "sizing", "resize", "resized", "resizes", "resizing",
    "downsize", "downsized", "downsizing", "upsize", "oversize", "oversized",
    "prize", "prizes", "prized", "seize", "seizes", "seized", "seizing", "capsize",
    "capsized", "maize", "assize", "midsize",
}


def scan(path):
    hits = []
    in_fence = False
    with open(path, encoding="utf-8") as f:
        for n, line in enumerate(f, 1):
            if line.lstrip().startswith("```"):
                in_fence = not in_fence
                continue
            if in_fence:
                continue
            low = line.lower()
            for us, au in WORD_MAP.items():
                for m in re.finditer(rf"\b{re.escape(us)}\b", low):
                    hits.append((n, line[m.start():m.end()].strip() or us, au))
            for m in IZE_RE.finditer(line):
                w = m.group(1)
                if w.lower() in IZE_ALLOW:
                    continue
                au = re.sub(r"iz", "is", w, flags=re.I)
                au = re.sub(r"yz", "ys", au, flags=re.I)
                hits.append((n, w, au))
    return hits


def main():
    if len(sys.argv) != 2:
        print("usage: check_australian_spelling.py <chapter.md>", file=sys.stderr)
        return 2
    hits = scan(sys.argv[1])
    if not hits:
        print("No American spelling candidates found.")
        return 0
    print(f"{len(hits)} candidate(s) — CHECK EACH: skip any inside a quoted title, "
          f"proper name, or code identifier; fix the rest.\n")
    for n, word, au in sorted(hits):
        print(f"  line {n}: {word!r} -> {au}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
