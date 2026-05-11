# SEO Guidelines for baltimore.ai

The 6 docs in this set translate RooferRate's SEO playbook to baltimore.ai's context: a single-metro, B2B-skewed directory of AI companies, research labs, and resources. Most rules transfer directly (and have ratios/limits worth treating as universal); some need adaptation for AI/B2B.

## The six docs

| File | What it covers | When to read it |
|---|---|---|
| [SEO_KEYWORD_CLUSTERS.md](SEO_KEYWORD_CLUSTERS.md) | Primary, affiliation, vertical, capability, intent, content clusters. Mapping pages → clusters. | Before writing a new page or guide. |
| [SEO_META_RULES.md](SEO_META_RULES.md) | `<title>` and meta description formulas per page type. Char limits. Canonical URLs. | When adding a new page type or auditing for duplicates. |
| [SEO_HEADER_RULES.md](SEO_HEADER_RULES.md) | One H1 rule. Headers-as-story test. Pillar page pattern. | When writing or editing a guide; when adding a new view. |
| [SEO_ANCHOR_TEXT_RULES.md](SEO_ANCHOR_TEXT_RULES.md) | 10/40/30/15 anchor distribution. Donor sources. Internal anchor discipline. | Before placing or paying for any inbound link. |
| [SEO_IMAGE_RULES.md](SEO_IMAGE_RULES.md) | Alt text, compression, filenames, OG cards (1200×630). | When adding any image, especially OG cards. |
| [SEO_TRUST_AND_POLISH.md](SEO_TRUST_AND_POLISH.md) | Foundational pages, schema-by-page, FAQ rules, E-E-A-T checklist, Core Web Vitals targets. | Pre-launch checklist; quarterly audit. |

## What changed from RooferRate

| Translates directly | Adapted | Dropped |
|---|---|---|
| Header rules (entire doc) | Geo cluster (single-metro now) | Multi-state expansion |
| Anchor text ratios | Trust signals (license → affiliation) | Click-to-call as primary CTA |
| Meta char limits + formulas | Schema types (`LocalBusiness` → `Organization`) | MHIC license framing |
| Image format + compression | Mobile traffic assumption (80% → 50%) | Emergency / 24-7 service intent |
| Foundational pages list | Donor sources (home improvement → tech press) | |

## The most important rules (TL;DR)

1. **One primary keyword per page** (keyword clusters doc).
2. **`<title>` ≤60 chars, meta description ≤160, brand last** (meta doc).
3. **One H1 per page; read your headers top to bottom — they should tell a story** (header doc).
4. **First link to a page uses exact-match anchor; diversify after** (anchor doc).
5. **Every image gets descriptive alt text and is ≤100 KB** (image doc).
6. **Ship the About page with a real person's name before broad outreach** (trust doc).

## Implementation status

What's already wired into code (verified at deploy time):

- ✅ Per-page `<title>` and meta description (`app/views/layouts/application.html.erb`)
- ✅ Canonical URLs
- ✅ Open Graph + Twitter Card tags
- ✅ Organization / WebSite / BreadcrumbList / ItemList / FAQPage / Article JSON-LD
- ✅ Sitemap.xml with thin-facet filter (≥3 entities to index)
- ✅ Robots.txt
- ✅ Single H1 per page; descriptive H2/H3
- ✅ Internal anchor text uses entity names, not "click here"

What's still TODO (tracked in [LAUNCH.md](LAUNCH.md)):

- ⏳ About / Contact / How It Works / Editorial Standards / Privacy / Terms pages
- ⏳ OG card generator (1200×630 per listing)
- ⏳ Logos on company listings (via claim flow)
- ⏳ Last-verified date display
- ⏳ GSC + Bing verification
- ⏳ Citation submissions
- ⏳ Outreach to top 10 seeded companies

## Auditing

Before any broad outreach push, run through this short audit:

```bash
# Duplicate title check
for slug in $(bin/rails runner 'puts Company.published.pluck(:slug)'); do
  curl -sS "https://baltimore.ai/companies/$slug" | grep -oE '<title>[^<]+</title>'
done | sort | uniq -d
# Should produce no output.

# JSON-LD validation
# Visit https://search.google.com/test/rich-results and test:
#   https://baltimore.ai/
#   https://baltimore.ai/companies/redshred
#   https://baltimore.ai/categories/healthcare_ai
#   https://baltimore.ai/guides/ai-companies-baltimore-2026
# All should pass with no errors.

# Sitemap validity
curl -sS https://baltimore.ai/sitemap.xml.gz | gunzip | xmllint --noout - && echo OK

# Core Web Vitals
# Run https://pagespeed.web.dev/ on the homepage + 1 company + 1 guide.
# All three should be in the "Good" range.
```

If any of those fail, fix before promoting the site.
