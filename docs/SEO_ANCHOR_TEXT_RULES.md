# SEO Anchor Text Rules — baltimore.ai

**The rule.** Build a diversified anchor-text profile across all inbound links — internal and external. First link to a destination uses exact-match anchor; subsequent links rotate partial / branded / generic. Track every paid or placed link; let organic anchors be whatever donors choose.

## Target distribution

These ratios are the standard for a healthy backlink profile and apply identically regardless of vertical. Calibrate over your first 20–30 backlinks.

| Anchor type | Share | Example |
|---|---|---|
| Exact match | 10–15% | `Baltimore AI companies directory` |
| Partial match | 35–45% | `this list of Hopkins-affiliated AI startups` |
| Branded | 25–30% | `baltimore.ai`, `Baltimore.ai` |
| Generic | 10–20% | `here`, `this directory`, `read more` |

**Exact match dominates → Google's spam classifiers fire.** A 50%+ exact-match profile reads like a paid SEO campaign. The 10–15% target keeps the signal natural.

## Anchor types defined

- **Exact match.** The exact target keyword. Strong ranking signal; sparingly used.
- **Partial match.** Contains the target keyword but with surrounding words ("the leading Baltimore AI directory").
- **Branded.** The brand name or domain ("baltimore.ai", "Baltimore.ai").
- **Generic.** No keyword content ("read this", "here", "this guide").

## First-link / second-link discipline

The first time you (or a partner you can direct) links to a page, use an **exact-match** anchor. The page gets its strongest signal from that first link. After that, **diversify** — never two identical exact-match anchors in a row from the same donor.

```
Donor A → /companies         link 1: "Baltimore AI companies directory"   (exact)
Donor A → /companies         link 2: "the curated list at baltimore.ai"   (partial + branded)
Donor B → /companies         link 1: "AI companies in Baltimore"          (exact)
Donor C → /companies         link 1: "this directory"                      (generic — fine, low value)
```

## Priority pages (the link targets that matter)

When you're proposing anchor text for placements you control (guest posts, sponsorships, citation submissions), prioritize these targets in this order:

1. Homepage `/` — anchor: "Baltimore AI companies directory" / "baltimore.ai"
2. Top category hubs — anchor: "healthcare AI companies in Baltimore", "cybersecurity AI in the Baltimore-DC corridor"
3. Top guides — anchor: the guide's title or a tighter variant
4. Specific company pages — only when a donor has a natural reason to link to one company

Don't waste a high-authority external link on a deep, low-traffic page.

## Donor sources

Replace RooferRate's home-improvement / Yelp / BBB donor list with B2B-tech sources.

| Tier | Source | Typical link type |
|---|---|---|
| Local press | Technical.ly Baltimore, Baltimore Business Journal, Baltimore Inno | editorial follow |
| Industry press | The Information, TechCrunch, Axios Local, MIT Tech Review | editorial follow (high value) |
| Aggregators | Hacker News, Product Hunt | no-follow but high citation value |
| Tech communities | dev.to, IndieHackers, r/MachineLearning | mixed |
| Founder/investor lists | AngelList, Crunchbase, F6S, Built In | usually no-follow (citation > link juice) |
| Academic / institutional | JHU news, UMBC press, FastForward U, TEDCO | follow (high trust) |
| Personal sites | founder blogs, GitHub READMEs | follow (high relevance) |
| Newsletters | Tech Council of Maryland, Maryland Tech newsletters | follow |

**No-follow links still matter.** Crunchbase, LinkedIn, AngelList: their no-follow links don't pass PageRank but produce citation signals, referral traffic, and indexing prompts.

## Internal anchor text

The same rules apply inside the app. Internal links from one guide to a company should use descriptive anchors, not "click here":

| Bad | Good |
|---|---|
| `read more` | `the Hopkins healthcare AI cluster` |
| `here` | `Personal Genome Diagnostics` |
| `this company` | `RedShred's document intelligence platform` |

Existing guide content already follows this (see `db/seeds/guides.rb` — internal links use entity names or descriptive phrases). When writing new guides or category hubs, keep it.

## Track everything

For any link you placed, paid for, or asked for, log it. A simple sheet works:

| Date | Donor URL | Target URL | Anchor text | Type | Follow? | Notes |
|---|---|---|---|---|---|---|
| 2026-05-15 | technical.ly/baltimore/launches | baltimore.ai | "Baltimore AI companies directory" | exact | yes | Launch coverage |

After every ~10 placements, compute the distribution. Adjust the next batch toward the target ratios.

## Paid / sponsored placements

If you pay for a link, **verify do-follow** before you sign off. Some publishers default to no-follow on sponsored content; some will flip it on request, others won't.

Disclosure: `rel="sponsored"` on paid links is Google's preference. It still passes signal weight but flags the relationship.

## Dos and don'ts

**Do:**
- Vary anchor text across donors and across placements from the same donor.
- Let organic anchors (anything you didn't author) be whatever the donor chose. Even if it's "click here." Don't try to retroactively normalize.
- Audit periodically. Distribution drifts; rebalance the next batch.
- Use anchors that match the surrounding content's semantic context.

**Don't:**
- Don't accept a paid link without verifying follow / sponsored attributes.
- Don't use two identical exact-match anchors in adjacent paragraphs of the same donor page.
- Don't anchor "buy AI software" or other commercial-intent stuff to baltimore.ai — it's a directory, not an e-commerce destination, and commercial-intent anchors mismatched to a directory look manipulated.
- Don't use "Baltimore AI directory listings best top companies machine learning" as one anchor. Keyword-stuffed anchors are the easiest spam pattern for Google to catch.

## RooferRate parallels (for reference)

- The 10-15 / 35-45 / 25-30 / 10-20 ratios are universal — they translate directly with no adjustment.
- RooferRate's donor list (Yelp, BBB, Angi, home-improvement blogs) → baltimore.ai's donor list (Crunchbase, AngelList, HN, Technical.ly, GitHub, JHU news).
- The first-link / second-link discipline is identical.
- The "let organic anchors be whatever" rule is identical.
