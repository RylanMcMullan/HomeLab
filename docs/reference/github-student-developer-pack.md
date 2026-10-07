# GitHub Student Developer Pack for HomeLab

**Checked:** 2026-10-06 against the [current public Pack catalog](https://education.github.com/pack). These are offers to evaluate, not services deployed or benefits verified as redeemed on this account. Recheck eligibility, term, renewal, and checkout details before use. Do not record redemption codes, account identifiers, credentials, or the planned domain name here.

## Current decisions

The portfolio remains a separate public source repository with a static first release on the HP Proxmox host through [Cloudflare Tunnel](https://developers.cloudflare.com/tunnel/), subject to its [publication gate](../plans/publish-portfolio-website.md#tunnel-first-publication-gate). Cloudflare Pages or GitHub Pages can serve a static fallback. The intended `.com` remains the primary identity; none of the Pack domain offers checked lists a free `.com`. Email is optional for the first page. Independent monitoring and recovery remain a separate [planned effort](../plans/establish-remote-recovery.md).

## Offers worth considering

| Offer in the catalog | Relevant use | Decision or constraint |
| --- | --- | --- |
| [GitHub Pro](https://education.github.com/pack) while a verified student | Website source collaboration and account features | Useful if already active, but a public repository and basic Pages do not require it. Do not make deployment depend on a temporary student entitlement. |
| [GitHub Codespaces](https://education.github.com/pack) Pro-level access | A portable development environment for the separate website repository or a future agent | Optional development convenience; production remains on the HP. Check actual usage limits in the account before relying on it. |
| [GitHub Pages](https://education.github.com/pack) | Static fallback or preview from the website repository | Supports [custom domains and HTTPS](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https). Keep Cloudflare Tunnel as the preferred self-hosted route when isolation passes. |
| [Namecheap `.me`](https://education.github.com/pack), [Name.com selected extensions](https://education.github.com/pack), and [.TECH](https://education.github.com/pack) | Optional test domains | First-year or selected-extension offers; the desired `.com` is not listed. Check renewal and transfer terms before claiming a secondary domain. Namecheap's one-year SSL certificate is unnecessary for the planned Cloudflare-fronted static page. |
| [1Password](https://education.github.com/pack) one year | Interim credential storage for registrar, GitHub, and tunnel administration if no approved secret manager exists | Optional interim service; review exit/export and post-offer cost. It does not deploy the planned self-hosted password manager. Never store secrets in this public repository or general inventory. |
| [Termius](https://education.github.com/pack) while a student | Private SSH client for future guest administration | Optional client. Continue to require Tailscale or another approved private path and guest authentication; this does not provide remote power control. |
| [Datadog](https://education.github.com/pack) Pro for 10 servers for two years | Additional external visibility into selected hosts | Optional and time-limited. It sends telemetry to a third party, so review collection scope and renewal; the planned independent Uptime Kuma observer stays the primary HomeLab design. |
| [Testmail](https://education.github.com/pack) Essential while a student | Automated tests for future website contact forms or email flows | Test service only. It is not a verified production two-way custom-domain mailbox for Outlook. |

The catalog also lists temporary Azure credits, Appwrite, and other hosted services. They are not needed for a static portfolio or the current self-hosting goal. A student Microsoft 365 productivity offer is not evidence of a custom-domain business mailbox; use the separately tested [email plan](../plans/configure-portfolio-email.md) if professional mail is commissioned.

## Cost baseline for the chosen `.com` path

The [Cloudflare Registrar public price list](https://pricing.registrar.cloudflare.com/) showed **US$10.46** for standard `.com` registration and renewal on 2026-10-06. Cloudflare says Registrar sells and renews [at cost](https://developers.cloudflare.com/registrar/), and [Tunnel is available on all plans](https://developers.cloudflare.com/tunnel/). The first static site uses the already-owned HP; electricity, equipment failure, and the owner's time are real costs even without a hosting subscription. A specific name's availability, premium status, tax, and checkout total remain `UNKNOWN` until privately reviewed.

If two-way email is added later, [Zoho Mail Lite 5 GB](https://www.zoho.com/mail/zohomail-pricing.html) was listed at US$1 per user/month billed yearly at the prior check. A standard `.com` plus that mailbox would be about **US$22.46/year before tax** at these listed rates, subject to current checkout and renewal terms. Cloudflare Email Routing or the Pack's Testmail offer does not replace that production send-and-receive mailbox.

## Reuse for future deployments

For each new service, check the live Pack catalog and record its role, eligibility, renewal date, export/exit path, telemetry/privacy impact, and whether it preserves the planned HomeLab security boundary. Prefer a durable, self-hosted production design over a temporary credit when the credit would become a single point of failure. Keep promotional domain experiments separate from the professional `.com` and never put live tokens or account data in Git.
