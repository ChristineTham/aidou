#!/usr/bin/env python3
"""PreToolUse hook: refuse edits to files the build regenerates.

Almost everything under `quarto/` is produced by `build_site.py` from `book/`,
`theme.yml` and `images/`, and is git-ignored. Editing a generated file looks
like it works and is silently destroyed by the next build - the change is gone
and the real source was never touched.

A handful of files under `quarto/` ARE hand-authored and git-kept; those are
listed in KEEP below and edit normally.

Reads the tool call as JSON on stdin. Exit 2 blocks the call and returns the
message on stderr to Claude; exit 0 allows it.
"""
from __future__ import annotations

import json
import os
import sys

# Hand-authored, git-kept files under quarto/ - safe to edit.
KEEP = {
    "quarto/index.qmd",
    "quarto/changelog.qmd",
    "quarto/_quarto.yml",
    "quarto/brand.scss",
    "quarto/epub.css",
    "quarto/typst-show.typ",
    "quarto/typst-fonts.typ",
    "quarto/typst-lists.typ",
    "quarto/_tokens.typ",
    "quarto/build.sh",
}

GENERATED_DIRS = ("quarto/_book/", "quarto/.quarto/", "quarto/site_libs/")


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0  # never block on a malformed payload

    ti = payload.get("tool_input") or {}
    path = ti.get("file_path") or ti.get("path") or ""
    if not path:
        return 0

    try:
        rel = os.path.relpath(path, os.getcwd())
    except ValueError:
        return 0
    rel = rel.replace(os.sep, "/")

    if not rel.startswith("quarto/"):
        return 0
    if rel in KEEP:
        return 0
    if rel.startswith(GENERATED_DIRS) or rel.endswith((".qmd", ".typ", ".md", ".json", ".html")):
        print(
            "Refusing to edit " + rel + ": the build regenerates everything under "
            "quarto/ except " + ", ".join(sorted(KEEP)) + ".\n"
            "Edit the real source instead - chapter text lives in book/*.md, design "
            "tokens in theme.yml, art in images/ - then run `cd quarto && ./build.sh`.",
            file=sys.stderr,
        )
        return 2

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
