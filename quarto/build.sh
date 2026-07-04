#!/usr/bin/env bash
# Build (or preview) the book: regenerate Quarto chapters from ../book, then run Quarto.
#   ./build.sh            -> render HTML + PDF + ePub into _book/
#   ./build.sh preview    -> live preview (re-run after editing book/*.md)
set -euo pipefail
cd "$(dirname "$0")"
# Let Typst find the bundled Spectral fonts (same files _brand.yml gives the HTML).
export TYPST_FONT_PATHS="$(pwd)/fonts"
# Generate design-token files (_brand.yml, _tokens.*) from theme.yml first, so
# build_site (chapter accents) and the render (SCSS/CSS/Typst) can consume them.
python3 ../.claude/skills/book-build/scripts/gen_theme.py .
python3 ../.claude/skills/book-build/scripts/build_site.py --book ../book --out .
# Generate the landing partials (_blurb.*, _epigraph.md) from book/blurb.md and
# book/epigraph.md before render — Quarto resolves {{< include >}} before pre-render hooks.
python3 ../.claude/skills/book-build/scripts/gen_blurb.py .
quarto "${1:-render}"
