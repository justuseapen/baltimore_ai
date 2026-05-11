# SEO Meta Rules — baltimore.ai

**The rule.** Every page has a unique meta title ≤60 characters with the primary keyword front-loaded and the brand last; meta description ≤160 characters, written for click-through, with one trust signal. Title and H1 match — no surprises.

## Hard limits

| Element | Max length | Why |
|---|---|---|
| `<title>` | 60 chars | Google truncates around 580px wide; 60 chars is a safe ceiling. |
| Meta description | 160 chars | Truncates around 160 desktop / 120 mobile. Lead with the most important 120. |
| OG title | 60 chars | Same as `<title>`. Layouts above the fold rarely show more. |
| OG description | 160 chars | LinkedIn/Twitter card previews truncate near 160. |

## Title formulas by page type

The brand is `Baltimore.ai` — short, distinct, doubles as the URL. **Always last**, separated by `·`.

| Page | Formula | Example |
|---|---|---|
| Homepage `/` | `[Primary keyword] · Baltimore.ai` | `AI companies in Baltimore · Baltimore.ai` |
| Companies index `/companies` | `AI companies in Baltimore · Baltimore.ai` | (same) |
| Category `/categories/[slug]` | `[Vertical] in Baltimore · Baltimore.ai` | `Healthcare AI in Baltimore · Baltimore.ai` |
| Company `/companies/[slug]` | `[Company] · Baltimore AI directory · Baltimore.ai` | `RedShred · Baltimore AI directory · Baltimore.ai` |
| Resource `/resources/[slug]` | `[Resource] · Baltimore.ai` | `Johns Hopkins APL · Baltimore.ai` |
| Resources index `/resources` | `Baltimore AI labs & resources · Baltimore.ai` | (same) |
| Guide `/guides/[slug]` | `[Guide title] (YYYY) · Baltimore.ai` | `AI companies in Baltimore (2026) · Baltimore.ai` |
| Guides index `/guides` | `Guides to AI in Baltimore · Baltimore.ai` | (same) |

**The year on guide titles is non-optional.** "(2026)" tells users it's fresh and lets Google index dated-search variants ("ai companies baltimore 2026").

## Meta description formulas

Lead with concrete numbers (company counts, year). End with an action or hook. **No filler.**

| Page | Formula |
|---|---|
| Homepage | `A curated directory of {N} AI companies, research labs, and resources in the Baltimore metro.` |
| Category hub | `{N} Baltimore-area AI companies in {vertical} — including {top 3 names}.` |
| Company | `{Company tagline}. Founded {year}, based in Baltimore. Part of the Baltimore.ai directory.` (or company-supplied) |
| Resource | `{Resource} — a {type} supporting AI work in Baltimore.` (or resource-supplied) |
| Guide | First 160 chars of the guide intro, hand-edited if needed for a strong CTA. |

## Implementation in the app

These rules are already enforced in code. Reference points:

- `app/views/layouts/application.html.erb` — sets defaults via `content_for :title` and `content_for :meta_description`, plus canonical URL.
- `app/helpers/application_helper.rb#page_title` — joins parts with `·` and appends `Baltimore.ai`.
- Each view's first two lines override per-page values.

When adding a new page type, follow that pattern. **Never let a page fall through to the layout default title** — that's how duplicate-title penalties happen.

## Canonical URLs

- One canonical URL per page. Defined in the layout from `request.path`.
- No `?utm_*` indexed variants. Strip tracking parameters at the canonical level.
- Slugs are flat, kebab-case, no category prefix (a company can span verticals; the URL shouldn't churn when categorization shifts).

## Uniqueness audit

Every published page must have a unique `<title>` and unique meta description. Quick check:

```bash
# After deploy, run from local:
for slug in $(bin/rails runner 'puts Company.published.pluck(:slug)'); do
  curl -sS "https://baltimore.ai/companies/$slug" | grep -oE '<title>[^<]+</title>'
done | sort | uniq -d
```

If anything appears, fix before broad outreach.

## Dos and don'ts

**Do:**
- Match `<title>` exactly to the H1 (or to a tighter variant of it).
- Front-load the primary keyword.
- Use `·` as the separator. Consistent visual identity in SERPs.
- Templatize per page type — never hand-author a one-off.
- Add the year to guide and category titles when content is dated.

**Don't:**
- Don't include `MD` or `Maryland` in titles. The `.ai` brand telegraphs Baltimore; those characters are better spent on a vertical or affiliation word.
- Don't duplicate titles across pages. A category page and its lone company page must not share a title.
- Don't put the brand first. `Baltimore.ai — AI companies in Baltimore` wastes the most valuable real estate on a known brand.
- Don't keyword-stuff descriptions ("AI Baltimore best top companies firms machine learning"). Read aloud — if it sounds like a phishing email, rewrite.
- Don't emoji-pad titles for CTR. Looks spammy in SERPs and inconsistent across devices.

## RooferRate parallels (for reference)

- RooferRate appends state abbreviations (`MD`, `VA`) to titles for multi-state distinction. baltimore.ai doesn't — single-metro, brand telegraphs location.
- RooferRate's per-page-type formulas translate directly; only the noun changes ("roofer" → "AI company").
- RooferRate's "(2026)" year-tag rule on cost guides applies identically to baltimore.ai's editorial guides.
