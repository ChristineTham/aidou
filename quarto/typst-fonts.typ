// Back-of-book index (page-numbered). in-dexter collects #index[..] markers
// injected through the body as {=typst} spans and renders them via #make-index().
#import "@preview/in-dexter:0.7.2": *

// Fit a chapter title: start at `base` and shrink only until it fits the text
// column OR reaches `floor`; a title too long to fit at `floor` wraps to two
// lines rather than shrinking further, so titles stay bold and legible.
#let fit-title(body, base: 30pt, floor: 22pt) = context layout(size => {
  let s = base
  while s > floor and measure(text(font: "Raleway", weight: 800, size: s, body)).width > size.width {
    s = s - 0.5pt
  }
  text(font: "Raleway", weight: 800, size: s, body)
})

// Keep a heading glued to the text beneath it, so a section title can never be
// stranded alone at the foot of a page (orphaned heading).
#show heading: set block(sticky: true)

// Body font for the PDF. The orange-book template leaves the base font unset
// (Typst then defaults to Libertinus) and Quarto's brand only wires up the
// heading font, so we set the body serif here. We deliberately give a single
// family (not a list): Typst then keeps its automatic fallback on, so the two
// kanji (愛 道) resolve to whatever CJK font is installed — Noto CJK on CI (see
// deploy.yml), a system CJK font locally — in every context, including page
// headers and callout titles that our own show-rules can't reach.
#set text(font: "Noto Serif")

// Chapter titles (level-1 headings) always in Raleway ExtraBold. The heading
// font is Raleway (from _brand.yml); this bumps only the weight, and Typst
// finds Raleway-ExtraBold in TYPST_FONT_PATHS. Section headings keep their weight.
#show heading.where(level: 1): set text(weight: 800)

// Smart-scale Mermaid diagrams. Quarto renders every diagram PNG at the same
// high effective density and tags it at a natural size whose on-page text ends
// up far larger than the body text (and often wider than the page too). Because
// the density is uniform, a single factor normalises the diagram text to roughly
// body size; the text-column width then caps anything still too wide to show at
// that size — whichever comes first. The full-page 6x9in cover image is left
// untouched (identified by its height).
#let diagram-scale = 0.55
#show image: it => layout(size => {
  let m = measure(it)
  let given = m.width
  if given <= 0pt or m.height >= 8.5in {
    it                              // full-page cover / unmeasurable — leave as-is
  } else {
    let target = calc.min(given * diagram-scale, size.width)
    let f = target / given
    scale(x: f * 100%, y: f * 100%, origin: top + left, reflow: true, it)
  }
})
