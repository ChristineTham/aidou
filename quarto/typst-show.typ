#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#set document(title: "AI-dō", author: "Chris Tham")

// Restore the Table of Contents heading. heading-style: 99 blanks orange-book's
// level-1 heading rendering, which also suppresses Typst's auto outline title
// (and its page-break would orphan a prepended title). So we drop the auto title
// entirely and render our own "Contents", only for the main ToC: the mini page
// outlines use depth 2 and the figure/table lists target figures, so keying on
// the main outline depth (outline-depth = toc-depth = 3) isolates it. Defined
// before `#show: book` so it is active when the outline is rendered.
#set outline(title: none)
#show outline: it => {
  if it.depth == 3 {
    pagebreak(to: "odd")
    block(text(font: "Raleway", weight: 800, size: 24pt, fill: rgb("#27272A"))[Contents])
    v(0.5em)
  }
  it
}

// Custom cover + page size for the PDF.
// - cover: our designed cover.png, full-bleed (6:9 image on a 6x9 page, no distortion).
// - cover-background transparent + no title/subtitle/author passed, so orange-book's
//   default title band is invisible and only our cover shows.
// - width/height: US octavo / trade (6 x 9 in), smaller than the old A4.
#show: book.with(
  title: "",
  subtitle: "",
  author: "",
  cover: image("cover.png"),
  cover-background: rgb("#00000000"),
  width: 6in,
  height: 9in,
  margin: (x: 1.7cm, top: 2.1cm, bottom: 2.1cm),
  copyright: [
    #set text(size: 9.5pt)
    #set par(leading: 0.72em)
    #text(font: "Raleway", weight: 800)[AI-dō] — The Way of AI, grounded in practice (道) \
    Chris Tham
    #v(1.1em)
    Read it online, or download the latest PDF and ePub: \
    #link("https://christham.net/aidou")[christham.net/aidou] \
    #link("https://christham.net/aidou/ai-do.pdf")[christham.net/aidou/ai-do.pdf] · PDF \
    #link("https://christham.net/aidou/ai-do.epub")[christham.net/aidou/ai-do.epub] · ePub
    #v(1.1em)
    This book is open source. The text, the code it discusses, and the full
    toolchain that builds the website, PDF, and ePub are on GitHub: \
    #link("https://github.com/ChristineTham/aidou")[github.com/ChristineTham/aidou]
    #v(1.1em)
    First published 2026. \
    © 2026 Chris Tham · Hello Tham (#link("https://christham.net")[christham.net])
  ],
$if(lang)$
  lang: "$lang$",
$endif$
  main-color: brand-color.at("primary", default: blue),
  // Suppress orange-book's boxed chapter title (its style branches handle only
  // 0/1/2); an out-of-range value keeps the page-break + counter resets but
  // renders no box. Our own clean title is injected into the body, PDF-only,
  // by build_site.py so it can sit above the seigaiha banner.
  heading-style: 99,
$if(toc-depth)$
  outline-depth: $toc-depth$,
$endif$
$if(margin-geometry)$
  padded-heading-number: false,
$endif$
)

$if(margin-geometry)$
#import "@preview/marginalia:0.3.1" as marginalia
#show: marginalia.setup.with(
  inner: (
    far: $margin-geometry.inner.far$,
    width: $margin-geometry.inner.width$,
    sep: $margin-geometry.inner.separation$,
  ),
  outer: (
    far: $margin-geometry.outer.far$,
    width: $margin-geometry.outer.width$,
    sep: $margin-geometry.outer.separation$,
  ),
  top: $if(margin.top)$$margin.top$$else$1.25in$endif$,
  bottom: $if(margin.bottom)$$margin.bottom$$else$1.25in$endif$,
  book: true,
  clearance: $margin-geometry.clearance$,
)
$endif$
