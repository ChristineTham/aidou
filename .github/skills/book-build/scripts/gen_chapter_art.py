#!/usr/bin/env python3
"""Generate the chapter + front-matter banners (SVG + PNG) for the book.

Design: a thin, full-width "seigaiha tide" ribbon placed under a page title —
a solid field in the page's accent colour, overlaid edge-to-edge with cream
seigaiha wave scallops. Chapter banners add a centred cream "moon" holding the
chapter's kanji (in the accent colour). Front-matter banners (preface, landing)
use the same tide with no moon/kanji. Kanji glyphs are outlined into
self-contained SVG paths (no font dependency in the output) via fontTools, the
same approach used for the cover.

Output goes to `images/chapter-art/<slug>.svg` and `<slug>.png` (the source of
truth); the build copies the PNGs into the Quarto project dir. The build
(`build_site.py`) embeds the **PNG** under each page title so it renders
reliably across HTML + Typst PDF + ePub (SVG masks/gradients aren't safe in
Typst/ePub).

Requirements (generation-time only; nothing extra ships with the book):
  * fontTools  ->  pip install fonttools
  * The full Noto Serif JP variable font (the bundled quarto/fonts subset only
    contains 愛/道). Download once, e.g.:
      curl -L -o NotoSerifJP.ttf \
        "https://github.com/google/fonts/raw/main/ofl/notoserifjp/NotoSerifJP%5Bwght%5D.ttf"
  * For --png: Google Chrome (headless) to rasterize.

Usage:
    gen_chapter_art.py --font NotoSerifJP.ttf --out ../../images/chapter-art --png
"""
import argparse, json, os, shutil, subprocess

# The slug -> kanji map is content; the accent colours come from theme.yml (via
# _tokens.json) at generation time. Fallbacks below apply if no tokens are passed.
CREAM = "#F4EEE8"
KANJI = [("foundations", "基"), ("productivity", "愛"), ("software-development", "創"),
         ("engineering-disciplines", "匠"), ("governance", "責"), ("mastery", "道")]
FALLBACK_ACCENTS = {"foundations": "#85677B", "productivity": "#D2386C",
                    "software-development": "#EC809E", "engineering-disciplines": "#BE9CC1",
                    "governance": "#93A9D1", "mastery": "#B565A7"}
FALLBACK_FM = "#B565A7"
W, H = 1600, 200


def make_glyphs(font_path, weight=600):
    from fontTools.ttLib import TTFont
    from fontTools.varLib.instancer import instantiateVariableFont
    from fontTools.pens.svgPathPen import SVGPathPen
    from fontTools.pens.boundsPen import BoundsPen
    f = TTFont(font_path)
    if "fvar" in f:
        instantiateVariableFont(f, {"wght": weight}, inplace=True)
    cmap, gs = f.getBestCmap(), f.getGlyphSet()

    def path(ch, th, cx, cy, fill):
        g = cmap[ord(ch)]
        pen = SVGPathPen(gs); gs[g].draw(pen)
        bp = BoundsPen(gs); gs[g].draw(bp)
        x0, y0, x1, y1 = bp.bounds
        s = th / (y1 - y0); sw = s * (x1 - x0)
        tf = (f"translate({(cx-sw/2)-s*x0:.2f},{(cy-th/2)+s*y1:.2f}) "
              f"scale({s:.5f},{-s:.5f})")
        return f'<path transform="{tf}" d="{pen.getCommands()}" fill="{fill}"/>'
    return path


def seigaiha(pid, color, op, tile, sw):
    h = tile / 2
    rs = [h, h * 0.75, h * 0.5, h * 0.25]
    circles = "".join(f'<circle cx="{cx}" cy="{h}" r="{r}"/>'
                      for cx in (0, h, tile) for r in rs)
    return (f'<pattern id="{pid}" width="{tile}" height="{h}" '
            f'patternUnits="userSpaceOnUse"><g fill="none" stroke="{color}" '
            f'stroke-opacity="{op}" stroke-width="{sw}">{circles}</g></pattern>')


def banner_svg(slug, ch, acc, glyph):
    """Seigaiha tide: accent field + cream scallops; centred moon+kanji if `ch`."""
    sfx = slug[:3]
    moon = ""
    if ch is not None:
        mcx, mcy, R, kth = W // 2, 100, 82, 116
        moon = (f'<circle cx="{mcx}" cy="{mcy}" r="{R}" fill="{CREAM}"/>'
                f'{glyph(ch, kth, mcx, mcy, acc)}')
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" '
            f'preserveAspectRatio="xMidYMid slice">'
            f'<defs>{seigaiha("s"+sfx, CREAM, 0.55, 150, 3)}</defs>'
            f'<rect width="{W}" height="{H}" fill="{acc}"/>'
            f'<rect width="{W}" height="{H}" fill="url(#s{sfx})"/>'
            f'{moon}</svg>')


def chrome():
    for c in ("google-chrome", "chromium",
              "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"):
        if os.path.exists(c) or shutil.which(c):
            return c
    return None


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--font", required=True, help="path to full Noto Serif JP .ttf")
    ap.add_argument("--out", default="../../images/chapter-art")
    ap.add_argument("--png", action="store_true", help="also rasterize to PNG via headless Chrome")
    ap.add_argument("--scale", type=int, default=2400, help="PNG width in px (height follows the SVG aspect)")
    ap.add_argument("--tokens", default="quarto/_tokens.json",
                    help="theme token JSON (from gen_theme.py) for the accent colours")
    a = ap.parse_args()

    global CREAM
    tok = {}
    if os.path.isfile(a.tokens):
        try:
            tok = json.load(open(a.tokens, encoding="utf-8"))
        except (ValueError, OSError):
            pass
    CREAM = tok.get("colors", {}).get("cream", CREAM)
    accents = {**FALLBACK_ACCENTS, **tok.get("chapter_accents", {})}
    fm = tok.get("front_matter_accent", FALLBACK_FM)
    entries = [(s, k, accents[s]) for s, k in KANJI] + [("frontmatter", None, fm)]

    os.makedirs(a.out, exist_ok=True)
    glyph = make_glyphs(a.font)
    ch_bin = chrome() if a.png else None
    for slug, ch, acc in entries:
        svg = banner_svg(slug, ch, acc, glyph)
        svg_path = os.path.join(a.out, slug + ".svg")
        open(svg_path, "w", encoding="utf-8").write(svg)
        print("wrote", svg_path)
        if a.png:
            if not ch_bin:
                print("  (skip PNG: Chrome not found)"); continue
            png_path = os.path.join(a.out, slug + ".png")
            subprocess.run([ch_bin, "--headless", f"--screenshot={png_path}",
                            f"--window-size={a.scale},{a.scale*H//W}",
                            "--force-device-scale-factor=1", "--hide-scrollbars",
                            "file://" + os.path.abspath(svg_path)],
                           check=True, capture_output=True)
            print("wrote", png_path)


if __name__ == "__main__":
    main()
