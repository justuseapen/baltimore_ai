# Resend setup for baltimore.ai

End-to-end setup for production transactional email via [Resend](https://resend.com). ~15 minutes total, mostly waiting for DNS to propagate.

## Why Resend

- Single API key, no separate "username" / "server token" dance.
- Free tier: 100 emails/day, 3,000/month — comfortably above baltimore.ai's projected volume for at least the first 6 months.
- Clean dashboard, useful per-message debugging, no marketing fluff.

## Steps

### 1. Sign up (1 minute)

[resend.com/signup](https://resend.com/signup) → use your real email. No credit card required for the free tier.

### 2. Add and verify the sender domain (5-10 minutes including DNS propagation)

In Resend → **Domains** → **Add Domain** → enter `baltimore.ai`.

Resend will give you 3-4 DNS records to add at your registrar (Marcaria right now):

| Type | Name | Value | Purpose |
|---|---|---|---|
| MX | `send` | `feedback-smtp.us-east-1.amazonses.com` (priority 10) | Bounce/feedback handling |
| TXT | `send` | `v=spf1 include:amazonses.com ~all` | SPF |
| TXT | `resend._domainkey` | `p=...` (long key Resend provides) | DKIM |
| TXT | `_dmarc` (optional but recommended) | `v=DMARC1; p=none;` | DMARC monitoring |

Add them at Marcaria, then wait. Resend's verification typically clears within 5-10 minutes once Cloudflare's resolver sees the records.

### 3. Create an API key (30 seconds)

In Resend → **API Keys** → **Create API Key** → name it `baltimore-ai-production` → permission: **Sending access** (not Full access — least privilege).

Copy the key (`re_xxxxxxxxxxxxxxxxxxxxxxx`) somewhere safe. **Resend only shows it once.**

### 4. Set the Fly secret (10 seconds)

```sh
fly secrets set --app baltimore-ai SMTP_PASSWORD=re_xxxxxxxxxxxxxxxxxxxxxxx
```

That's the only secret needed. The other SMTP env vars (`SMTP_ADDRESS=smtp.resend.com`, `SMTP_PORT=587`, `SMTP_USERNAME=resend`) have sensible defaults in `config/environments/production.rb`.

Fly will automatically redeploy the running machine to pick up the new secret.

### 5. Verify end-to-end (1 minute)

Submit the contact form on the live site at https://baltimore.ai/contact. The message should arrive at `ADMIN_EMAIL` within ~30 seconds. Then check Resend's **Emails** dashboard to confirm delivery.

If the email doesn't arrive:

- **Check Resend's dashboard first.** It'll show whether the message left Resend (delivery succeeded) or got bounced/rejected.
- `fly logs --app baltimore-ai` — look for `ContactMessageMailer` lines.
- If Rails says delivery succeeded but the email never arrives, your sender domain probably isn't fully verified yet. Wait 5 more minutes for DNS, then check Resend's Domains page.

## What we send via Resend

| Mailer | Trigger | Recipient |
|---|---|---|
| `ContactMessageMailer#notify_admin` | Contact form submission | `ADMIN_EMAIL` |
| `SessionMailer#magic_link` | User requests sign-in | The user |
| `ProfileClaimMailer#verification_code` | User initiates a listing claim | The claimant |
| `ProfileClaimMailer#admin_new_claim` | Non-domain-match claim needs review | `ADMIN_EMAIL` |
| `ProfileClaimMailer#welcome` | Claim completed | The new owner |

All five run through `deliver_later` (Solid Queue) — Resend handles them async.

## Costs

Free tier covers everything until baltimore.ai is doing real volume:

- 100 emails/day, 3,000/month free.
- Pro tier ($20/mo) bumps to 50,000/month if you ever need it.

For baltimore.ai's launch volume, you're going to use ~5-50 emails per month for the first quarter. The free tier is fine indefinitely.

## Domain alternatives

If you don't want to verify `baltimore.ai` itself (e.g. you want to keep MX records on a different provider), Resend also supports sending from a subdomain like `mail.baltimore.ai`. Update `MAIL_FROM` accordingly:

```sh
fly secrets set MAIL_FROM="Baltimore.ai <hello@mail.baltimore.ai>"
```

Same DNS records, just on the subdomain instead of the apex.

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Domain stuck in "Verifying" | DNS not propagated | Wait 10 min; check with `dig TXT resend._domainkey.baltimore.ai @1.1.1.1` |
| Rails logs "delivery succeeded" but no email | Domain not yet verified | Verify in Resend dashboard before sending real mail |
| Resend dashboard shows "Bounced" | Recipient's mail server rejected it | Check the bounce reason — usually a typo'd address |
| All emails going to spam | Missing DMARC | Add the `_dmarc` TXT record from Step 2 |
