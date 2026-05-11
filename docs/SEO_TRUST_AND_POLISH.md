# SEO Trust & Polish — baltimore.ai

**The rule.** Every public page is responsive (B2B traffic skews desktop), uses structured data correctly, has the foundational pages search engines and skeptics look for, and demonstrates E-E-A-T (experience, expertise, authoritativeness, trustworthiness) through real attribution.

This doc adapts RooferRate's `SEO_TRUST_MOBILE_POLISH.md` for an AI/B2B context. The biggest changes: traffic isn't 80% mobile, click-to-call isn't the primary CTA, and the trust signals are fundamentally different (no MHIC license to verify — instead, funding, affiliation, security certifications).

## Traffic assumption

| Audience | Approximate device split |
|---|---|
| Engineers, founders, recruiters | 55–65% desktop |
| Researchers (academic-side) | 60–70% desktop |
| Local press, citation submitters | 50/50 |

**Plan for ~50/50** — responsive across breakpoints, no "mobile-first" framing that gates desktop affordances. This is the opposite of RooferRate's assumption.

## Foundational pages (TODO — not yet built)

A directory that doesn't have these reads as unfinished and ranks worse. Build these before any broad outreach:

- [ ] `/about` — what baltimore.ai is, who runs it, how listings are curated. Must name a real person/company (E-E-A-T).
- [ ] `/contact` — at minimum, an email. Optionally a contact form that creates an admin notification.
- [ ] `/how-it-works` — explains the claim/verify flow, moderation, what gets listed.
- [ ] `/editorial-standards` — how curated entries are written, what triggers a manual review, where the editorial line is drawn.
- [ ] `/privacy` — minimal but real privacy policy. Required for Google's trust signals and basic compliance.
- [ ] `/terms` — terms of use. Same.

Layout chrome (header + footer) should link to all six.

## Schema-by-page-type

Three layers per page (already implemented):

| Page | Site graph (always) | Page-specific |
|---|---|---|
| Home `/` | Organization + WebSite | (none extra) |
| `/companies` | site graph | `ItemList` + `BreadcrumbList` |
| `/companies/[slug]` | site graph | `Organization` (the company) + `BreadcrumbList` |
| `/categories` | site graph | `BreadcrumbList` |
| `/categories/[slug]` | site graph | `ItemList` + `BreadcrumbList` + `FAQPage` |
| `/resources` | site graph | `BreadcrumbList` |
| `/resources/[slug]` | site graph | `Organization` (the resource) + `BreadcrumbList` |
| `/guides` | site graph | `BreadcrumbList` |
| `/guides/[slug]` | site graph | `Article` + `BreadcrumbList` |

**Do not use `LocalBusiness`** for AI companies, even though it superficially fits. Google's 2026 docs explicitly flag misuse of `LocalBusiness` for non-storefront orgs. Use `Organization` (or a specific subtype like `SoftwareApplication`, `ResearchOrganization`) instead. The current implementation gets this right.

