#!/usr/bin/env python3
"""Give every rendered HTML page a self-referencing canonical, and make the
sitemap advertise the home page in its canonical form.

Quarto emits no `<link rel="canonical">` for this book, and it lists the home
page in sitemap.xml as `.../aidou/index.html` while `og:url` (from gen_blurb.py)
declares the directory form `.../aidou/`. Both forms return 200, so those two
contradictory signals leave Google to index either — or both — with nothing to
settle it. This step fixes both ends:

  * every page canonicalises to *itself*. It must never be a single site-wide
    canonical pointing at the home page: that would tell Google the chapters are
    duplicates of "/" and suppress them from the index entirely.
  * index.html canonicalises to the directory form, matching og:url.
  * sitemap.xml's index.html entry is rewritten to the directory form, so the
    sitemap advertises only canonical URLs.

The base URL is read from `_quarto.yml` (`site-url`) so it stays in step with
the rest of the build. Idempotent: a page that already has a canonical is left
alone. Runs as a Quarto post-render step (before cachebust); runnable directly:
`python3 seo_canonical.py [output-dir]`.
"""
import os
import re
import sys

FALLBACK_SITE_URL = "https://christham.net/aidou/"


def site_url():
    """Read site-url from _quarto.yml (the build's single source), with a slash."""
    try:
        s = open("_quarto.yml", encoding="utf-8").read()
        m = re.search(r'^\s*site-url:\s*"?([^"\s#]+)"?', s, re.M)
        if m:
            u = m.group(1)
            return u if u.endswith("/") else u + "/"
    except OSError:
        pass
    return FALLBACK_SITE_URL


def main():
    out = (sys.argv[1] if len(sys.argv) > 1
           else os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book"))
    base = site_url()
    if not os.path.isdir(out):
        print(f"seo-canonical: no {out}/; skipping", file=sys.stderr)
        return

    added = 0
    for fn in sorted(os.listdir(out)):
        if not fn.endswith(".html"):
            continue
        path = os.path.join(out, fn)
        html = open(path, encoding="utf-8").read()
        if 'rel="canonical"' in html:
            continue
        href = base if fn == "index.html" else base + fn
        tag = f'<link rel="canonical" href="{href}">'
        new, n = re.subn(r"(<head[^>]*>)", lambda m: m.group(1) + "\n" + tag,
                         html, count=1)
        if n:
            open(path, "w", encoding="utf-8").write(new)
            added += 1
    print(f"seo-canonical: added a self-referencing canonical to {added} page(s)")

    sm = os.path.join(out, "sitemap.xml")
    if os.path.isfile(sm):
        s = open(sm, encoding="utf-8").read()
        new = s.replace(f"<loc>{base}index.html</loc>", f"<loc>{base}</loc>")
        if new != s:
            open(sm, "w", encoding="utf-8").write(new)
            print("seo-canonical: sitemap home entry -> canonical directory form")


if __name__ == "__main__":
    main()
