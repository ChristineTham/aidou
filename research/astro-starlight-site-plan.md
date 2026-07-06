# Plan: Publish AI-dō as an Astro Starlight site on GitHub Pages

> Saved plan (not yet executed). Approach chosen: Astro Starlight, multi-page, deployed to GitHub Pages. Source of truth stays `book/*.md`; site content is generated.

## Context

The book currently exists only as Markdown chapters in `book/` and a locally-built PDF (`dist/AI-do.pdf`). The author wants a web version on GitHub Pages, multi-page, that renders the two things the chapters rely on: **GFM alerts** (`> [!NOTE]` — 18 across the book) and **Mermaid diagrams** (15 blocks). The author chose **Astro Starlight**, which supports both via plugins and has a canonical GitHub Pages deploy path.

**Key constraint:** `book/*.md` stays the single source of truth (the PDF build and the whole authoring/citation/numbering toolchain read those files). The site's content is **generated** from `book/` by a small sync script, not hand-edited — so the site never diverges from the book.

Facts confirmed by exploration: repo is `github.com/ChristineTham/aidou` → project Pages URL `https://christinetham.github.io/aidou/` (base `/aidou`). No existing Node/Astro tooling. Chapters have no local images or assets (only external citation URLs and prose cross-references), so nothing extra needs bundling.

## Approach

Add a self-contained Astro Starlight project in a `site/` subdirectory (keeps Node artefacts out of the repo root). Generate one Starlight page per chapter from `book/` via a new `build_site.py`, commit the generated content, and deploy with the standard `withastro/action` workflow. Committing the generated content keeps CI to the exact canonical Astro workflow (no Python step in CI) and fits the repo's existing "run scripts, then commit" ritual (citations, numbering). `build_site.py` becomes part of that ritual.

Plugins (from research):
- **Mermaid:** `astro-mermaid` + `mermaid`, `theme: 'neutral'` (matches the book), `autoTheme: true`. **Must be listed before `starlight` in `integrations`.**
- **GFM alerts:** `starlight-github-alerts` (Starlight plugin) — converts `> [!NOTE]/[TIP]/[IMPORTANT]/[WARNING]/[CAUTION]` into theme-aware Starlight asides, no CSS needed.

## Files to create

### 1. `site/` — Astro Starlight project
Scaffold with the Starlight template (`npm create astro@latest site -- --template starlight`), then:

- **`site/package.json`** — add deps: `astro-mermaid`, `mermaid`, `starlight-github-alerts` (template already brings `astro`, `@astrojs/starlight`).
- **`site/astro.config.mjs`** — the integration + deploy config:
  ```js
  import { defineConfig } from 'astro/config';
  import mermaid from 'astro-mermaid';
  import starlight from '@astrojs/starlight';
  import starlightGithubAlerts from 'starlight-github-alerts';

  export default defineConfig({
    site: 'https://christinetham.github.io',
    base: '/aidou',
    integrations: [
      mermaid({ theme: 'neutral', autoTheme: true }),   // MUST precede starlight
      starlight({
        title: 'AI-dō',
        plugins: [starlightGithubAlerts()],
        sidebar: [
          { label: 'Preface', slug: 'preface' },
          { label: '1 · Foundations', slug: 'foundations' },
          { label: '2 · Personal Productivity', slug: 'productivity' },
          { label: '3 · Software Development', slug: 'software-development' },
          { label: '4 · Engineering Disciplines', slug: 'engineering-disciplines' },
          { label: '5 · Responsibility & Governance', slug: 'governance' },
          { label: '6 · Mastery & Forward Practice', slug: 'mastery' },
        ],
        social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/ChristineTham/aidou' }],
      }),
    ],
  });
  ```
