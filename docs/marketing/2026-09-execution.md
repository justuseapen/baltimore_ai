# Baltimore.ai campaign execution ledger

Updated: September 8, 2026. Campaign: `baltimore_ai_fall_2026`.

## Completed today

| Action | Verified outcome |
| --- | --- |
| Replace stale launch checklist | [30-day organic strategy](../LAUNCH.md) with audience, channel order, calendar, dependencies, measurement, and $0 paid-media budget |
| Prepare distribution | [Eight primary-source contact routes](2026-09-distribution-targets.md), tailored angles, and September deadlines |
| Prepare social and partner copy | [LinkedIn, three X posts, two outreach templates, partner blurb](2026-09-launch-copy.md); all unposted |
| Create concrete outreach drafts | Three addressed Gmail drafts for Johns Hopkins DSAI, Pava Center, and UpSurge; verified with the DRAFT label; [exact copy](2026-09-outreach-drafts.md) |
| Create campaign links | [Nine tagged URLs](2026-09-campaign-links.json), all checked live: HTTP 200 and clean matching canonical |
| Deploy Google ownership verification | Public verification meta tag deployed in Fly release v6, September 8, 16:50 UTC; production homepage and health check pass |
| Verify Search Console property | `https://baltimore.ai/` ownership confirmed through the HTML tag in the existing personal owner account |
| Submit sitemap | `/sitemap.xml` submitted September 8; Google shows **Success**, last read September 8, **55 discovered pages**, zero videos |
| Request guide indexing | Fall events guide and September field report each returned **Indexing requested**, added to Google's priority crawl queue |
| Check AI search control | Settings → Search generative AI shows inherited default **Current control: Include**; no control change was necessary |
| Verify limited site change | 13 discovery/foundational integration tests, 143 assertions, no failures/errors; independent copy QA found one retirement-date inconsistency, now fixed |

The sitemap initially displayed “Couldn't fetch” while processing. A subsequent refresh showed Success and 55 discovered pages; no resubmission or sitemap code change was needed. Both guide inspections initially reported “URL is unknown to Google.” The successful requests are **not** evidence that either page is now indexed. Search performance and indexing reports are still processing.

Release image: `registry.fly.io/baltimore-ai:deployment-01M20YT9F1SGXNE5A0NT12WKXN`. The only application change is the public Google verification meta tag; preserve it in later deployments.

## Prepared, not executed

| Item | Current status / next dependency |
| --- | --- |
| Public social posts | No posts published or scheduled; select the personal or branded account and give a clear publishing instruction |
| External outreach | Three Gmail drafts saved, zero messages sent; review recipient and text before an explicit send instruction |
| AI Collective / Technical.ly | Copy ready; verified routes are host/editorial contact forms; neither form submitted |
| Bing Webmaster Tools | Browser reached sign-in; no authenticated account, verification, or submission completed |
| Visitor attribution | No third-party visitor analytics; tagged URLs do not collect data themselves |
| Recurring execution | Calendar is a plan only; no automation or scheduled posts created |

The account-selection question is pending. Search setup and prepared assets proceed independently. Application mail remains unconfigured, so campaign copy directs readers to guides and organizers, not listing claims or sign-in.

## Results ledger

Record actual evidence here as distribution happens. Empty entries mean not yet measured or executed; do not turn them into zero traffic or zero interest.

| Date | Channel / target | Asset ID | Actual post or message receipt | Native link clicks, if available | Substantive responses | Verified placement URL | Next action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| — | — | — | — | — | — | — | — |

## Measurement checkpoints

These are proposed work dates, not reminders or background jobs.

- **September 9–10:** when Google's processing completes, record the available coverage and performance baseline; inspect the two guide statuses without repeating successful indexing requests.
- **September 15:** retire the Pava / networking copy if still unsent. On September 16, retire the Hopkins deadline version if still unsent; verify whether the guide needs an editorial update.
- **September 22:** compare actual channel evidence and responses. A single relevant follow-up may be appropriate after seven days; stop on a decline.
- **October 8:** assess the strategy's planning targets: three independent mentions/shares and ten useful conversations. These are aspirations, not promised outcomes. Choose the next research topic from real demand.

Keep raw logs and Gmail draft/message identifiers outside the public repository. Use the exact subjects in the draft file to find and update existing drafts, rather than creating duplicates.
