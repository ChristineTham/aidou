---
name: book-build
description: 'Build and publish the book from one Markdown source to a GitHub Pages website, a print-quality PDF, and a reflowable ePub, using Quarto. Covers where content/art/tokens live (book/, images/, theme.yml), regenerating the Quarto pages, local render/preview, Mermaid + GFM-alert + numbering handling, cover and chapter-art generation, and the GitHub Actions deploy. Use when rendering, previewing, exporting, deploying, or restyling the book.'
---

# Build & publish the book

The production pipeline is **Quarto**: one Markdown source → an HTML site (GitHub
Pages) + a **PDF** (Typst) + a reflowable **ePub**, the site offering the PDF/ePub
as downloads. The Quarto project lives in `quarto/` and holds **only the
pipeline** — config, templates, `build.sh`, and fonts. All authored content,
art, and design tokens live outside it:

| Where | What (edit these) |
| --- | --- |
| `book/*.md` | the chapters (`00-preface` … `06-mastery`), plus `blurb.md` and `epigraph.md` |
| `images/` | `cover.svg` / `cover.png`, and `chapter-art/` (banner SVGs + PNGs) |
| `theme.yml` (repo root) | design tokens: palette, colour roles, type sizes, fonts, per-chapter accents |

Everything the build writes into `quarto/` is generated and **git-ignored**
(the `*.qmd`, `_brand.yml`, `_tokens.*`, `_blurb.*`, `_epigraph.md`, `cover.png`,
`chapter-art/`). The one hand-authored file kept in `quarto/` is `index.qmd`, the
landing *template* (thin glue that `{{< include >}}`s the epigraph and blurb).

## Build order

`build.sh` (and CI) run these before `quarto render`, in this order:

1. **`scripts/gen_theme.py`** — `theme.yml` → `_brand.yml`, `_tokens.scss`,
   `_tokens.css`, `_tokens.typ`, `_tokens.json` (see *Design & theme*).
2. **`scripts/build_site.py`** — `book/*.md` → `quarto/*.qmd`, and copies the
   rasters the renderer needs (`cover.png`, `chapter-art/*.png`) in from
   `images/`. It lifts the `# ` heading to the page title; strips manual `1.1`
   section numbers so **Quarto numbers natively**; marks `## References`
   unnumbered; converts `> [!NOTE]` alerts to `::: {.callout-note}`; converts
   ```` ```mermaid ```` fences to executable ```` ```{mermaid} ```` cells; and
   injects each chapter's banner (and the preface/front-matter band) under the
   title, with the PDF title accent read from `_tokens.json`.
3. **`scripts/gen_blurb.py`** — `book/blurb.md` + `book/epigraph.md` → the
   landing/back-cover partials (see *Back cover & epigraph*). Runs *before*
   render because Quarto resolves `{{< include >}}` before its own pre-render
   hooks.

Then post-render (`project: post-render` in `_quarto.yml`): `epub_fix.py` →
`epub_backcover.py` → `cachebust.py`.

## Build locally

```bash
cd quarto
./build.sh            # generate + render HTML + PDF + ePub into quarto/_book/
./build.sh preview    # live preview (re-run after editing sources)
```

Outputs: `quarto/_book/index.html` (+ chapters), `quarto/_book/ai-do.pdf`,
`quarto/_book/ai-do.epub`.

## Design & theme (tokens in `theme.yml`)