- **`site/src/content/docs/index.mdx`** — hand-authored splash landing page (`template: splash`, hero with tagline + "Start reading" action → `preface`), adapted from `README.md`'s "Start here" / "Why read it". Committed; not overwritten by the sync.
- **`site/src/content/docs/*.md`** — the 7 chapter pages, **generated** by `build_site.py` (see below): `preface.md`, `foundations.md`, `productivity.md`, `software-development.md`, `engineering-disciplines.md`, `governance.md`, `mastery.md`.

### 2. `.agents/skills/book-build/scripts/build_site.py` (+ mirror to `.agents/skills/...`)
Portable Python sync, consistent with the other book-build scripts. For each source chapter it:
- reads the file, lifts the first `# ` line as the page **title** (Starlight renders the frontmatter title as the H1), and **removes that H1 line** to avoid a duplicate heading;
- writes `site/src/content/docs/<slug>.md` with frontmatter `--- title: "<H1 text>" ---` followed by the unchanged body (alerts, ```mermaid, tables, and the `## References` section pass through untouched);
- maps `book/00-title.md` out (its role is replaced by the splash landing page).

Mapping (source → slug):
`00-preface → preface`, `01-foundations → foundations`, `02-productivity → productivity`, `03-software-development → software-development`, `04-engineering-disciplines → engineering-disciplines`, `05-governance → governance`, `06-mastery → mastery`.

CLI mirrors the other scripts: `python build_site.py --book book --out site/src/content/docs`.

### 3. `.github/workflows/deploy.yml`
Canonical Astro→Pages workflow, pointed at the subdir:
```yaml
name: Deploy site to GitHub Pages
on: { push: { branches: [main] }, workflow_dispatch: {} }
permissions: { contents: read, pages: write, id-token: write }
concurrency: { group: pages, cancel-in-progress: false }
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: withastro/action@v6
        with: { path: ./site }
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: { name: github-pages, url: '${{ steps.deployment.outputs.page_url }}' }
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

### 4. `.gitignore` (create at repo root)
Ignore Node build artefacts: `site/node_modules/`, `site/dist/`, `site/.astro/`.

## Files to modify

- **`README.md`** — add a one-line "Read it online" link to `https://christinetham.github.io/aidou/` near the top; note in the contributors `<details>` that `build_site.py` regenerates the site content and is part of the edit ritual.
- **`.agents/skills/book-build/SKILL.md`** (+ `.github` mirror) — document `build_site.py` and the Starlight/Pages setup alongside the existing PDF build.

## Manual step (author, one-time; the agent cannot do this)
Repo **Settings → Pages → Source: "GitHub Actions"**. First push to `main` then triggers the build and publishes to `https://christinetham.github.io/aidou/`.

## Assumption
This targets a **project page** at `/aidou` (hence `base: '/aidou'`). If a custom domain or a `christinetham.github.io` user repo is used later, set `base: '/'` and add a `CNAME`. Flag before deploying if either is intended.

## Verification
1. **Local dev:** `cd site && npm install && python3 ../.agents/skills/book-build/scripts/build_site.py --book ../book --out src/content/docs && npm run dev` → open `http://localhost:4321/aidou/`.
   - Landing (splash) renders; sidebar lists Preface + 6 chapters in order; a chapter opens with its title as H1 and no duplicate heading.
   - **Mermaid:** all 15 diagrams render (spot-check the flowcharts in Foundations and the ICE diagram in Software Development); toggling dark/light re-themes them.
   - **Alerts:** `> [!NOTE]/[TIP]/[IMPORTANT]` render as styled asides (18 total).
   - Tables, fenced code, right-hand heading TOC, and each chapter's References links all work.
2. **Production build:** `npm run build && npm run preview` — confirm no build errors and the `base: /aidou` links resolve under preview.
3. **Deploy:** after enabling Pages (Source: GitHub Actions), push to `main`; confirm the Action succeeds and the live URL renders diagrams + alerts.

## Out of scope
No change to `book/*.md` content, the PDF build, or the citation/numbering pipeline. The site is a new, generated view of the existing book.
