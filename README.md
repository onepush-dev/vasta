# Vasta — self-hosted Capacities/Notion-style notes with typed objects and daily notes. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/PLACEHOLDER)

One-click Railway packaging of [Vasta](https://github.com/ariedotme/vasta) (AGPL-3.0): typed objects, daily notes,
calendars, captures from Telegram/the browser extension/Shortcuts, spaces you can share, and an MCP endpoint.
Vasta is alpha software; back up your data.

This repo uses the official image `ghcr.io/ariedotme/vasta:0.8.0` unmodified, with a small start wrapper.

## What the template sets up
- One service on port 8080 (public HTTPS domain), health check `/api/health`.
- One volume at `/data` (SQLite database + media).
- **No setup code needed:** on first boot the owner account `admin` is created with Vasta's own CLI
  (`vasta user add`) using the generated `VASTA_ADMIN_PASSWORD`. Vasta has no public sign-up; invite others from
  Settings › Server accounts.
- `VASTA_WEB_URL` points at the Railway domain (links in reminders and bot replies).

## Variables
| Variable | Default | Purpose |
|---|---|---|
| `VASTA_ADMIN_PASSWORD` | generated | Password of the first owner account `admin` (first boot only) |
| `VASTA_WEB_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Public address used in links |
| `VASTA_ADMIN_USER` / `VASTA_ADMIN_NAME` | `admin` / `Admin` (baked) | Username and display name of the first account |

Optional (add in Railway variables): `VASTA_TIMEZONE` (e.g. `Europe/Lisbon`), `TELEGRAM_BOT_TOKEN`, `VASTA_S3_*`
for an S3 media bucket. See upstream `.env.example`.

## After deploy
1. Open the Railway domain and sign in as `admin` with `VASTA_ADMIN_PASSWORD`.
2. Change the password in Settings › Account.
3. Prefer the upstream setup-code flow? Delete `VASTA_ADMIN_PASSWORD` before the first deploy; the code is then
   printed in the deploy logs (`Setup code XXXX-XXXX-XXXX`).

Changing `VASTA_ADMIN_PASSWORD` after the first boot does not change an existing account
(use `vasta user passwd admin` in the Railway shell).
