# AI-dō — Image Generation Prompts (Option A: Kanji hero + wagara)

Prompts for an image model (Nano Banana / Gemini image, Midjourney, etc.) to generate
the **cover background** + **6 chapter opener images**, as one consistent family.

---

## How to use this

1. **One image at a time.** Copy a single prompt block below and generate it. Each block
   is self-contained (style + palette + specifics), so you don't need anything else.
2. **Every image is 3:2 (landscape)** — chapters *and* the cover. The cover art is a
   3:2 **panel woven into the existing typographic cover** (`quarto/cover.svg`), not a
   full-bleed image; the title, author and logo stay typeset in the layout. Generate at
   the highest resolution the tool offers.
3. **Lock consistency:** generate **Chapter 1** first; once you're happy with it, **feed
   that image back into the model as a style/reference image** for the other five (Nano
   Banana and most tools support an input reference). Keep the same seed if the tool
   exposes one.
4. **Verify the kanji.** Image models can distort CJK characters. Check each generated
   kanji against the one printed in the block; regenerate if a stroke is wrong.
5. **No text is baked in on purpose.** The chapter number/title and the cover title,
   author and logo are added later in the page layout — that's why the prompts forbid
   letters/words. This avoids the garbled-text AI tell and keeps typography crisp.
6. **Output PNG with a transparent background if the tool supports it** — the motif
   (kanji, seigaiha pattern, accent dot) should sit on **transparency** so the cream page
   shows through and the art composites seamlessly onto any layout. Where a prompt mentions
   "cream background" or "empty cream space," read that as **transparent**. If the model
   can't do alpha, fall back to a **flat cream `#F4EEE8`** fill (it matches the page, so it
   still composites cleanly) and export PNG.

## The look (applies to every image)

Flat, minimal, elegant **editorial vector illustration** — calm, premium, literary,
Japanese-influenced restraint, lots of empty space. **NOT** a photograph, **not** 3D,
**not** painterly, **not** watercolour, **not** grunge. Perfectly flat colour: **no
gradients, no drop shadows, no glow, no texture noise, no bevels.**

## Rosely palette (use these exact hex values)

- Background cream `#F4EEE8`
- Ink velvet `#27272A`
- Mauve `#85677B` · Grey `#615F5F`
- Rose `#D2386C` · Pink `#EC809E` · Purple `#B565A7` · Lilac `#BE9CC1`
- Blossom `#F7CACA` · Petal `#F4DEDE`
- Teal `#64BFA4` · Blue `#93A9D1`

## Global "do NOT include"

No people, faces, hands, or bodies. No photorealism or 3D render. No watercolour/paint
texture. No gradients, shadows, or glows. **No text, letters, words, numbers, logos, or
UI** anywhere — except the single decorative kanji named in the prompt. No borders/frames.
No clutter — protect the negative space.

---

## COVER ART PANEL  (aspect ratio 3:2, landscape — woven into the cover layout)

This is a **decorative 3:2 panel** that sits in the middle/lower band of the existing
portrait cover. The cover's title, kicker, author and helloTham logo remain **typeset in
the layout around and over it** — do NOT put any of them in the image.

