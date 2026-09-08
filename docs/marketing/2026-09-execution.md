# Baltimore.ai campaign execution ledger

Updated: September 8, 2026, after the user authorized execution. Campaign: `baltimore_ai_fall_2026`. First wave: **two public posts, four confirmed email sends, and one host-form submission with delivery unconfirmed**.

## Completed today

| Action | Verified outcome |
| --- | --- |
| Replace stale launch checklist | [30-day organic strategy](../LAUNCH.md) with audience, channel order, calendar, dependencies, measurement, and $0 paid-media budget |
| Prepare distribution | [Eight primary-source contact routes](2026-09-distribution-targets.md), tailored angles, and September deadlines |
| Prepare social and partner copy | [LinkedIn, three X posts, two outreach templates, partner blurb](2026-09-launch-copy.md); first-wave publication recorded below |
| Create concrete outreach drafts | Initially saved three addressed Gmail drafts for Johns Hopkins DSAI, Pava Center, and UpSurge; subsequently sent after authorization; [sent copy](2026-09-outreach-drafts.md) |
| Publish X launch | [Networking post on @justuseapen](https://x.com/justuseapen/status/2097373100023136741), September 8 at 17:14:49 UTC; live post and author verified |
| Publish LinkedIn launch | [Launch post on Justus Eapen's personal account](https://www.linkedin.com/feed/update/urn:li:share:7503141627100602368/), September 8; “Post successful” shown, permalink and author verified |
| Send three initial pitches | Hopkins DSAI, Pava Center, and UpSurge sent September 8 at 17:14 UTC; each read back with Gmail's SENT label |
| Send Technical.ly pitch | Contact form returned a validation error; the same pitch, addressed “Hi Katie,” was sent to Katie Malone's [published editorial email](https://katie-malone.com/) at 17:23 UTC; Gmail SENT verified |
| Submit AI Collective host message | Filled and submitted the approved message once through the Luma event's Contact the Host form. The dialog closed without a visible error; no durable delivery receipt or confirmation email was captured. Delivery remains unconfirmed; do not resend blindly |
| Create campaign links | [Nine tagged URLs](2026-09-campaign-links.json), all checked live: HTTP 200 and clean matching canonical |
| Deploy Google ownership verification | Public verification meta tag deployed in Fly release v6, September 8, 16:50 UTC; production homepage and health check pass |
| Verify Search Console property | `https://baltimore.ai/` ownership confirmed through the HTML tag in the existing personal owner account |
| Submit sitemap | `/sitemap.xml` submitted September 8; Google shows **Success**, last read September 8, **55 discovered pages**, zero videos |
| Request guide indexing | Fall events guide and September field report each returned **Indexing requested**, added to Google's priority crawl queue |
| Check AI search control | Settings → Search generative AI shows inherited default **Current control: Include**; no control change was necessary |
| Verify limited site change | 13 discovery/foundational integration tests, 143 assertions, no failures/errors; independent copy QA found one retirement-date inconsistency, now fixed |

The sitemap initially displayed “Couldn't fetch” while processing. A subsequent refresh showed Success and 55 discovered pages; no resubmission or sitemap code change was needed. Both guide inspections initially reported “URL is unknown to Google.” The successful requests are **not** evidence that either page is now indexed. Search performance and indexing reports are still processing.

Release image: `registry.fly.io/baltimore-ai:deployment-01M20YT9F1SGXNE5A0NT12WKXN`. The only application change is the public Google verification meta tag; preserve it in later deployments.

## Remaining work

| Item | Current status / next dependency |
| --- | --- |
| Later social posts | Poster-deadline and founder X posts are prepared for their planned dates. The second LinkedIn research post is planned; copy is not yet drafted. No scheduled posts created |
| Later external outreach | Techstars, TEDCO, and bwtech remain planned and uncontacted |
| AI Collective receipt | Host form submitted once; wait for a reply or independent confirmation before treating delivery as confirmed |
| Bing Webmaster Tools | Browser reached sign-in; no authenticated account, verification, or submission completed |
| Visitor attribution | No third-party visitor analytics; tagged URLs do not collect data themselves |
| Recurring execution | Calendar is a plan only; no automation or scheduled posts created |

The user authorized execution and signed into LinkedIn. The selected accounts are Justus Eapen's personal LinkedIn and @justuseapen on X. Application mail remains unconfigured; the confirmed outreach sends used the connected Gmail account. Copy directs readers to guides and organizers, not listing claims or sign-in.

## Results ledger

Record actual evidence here as distribution happens. Empty entries mean not yet measured or executed; do not turn them into zero traffic or zero interest.

| Date | Channel / target | Asset ID | Actual post or message receipt | Native link clicks, if available | Substantive responses | Verified placement URL | Next action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Sept 8 | X / @justuseapen | x_networking | [Live post](https://x.com/justuseapen/status/2097373100023136741), 17:14:49 UTC | Not measured | Not measured | Owned post only | Next X post in Sept 11–14 window |
| Sept 8 | Personal LinkedIn | linkedin_personal_launch | [Live post](https://www.linkedin.com/feed/update/urn:li:share:7503141627100602368/) | Not measured | Not measured | Owned post only | Respond to relevant comments when reviewed |
| Sept 8 | Hopkins DSAI | jhu_dsai_resource_outreach | Gmail SENT verified, 17:14 UTC | Not available | Not measured | None verified | Await reply |
| Sept 8 | Pava Center | pava_center_newsletter_outreach | Gmail SENT verified, 17:14 UTC | Not available | Not measured | None verified | Await reply |
| Sept 8 | UpSurge | upsurge_newsletter_outreach | Gmail SENT verified, 17:14 UTC | Not available | Not measured | None verified | Await reply |
| Sept 8 | Technical.ly / Katie Malone | technically_editorial_pitch | Gmail SENT verified, 17:23 UTC | Not available | Not measured | None verified | Await reply; no duplicate form submission |
| Sept 8 | AI Collective Baltimore hosts | ai_collective_host_outreach | Luma form submitted once; delivery unconfirmed | Not available | Not measured | None verified | Check for reply before any resend |

Gmail SENT confirms submission to Gmail, not recipient delivery or readership. The X page showed 22 native post views during verification around 13:31 Eastern; that is an early platform counter, not site visits, unique readers, or link clicks. No earned partner placement is claimed from sending a pitch.

## Measurement checkpoints

These are proposed work dates, not reminders or background jobs.

- **September 9–10:** when Google's processing completes, record the available coverage and performance baseline; inspect the two guide statuses without repeating successful indexing requests.
- **September 15:** retire the Pava / networking copy if still unsent. On September 16, retire the Hopkins deadline version if still unsent; verify whether the guide needs an editorial update.
- **September 22:** compare actual channel evidence and responses. A single relevant follow-up may be appropriate after seven days; stop on a decline.
- **October 8:** assess the strategy's planning targets: three independent mentions/shares and ten useful conversations. These are aspirations, not promised outcomes. Choose the next research topic from real demand.

Keep raw logs and Gmail draft/message identifiers outside the public repository. Use the exact subjects in the draft file to find and update existing drafts, rather than creating duplicates.
