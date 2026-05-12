---
title: Revenue model for baltimore.ai (on the existing directory, no new wedge)
status: brainstorm
date: 2026-05-11
---

# Revenue model for baltimore.ai

## What we're building

A revenue model layered on top of the existing baltimore.ai directory —
no new product surface, no marketplace, no weekly content commitment.
Three revenue streams stacked: lead-gen brokerage (C), featured listings (A),
and sponsored guides (B). All three share the same prerequisites:
traffic + the foundational pages already on the LAUNCH.md TODO list.

## Why this approach (and what we ruled out)

The session that produced this doc walked through:

1. **Talent marketplace** (people profiles + jobs board + weekly digest) →
   Killed after verifying Baltimore AI job volume (~70-110 live roles,
   ~100-180 new/quarter). The volume *barely* supports a digest, but the
   $2-10k/mo revenue ceiling doesn't justify the weekly content
   commitment, especially against "depends on momentum" time budget.
2. **Vendor procurement / RFP** → Considered but not chosen.
   Longest payback period of the three wedges; requires buyer-side
   liquidity before vendors will pay.
3. **Events** → Ruled out; different business than directory work,
   high production-energy requirement.

**What's left:** the directory itself. Monetize it directly without
building a new surface. This is the conservative play and the honest one
given "I want revenue" + "depends on momentum" + "inbound traffic as
north star."

## Key decisions

### Three revenue streams, layered in sequence

**Stream C (foundation): Lead-gen brokerage.**
- "Request an introduction" CTA on company pages and category hubs.
- Inquiry → routes to the listed vendor + 2-3 similar vendors.
- Vendors pay $200-500/lead, billed monthly.
- Builds on existing claim flow (claimed companies opt in to receive leads).
- Works from day one — doesn't need huge traffic, just qualified buyer intent.
- Realistic revenue: $500-2000/mo at 12 months.

**Stream A (month 3+): Featured listings.**
- "Featured" section at top of `/companies`, `/categories/*`, homepage.
- Companies pay $99-299/mo to appear there.
- Requires ~1k+ monthly visits to be defensible.
- Realistic revenue: $500-2000/mo at 12 months (5-10 featured slots).

**Stream B (month 6+): Sponsored guides.**
- Companies pay for a guide written *about* their work or their vertical.
- Clearly labeled "Sponsored by [Company]."
- $1-5k per piece.
- Requires authority + traffic + editorial credibility.
- Realistic revenue: 2-4 sponsored guides/quarter = $4-20k/quarter.

**Combined ceiling at 12 months if all three are working:** ~$3-10k/mo.
Not life-changing; meaningful side-project revenue.

### Build sequence (the non-obvious part)

All three revenue streams share the same prerequisites. **Don't build
any of them until the prerequisites ship.** The prerequisites are:

1. **About page** — naming a real person (the curator). Highest-leverage
   E-E-A-T move. Without it the site looks like an SEO shell and no
   buyer/vendor will trust it.
2. **Editorial Standards page** — what gets listed, what triggers manual
   review, where the editorial line is. Buyers and vendors both read this
   to decide whether the directory's signal is trustworthy.
3. **How It Works page** — explains the claim flow + moderation.
   Reduces support load before it appears.
4. **Privacy + Terms** — required for any monetization. Stripe won't
   even let you onboard without these.
5. **OG cards (1200×630)** — every page that gets shared on LinkedIn
   needs a real social card. The default favicon-as-OG kills click-through.
6. **Contact form** — required for lead-gen (Stream C) to work.

These ship before any of A/B/C. Most are 1-2 hours of work each;
total ~1 week of part-time effort.

### What we explicitly are NOT building

- `/people` (engineer/consultant profiles). Legal/ethical complexity,
  small audience.
- `/jobs` board. Volume marginal, weekly digest commitment too high
  for time budget.
- Weekly email digest. Same.
- Annual hiring report. Same.
- Public API. Premature.
- Subscriber-paid premium tier (paywalled directory). The directory's
  value is being free + discoverable; paywall breaks SEO.
