# SEO Image Rules — baltimore.ai

**The rule.** Every image has descriptive, keyword-bearing alt text; is compressed and resized to display dimensions; is named with keywords; is unique per page. Image search is a secondary discovery surface, and social-card images dominate B2B distribution.

## Hard limits

| Property | Limit | Why |
|---|---|---|
| File size | ≤100 KB | Mobile users on slow connections; LCP scoring. |
| Hero / OG width | ~1200px | Display max; anything larger is wasted bytes. |
| Thumbnail width | 400–800px | Used in listing rows. |
| OG / Twitter card | exactly 1200×630 | LinkedIn, Twitter, Slack expect this aspect. |
| Format | WebP preferred, AVIF acceptable | 30–50% smaller than JPEG/PNG, supported everywhere. |
| Alt text length | ≤125 characters | Screen reader pacing; Google reads more but >125 is rarely useful. |

## Alt text discipline

Alt text serves two readers: screen reader users and Google. Both need a **concrete description** that also happens to include the relevant keyword. Stuffing keywords without describing the image is worse than no alt text.

| Image | Bad alt | Good alt |
|---|---|---|
| RedShred founder headshot | `image1.jpg` or `founder` | `RedShred founder at the company's Baltimore office` |
| Hopkins APL building exterior | `apl building` | `Johns Hopkins APL building in Laurel, MD` |
| Baltimore Inner Harbor skyline (hero) | `baltimore` or `city` | `Baltimore Inner Harbor at sunset — home to the city's AI cluster` |
| Company logo | `logo` | `RedShred logo` |
| Decorative pattern (no content) | `decorative pattern` | `""` (empty alt — see below) |

**Decorative images get `alt=""`.** Empty alt tells screen readers to skip; missing alt makes them read the filename. Always set one or the other.

## Filename conventions

Filenames are a weak signal but they're free. Use kebab-case, keyword-bearing names.

```
✓  redshred-logo.webp
✓  hopkins-apl-baltimore.webp
✓  baltimore-ai-companies-2026-hero.webp

✗  IMG_2847.jpg
✗  image-final-v2-USE-THIS.png
✗  logo.png  (in a directory with 30 logos)
```

## Image inventory by page type

| Page | Images needed | Notes |
|---|---|---|
| Homepage `/` | OG card (1200×630), favicon | OG is critical — most launch traffic comes from social. |
| `/companies/[slug]` | Logo (square, ≥400×400), OG card, optional team/office photo | Logo from company press kit; OG card auto-generated from logo + name. |
| `/categories/[slug]` | OG card | Auto-generated; vertical name + count. |
| `/resources/[slug]` | Logo / building photo | JHU, UMBC, FastForward provide press kits. |
| `/guides/[slug]` | OG card (1200×630), optional hero | Custom hero for guides we want to promote; OG card always required. |

## OG / social cards — the most important image you'll make

**B2B distribution is LinkedIn-heavy.** Every public page's OG image is what 90% of clicks see first. Standards:

- **Exact dimensions: 1200×630.** Off-spec sizes get cropped weirdly on different platforms.
- **Text-safe zone: center 1000×500.** LinkedIn and Twitter crop the edges on some layouts.
- **Readable at 600×315.** Phone previews shrink it. If the text is unreadable there, it's wrong.
- **Brand mark in a consistent corner.** Bottom-left works. Same place on every card.
- **High contrast.** Dark text on light bg or vice versa. No "white text on a busy photo."

```
Template for a company OG card:

  ┌──────────────────────────────────────────────────┐
  │                                                  │
  │   RedShred                          Baltimore.ai │
  │                                                  │
  │   AI-powered document intelligence               │
  │                                                  │
  │                                                  │
  │   APPLIED AI · BALTIMORE · FOUNDED 2014          │
  │                                                  │
  └──────────────────────────────────────────────────┘
```

We don't have automated OG card generation yet (TODO post-launch — use `og:image` defaults to the favicon for now). When implemented, generate at request time and cache to Active Storage.

## Source images responsibly

| Source | Use case | Caveats |
|---|---|---|
| Company press kits | Logos, team photos | Always preferred; companies expect to be listed. |
| Founder LinkedIn (public) | Headshots for guides | Only with attribution and only for editorial use. |
| Unsplash / Pexels | Stock for guides | Vet for AI-aesthetic clichés — neon hands holding holograms is a no. |
| Self-generated | Diagrams, illustrations, OG cards | Best long-term — distinctive and never DMCA-able. |
| AI-generated (Imagen, DALL-E) | Sparingly, for guides | Disclose in alt text. Risk of generic AI look. |

**Never use:**
- Watermarked stock photos.
- Photos from a company without their permission for editorial use (e.g. scraped from their site for our guide).
- Anything from a Google Images result without clearing the source.

## Lazy load below the fold

Native HTML attribute, no JS required:

```html
<img src="..." alt="..." loading="lazy" decoding="async" width="..." height="...">
```

**Always include `width` and `height` attributes** — even when CSS-sizing the image. They prevent CLS (Cumulative Layout Shift) on slow connections. Rails' `image_tag` helper accepts both.

## Uniqueness

Don't reuse the same hero image across multiple pages. Google's image-deduplication treats reused images as low-value. If you only have one hero photo, crop/recompose for each page.

The exception: small icons (chevrons, social-platform marks) are fine reused everywhere. The rule is about **content images**.

## Implementation status

| Rule | Current state | TODO |
|---|---|---|
| Alt text discipline | No images shipped yet | Apply when adding logos/OG cards |
| OG card generation | Falls through to favicon | Build OG-card generator service post-launch |
| WebP format | N/A | Use WebP for all new images |
| Lazy loading | N/A | Apply when adding images |
| Filename convention | N/A | Apply when adding images |

When we add the first logos (probably as part of company claim flow letting owners upload one), Active Storage variants should be configured to generate WebP at appropriate sizes. The `image_processing` gem is already in the Gemfile.

## Dos and don'ts

**Do:**
- Write alt text that would tell someone over the phone what the image shows.
- Resize to display dimensions before upload — never serve a 4000px image scaled down by CSS.
- Use a consistent visual tone across all OG cards. Same font, same brand mark placement.
- Test OG cards using LinkedIn Post Inspector, Twitter's Card Validator.

**Don't:**
- Don't leave images without `width` and `height` — CLS will tank Core Web Vitals.
- Don't ship a single image >100 KB without a deliberate reason. Even hero photos compress to ~80 KB at WebP quality 80.
- Don't keyword-stuff alt text. "Baltimore AI companies machine learning artificial intelligence directory image" is a no.
- Don't use the same photo on two pages and call it "unique because the alt text is different."
- Don't use AI-generated images for hero or OG without human review. Six-fingered hands and uncanny gradients destroy trust.

## RooferRate parallels (for reference)

- All format, compression, alt-text, filename, lazy-load, watermark, and uniqueness rules translate directly.
- RooferRate's "before/after project photos" → product screenshots, demo GIFs, architecture diagrams.
- RooferRate's "contractor truck / certification badges" → company logo + funding/accelerator badges (YC, NSF, TEDCO).
- RooferRate's "encourage contractors to upload during claim" → baltimore.ai's claim flow should accept logo + (optional) team photo. Not implemented yet.
- New on baltimore.ai: dedicated OG / social-card emphasis (1200×630). RooferRate's traffic is primarily Google Search and Maps; baltimore.ai's launch traffic is heavily LinkedIn/Twitter.
