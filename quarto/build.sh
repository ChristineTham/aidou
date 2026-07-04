#!/usr/bin/env bash
# Build (or preview) the book: regenerate Quarto chapters from ../book, then run Quarto.
#   ./build.sh            -> render HTML + PDF + ePub into _book/
#   ./build.sh preview    -> live preview (re-run after editing book/*.md)
set -euo pipefail
cd "$(dirname "$0")"
# Let Typst find the bundled Spectral fonts (same files _brand.yml gives the HTML).
export TYPST_FONT_PATHS="$(pwd)/fonts"
python3 ../.claude/skills/book-build/scripts/build_site.py --book ../book --out .
# Generate the per-format blurb partials (_blurb.md, _blurb.typ) from blurb.json
# before render — Quarto resolves {{< include >}} before its pre-render hooks run.
python3 ../.claude/skills/book-build/scripts/gen_blurb.py .
quarto "${1:-render}"
