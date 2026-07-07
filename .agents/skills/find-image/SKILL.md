---
name: find-image
description: >-
  Given a plain-language description, find the best-matching open-source illustration on undraw.co,
  recolour it to the book's Rosely palette, save it, and (if a section is named) place it in the book.
  Use whenever the user wants to "find an image/illustration/graphic for" a spot, "add a picture to §X",
  "get an undraw image of …", or otherwise illustrate a passage. Because an exact match is unlikely, the
  skill is deliberately resilient: it tries several search terms, downloads a shortlist of ~3 candidates,
  renders a preview of each, looks at them, and picks the one that actually matches the description — not
  just the closest slug. undraw illustrations are flat vector SVGs released free for commercial use with no
  attribution, and every accent is one recolourable colour, so the winner can be restyled to the book's
  per-chapter accent automatically. The chain for one image: description → several search terms → pooled
  candidates → download 3 SVGs → render PNG previews → evaluate and select the best → recolour the winner →
  save to images/illustrations/ → optionally place a figure in book/*.md → verify with a build.
compatibility: >-
  Uses curl (undraw's search page + CDN) and perl (case-insensitive hex recolour). Evaluation needs to turn
  a candidate SVG into a viewable PNG; undraw's CDN serves SVG only, so the skill renders the PNG locally
  with the first available of rsvg-convert / cairosvg / inkscape, falling back to the headless Chromium the
  book build already uses (see build_pdf.py's browser discovery). The build copies images/illustrations/*.svg
  into the site via build_site.py's copy_assets (already wired).
---

# find-image

The user wants an illustration for a passage and would rather reuse a good open-source one than commission
a style. undraw.co is the right well: thousands of flat vector illustrations, free for commercial use with
no attribution, each built around a single recolourable accent — so an undraw image can be restyled to the
book's palette and dropped in.

The hard part is not fetching — it is *choosing*. undraw search is keyword-based, an exact match for a
sentence-long description almost never exists, and the top slug is often not the best picture. So this skill
does what a person does: try a few searches, pull a handful of real candidates, **look at them**, and pick
the one that fits. It evaluates the rendered image, not the file name.

## Why this fits the book

The book is text-first and flat (no gradients), in the Rosely palette with a per-chapter accent
(`theme.yml` → `chapter-accents`). undraw illustrations are flat and single-accent, so recolouring the
accent to the chapter's token makes an undraw image look like it belongs — without hand-drawing anything.
Because the licence is free and attribution-free, an illustration is **not** a citation: nothing goes into
`references.json` or a References list (the opposite of [[inject-article]] / [[enhance-book]]).

## The chain

### 1. Turn the description into *several* search terms

undraw matches an illustration's name and tags, not a sentence — so reduce the description to the concrete
concepts undraw is likely to have tagged, and produce **several distinct queries that come at it from
different angles**: the subject, the action, the setting, and the metaphor. For *"a person overseeing
several AI agents"* that might be `ai agent`, `control panel`, `automation`, `team`, `robot`, `dashboard`.
One term rarely surfaces the best picture; a spread of terms is what makes the search resilient. undraw has
a deep vocabulary for this book's subjects (`ai-agent`, `ai-research-assistant`, `machine-learning`, `data`,
`security`, `workflow`, `decision`, `remote work`, `ideas`, …). When a term returns nothing, fall back to a
simpler synonym.

### 2. Pool the candidates

For each term, scrape the ranked CDN links from the search page (page order = relevance) and pool them,
deduped by slug:

```bash
curl -sL "https://undraw.co/search/$(printf '%s' "$TERM" | sed 's/ /-/g')" \
  | grep -oiE 'cdn\.undraw\.co/illustrations?/[a-z0-9-]+_[a-z0-9]+\.svg' | sort -u
```

Notes:

- The path segment is **`/illustration/` for some slugs and `/illustrations/` for others** — keep whichever
  the search returned for each slug (the regex captures both); if you ever construct a URL yourself, try one
  and fall back to the other.
- The CDN serves **SVG only** — there is no `.png` URL (the site's "download PNG" is a client-side render).
- The **slug is your first filter**: read the slugs and keep the ones whose central concept matches the
  description. Aim for a **diverse shortlist of about 3** — ideally from different terms, so you are choosing
  between genuinely different pictures, not three near-duplicates.

### 3. Download the 3 candidates and render a preview of each

Download the shortlisted SVGs from the CDN, then render a small PNG of each so they can actually be seen and
judged (undraw has no PNG URL, so rasterise the SVG locally). Use the first tool available; the last fallback
is the headless Chromium the book build already relies on:

```bash
render_png () {           # $1 = candidate.svg  $2 = out.png  (preview ~640px wide)
  if   command -v rsvg-convert >/dev/null; then rsvg-convert -w 640 "$1" -o "$2"
  elif command -v cairosvg     >/dev/null; then cairosvg "$1" -o "$2" --output-width 640
  elif command -v inkscape     >/dev/null; then inkscape "$1" --export-type=png -w 640 -o "$2"
  else                                          # headless Chromium (as in build_pdf.py)
    W=640; H=$(python3 - "$1" <<'PY'
import re,sys
s=open(sys.argv[1]).read()
m=re.search(r'viewBox="[\d.]+ [\d.]+ ([\d.]+) ([\d.]+)"',s) or re.search(r'width="([\d.]+)"[^>]*height="([\d.]+)"',s)
w,h=(float(m.group(1)),float(m.group(2))) if m else (640,480)
print(round(640*h/w))
PY
)
    "$CHROME" --headless=new --disable-gpu --no-sandbox --hide-scrollbars \
      --force-device-scale-factor=1 --default-background-color=faf7f4ff \
      --screenshot="$2" --window-size=${W},${H} --user-data-dir=/tmp/cr-find-image "$1" >/dev/null 2>&1
  fi
}
```

(Find `$CHROME` the way `build_pdf.py` does — on macOS `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome` or Microsoft Edge; elsewhere `google-chrome` / `chromium` / `brave-browser`.) Size the render on
a warm ground so it reads as it will in the book; render the **original** undraw SVG for evaluation, before
any recolour.

### 4. Evaluate the previews and select the best

**Look at the three PNGs** (open them so you actually see them) and judge each against the description on
concrete criteria — do not pick on the slug alone:

- **Subject fit** — does it depict the thing described (the right actors, the right action), not just share
  a keyword?
- **Legibility** — is it a single clear scene, or cluttered and busy? Simple reads better small and beside
  prose.
- **Recolours cleanly** — a single-accent illustration (one dominant hue) restyles perfectly; a busy
  multi-colour ramp is harder to bring fully into palette. Prefer the clean one when fit is equal.
- **Orientation** — a landscape illustration suits an inline figure; a tall one may not.

Pick the best, and **show the user the three previews with your recommendation and one line of reasoning**,
so the visible choice is theirs to confirm. If none of the three fits well, widen or change the search terms
and pull a fresh shortlist; if nothing across a couple of rounds fits, say so and place nothing — a weak
illustration is worse than none.

### 5. Recolour the winner — detect the accent, never assume

Work on the chosen candidate's SVG. **undraw has two eras, so detect the accent first** — histogram the hexes
and see what dominates:

```bash
grep -oE '#[0-9a-fA-F]{6}' winner.svg | tr 'A-F' 'a-f' | sort | uniq -c | sort -rn
```

- **Classic illustrations** use one signature purple accent, `#6c63ff`, everywhere — a single swap.
- **Newer flat illustrations** use a different hue and often a **ramp** — e.g. `#0055dc` with lighter tints
  `#6ecce5`, `#c5ebf5`; there is no purple, so map the whole ramp.
- The **ink varies** (`#2f2e41`, `#3f3d56`, `#090814`, `#36393a`); light greys (`#f2f2f2`, `#e6e6e6`,
  `#e2e3e4`) and skin tones (`#ffb8b8`, `#9e616a`, `#ed9da0`) are neutral — leave them.

Identify the accent as the most frequent **saturated** colour that is not near-black (ink), not a low-
saturation grey/white, and not a skin tone, then remap:

- **accent (or ramp base) → the chapter's Rosely accent** from `theme.yml` → `chapter-accents`
  (foundations→`grapeade #85677b`, productivity→`raspberry-sorbet #d2386c`, software→`morning-glory #ec809e`,
  disciplines→`lupine #be9cc1`, governance→`serenity #93a9d1`, mastery→`radiant-orchid #b565a7`; front
  matter→`radiant-orchid`). **If the chapter accent is pale** (`lupine`, or any light tint), the accent shapes
  wash out — substitute a stronger sibling (`radiant-orchid #b565a7` is the safe default) and say so.
- **ramp tints → Rosely pinks** so they stay in family: mid → `rose-quartz #f7caca`, lightest →
  `heavenly-pink #f4dede`, near-white → `warm #faf7f4`.
- **ink → `black-beauty #27272a`** (map every ink hex you found).

Recolour with **case-insensitive** replacement — undraw stores some hexes uppercase (`#0055DC`), and macOS
`sed` has no `/i`, so use `perl`:

```bash
perl -pe 's/#6c63ff/#b565a7/gi; s/#3f3d56/#27272a/gi; s/#090814/#27272a/gi' winner.svg > out.svg
```

**Preserve the native aspect ratio.** Keep the SVG's own `viewBox`, `width`, and `height` — never add or
change them to force a shape (e.g. 3:2); the figure should display at undraw's own proportions. Verify: re-run
the histogram (every source accent/ink hex should be gone), and re-render a PNG of the recoloured SVG to
confirm it reads in-palette with nothing washed out or left off-palette.

### 6. Save

Write the recoloured SVG to `images/illustrations/<slug>.svg`. The build copies `images/illustrations/*` into
the site — `build_site.py`'s `copy_assets` handles it, mirroring `images/projects/*`. Reference it in the book
**relative to the real file** so a raw Markdown preview (e.g. VS Code) renders it: `../images/illustrations/<slug>.svg`
(the chapter files are in `book/`, so `../images/…` points at the source). `build_site.py` strips the `../images/`
prefix when it generates the `.qmd`, so the built site resolves the staged in-project copy — you get both a
working preview and a working build. Keep a one-line provenance note (source CDN URL + the accent map used) so
it can be re-fetched or re-toned; this is provenance, not a citation.

### 7. Place it in the book — only if a section was named, and only where it helps

Insert one Markdown figure in the house style, caption as a full sentence (see the `projects/*.png` figures
in Chapter 3):

```markdown
![A single agent working a task in a loop while a person reviews the result.](../images/illustrations/<slug>.svg)
```

Place it where it *earns its place* — a section opener, or beside the idea it depicts. One image per idea;
the book's style is restraint. Match the alt text to what the picture actually shows.

### 8. Verify

- `cd quarto && ./build.sh` → "Output created", and the SVG lands in `_book/illustrations/` once a chapter
  references it.
- Open the page (or PDF/ePub) and check the recolour reads in the palette and the figure sits well.
- No citation checks — undraw is not a cited source.

## Rules

- **Evaluate the rendered image, not the slug.** Always download ~3 and look before choosing.
- **Cast a wide net.** Several search terms from different angles; a diverse shortlist, not near-duplicates.
- **One image at a time**, and respect the option to place nothing when nothing fits.
- **Detect the accent; never blind-swap `#6c63ff`.** Newer illustrations use a different hue and a ramp.
- **Recolour case-insensitively** (`perl … /gi`), and map every ink hex to `black-beauty`.
- **Match the accent to the section** via `theme.yml`; swap a pale accent for a stronger one so the
  illustration does not wash out.
- **Keep the native aspect ratio** — never force a shape; use undraw's own `viewBox`.
- **Not a citation.** undraw is free and attribution-free — nothing enters `references.json`. Keep only a
  light provenance note.
- **Restraint.** An illustration must help the reader, not fill space.
- **Do not commit or push** unless the user asks (the book's standing rule).
