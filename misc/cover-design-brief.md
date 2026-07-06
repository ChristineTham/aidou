# AI-dō — Book Cover Design Brief

*Precise instructions for an AI design tool (e.g. Claude Design, Stitch, Figma AI).
Everything below is the agreed spec, converged over many iterations. Follow it exactly;
deviate only where a section says "designer's choice."*

---

## 1. Concept

A book cover for **AI-dō**, a practice guide on working with AI. The title fuses
**AI** (Latin, technology) with **dō** (道, the Japanese "way" / discipline). The
whole design is a quiet East-meets-West fusion: geometric sans Latin + Japanese
kanji, on a warm, restrained, literary-non-fiction palette. Mood: calm, confident,
premium, disciplined, a little Zen. **Not** techy/AI-cliché — no circuits, robots,
neon, glows, or stock imagery.

## 2. Format & output

- **Aspect 2:3, portrait.** Working canvas **1600 × 2400 px**. For print: 6 × 9 in
  @ 300 dpi, 0.125 in bleed, 0.5 in safe margin.
- **Deliverable: an SVG master with ALL text converted to vector outlines**
  (self-contained, no font dependency, resolution-independent, print-sharp), plus a
  PNG export. Do **not** rely on `@font-face`/live fonts in the final file — outline
  everything.
- Colours are CMYK-safe; keep ink coverage low (see background).

## 3. Palette — "Rosely" (use these exact values)

| Role | Colour | Hex |
|---|---|---|
| Background | cream | `#F4EEE8` |
| Primary ink (title, author) | velvet | `#27272A` |
| Kicker | mauve | `#85677B` |
| Subtitle | grey | `#615F5F` |
| Rule / accent / "Tham" | rose | `#D2386C` |
| "hello" + logo mark eyes/gear | purple | `#B565A7` |
| Watermark 道 | blossom | `#F7CACA` |
| Watermark AI | lilac | `#BE9CC1` |
| Easter-egg 愛 | teal | `#64BFA4` |

**Light background is mandatory** — a dark full-bleed wastes ink when the PDF is
printed. Let whitespace carry the design (Japanese *ma*).

## 4. Typography (all free Google Fonts, OFL)

- **Raleway** — headings/structure. ExtraBold (800) for the title; Light (300) for
  the kicker and the "hello" wordmark; Bold (700) for "Tham".
- **Noto Serif Italic** — the subtitle.
- **Cormorant Garamond, Medium Italic** — the author signature (elegant, feminine,
  still readable).
- Japanese glyphs (道, 愛): a serif CJK face (e.g. Noto Serif JP).
- **Do not exceed these families.** The title must be genuine Raleway (a *sans*).

## 5. Grid

Left-aligned to a single strong left axis. Left & right margins = **128 px**, so the
**text measure = 1344 px** (x: 128 → 1472). The kicker and title both span this
measure exactly.

## 6. Copy (exact)

- Kicker: **A structured way of working with AI**
- Title: **AI-dō**
- Subtitle: **The Way of AI, grounded in practice (道)**
- Author: **Chris Tham**
- Publisher: **helloTham** (wordmark + eye/gear mark)

## 7. Layout — top cluster (bunched together near the top)

1. **Kicker** — Raleway Light, UPPERCASE, mauve. One line, **spanning the full
   measure** via *even* letter-spacing distributed across all letters (≈3 px at this
   scale). NOT justified word-gaps; NOT stretched glyphs. (At 1600px canvas this lands
   ≈60 px font size.)
2. **Title "AI-dō"** — Raleway **ExtraBold**, velvet, **sized so its natural width
   equals the measure** (edge-to-edge, no distortion, no letter-spacing gaps). Dominant
   element (~4× the author). The macron on **ō** must be correct (U+014D).
3. **Subtitle** — Noto Serif *italic*, grey, broken at the comma into two lines
   ("The Way of AI," / "grounded in practice (道)").
4. **Rule** — a short rose bar (~132 × 6 px, rounded) directly under the subtitle.

Keep 1–4 close together as one block in the upper third.

## 8. Layout — footer (bottom edge)

- **Author "Chris Tham"** — Cormorant Garamond italic, velvet — **bottom-LEFT** at the
  left margin.
- **helloTham lockup** — **bottom-RIGHT**, right-aligned to the right margin.
- **Both sit on the SAME baseline.** Author ≈2× the wordmark height.
- **helloTham lockup** (matches the brand `banner.png`): the word **hello** in Raleway
  Light **purple**, immediately followed by **Tham** in Raleway Bold **rose**, then the
  **eye/gear mark** to the right — a circle (rose stroke) containing two eyes + a gear
  (purple). Mark height ≈ the wordmark's cap height; vertically centred to the wordmark.

## 9. Background decoration (the layered watermarks)

Fill the middle/lower field as soft decoration behind the text. Three layers:

1. **"AI"** (Latin, Raleway ExtraBold, **lilac**, ~45% opacity) — **large**, lower-left.
2. **道** (kanji, serif, **blossom**, ~58% opacity) — **smaller than AI**, upper-right,
   so it is offset from AI on **both** axes (diagonal) and overlaps it in the middle.
3. **Easter egg — 愛** ("ai" = *love*, serif, **teal**, ~60% opacity) — small, enclosed
   in a **very faint heart** (rose, ~16% opacity), nestled inside the **counter (the open
   triangle) of the big "A"**. Subtle — for the alert reader to discover. Together the
   background secretly spells **愛道** (love + way) — the true meaning of the book's name.

All watermarks stay **fully inside the cover** (never cropped at the edges).

## 10. Reference proportions (as built at 1600×2400)

Concrete values from the approved version — scale proportionally to other canvas sizes:

- Kicker baseline y≈300; Title baseline y≈720; Subtitle baselines y≈858 & 976; Rule
  y≈1044.
- Big **AI** watermark ≈1180 px cap, x≈5, baseline≈2080. **道** watermark ≈900 px,
  upper-right, baseline≈1760. **愛** ≈140 px inside a ~300×270 px heart, centred in the A.
- Footer shared baseline y≈2250; author ≈104 px; wordmark ≈54 px; mark ≈60 px.

## 11. Avoid

- Dark / full-bleed ink-heavy backgrounds.
- Justified lines with big word-gaps; over-tracked or horizontally-stretched/distorted
  titles.
- Centered stacked text, drop shadows, faux-3D, gradients-as-crutch, stock AI imagery.
- Serif or generic fonts for the title (it must read as Raleway sans).
- Watermarks cropped at the edges.
- More than the type families listed in §4.

---

*Current production master lives at `quarto/cover.svg` (outlined) → `quarto/cover.png`.*
