#import "@preview/orange-book:0.7.1": book, part, chapter, appendices
#import "_tokens.typ": *   // colour tokens generated from theme.yml

#set document(title: "AI-dō", author: "Chris Tham")

// Restore the Table of Contents heading. heading-style: 99 blanks orange-book's
// level-1 heading rendering, which also suppresses Typst's auto outline title
// (and its page-break would orphan a prepended title). So we drop the auto title
// entirely and render our own "Contents", only for the main ToC: the mini page
// outlines use depth 2 and the figure/table lists target figures, so keying on
// the main outline depth (outline-depth = toc-depth = 3) isolates it. Defined
// before `#show: book` so it is active when the outline is rendered.
// The plain (no-kanji) seigaiha banner used on the preface, reused on the other
// front/back-matter pages (Contents, the Figures/Diagrams/Tables lists, the
// epigraph, the Index) so they carry the same chapter art, with a gap before the
// content. Defined here (before the outline show-rule that uses it, and before
// `#show: book`) so it is in scope on the front-matter pages too. The local
// `show image` cancels the body's diagram-scale rule, so the banner is a clean
// full-column width whether or not that rule is active where it renders.
#let frontmatter-art = {
  v(0.35em)
  { show image: it => it; image("chapter-art/frontmatter.png", width: 100%) }
  v(1.1em)
}

// Blockquotes: give the PDF the same styling as the web and ePub (a lupine left
// rule, a warm tint, italic granite text) so quoted prompts read as quotes and
// not as plain body paragraphs. orange-book ships no quote style of its own.
#show quote.where(block: true): it => block(
  width: 100%,
  fill: c-warm,
  radius: 2pt,
  stroke: (left: 2.5pt + c-lupine),
  inset: (left: 1em, right: 0.8em, y: 0.5em),
  text(style: "italic", fill: c-granite-gray, it.body),
)

// Tables: Rosely styling to match (and enliven) the web/ePub — a pink,
// orchid-ruled header in bold, warm zebra body rows, heavenly-pink hairlines —
// instead of orange-book's plain rules.
#set table(
  inset: (x: 0.6em, y: 0.45em),
  stroke: (_, y) => (
    left: 0.4pt + c-heavenly-pink,
    right: 0.4pt + c-heavenly-pink,
    top: 0.4pt + c-heavenly-pink,
    bottom: if y == 0 { 1.5pt + c-radiant-orchid } else { 0.4pt + c-heavenly-pink },
  ),
  fill: (_, y) => if y == 0 { c-heavenly-pink } else if calc.even(y) { c-sugar-swizzle } else { white },
)
#show table.cell.where(y: 0): set text(weight: 700, fill: c-black-beauty)
#show table: set text(size: 0.95em)

#set outline(title: none)
#show outline: it => {
  if it.depth == 3 {
    pagebreak(to: "odd")
    block(text(font: "Raleway", weight: 800, size: 24pt, fill: c-black-beauty)[Contents])
    frontmatter-art
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
    Twelve beautiful illustrations by Katerina Limpitsouni \
    (#link("https://undraw.co")[unDraw · undraw.co]), recoloured to the book's palette.
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
