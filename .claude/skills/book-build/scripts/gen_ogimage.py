#!/usr/bin/env python3
"""Generate the Open Graph / social-share image from the book cover.

Produces a 1200x630 landscape re-layout of `images/cover.svg`: the text block
(tagline, "AI-dō" title, subtitle + accent, author) on the left, and the
decorative graphic (glitch "AI" + 道 + 愛 + heart) scaled down and bled off the
top-right, over the shared seigaiha background. Every element is reused verbatim
from cover.svg's outlined paths — so re-run this whenever the cover changes.

Outputs (into images/): ogimage.svg (source of truth). With --render it also
rasterises ogimage.png (headless Chrome) and ogimage.jpg (macOS `sips`, exactly
1200x630) — the JPG is what the site's og:image / twitter:image points at.

Usage:
  gen_ogimage.py [--cover images/cover.svg] [--out images/ogimage.svg] [--render]
"""
import argparse
import os
import re
import subprocess
import sys

W, H = 1200, 630

# --- Layout, tuned interactively. Left column = text; top-right = graphic. ---
TITLE_W, TITLE_X, TITLE_TOP = 600, 56, 74        # tagline+title+subtitle+accent
AUTHOR_W, AUTHOR_X, AUTHOR_BOTTOM = 235, 56, 588
LOGO_W, LOGO_RIGHT, LOGO_BOTTOM = 200, 1150, 588
GRAPHIC_SCALE = 0.5                              # exact
GRAPHIC_RIGHT, GRAPHIC_TOP = 1236.0, -0.6       # bbox right edge / top (bleeds off)

CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"


def _tf(p):
    m = re.search(r'transform="([^"]*)"', p)
    if not m:
        return 0, 0, 1, 1
    tr = m.group(1)
    tx, ty = [float(x) for x in re.search(r'translate\(([^)]*)\)', tr).group(1).split(',')]
    s = re.search(r'scale\(([^)]*)\)', tr).group(1).split(',')
    return tx, ty, float(s[0]), float(s[1] if len(s) > 1 else s[0])


def _coords(p):
    d = re.search(r'\bd="([^"]*)"', p).group(1)
    n = [float(x) for x in re.findall(r'-?\d+\.?\d*(?:e-?\d+)?', d)]
    return n[0::2], n[1::2]


def _pbbox(p, parent=(0, 0, 1, 1)):
    xs, ys = _coords(p)
    tx, ty, sx, sy = _tf(p)
    px, py, ps, psy = parent
    X = [px + ps * (tx + x * sx) for x in xs]
    Y = [py + psy * (ty + y * sy) for y in ys]
    return min(X), min(Y), max(X), max(Y)


def _union(bbs):
    return (min(b[0] for b in bbs), min(b[1] for b in bbs),
            max(b[2] for b in bbs), max(b[3] for b in bbs))


def _classify(paths):
    """Bucket cover paths by role from their fill colour and document order:
    graphic (everything before the tagline), then the tagline / title / subtitle
    / author / logo runs. Robust to glyph-count (text-length) changes."""
    fills = [((re.search(r'fill="([^"]*)"', p) or [None, ''])[1]) for p in paths]
    first_tag = next(i for i, f in enumerate(fills) if f == "#85677B")
    b = {"graphic": list(range(first_tag))}
    i = first_tag
    def run(cols):
        nonlocal i
        start = i
        while i < len(paths) and fills[i] in cols:
            i += 1
        return list(range(start, i))
    b["tagline"] = run({"#85677B"})
    b["title"] = run({"#27272A"})
    b["subtitle"] = run({"#615F5F"})
    b["author"] = run({"#27272A"})
    b["logo"] = run({"#B565A7", "#D2386C"})
    return b