> Flat minimal editorial vector illustration, 3:2 landscape, **transparent background**
> (PNG with alpha; or flat cream `#F4EEE8` if transparency isn't supported). A quiet,
> layered typographic motif: large translucent Latin letters "AI" in
> lilac `#BE9CC1` (~45% opacity) sitting lower-left, overlapping a smaller Japanese kanji
> "道" (meaning "the way") in blossom pink `#F7CACA` (~58% opacity) upper-right — the two
> offset diagonally and overlapping in the middle. Tucked inside the triangular counter of
> the big "A", a very small kanji "愛" (meaning "love") in soft teal `#64BFA4`, wrapped in
> a very faint rose `#D2386C` heart outline. A faint traditional Japanese seigaiha wave
> pattern (thin concentric arcs) in warm grey `#85677B` at ~10% opacity fills the
> background. Perfectly flat colour — no gradients, shadows, glow, photo or 3D. No text
> except the kanji 道 and 愛 and the Latin letters "AI" described. Balanced so it reads
> well as a horizontal band. 3:2.

*(Composition note for weaving in: the current cover already places this motif as vector
art. Swapping in a generated panel means dropping the SVG watermark layer and inserting
the image into the same mid/lower region of `quarto/cover.svg`, behind the typeset text.
Keep the cream background matched so the panel blends seamlessly into the page. If you'd
rather not, the existing all-vector cover stands on its own.)*

---

## Chapter opener template

Every chapter image uses the **same composition** so they read as a set: large single
kanji in the **right third** (partly bleeding off the right edge), faint seigaiha pattern
behind it, and the **left two-thirds left as calm empty cream space** for the chapter
number + title (added in layout). Only the **kanji** and its **accent tint** change per
chapter. Seigaiha stays warm grey `#85677B` at ~10% throughout.

### CHAPTER 1 — Foundations  (aspect ratio 3:2)

> Flat minimal editorial vector illustration, **transparent background** (PNG with alpha;
> or flat cream `#F4EEE8` if transparency isn't supported). A large
> single Japanese kanji "基" (meaning "foundation / base"), drawn as clean, accurate
> serif/Mincho-style strokes in translucent blossom pink `#F7CACA` (~80% opacity), placed
> in the right third of the frame and partly bleeding off the right edge. Behind it, a very
> faint traditional Japanese seigaiha wave pattern (thin concentric arcs) in warm grey
> `#85677B` at ~10% opacity. The left two-thirds is calm empty cream negative space. One
> tiny rose `#D2386C` dot as a quiet accent, lower-left. Understated, premium, flat colour,
> no gradients/shadows/photo/3D/watercolour. No text except the single kanji "基". 3:2.

### CHAPTER 2 — Personal Productivity  (aspect ratio 3:2)

> Same style and layout as Chapter 1. Kanji "愛" (meaning "love / care"), in translucent
> pink `#EC809E` (~80% opacity), right third, partly bleeding off the right edge. Faint
> seigaiha wave pattern in warm grey `#85677B` at ~10%. Left two-thirds empty cream space.
> Tiny rose `#D2386C` accent dot. Flat vector, no gradients/shadows/photo/3D. No text except
> the kanji "愛". 3:2.

### CHAPTER 3 — Software Development  (aspect ratio 3:2)

> Same style and layout. Kanji "創" (meaning "to create"), in translucent lilac `#BE9CC1`
> (~80% opacity), right third, bleeding slightly off the right edge. Faint seigaiha in warm
> grey `#85677B` at ~10%. Left two-thirds empty cream. Tiny rose `#D2386C` accent dot. Flat
> vector, no gradients/shadows/photo/3D. No text except the kanji "創". 3:2.

### CHAPTER 4 — Engineering Disciplines  (aspect ratio 3:2)

> Same style and layout. Kanji "匠" (meaning "artisan / master craftsman"), in translucent
> blue `#93A9D1` (~80% opacity), right third, bleeding slightly off the right edge. Faint
> seigaiha in warm grey `#85677B` at ~10%. Left two-thirds empty cream. Tiny rose `#D2386C`
> accent dot. Flat vector, no gradients/shadows/photo/3D. No text except the kanji "匠". 3:2.

### CHAPTER 5 — Responsibility & Governance  (aspect ratio 3:2)

> Same style and layout. Kanji "責" (meaning "responsibility"), in translucent mauve
> `#85677B` (~80% opacity), right third, bleeding slightly off the right edge. Faint
> seigaiha in warm grey `#85677B` at ~10% (keep it fainter than the kanji so they separate).
> Left two-thirds empty cream. Tiny rose `#D2386C` accent dot. Flat vector, no
> gradients/shadows/photo/3D. No text except the kanji "責". 3:2.

### CHAPTER 6 — Mastery & Forward Practice  (aspect ratio 3:2)

> Same style and layout. Kanji "道" (meaning "the way" — mirrors the cover), in translucent
> purple `#B565A7` (~80% opacity), right third, bleeding slightly off the right edge. Faint
> seigaiha in warm grey `#85677B` at ~10%. Left two-thirds empty cream. Tiny rose `#D2386C`
> accent dot. Flat vector, no gradients/shadows/photo/3D. No text except the kanji "道". 3:2.

---

## Consistency checklist (before you accept a set)

- [ ] Same warm cream `#F4EEE8` background on all 7.
- [ ] Same composition on the 6 chapters: kanji right third, empty cream left two-thirds.
- [ ] Seigaiha pattern equally faint and same warm grey on all.
- [ ] Each kanji correct and legible (compare to this file).
- [ ] Only the specified kanji present — no stray letters/words/numbers.
- [ ] Flat colour only — reject any output with gradients, shadows, glow, paint texture,
      or a 3D/photographic feel.
- [ ] All 7 images 3:2 landscape (the cover panel included — it's woven into the layout,
      not a full-bleed cover).
- [ ] Exported as PNG with a transparent background (or flat cream `#F4EEE8` if the tool
      can't do alpha).

*Kanji reference: 基 (foundation) · 愛 (love) · 創 (create) · 匠 (artisan) · 責 (responsibility) · 道 (the way).*
