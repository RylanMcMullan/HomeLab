# Cloudflare Tunnel

**Status:** planned; not deployed for any HomeLab service.

The accepted target uses the owner's future domain and separately reviewed HTTPS routes for the public portfolio site at the domain apex and for Home Assistant, Nextcloud, and the later production password manager on distinct subdomains. These are planned names and routes only. A published application route exposes that application's login or content to the internet; Cloudflare Tunnel does not itself authenticate users.

Place connectors where they can reach only the intended origin service and port. Whether to use one connector per zone/service, where Home Assistant's Archer-side connector runs, Cloudflare Access policy, certificate/origin settings, native-client compatibility, and availability dependencies remain `TODO`. A Cloudflare Access login must be tested with Home Assistant, Nextcloud sync, and password-manager clients before adoption. Do not publish Proxmox, switch management, Homepage, Uptime Kuma administration, or the Acer host administration through this plan.

Tunnel name/ID, Cloudflare account and zone details, exact domain, DNS records, connector hosts, access policies, and configuration are `UNKNOWN` until deployment is verified. See [decision 0003](../decisions/0003-segmented-services-and-remote-access.md).

Cloudflare tokens, tunnel credentials, JSON credentials, API tokens, and origin authentication material are secrets and must never be committed. Track work in [ROADMAP.md](../../ROADMAP.md).