def build_svg(cover_svg):
    svg = open(cover_svg, encoding="utf-8").read()
    defs = svg[svg.find("<defs>"):svg.find("</defs>") + 7]
    paths = re.findall(r'<path\b[^>]*>', svg)
    accent = re.search(r'<rect x="128" y="1044"[^>]*>', svg).group(0)
    owl = re.search(r'<g transform="translate\(1412\.2.*?</g>', svg, re.S).group(0)
    owl_parent = (*re.search(r'translate\(([^)]*)\)', owl).group(1).split(','),)
    owl_tx, owl_ty = float(owl_parent[0]), float(owl_parent[1])
    owl_s = float(re.search(r'scale\(([^)]*)\)', owl).group(1))
    b = _classify(paths)

    # accent rect bbox (fixed placement in cover space)
    accent_bb = (128, 1044, 260, 1050)
    G = _union([_pbbox(paths[i]) for i in b["graphic"]])
    T = _union([_pbbox(paths[i]) for i in (b["tagline"] + b["title"] + b["subtitle"])] + [accent_bb])
    A = _union([_pbbox(paths[i]) for i in b["author"]])
    owl_bb = _union([_pbbox(op, (owl_tx, owl_ty, owl_s, owl_s))
                     for op in re.findall(r'<path\b[^>]*>', owl)])
    L = _union([_pbbox(paths[i]) for i in b["logo"]] + [owl_bb])

    def gt(tx, ty, s):
        return f'translate({tx:.2f},{ty:.2f}) scale({s:.5f})'

    def J(idxs):
        return "".join(paths[i] for i in idxs)

    # transforms (map each block's cover-space bbox into the OG layout)
    sT = TITLE_W / (T[2] - T[0]); txT = TITLE_X - sT * T[0]; tyT = TITLE_TOP - sT * T[1]
    sA = AUTHOR_W / (A[2] - A[0]); txA = AUTHOR_X - sA * A[0]; tyA = AUTHOR_BOTTOM - sA * A[3]
    sL = LOGO_W / (L[2] - L[0]); txL = LOGO_RIGHT - sL * L[2]; tyL = LOGO_BOTTOM - sL * L[3]
    sG = GRAPHIC_SCALE; txG = GRAPHIC_RIGHT - sG * G[2]; tyG = GRAPHIC_TOP - sG * G[1]

    g = b["graphic"]
    return "\n".join([
        '<?xml version="1.0" encoding="UTF-8"?>',
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">',
        defs,
        f'<rect width="{W}" height="{H}" fill="#F4EEE8"/>',
        f'<rect width="{W}" height="{H}" fill="url(#seigaiha)"/>',
        # graphic (backdrop, top-right) — original per-part opacities preserved
        f'<g transform="{gt(txG, tyG, sG)}">'
        f'<g fill-opacity="0.5">{J(g[0:2])}</g>'
        f'<g fill-opacity="1">{J(g[2:4])}</g>'
        f'<g fill-opacity="0.6">{J(g[4:5])}</g></g>',
        # text (on top), full opacity
        f'<g transform="{gt(txT, tyT, sT)}">{J(b["tagline"] + b["title"] + b["subtitle"])}{accent}</g>',
        f'<g transform="{gt(txA, tyA, sA)}">{J(b["author"])}</g>',
        f'<g transform="{gt(txL, tyL, sL)}">{J(b["logo"])}{owl}</g>',
        '</svg>',
    ])


def render(svg_path):
    png = os.path.splitext(svg_path)[0] + ".png"
    jpg = os.path.splitext(svg_path)[0] + ".jpg"
    subprocess.run([CHROME, "--headless", f"--screenshot={png}",
                    f"--window-size={W},{H}", "--force-device-scale-factor=1",
                    "--hide-scrollbars", "file://" + os.path.abspath(svg_path)],
                   check=True, stderr=subprocess.DEVNULL)
    subprocess.run(["sips", "-s", "format", "jpeg", "-s", "formatOptions", "88",
                    png, "--out", jpg], check=True, stdout=subprocess.DEVNULL)
    print(f"rendered {png} + {jpg} ({W}x{H})")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cover", default="images/cover.svg")
    ap.add_argument("--out", default="images/ogimage.svg")
    ap.add_argument("--render", action="store_true",
                    help="also rasterise ogimage.png + ogimage.jpg (needs Chrome + sips)")
    a = ap.parse_args()
    open(a.out, "w", encoding="utf-8").write(build_svg(a.cover))
    print(f"wrote {a.out}")
    if a.render:
        render(a.out)


if __name__ == "__main__":
    main()
