---
name: inject-article
description: >-
  Ingest a single cutting-edge article, post, or talk — an X (Twitter) link, a blog post, a newsletter, a
  LinkedIn piece, or a YouTube video (transcript) — and weave it into the book as one well-placed,
  honestly-flagged citation. Use whenever the user hands you a link (especially an opinion piece, a
  practitioner thread, an industry-leader post, or a conference talk) and says "treat this as a source",
  "ingest this", "add this article", or "cite this". These sources are usually emerging opinion rather
  than verified research, so the citation must say so. The skill runs the whole chain for one link:
  fetch (web pages via download-source; X/Twitter via the fxtwitter JSON mirror; YouTube via the
  youtube-transcript-api tool) → save to sources/ → summarise into summaries/ → find the single best home
  in book/*.md → cite it (flagged as emerging opinion) → update references.json → run the book-style loop
  on just that section → verify and build. It is the lightweight, single-link cousin of research-topic,
  and it reuses download-source, summarise-source, enhance-book, and book-style.
compatibility: >-
  YouTube transcript fetching needs the youtube-transcript-api CLI (jdepoix/youtube-transcript-api),
  installed at ~/.local/bin/youtube_transcript_api. Everything else uses curl and the repo's own scripts.
---

# inject-article

The user hands you a link to a current, opinion-shaped article and wants it in the book — ingested,
summarised, and cited in exactly one apt place, with the citation making clear it is an emerging view
rather than established practice. This skill formalises that chain for a single link.

Unlike [[research-topic]], there is no search stage: the user has already chosen the source. The work is
to fetch it faithfully, place it well, and cite it honestly. The source may be a written piece (article,
post, thread) or a talk (a YouTube video, ingested as its transcript). Do one link at a time; if the user
pastes several, run the chain per link (the placement search must see the citations the previous link
added).

## Why the "emerging opinion" flag matters

These sources are the frontier of practice: X threads, lab-leader essays, practitioner field guides. They
are valuable precisely because they are ahead of the literature — and unreliable for exactly the same
reason. Many are also self-interested (an engineer praising the tools they build; a CEO describing the
platform their company sells). The book's credibility rests on never dressing an opinion as a finding, so
**every citation from this skill must name what the source is and hedge accordingly** (see step 4).

## The chain

### 1. Fetch the article faithfully

Get the real text, not a preview. X/Twitter and many sites block scrapers and `WebFetch` (you will see
`402`, `403`, or a JS stub), so:

- **X / Twitter links** — hit the JSON mirror: `curl -sL https://api.fxtwitter.com/<user>/status/<id>`.
  A plain tweet's text is in `.tweet.text`; a long-form X *article* is in `.tweet.article` — its title is
  `.article.title`, its body is the `.article.content.blocks[]` array (join each block's `.text`, mapping
  `header*` types to headings and `*-list-item` to bullets). `api.vxtwitter.com` is a fallback.
- **YouTube links** — the source is the talk, not a page, so pull its transcript with the
  `youtube-transcript-api` tool (jdepoix/youtube-transcript-api, installed; CLI at
  `~/.local/bin/youtube_transcript_api`, so `export PATH="$HOME/.local/bin:$PATH"` first if it is not
  found). It takes a bare **11-character video ID, not a URL** — extract it from the link
  (`watch?v=`, `youtu.be/`, `/shorts/`, `/live/`, `/embed/`), e.g.
  `echo "$URL" | sed -E 's#.*(v=|youtu\.be/|/shorts/|/live/|/embed/)([A-Za-z0-9_-]{11}).*#\2#'`. Then:
  `youtube_transcript_api <VIDEO_ID> --format text --languages en` (use `--list-transcripts <ID>` to see
  what languages exist, and pick another if there is no English one). The transcript is the fetch;
  **its metadata is not** — the CLI gives you no title, channel, or date. Get the title and channel from
  the oEmbed endpoint (`curl -s "https://www.youtube.com/oembed?url=<full-url>&format=json"` →
  `title`, `author_name`), and the publish date from the watch page or the description; if you cannot
  confirm the date, say "n.d." rather than guess.
- **Ordinary web pages/blogs** — use [[download-source]] (its `html2md.py`, or the curl + strip-tags
  fallback). Verify you got the body, not a cookie wall.
- Capture, from the source itself: exact title, author (real name and/or handle), the author's role
  (it decides the conflict-of-interest flag), publication date, and the canonical URL. Never guess a
  surname; if the byline is a mononym or handle, cite it as given. For a video, the "author" is the
  speaker or channel and the container is "YouTube".

Save the extracted text to `sources/<topic>/<slug>.md` with a metadata header (source URL, author + role,
date, and a one-line "Type:" noting it is an opinion/vision/practitioner piece, not peer-reviewed). Pick
the `<topic>` folder that matches the subject (e.g. `ai-coding/`, `human-ai-future/`, `ai-governance/`);
create it if new.

### 2. Summarise it

Run [[summarise-source]] (or write the summary directly, following that skill's format) into
`summaries/<topic>/<slug>.md`. Two requirements specific to this skill:

- The `> [!NOTE]` block must **flag the source's status prominently**: opinion vs research, and any
  conflict of interest (does the author sell or build what they are praising?).
- **For a YouTube transcript, add one more caution.** An auto-generated transcript has no punctuation you
  can trust, no speaker labels, and it mis-hears names, numbers, and technical terms. So treat it as a
  rough record: paraphrase the argument rather than quoting long stretches, and quote a phrase verbatim
  only when it is plainly correct and you would stake the citation on it. Note in the header that the
  text is an auto-caption transcript, so a later reader knows why the wording is loose.
- **A long, multi-speaker source (a keynote block, a panel, a conference livestream) cannot be summarised
  whole — do not try.** Tens of thousands of words of speaker-unlabelled auto-caption will not let you
  attribute specific claims to specific people without inventing. Instead, narrow to what is *safely
  citable*: the framing you can verify (the event's own title/theme, the named opening speaker's thesis)
  and one or two ideas the transcript states plainly. Say in the summary exactly what you are *not*
  citing and why. The honest value of such a source is usually as a **dated snapshot of the field's mood**,
  not as evidence — cite it that way.
- End with a short **"Relation to the book"** paragraph naming the one or two sections whose argument this
  source most directly touches — this is your shortlist for step 3.

### 3. Find the single best home

Search the whole book for where the source's *central* claim reinforces (or usefully complicates) an
argument the book already makes. Prefer one strong placement over scattering the same source across
sections. Judgement calls:

- Place it where the source's **thesis** lands, not merely where a technique or phrase would fit.
- A cutting-edge opinion earns its place best **next to cited research on the same point** — as the
  practitioner's echo of a finding, or an industry view set against the evidence — so the reader sees the
  difference in weight.
- If the source genuinely supports two distinct, non-overlapping points, it may take two homes (as
  [[enhance-book]] allows) — but the default is one. Record the runners-up in the summary rather than
  citing everywhere.
- If it adds nothing the book does not already cover better, say so and cite nothing. A link is not an
  obligation.
- **If the source is the same argument by an author the book already cites** — a talk of an article you
  cited, a fuller version of the same post — do **not** add a second citation that says the same thing in
  the same place. *Refine* the existing one instead: correct or complete the author's name if this source
  verifies it (a conference listing or an oEmbed title often gives the full name a handle did not),
  update the citation, and, if the reader would value it, add the new form as a companion reference on the
  same in-text mention ("a case he makes both in a written guide [...] and a talk of the same name
  [...]"). Only open a citation in a *different* section if this source makes a genuinely *different*
  point there — and even then, weigh it against crowding a section that already carries the argument.

### 4. Cite it, flagged as emerging opinion

Weave one citation in via [[enhance-book]]'s conventions:

- APA-style inline link, first-mention-with-title, added to the chapter's References list (alphabetical)
  **and** to `references.json` (repo root). For a mononym/handle author, the intext is that name +
  year (e.g. `Thariq, 2026`); the reference line uses it verbatim with "X (formerly Twitter)" as the
  container.
- The prose must **state the source's status in the sentence**, in the author's voice — not a footnote.
  Patterns that work: "a practitioner's account offered as emerging craft rather than tested practice";
  "read it as an emerging industry view rather than a settled one — the author sells the tools they
  describe". Then say why it is still worth citing (it names the same skill the research points to; it is
  a striking statement of the book's own argument from an unexpected source).
- Keep to the house style: teach the idea plainly, keep a person in the sentence, no hype.

### 5. Run book-style on that section

Immediately run the [[book-style]] loop on **only the section you edited** (not the whole chapter). The
first draft of an inserted paragraph always carries a fingerprint or two — a mirror-payoff cap, a banned
abstraction like *compounding*, an em-dash chain. Do the rewrite → fresh-eyes check → fix loop until a
check pass on that section comes back clean. This step is mandatory: it is why the injected paragraph ends
up in the author's voice rather than the source's.

### 6. Verify and report

- `book-style/scripts/check_preservation.py` against the pre-edit file: the only change is the added
  citation URL; structure otherwise identical.
- Citation reconciliation: the new in-text URL resolves to the chapter's References list and to
  `references.json`; the reference list stays alphabetical.
- `cd quarto && ./build.sh` → "Output created".
- Report: source (title, author, role, date), where it landed and why, the exact hedge used, how many
  book-style rounds the section needed, and any runner-up placements you noted but did not use.

## Rules

- **One link at a time**; never batch the placement search.
- **Verify metadata at the source** — this flows into a citation. Never invent a surname or a date.
- **Always flag status and conflict of interest** in the citing sentence. This is the whole point of the
  skill; a bare citation of an opinion piece is a bug.
- **Do not commit or push** unless the user asks (the book's standing rule).
- Prefer **one honest citation** to three eager ones; respect the option to cite nothing.