- Events platform. Different business.

## Open questions

- **How do we structure the "Request an introduction" flow?**
  Options: (a) form on every claimed company page, (b) form on category
  hubs that routes to 2-3 vendors, (c) both. The RooferRate analog is
  closer to (b) — buyer self-qualifies by category, you route to top vendors.
- **Who decides which 2-3 vendors a lead routes to?**
  Options: round-robin among paying vendors; pinned editorial choice;
  buyer picks from a list. Different revenue/UX trade-offs.
- **How transparent is the "Featured" label?**
  RooferRate makes it explicit. Worth doing the same here — opacity erodes
  the directory's editorial credibility, which is the entire moat.
- **Stripe vs Lemon Squeezy for billing?**
  Stripe is standard; LS handles VAT/sales tax automatically. For B2B
  US billing Stripe is fine.
- **Is the editorial standards page strong enough to survive a sponsored guide?**
  Need to draft the policy *before* taking the first sponsorship.
  "Sponsored doesn't mean we recommend" must be unambiguous.

## Resolved questions

- **Talent marketplace?** → No. Volume thin, time commitment too high.
- **Jobs board?** → No. Same reason.
- **Which revenue streams?** → A + B + C, all on the existing directory.
- **What about D (no monetization, personal-brand asset)?** → Considered.
  User prefers active monetization to passive brand-building.
- **What about E (hold and sell)?** → Considered. User prefers continued
  development.
- **Build sequence?** → Foundational pages first; C, A, B in order.

## Risk register

- **The single biggest risk:** zero traffic for 90 days. Without traffic,
  A and B don't work and C produces ~0 leads/month. Mitigation: execute
  LAUNCH.md aggressively for the first 90 days (citations, outreach to
  seeded companies, press push). Without that, nothing else matters.
- **Editorial credibility erosion:** if sponsored guides aren't clearly
  labeled, or if featured listings squeeze out quality, the directory's
  authority crumbles. Mitigation: explicit Editorial Standards page;
  visible "Sponsored" / "Featured" labels; cap on featured slots.
- **Concentration risk on Streams A/B:** the same 5-10 paying companies
  drive most revenue. If one drops, revenue is volatile. Mitigation:
  acceptable for a side project; not acceptable for a venture.
- **Time commitment:** Stream B (sponsored guides) requires editorial
  effort per piece. Sets a floor on "depends on momentum" — if you have
  zero hours for 4 weeks, you can't deliver a sold sponsorship.
  Mitigation: only sell guides you have time for; price high enough
  that 2-4/quarter is enough.

## Success criteria (12 months in)

- $1k+ MRR from at least one stream (likely C first)
- 1k+ monthly organic visits per Google Search Console
- 20+ claimed companies (out of 24 published, plus newly added)
- 5+ inbound citations (Technical.ly, BBJ, EAGB, GBC, JHU)
- 1 sponsored guide published with clear "Sponsored by" labeling
- Stripe Atlas / billing infrastructure live

If we hit none of these at 12 months: revisit. The directory still has
value as a personal-brand asset and a domain that compounds (.ai city
domains appreciate). No catastrophe in walking away.

## Why this is the right answer

- **Doesn't require new product surface.** Every revenue stream attaches
  to pages that already exist.
- **Doesn't require ongoing content commitment** (Stream C is passive;
  Streams A/B are intermittent).
- **Doesn't require a marketplace cold-start.** No two-sided liquidity
  problem.
- **Failure modes are bounded.** Worst case: site stays live, no revenue,
  no extra ongoing cost (the directory itself is the only commitment).
- **Compounds with LAUNCH.md execution.** Every citation, every claimed
  listing, every guide helps all three streams.

The honest framing: this is not a venture. It's a side-project directory
that pays for itself, gives you authority in Baltimore AI, and *could*
become more if you choose to invest more later. That fits the actual
time + motivation profile better than the SaaS-wedge framing did.
