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

## Sitemap regeneration

The sitemap is regenerated as part of release if you add to the release script,
or run on demand:

```sh
fly ssh console -C "bundle exec rake sitemap:create"
```

For now, run locally before deploy or wire into the release command if it grows.

## Monitoring

- `/up` — health check (Fly reads this every 30s)
- `fly logs` — live logs
- `fly status` — current machine status

## Rollback

```sh
fly releases   # find a prior version id
fly deploy --image <image-from-prior-release>
```
