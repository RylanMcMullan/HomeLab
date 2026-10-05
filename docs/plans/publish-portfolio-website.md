# Publish Portfolio Website

**Status:** Planned; target first public page by 2026-10-06. No site, domain, or tunnel is verified as deployed. Related: [Configure Remote Application Access](configure-remote-application-access.md), [Configure Portfolio Email](configure-portfolio-email.md), [Segment HomeLab Network](segment-homelab-network.md), and [hosting decision](../decisions/0004-portfolio-launch-hosting.md).

## Launch decision and scope

The operator chose a **tunnel-first launch if its security and recovery checks pass**. The first release should be a small static portfolio in a separate public source repository, served from a dedicated Proxmox guest through Cloudflare Tunnel at `<DOMAIN>` after the domain is purchased and verified. A one-page site can contain a short introduction, selected projects, resume link, and `mail@<DOMAIN>` only after two-way mail is tested. Use `www` as a redirect or matching hostname after testing. Keep deployment code and content in the separate repository; this HomeLab repository records infrastructure state and the sanitized project facts the site may cite.

Keep the candidate domain out of this public repository until registration; continue using `<DOMAIN>` afterwards unless the operator explicitly approves publishing the exact name here. The registrar account, not GitHub documentation, holds the authoritative domain value.

Publish the tunnel route only when the gate below passes. If it cannot pass in time, the fallback for the public deadline is Cloudflare Pages, while tunnel work continues privately. The Portfolio VLAN in [decision 0003](../decisions/0003-segmented-services-and-remote-access.md) remains the target design, not current protection. Do not claim that a tunnel makes an unsegmented origin safe or guarantees uptime.

## First-release sequence

1. Check live registrar availability and both registration and renewal prices for the chosen domain; purchase only after the operator reviews the final price and registrant details. Verify the registrant email, enable account MFA and domain auto-renew, and record the registration without the domain name, billing details, or account identifiers in this repository. Domain availability, price, and ownership are `UNKNOWN` until checked in the registrar.
2. Create the separate public website repository and a small static, mobile-friendly site. Review biography, project claims, resume, metadata, accessibility, links, and any image rights before publication. Avoid publishing private network details or copying private inventory. Build and preview locally.
3. Prepare the dedicated guest and connector, then pass every [tunnel publication check](#tunnel-first-publication-gate). Add only the apex route, configure `www` deliberately, and verify HTTPS and redirects from an external network. If the gate fails, deploy the reviewed static build to Cloudflare Pages and attach the apex through its [custom-domain flow](https://developers.cloudflare.com/pages/configuration/custom-domains/). Keep a previous deployment or reviewed holding page available for rollback.
4. Configure and test the contact address using the [email plan](configure-portfolio-email.md). Add it to the site and resume only after both inbound delivery and a reply from the custom address pass.
5. Record external availability and a recovery path. Check the public page, TLS, links, and contact delivery after publication and again after DNS settles. Mark the relevant roadmap steps complete only from observed results; update [Current State](../../CURRENT_STATE.md), a service record, dated history, and [CHANGELOG](../../CHANGELOG.md) for a significant deployment.

## Tunnel-first publication gate

Complete these checks **before** adding a public home-hosted route:

- Refresh HP capacity and storage/backup status; create a dedicated, minimally provisioned website guest. No application database, admin panel, shell, Proxmox endpoint, or other service shares the public origin. Back up the site and prove a representative restore or redeploy.
- Place `cloudflared` with access only to this site's origin endpoint. Verify local host firewall and network policy deny new connections from the website guest and connector to Proxmox management, the switch, Tailscale administration, IoT, and unrelated services. The current shared HomeLab LAN and unverified switch/VLAN settings do **not** establish this isolation. If a safe temporary boundary cannot be demonstrated, defer the tunnel publication until [segmentation](segment-homelab-network.md).
- Permit only required connector egress; keep inbound router forwards closed. Scope the tunnel token to this service and store it outside public repositories and general inventory. Run connector and web server as managed services with restart behavior, updates, and logs. Publish only the reviewed apex route; inspect for wildcard or management routes. Cloudflare [documents egress and availability controls](https://developers.cloudflare.com/tunnel/configuration/).
- Test from outside the HomeLab: page and HTTPS, origin reachability, denied management paths, guest/connector restart, home outage behavior, and recovery. A Cloudflare tunnel marked healthy does not prove the origin works; [Cloudflare distinguishes those checks](https://developers.cloudflare.com/tunnel/troubleshooting/https-origins/). A single HP host, household power, and home internet remain availability dependencies. Additional connectors on the same host do not remove them.

## Later full-stack development

Define interactive features from a concrete user need before adding server-side code. Keep public website data separate from HomeLab administration. For HomeLab-driven updates, start with a curated, reviewed data file or a build-time read of **public, allowlisted** repository content; publish only explicitly selected facts and links. Do not give the public app live access to Proxmox, private inventory, tunnel credentials, GitHub write tokens, or HomeLab management APIs. Add an API and data store only with a separate threat model, validation, rate limits, update/restore procedure, and a verified network boundary. The stack, dynamic feature list, and deployment placement are `TODO` until chosen in the website repository.

## Rollback

For Pages, roll back to the last known-good deployment or temporarily replace the apex with a reviewed holding page. For a home tunnel, remove the public hostname route first, then stop the connector or guest and investigate privately. Keep the domain and tested mail routing independent of site rollback. Record any deployed-state change in current and history records.
