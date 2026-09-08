# Deploying baltimore.ai to Fly.io

## First-time setup

```sh
# 1. Create the Fly app (matches name in fly.toml)
fly apps create baltimore-ai

# 2. Provision Postgres
fly postgres create --name baltimore-ai-db --region iad
fly postgres attach --app baltimore-ai baltimore-ai-db

# 3. Set secrets
fly secrets set RAILS_MASTER_KEY=$(cat config/master.key)
fly secrets set APP_HOST=https://baltimore.ai
fly secrets set APP_HOST_NAME=baltimore.ai
fly secrets set MAIL_FROM="Baltimore.ai <hello@baltimore.ai>"
fly secrets set ADMIN_EMAIL=you@yourdomain.com

# 4. Configure outbound email (Resend)
#    See docs/RESEND_SETUP.md for the full walkthrough.
#    Short version: resend.com → verify baltimore.ai sender domain
#    (add SPF + DKIM DNS records) → create an API key → set as SMTP_PASSWORD.
fly secrets set SMTP_PASSWORD=re_xxxxxxxxxxxxxxxxxxxxxxx

# 5. Deploy
fly deploy
```

After the first deploy, point `baltimore.ai` DNS at Fly:
- `fly certs add baltimore.ai`
- Add the A/AAAA records Fly prints to your registrar (Marcaria → eventually move to Cloudflare).

## Routine deploys

```sh
fly deploy
```

The release command runs `bin/rails db:prepare`, which is idempotent.

## Publishing a researched content refresh

Run migrations with the normal deployment, then import the versioned research catalog:

```sh
fly ssh console --app baltimore-ai -C "./bin/rails content:refresh"
```

The content task preserves company-managed records and makes all changes in one database transaction. It does not create admin accounts or send mail. Before a production refresh, save a private backup of the current curated content; the retirement list hides records without deleting them. Check the resulting company/resource/guide counts and verify the published field report.

## Sitemap

`/sitemap.xml` is generated from current published records on each request. It includes current modification dates and excludes hidden records and thin categories. The legacy `/sitemap.xml.gz` URL redirects to it. Do not generate files under `public/sitemap.xml*`, because a static file would shadow these routes.

## Monitoring

- `/up` — health check (Fly reads this every 30s)
- `fly logs` — live logs
- `fly status` — current machine status

## Rollback

```sh
fly releases   # find a prior version id
fly deploy --image <image-from-prior-release>
```
