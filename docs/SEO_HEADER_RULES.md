# SEO Header Rules — baltimore.ai

**The rule.** Exactly one H1 per page, containing the primary keyword. H2 and H3 rotate cluster synonyms and affiliation modifiers. UI labels never become headers. The page should make sense when you read only the headers top to bottom.

## The headers-as-story test

Read every H1, H2, H3 on a page in order, ignoring body text. **Does it sound like a coherent outline of what the page covers?** If not, fix the headers — not the body. This is the single best test for whether your headers are doing SEO work or are decorative.

Good (a company page):
> RedShred · AI-powered document intelligence platform · About RedShred · Similar applied AI companies in Baltimore

Bad (UI labels masquerading as structure):
> RedShred · Tags · Links · Similar

The bad version's "Tags" / "Links" should be paragraph labels or `<dt>` elements, not headers.

## One H1, always

Every page has exactly one `<h1>`. The H1:
- Contains the primary keyword from `SEO_KEYWORD_CLUSTERS.md`.
- Matches (or is a tighter variant of) the `<title>`.
- Is the largest, most prominent text on the page.

```
Page              H1 example
─────────────────────────────────────────────────────────────────
/                 The directory of AI in Baltimore.
/companies        AI companies in Baltimore
/categories/...   Healthcare AI in Baltimore
/companies/[slug] [Company name]    (the company is the entity)
/resources/...    [Resource name]
/guides/...       [Guide title]
```

## H2 / H3 patterns

H2s break the page into the 3–6 sections a reader scans. H3s subdivide where needed. **Rotate synonyms** across these — every H2 doesn't need the head keyword.

### Homepage (`/`) — pillar pattern

The homepage is the site's pillar page. H1 is the umbrella; H3s are the actual traffic drivers because they target long-tail searches.

```
H1  The directory of AI in Baltimore.
H2  Recently added
H2  Guides
H3    AI companies in Baltimore: a 2026 field guide
H3    Healthcare AI in Baltimore: the Hopkins effect
H3    Cybersecurity AI in the Baltimore-DC corridor
H2  Categories
H3    Applied AI · Healthcare AI · AI Consulting · ...
H2  Labs & resources
```

### Category hub (`/categories/healthcare_ai`)

```
H1  Healthcare AI in Baltimore
H2  Companies                       (the list of orgs)
H2  Frequently asked                (FAQPage source)
```

### Company detail (`/companies/[slug]`)

The company *is* the entity, so the company name is the H1. Sub-sections explain attributes.

```
H1  RedShred
H2  About RedShred                  (intro paragraph)
H2  Tags / Links / Founded          ← these are paragraph labels, NOT headers
H2  Similar applied AI companies in Baltimore
```

### Guide (`/guides/[slug]`)

The guide title is the H1; H2s and H3s come from the markdown body and should already rotate synonyms naturally because that's how good editorial reads.

```
H1  AI companies in Baltimore: a 2026 field guide
H2  The three Baltimore AI scenes
H3    Healthcare and life-sciences AI
H3    Cybersecurity AI
H3    Generalist applied AI and consulting
H2  What's missing
H2  Why this matters for hiring
```

## Synonym rotation

Across a single page's headers, vary how you refer to the entity class. Goal: hit each cluster variant once without it sounding mechanical.

| Entity | Acceptable variants |
|---|---|
| AI company | AI company, AI startup, machine learning firm, artificial intelligence company |
| Research lab | research lab, AI lab, research institute, applied research center |
| Founder / engineer | founder, AI engineer, researcher, ML engineer, technical lead |
| Baltimore metro | Baltimore, Baltimore metro, the Baltimore-DC corridor, the I-95 cluster |

**Do not** force four variants into four consecutive headers. Use the one that reads naturally; vary when natural variation is available.

## Use common names, not legal ones

Search behavior favors how people actually talk about an entity.

| Use | Not |
|---|---|
| Hopkins APL | The Johns Hopkins University Applied Physics Laboratory |
| UMBC | University of Maryland, Baltimore County |
| JHU | The Johns Hopkins University |
| MINDS | JHU Mathematical Institute for Data, Algorithms, and Decision-making |
| Tenable | Tenable Holdings, Inc. |

## Demote UI labels to paragraphs

A header should be a heading — a content scaffold. If it's a label for one field, it's not a header.

**Header (correct):**
> ## Similar applied AI companies in Baltimore

**Label (correct, NOT a header):**
> **Tags:** Natural Language Processing, Data Platform, Defense & National Security

The current `/companies/[slug]` view follows this rule — `Tags`, `Links`, `Founded`, `Team size`, `Location`, `Website` are styled like labels (small uppercase, neutral color) but are paragraph or `<dt>` elements, not headers.

## Thresholds

| Page type | Reasonable header count |
|---|---|
| Homepage | 4–6 H2s, 5–15 H3s (pillar) |
| Category hub | 2 H2s |
| Company detail | 2–4 H2s |
| Resource detail | 1–2 H2s |
| Guide | 3–6 H2s, 0–10 H3s |

**>20 headers** on any page means you're either oversectioning or treating UI as content.

## Dos and don'ts

**Do:**
- Run the headers-as-story test before publishing.
- Use the common name of an entity, not its legal/official name.
- Let H3s on the homepage carry long-tail keywords.
- Match H1 to `<title>` (tighter variant OK).

**Don't:**
- Don't have more than one H1 per page. Modern HTML allows it; Google's understanding still leans on document outline conventions, and the discipline forces clarity.
- Don't skip levels (H2 → H4). Browsers don't care; readers and screen readers do.
- Don't put the brand in the H1 ("Baltimore.ai — Healthcare AI in Baltimore"). The brand is in the `<title>` and header chrome.
- Don't make UI labels into headers.
- Don't keyword-pack a header. "Best AI companies in Baltimore, MD: top machine learning firms in Maryland 2026" — pick one.

## RooferRate parallels (for reference)

- The pillar pattern (H1 umbrella, H3s as traffic drivers) translates directly. RooferRate uses it on state pages; baltimore.ai uses it on the homepage.
- The "common name over legal name" rule is identical, only the examples change.
- The demote-UI-labels rule is identical.
- "Read headers as a story" test is identical.
