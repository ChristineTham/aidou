---
name: download-source
description: >-
  Download a source into the repo's sources/ tree, in the right form and place. Use whenever the user
  wants to fetch/save/grab a source — an arXiv paper, a web page or article, an analyst PDF — given a
  source from search-topic or a URL/arXiv id the user names. Puts arXiv papers as PDFs in sources/arXiv/,
  converts HTML pages to Markdown in the right sources/<topic>/ folder (creating the topic folder if new),
  and downloads other PDFs into sources/<topic>/. Reports the local path. Pair with search-topic (before)
  and summarise-source (after).
argument-hint: 'A source URL or arXiv id (+ topic), or a source row from search-topic.'
user-invocable: true
---

# download-source

Get one or more sources onto disk under `sources/`, correctly named and placed, ready for
`summarise-source`. This skill only fetches and files — it does not summarise.

## Where each kind goes

| Source kind | Destination | Form |
|---|---|---|
| **arXiv paper** | `sources/arXiv/<id>-<slug>.pdf` | **PDF, always** (regardless of topic) |
| **Web page / article** | `sources/<topic>/<slug>.md` | **Markdown** (converted from HTML) |
| **Non-arXiv PDF** (analyst report, journal PDF, book) | `sources/<topic>/<slug>.pdf` | PDF |

- **arXiv PDFs live together** in `sources/arXiv/` — that is the repo convention, so an arXiv paper goes
  there whatever book topic it serves. Its topic still matters for the *summary* (which lands in
  `summaries/arXiv/`) and for citing it later, so keep the topic noted.
- **Everything else** goes under its **topic folder**, `sources/<topic>/`. If the topic is new, create the
  folder (kebab-case, matching the taxonomy — see the topic list in [[search-topic]]).
- **Slug**: kebab-case from the title (e.g. `chain-of-thought-prompting`). For arXiv use `<id>-<slug>`.
- **Never clobber**: if the target file already exists, say so and stop unless the user wants it refreshed.

## How to fetch

**arXiv** — use the helper (downloads the PDF into `sources/arXiv/`):

```bash
python scripts/fetch_arxiv.py <id> <slug>        # e.g. 2201.11903 chain-of-thought
```

It verifies the file isn't a tiny error page. It does **not** write a summary — that's `summarise-source`.

**Non-arXiv PDF**:

```bash
curl -sL -A "Mozilla/5.0" "<url>" -o "sources/<topic>/<slug>.pdf"
```

Then sanity-check it's a real PDF (`file`/size), not an error/login page.

**Web page → Markdown** — fetch the page and save clean Markdown to `sources/<topic>/<slug>.md`. Either:

- fetch the readable content (a reader tool, WebFetch, or `pandoc <url_or_html> -o out.md`) and save it; or
- save the raw HTML into `sources/<topic>/` and run the bundled converter, which strips
  script/style/nav/footer chrome and turns headings/lists/paragraphs into rough Markdown:

  ```bash
  python scripts/html2md.py sources/<topic> --delete   # <slug>.html -> <slug>.md, removes the .html
  ```

  The converter is quick-and-rough — good enough for research notes. Trim any leftover site boilerplate
  so the file is real content, not menus.

## After downloading

- Report the local path(s) written.
- Keep the **canonical source URL** (arXiv `abs`, DOI, or page) with each file — the citation needs it,
  and `summarise-source` puts it in the summary header.
- Natural next step: run [[summarise-source]] on each downloaded file.

## Rules

- **arXiv is always a PDF.** Do not save an arXiv paper as HTML/Markdown.
- Verify a download succeeded (non-trivial size, right file type) before moving on.
- Match the existing topic taxonomy; only invent a new topic when nothing fits, and name it in kebab-case.
