# Brief: make the AI-dō book discoverable from christham.net

**For an agent working in the christham.net root site repo** (the Astro v5.4.1 site that
serves `https://christham.net/` and generates `sitemap-index.xml`). This brief is
self-contained — you do not need the book repo to do any of it.

## Background

The book *AI-dō* is published at **https://christham.net/aidou/**. It is **deployed
separately** (from the `ChristineTham/aidou` repo, via its own GitHub Pages workflow) and
is *not* built by this Astro site. Do **not** try to take over building or deploying it —
the only job here is to make it **discoverable**.

## The problem (audited 15 July 2026)

The book is **not in Google's index at all** — an exact-phrase search for its unique
subtitle returns nothing. It is an orphan: Googlebot has no path to it.

Evidence, all reproducible with `curl`:

| Check | Finding |
|---|---|
| `https://christham.net/robots.txt` | `Allow: /` (not blocking) → advertises only `Sitemap: https://christham.net/sitemap-index.xml` |
| `sitemap-index.xml` → `sitemap-0.xml` | **1084 URLs, 0 of them under `/aidou/`** |
| `https://christham.net/aidou/sitemap.xml` | Exists, valid, 12 correct URLs — but **referenced nowhere** |
| Link from `christham.net` homepage → `/aidou/` | **None** |

So the book's own sitemap is fine; nothing tells Google it exists.

The book side is already fixed (self-referencing canonicals, sitemap advertises the
canonical `/aidou/` home URL, on-page text). **Everything remaining is in this repo.**

## Task 1 — Register the book's sitemap (highest value)

The book's sitemap is already correct; just point Google at it. **Preferred fix:** add a
second `Sitemap:` line to this site's robots.txt. Multiple `Sitemap:` directives are valid
and Google reads them all:

```
Sitemap: https://christham.net/sitemap-index.xml
Sitemap: https://christham.net/aidou/sitemap.xml
```

Find how robots.txt is produced in this repo (commonly `public/robots.txt`, or an
integration/endpoint that generates it) and add the line there, not to build output.

*Alternative or complement:* `@astrojs/sitemap` supports a `customPages` option, which can
add external URLs into `sitemap-0.xml`. Only use this if adding the robots.txt line is
awkward — it duplicates URLs this site does not own, and they would need manual updating
when the book gains pages. The robots.txt line stays correct automatically.

**Do not** add `/aidou/*` as Astro routes or redirects — it is a separate deploy.

## Task 2 — Link to the book from christham.net

Internal links are how crawlers actually discover pages (and they pass authority). Add at
least one link from an indexed page — the homepage, a projects/writing list, or the nav —
to `https://christham.net/aidou/`.

Use descriptive anchor text, not "click here". Good: **AI-dō — The Way of AI, grounded in
practice**. Because the book should also be findable by the romanised spelling, wording
that includes "aidou" naturally is a bonus (e.g. *AI-dō (aidou)*). Match the site's
existing style — do not invent a new component if a list/card pattern already exists.

## Task 3 — Search Console (hand back to Chris — an agent cannot do this)

This one needs a human with account access. Report it as a follow-up:

1. In Google Search Console, for the `christham.net` property, **submit the sitemap**
   `https://christham.net/aidou/sitemap.xml`.
2. Use **URL Inspection → Request Indexing** on `https://christham.net/aidou/`.

This is the fastest path — days rather than weeks. Tasks 1 and 2 make the book
discoverable; Task 3 makes it *prompt*.

## Verify before you report done

After the site deploys:

```bash
# 1. robots.txt advertises both sitemaps
curl -s https://christham.net/robots.txt | grep -i sitemap

# 2. the book's sitemap is reachable and valid (should print 12)
curl -s https://christham.net/aidou/sitemap.xml | grep -c "<loc>"

# 3. the homepage really links to the book
curl -s https://christham.net/ | grep -oE 'href="[^"]*aidou[^"]*"'
```

All three must return the expected output. Note the book will not appear in search results
immediately even once fixed — the site is new, so indexing takes time; Task 3 is what
accelerates it.

## Scope / constraints

- Touch only this repo. Do not modify the book's content, build, or deploy.
- Do not commit or push unless Chris asks.
- Do not add `noindex`, redirects, or rewrites for `/aidou/`.