**Validate after deploy.** Use [Google's Rich Results Test](https://search.google.com/test/rich-results) on:
- `/` — Organization + WebSite
- `/companies/redshred` — Organization
- `/companies` — ItemList
- `/categories/healthcare_ai` — FAQPage + ItemList
- `/guides/ai-companies-baltimore-2026` — Article

All five should pass at deploy time.

## FAQ pages

Currently implemented on category hubs (`app/views/categories/show.html.erb`). Rules:

- 3–5 questions per page. Fewer feels thin; more reads like SEO bait.
- Questions are unique per page. Don't reuse the same FAQ across multiple categories.
- Answers are real and useful. "How many AI companies are in Baltimore?" → an actual count, not boilerplate.
- Visible to users AND emitted as `FAQPage` JSON-LD. Hidden-only FAQ is a Google policy violation.

When adding FAQs to other page types (homepage, About, How It Works), follow the same rules.

## Trust signals — the AI/B2B substitution

RooferRate trusts contractors by surfacing licenses, insurance, and BBB ratings. Those are wrong here. The equivalents:

| RooferRate (don't use) | baltimore.ai equivalent |
|---|---|
| MHIC license number | YC / TechStars / FastForward / TEDCO badge |
| Liability insurance | Funding round (Series A, etc.) with date |
| BBB rating | GitHub stars, arxiv citations, NSF grants |
| Years in business | Founding year + last_verified_at |
| Customer reviews | Press mentions (Technical.ly, BBJ, TechCrunch) |
| Service area map | "Baltimore-headquartered" / "Hopkins APL spinout" — affiliation |

When the claim flow lets companies upload enrichment data (post-launch), make these fields first-class on the company detail page. Until then, the editorial blurb carries the trust signal.

**Show `last_verified_at` on the page.** "Verified by RedShred · May 2026" tells users (and Google) the info is current.

## Foundational page templates

Quick sketches for the missing foundational pages. Build these as Rails views; no need for a CMS.

### /about — must mention a real person

> **Baltimore.ai is a directory of AI companies, research labs, and resources in the Baltimore metro.**
>
> Built and curated by [Justus Eapen](https://justuseapen.com), who has worked in Baltimore tech for [...] years and watched the AI scene grow up around Hopkins APL, UMBC, and the I-95 corridor. Editorial entries are written by hand; companies can claim and edit their own listings via the [claim flow](/sign-in).
>
> Have a correction or want to be listed? [Contact us](/contact).

This is the most important page for E-E-A-T. Without a named person and a real-sounding bio, the site reads as low-trust.

### /how-it-works

> 1. **Curated to start.** Every listing starts as an editorial entry written from public information.
> 2. **Claim your listing.** Companies can claim an entry by verifying an email at the company's domain. Auto-approves when the email and website domain match; otherwise routes to manual review.
> 3. **Edit anytime.** After claiming, you sign in with a magic link to edit your own listing.
> 4. **Moderation.** Manual-review claims are approved within 7 days. Stale claims auto-reject after 30.

### /editorial-standards

> - Listings cover companies based in or with significant operations in the Baltimore metro.
> - "Significant presence" means a real office, leadership in the region, or a substantive multi-year program tie. Distributed-team-with-one-Baltimore-engineer doesn't count.
> - Editorial blurbs are written by hand; we don't auto-generate company descriptions.
> - Funding, headcount, and founding year are sourced from public records (Crunchbase, SEC filings, official company sites) and verified at last-verified date shown on the listing.
> - When in doubt, we err toward not listing.

This is what credibility looks like. Six paragraphs is enough.

## Click intent — what the page asks users to do

| Page | Primary CTA | NOT this |
|---|---|---|
| Homepage | "Browse companies" | "Get a free quote" / "Call now" |
| Company detail | "Visit website" (outbound) or "Claim listing" (for unclaimed) | "Call this company" |
| Guide | Internal link to next guide or category | (no commercial CTA) |
| Category hub | "Browse [vertical] companies" | (none) |

Click-to-call (`tel:` links) is the wrong primary CTA for AI-vendor discovery. Click-to-website ("Visit redshred.com") and click-to-claim are the right primary actions.

## Mobile tap targets (still apply, just less central)

When a button or link must be tappable on mobile:

- Min 44×44 px hit area (Apple HIG; Android material design agrees).
- 8px spacing between adjacent tap targets.
- Sufficient color contrast (WCAG AA: 4.5:1 for body, 3:1 for large text).

The current Tailwind styles meet these defaults; spot-check after design changes.

## E-E-A-T checklist

Google's E-E-A-T (Experience, Expertise, Authoritativeness, Trustworthiness) factors. For a niche directory:

| Factor | How baltimore.ai signals it |
|---|---|
| Experience | Editorial guides written from first-hand Baltimore tech experience (named author on About) |
| Expertise | Specific, opinionated guides (`healthcare-ai-baltimore-hopkins.md`) — not generic content |
| Authoritativeness | Inbound citations from Technical.ly, BBJ, EAGB, GBC (per LAUNCH.md) |
| Trustworthiness | About + Editorial Standards + named curator + claim flow audit trail |

The single highest-leverage move for E-E-A-T is **shipping the About page with a real person's name and credentials.**

## Performance & Core Web Vitals

Targets that pass Google's "good" thresholds:

| Metric | Target |
|---|---|
| LCP (Largest Contentful Paint) | < 2.5s |
| INP (Interaction to Next Paint) | < 200ms |
| CLS (Cumulative Layout Shift) | < 0.1 |
| Page weight | < 200 KB excluding images |

Current implementation: server-rendered Rails + Tailwind, importmap-rails (no bundler), very small JS surface. Should pass Web Vitals comfortably. **Verify with [PageSpeed Insights](https://pagespeed.web.dev/) on the live URL** after the next round of design changes.

## RooferRate parallels (for reference)

- The foundational-pages list is identical (About, Contact, How It Works, Privacy, Terms).
- The breadcrumbs + JSON-LD schema discipline translates directly. Schema *types* shift (`LocalBusiness` → `Organization`).
- FAQPage rules are identical.
- 80–85% mobile assumption is **inverted** — B2B skews desktop. Adjust mental model.
- Click-to-call CTA is **replaced** with click-to-website / click-to-claim.
- License/insurance trust modifiers are **replaced** with funding/affiliation/security-cert modifiers.
- "About page must name a real person" rule is identical and more important here, not less.