**`theme.yml` at the repo root is the single, user-editable source** for the
[Rosely](https://rosely.hellotham.com) palette, colour roles (primary/link/…),
type sizes, font families, and per-chapter accent assignments. Change a colour or
a font size there and nowhere else. `gen_theme.py` (dependency-free; a minimal
YAML reader) turns it into every format's token file — all git-ignored:

- **`_brand.yml`** — Quarto brand: palette + roles + typography. Quarto applies
  it to **both HTML and the Typst PDF**. (The font *file* list is pipeline detail
  inside `gen_theme.py`; the *families* come from `theme.yml`.)
- **`_tokens.scss`** — `$r-*`, `$font-size-root`, … layered ahead of
  `brand.scss` via `theme: [_tokens.scss, brand.scss]` in `_quarto.yml`.
- **`_tokens.css`** — `:root { --r-*: … }`, bundled into the ePub via
  `epub: css: [_tokens.css, epub.css]`.
- **`_tokens.typ`** — Typst colour lets (`c-*`), `#import`-ed by the Typst
  templates.
- **`_tokens.json`** — palette + chapter accents, read by the Python scripts
  (`build_site.py`, `gen_blurb.py`, `gen_chapter_art.py`), each with a fallback.

Fonts are self-hosted in `quarto/fonts/`: **Noto Serif** (body) + **Raleway**
(headings), with **Noto Serif JP / Noto Sans JP** fallbacks so 愛 / 道 render.
Typst finds them because `build.sh` and CI export `TYPST_FONT_PATHS=fonts`.
`quarto/brand.scss` is HTML polish only (reading measure, section rules, tinted
callouts, tables, code, download buttons); `quarto/epub.css` is the ePub rules,
using `var(--r-*)`.

## Cover

Source of truth is **`images/cover.svg`** (self-contained: outlined glyph paths
+ a vector seigaiha pattern). The 道 / 愛 kanji are outlined from **KokuryuSou**
(Adobe brush face — see *Chapter art* for the licence/activation note); the
"AI" letters are outlined Raleway. To re-swap the kanji font, re-outline them
into the same on-canvas boxes and rewrite `cover.svg`. Rasterise to
`images/cover.png` (1600×2400) with
headless Chrome; the build copies `cover.png` into `quarto/` and wires it via
`book: cover-image` (+ `typst-show.typ` for the PDF full-bleed cover):

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless \
  --screenshot=images/cover.png --window-size=1600,2400 \
  --force-device-scale-factor=1 --hide-scrollbars "file://$PWD/images/cover.svg"
```

## Chapter art

Each chapter (and the preface/landing) opens with a thin "seigaiha tide" banner
— a wave ribbon in the chapter's accent colour with the chapter kanji reversed on
a cream moon. **`scripts/gen_chapter_art.py`** produces them into
`images/chapter-art/<slug>.svg` + `.png` (source of truth); `build_site.py` copies
the PNGs into `quarto/chapter-art/` and injects the banner under each title.

- Colours come from `theme.yml` via `_tokens.json` (`chapter-accents` +
  `front-matter-accent`); the slug→kanji map is content in the script.
- Kanji glyphs are **outlined** into self-contained SVG paths (no font dependency
  in the *output*) with **fontTools**, from **KokuryuSou** — a Japanese brush
  display face from **Adobe Fonts** (`KsoKokuryuSou`, Adobe-Japan1-4). It's
  licensed, so it isn't in the repo: **activate it in Creative Cloud** (see the
  README), which installs it under `~/Library/Application Support/Adobe/CoreSync/
  plugins/livetype/.r/` with a hashed filename. Outlined artwork and the
  rasterised PNGs are distributable under the Adobe desktop licence; the font
  file is not. (Body/heading text still uses Noto Serif / Raleway.)
- Regenerate (run `gen_theme.py` first so `_tokens.json` exists; find the font
  path via `system_profiler SPFontsDataType | grep -B2 -i kokuryu`):

```bash
python3 .claude/skills/book-build/scripts/gen_chapter_art.py \
  --font "$KOKURYU_OTF" --out images/chapter-art --png
```

## Back cover & epigraph

Both are authored as Markdown in `book/` and fanned out by `gen_blurb.py`:

- **`book/blurb.md`** — YAML frontmatter `description:` (→ the ePub
  `<dc:description>`) + a body of a lead paragraph, conviction bullets
  (`- **Label** — text.`), and a closing paragraph.
- **`book/epigraph.md`** — the landing teaser (prose only; the `.epigraph`
  styling wrapper stays in `index.qmd`).

`gen_blurb.py` writes `_blurb.md` (web `{{< include >}}`), `_blurb.typ` (PDF back
cover via `typst-back-cover.typ`), `_blurb.json` (read post-render by
`epub_backcover.py` for the ePub back-cover page + description), and `_epigraph.md`
(web landing include). All git-ignored.

## Diagram fidelity (Mermaid)

- **HTML** — client-side SVG (vector).
- **PDF and ePub** — PNG raster (headless Chrome at build time). SVG isn't viable
  here: Quarto doesn't expose Mermaid's `htmlLabels:false`, so its SVG carries
  HTML labels Typst can't parse and e-readers render inconsistently.

**Sizing:** a `#show image` rule in `quarto/typst-fonts.typ` scales each diagram
by `diagram-scale` (≈0.55, so labels ≈ body text), capped at the text-column
width; the full-page cover is exempt (height ≥ 8.5in). HTML/ePub need no scaling.
To recalibrate: render `--to typst`, screenshot a page with a narrow diagram, and
adjust `diagram-scale`.

## Cache-busting the downloads

`scripts/cachebust.py` (a `post-render` step) appends a content-hash query
(`ai-do.pdf?v=<md5>`) to every download link in the rendered HTML, so a redeploy
always yields a fresh URL the CDN can't serve stale.

## Requirements

- **Quarto** (bundles Typst — no LaTeX needed).
- **Headless Chrome** for Mermaid rasterisation: `quarto install chrome-headless-shell`.
- **Python 3** for the generators (no third-party packages; `gen_chapter_art.py`
  additionally needs `fonttools` + the full Noto Serif JP font).
- Fonts bundled in `quarto/fonts/`; `TYPST_FONT_PATHS=fonts` is exported by the build.

## Deploy to GitHub Pages

`.github/workflows/deploy.yml` runs on push to `main`: set up Python + Quarto +
Chrome, run `gen_theme.py` → `build_site.py` → `gen_blurb.py`, `quarto render`,
then `upload-pages-artifact` + `deploy-pages`. Publishes to
`https://christinetham.github.io/aidou/` (custom domain `christham.net/aidou`).
The GitHub Pages "Deployment failed, try again later" flake is intermittent —
re-run the failed job.

**One-time manual step:** repo **Settings → Pages → Source: "GitHub Actions"**.

## Legacy

`scripts/build_pdf.py` is the older standalone single-file PDF, kept for a quick
one-off. The Quarto pipeline supersedes it for the site, PDF, and ePub.

> [!TIP]
> Mirror any change to both `.github/skills/book-build` (Copilot) and `.claude/skills/book-build` (Claude).
