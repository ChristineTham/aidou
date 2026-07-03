// Body font for the PDF. The orange-book template leaves the base font unset
// (Typst then defaults to Libertinus) and Quarto's brand only wires up the
// heading font, so we set the body serif here. We deliberately give a single
// family (not a list): Typst then keeps its automatic fallback on, so the two
// kanji (愛 道) resolve to whatever CJK font is installed — Noto CJK on CI (see
// deploy.yml), a system CJK font locally — in every context, including page
// headers and callout titles that our own show-rules can't reach.
#set text(font: "Noto Serif")

// Fit diagrams to the page. Quarto emits each Mermaid PNG at its natural size
// (often far wider than the page), which overflows and crops. Shrink any image
// wider than the text column to fit, preserving aspect ratio; leave smaller
// images untouched.
#show image: it => layout(size => {
  let w = measure(it).width
  if w > size.width {
    scale(x: size.width / w * 100%, y: size.width / w * 100%, origin: top + left, reflow: true, it)
  } else {
    it
  }
})
