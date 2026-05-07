# Launch checklist for baltimore.ai

A pragmatic, ordered runbook for going from "deployed" to "publicly launched." Designed for solo execution — about a week of part-time effort end to end.

## 1. Deploy (day 1)

Follow [DEPLOY.md](DEPLOY.md). Ends with:
- baltimore.ai resolving to Fly behind HTTPS
- Postmark configured and a test email delivered to your own inbox
- `/up` returning 200
- `bin/rails db:seed` run on production with `ADMIN_EMAIL=you@yourdomain.com`

Do not announce the launch yet.

## 2. Self-test the claim flow (day 1)

Before anyone else hits the site:

- [ ] Visit `/companies/redshred` (or any unclaimed listing).
- [ ] Click "Claim this listing."
- [ ] Enter your name + an email at a domain you control.
- [ ] Confirm code arrives via Postmark.
- [ ] Walk all 4 wizard steps; complete the claim.
- [ ] Verify the listing now shows "Claimed" and you can edit.
- [ ] Visit `/admin/profile_claims` — verify the claim appears as `auto_approved`.
- [ ] Sign out. Visit `/sign-in`. Request a magic link. Confirm sign-in works.

If any step fails, fix before proceeding.

## 3. Search engine verification (day 2)

- [ ] **Google Search Console**: Add `https://baltimore.ai` (URL prefix property). Verify via DNS TXT or HTML file.
- [ ] **Bing Webmaster Tools**: Same.
- [ ] Submit `https://baltimore.ai/sitemap.xml.gz` to both.
- [ ] In GSC, request indexing for: `/`, `/companies`, `/guides`, `/companies/redshred` (or any 1 company), `/guides/ai-companies-baltimore-2026`.

## 4. Citations (days 2-4)

The plan flagged these as priority citations. Submit baltimore.ai to each:

- [ ] **[Technical.ly Baltimore](https://technical.ly/baltimore/)** — pitch via their tip line; their reporters cover this beat.
- [ ] **[Baltimore Business Journal](https://www.bizjournals.com/baltimore/)** — same; their tech reporter is the right contact.
- [ ] **[Economic Alliance of Greater Baltimore (EAGB)](https://greaterbaltimore.org/)** — listed as a regional resource.
- [ ] **[Greater Baltimore Committee](https://gbc.org/)** — they maintain a tech ecosystem map.
- [ ] **[FastForward U](https://ventures.jhu.edu/fastforward/)** — they have a community-resources page.
- [ ] **Baltimore Inno** — Inno markets keep a regional tech directory.

For each: send a short note explaining baltimore.ai exists, what it does, and asking them to link from their resources / ecosystem-map / member-directory page. Aim for 5 inbound links by end of week 1.

## 5. Direct outreach to seeded companies (days 3-5)

The plan's success metric: **40% of seeded listings claimed within 90 days.** That requires direct outreach. Email founders/marketing leads at the first ~10 most prominent seeded companies:

- [ ] [RedShred](https://baltimore.ai/companies/redshred)
- [ ] [Mindgrub](https://baltimore.ai/companies/mindgrub)
- [ ] [Fearless](https://baltimore.ai/companies/fearless)
- [ ] [Protenus](https://baltimore.ai/companies/protenus)
- [ ] [Sonavex](https://baltimore.ai/companies/sonavex)
- [ ] [ZeroFox](https://baltimore.ai/companies/zerofox)
- [ ] [Tenable](https://baltimore.ai/companies/tenable)
- [ ] [Huntress](https://baltimore.ai/companies/huntress)
- [ ] [Blackpoint Cyber](https://baltimore.ai/companies/blackpoint-cyber)
- [ ] [QOMPLX](https://baltimore.ai/companies/qomplx)

### Outreach template

```
Subject: Baltimore.ai listing for [Company]

Hi [name],

I run baltimore.ai, a new directory of AI companies and resources in the
Baltimore metro. I've added [Company] to the directory because you're one
of the [healthcare AI / cybersecurity AI / etc.] companies that anchor the
local cluster — current listing here:

  https://baltimore.ai/companies/[slug]

I wrote a short editorial blurb based on public information. You can claim
the listing in about two minutes (we email a verification code to your work
domain) and then edit it directly:

  https://baltimore.ai/claim/[slug]

If anything in the description is wrong, claim and fix it; if you'd rather
not be listed at all, just reply and I'll remove it.

— [your name]
```

## 6. Public launch (day 6-7)

Pick one weekday. Sequence:

- [ ] **Show HN**: post in the morning (US East). Title: "Show HN: baltimore.ai — directory of AI companies in Baltimore." First comment from your own account explaining why you built it (10-year domain, etc.).
- [ ] **Twitter/X**: thread from @justuseapen. Lead with the strongest editorial take from a guide (the field-guide intro line is good: "There isn't a single Baltimore AI scene — there are at least three").
- [ ] **LinkedIn**: same content, more company-focused angle. Tag 2-3 of the founders you've reached out to.
- [ ] **Local Slack/Discord**: Baltimore tech community spaces (look for ones tied to Tech Council of Maryland, ETC, FastForward U).
- [ ] **Hacker News (Show HN)** later in the day if traction is good elsewhere.
- [ ] **ProductHunt**: optional. PH is more useful for SaaS than directories; only do it if you have a strong launch image and 5-10 hunters lined up.

## 7. Post-launch monitoring (week 2+)

- [ ] Check `/admin` daily for pending review claims.
- [ ] Check Search Console weekly for indexing progress and impressions.
- [ ] Track claim rate: how many of the 24 published listings get claimed in 30 days? Aim for ≥10.
- [ ] Track inbound links via Search Console "Links" report.

## 8. DNS cutover from Marcaria

Currently `baltimore.ai` resolves wherever Marcaria's default DNS points. After Fly is set up:

- [ ] At Marcaria, update nameservers OR add A/AAAA records pointing at Fly.
- [ ] `fly certs add baltimore.ai && fly certs add www.baltimore.ai`
- [ ] Confirm both apex and www resolve.
- [ ] Eventually consider transferring the domain to Cloudflare Registrar — significantly cheaper for `.ai` and you get free DNS + WAF + edge caching.

## 9. Honest pre-launch flags

Things to do *before* you publicly announce, not after:

- [ ] **Verify the 6 hidden seed entries** (Stride.ai, Element Biosciences, Vita Inclinata, Scopio, Sparkfly, WillowTree). Either confirm a real Baltimore connection and republish, or delete from the seed entirely. Currently they're hidden with TODO comments in `db/seeds/...` — see `db/seeds.rb`.
- [ ] **Walk the site on a real phone.** Not just headless 1280px. Especially the claim wizard.
- [ ] **Read each of the 5 guides aloud**, looking for: factual errors, dated claims, broken internal links, anything that sounds like generic AI content.
- [ ] **Open every outbound link** in the seeded companies and resources to make sure none have died since you wrote the blurb.

## 10. Out of scope (fine to defer)

These are real but not worth blocking launch on:

- People entity (founders, engineers)
- Newsletter
- Events / meetup calendar
- Job board
- Comparison pages (`/compare/a-vs-b`)
- Public API
- Featured / paid listings

---

**Rough timeline:** day 1 deploy + self-test, days 2-4 verification + citations, days 3-5 outreach, day 6-7 launch, week 2+ monitor.
