---
name: book-build
description: 'Build and publish the book from one Markdown source to a GitHub Pages website, a print-quality PDF, and a reflowable ePub, using Quarto. Covers regenerating the Quarto pages from book/*.md, local render/preview, Mermaid + GFM-alert + numbering handling, and the GitHub Actions deploy. Use when rendering, previewing, exporting, or deploying the book.'
argument-hint: 'Say whether to render, preview, or deploy, and which formats.'
user-invocable: true
---

# Build & publish the book

The production pipeline is **Quarto**: one Markdown source (`book/*.md`) → an HTML
site (GitHub Pages) + a **PDF** (Typst) + a reflowable **ePub**, with the site
offering the PDF/ePub as downloads. The Quarto project lives in `quarto/`.

## Single source → three formats

`book/*.md` stays canonical. A generator turns it into Quarto pages; nothing in
`book/` is edited.

- **`scripts/build_site.py`** — reads `book/*.md`, writes `quarto/*.qmd`:
  lifts the `# ` heading to the page title; strips our manual `1.1` section
  numbers so **Quarto numbers natively** (consistent across all formats, working
  cross-refs); marks `## References` unnumbered; converts `> [!NOTE]` alerts to
  native `::: {.callout-note}`; converts ```mermaid fences to executable
  ```{mermaid} cells with `htmlLabels:false` (so the ePub gets clean vector SVG
  and the PDF a clean PNG).
- **`quarto/build.sh`** — convenience: runs the generator, then `quarto render`
  (or `./build.sh preview`).

The generated `quarto/*.qmd` are **gitignored** (ephemeral); `quarto/index.qmd`
(the cover) is hand-authored and kept.

## Build locally

```bash
cd quarto
./build.sh            # generate + render HTML + PDF + ePub into quarto/_book/
./build.sh preview    # live preview (re-run after editing book/*.md)
```

Outputs: `quarto/_book/index.html` (+ chapters), `quarto/_book/ai-do.pdf`,
`quarto/_book/ai-do.epub`.

## Diagram fidelity (Mermaid)

- **HTML** — client-side SVG (vector), rendered by the browser.
- **PDF and ePub** — PNG raster, rendered by headless Chrome at build time.

SVG (vector) for the PDF/ePub is **not viable through this toolchain**: Quarto
does not expose Mermaid's `htmlLabels:false`, so Mermaid emits SVG whose node
labels are HTML (`foreignObject`/`<p>`). Typst's SVG parser rejects that, and
e-readers render it inconsistently. A genuinely vector PDF needs the **LaTeX**
PDF engine plus `rsvg-convert` (librsvg) or Inkscape to convert the SVGs — those
install cleanly on the CI Ubuntu runner (`apt-get install librsvg2-bin`) but not
on a stock macOS without Homebrew, so PNG is the reliable default.

### Diagram sizing (smart scaling)

Quarto renders every Mermaid PNG at the same high effective density and tags it
at a natural size whose on-page **text is much larger than the body text** (and
often wider than the page). Because the density is uniform, one factor normalises
diagram text to roughly body size across all diagrams.

- **PDF** — a `#show image` rule in `quarto/typst-fonts.typ` multiplies each
  diagram by `diagram-scale` (≈0.55, calibrated so diagram labels ≈ body text),
  then caps the result at the text-column width — whichever comes first. The
  full-page cover image is exempted (identified by height ≥ 8.5in). Without this,
  narrow diagrams escape any width cap and render comically large.
- **ePub / HTML** — need no scaling: e-readers treat the tagged `in` as 96px and
  cap at the container (`epub.css` `img{max-width:100%}`), and the HTML site
  renders Mermaid as vector SVG whose text already ≈ body. Both land near body
  size on their own; only the Typst PDF needs the explicit factor.

To recalibrate: render `--to typst`, screenshot a page with a narrow diagram, and
adjust `diagram-scale` until the labels match body text.

## Design & theme (Rosely)

One design spans the website, PDF, and ePub, driven by Quarto's cross-format
brand system:

- **`quarto/_brand.yml`** — the [Rosely](https://rosely.hellotham.com) palette
  (warm millennial-pink/purple: cream surfaces, velvet ink, purple primary, rose
  links) plus the **Spectral** serif. Quarto applies it to **both HTML and the
  Typst PDF**.
- **Fonts** are self-hosted in `quarto/fonts/` (Spectral TTFs, OFL). HTML gets
  them via `_brand.yml`; the Typst PDF finds them because `build.sh` (and CI)
  export `TYPST_FONT_PATHS=fonts`.
- **`quarto/brand.scss`** — HTML polish only (reading measure, warm section
  rules, Rosely-tinted callouts, tables, blockquotes, code, and the download
  buttons). Palette/fonts stay in `_brand.yml`.
- **`quarto/epub.css`** — Rosely colours for the ePub (e-readers usually control
  the font, so Spectral is set with a serif fallback).
- **Separate download buttons**: two pill buttons (PDF + ePub) on the landing
  page (`index.qmd`, styled in `brand.scss`), plus separate PDF/ePub tool icons
  in the sidebar (`book: sidebar: tools:` in `_quarto.yml`).

## Cache-busting the downloads

The PDF and ePub live at stable URLs (`ai-do.pdf`, `ai-do.epub`), which
browsers and the GitHub Pages CDN cache — so readers can get a stale file after
a redeploy. A Quarto **`project: post-render`** step runs
`scripts/cachebust.py`, which appends a short content-hash query
(`ai-do.pdf?v=<md5>`) to every download link in the rendered HTML. The hash
changes only when the file's bytes change, so each new build yields a fresh URL
that no cache can match. It runs on every `quarto render` (local and CI) — no
extra wiring.

## Cover

`quarto/cover.html` is a typographic cover; `quarto/cover.png` (1600×2400) is
rasterised from it with headless Chrome and wired in via `book: cover-image`.
Regenerate after edits:
`"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --screenshot=cover.png --window-size=800,1200 --force-device-scale-factor=2 file://$PWD/cover.html`

## Requirements

- **Quarto** (bundles Typst — no LaTeX needed for the PDF).
- **Headless Chrome** for Mermaid rasterisation in the PDF: `quarto install chrome-headless-shell`.
- **Python 3** for the generator.
- Fonts: bundled in `quarto/fonts/` (no install). `build.sh` exports `TYPST_FONT_PATHS=fonts` so Typst finds them.

## Deploy to GitHub Pages

`.github/workflows/deploy.yml` runs on push to `main`: set up Python + Quarto +
Chrome, run the generator, `quarto render`, then `upload-pages-artifact` +
`deploy-pages`. Publishes to `https://christinetham.github.io/aidou/`.

**One-time manual step:** repo **Settings → Pages → Source: "GitHub Actions"**.

## Legacy

`scripts/build_pdf.py` is the older standalone single-file PDF (Markdown →
HTML → headless-browser print), kept for a quick one-off PDF. The Quarto
pipeline supersedes it for the site, PDF, and ePub.

> [!TIP]
> Mirror any change to both `.github/skills/book-build` (Copilot) and `.claude/skills/book-build` (Claude).
