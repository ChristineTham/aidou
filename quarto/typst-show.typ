#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#set document(title: "AI-dō", author: "Chris Tham")

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
$if(lang)$
  lang: "$lang$",
$endif$
  main-color: brand-color.at("primary", default: blue),
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
