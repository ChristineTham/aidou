#!/usr/bin/env bash
# Build (or preview) the book: regenerate Quarto chapters from ../book, then run Quarto.
#   ./build.sh            -> render HTML + PDF + ePub into _book/
#   ./build.sh preview    -> live preview (re-run after editing book/*.md)
set -euo pipefail
cd "$(dirname "$0")"
python3 ../.claude/skills/book-build/scripts/build_site.py --book ../book --out .
quarto "${1:-render}"
