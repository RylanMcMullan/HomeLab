# Services

## Current services

- [Tailscale subnet router](tailscale.md) — remote administration path running in a lightweight Proxmox LXC.
- [Minecraft Java server](minecraft-java.md) — hosted on the Raspberry Pi 5 and publicly reachable through playit.gg.
- [Home Assistant](home-assistant.md) — Home Assistant OS running in a dedicated Proxmox VM with private web access.

## Deferred preparation

- [Local AI service](local-ai.md) on the Acer Nitro 5 — hardware inventory is complete; installation is deferred until after the network and Minecraft priorities.

## Planned services

- [Portfolio website](portfolio-website.md) — intended Proxmox-container workload; not deployed.
- [Cloudflare Tunnel](cloudflare-tunnel.md) — planned reviewed access path for the website, Home Assistant, Nextcloud, and a later production vault; not deployed.
- [Jellyfin](jellyfin.md) — future NAS-hosted app or separate guest using NAS media storage; placement undecided.
- [Nextcloud](nextcloud.md) — future NAS-hosted app or separate guest using NAS storage; placement undecided.
- [Uptime Kuma](uptime-kuma.md) — planned private availability monitoring; not deployed.
- [Homepage](homepage.md) — planned private HomeLab dashboard; not deployed.
- [Production Bitwarden](password-manager.md) — planned with the NAS phase after reliable backup and recovery are established; the educational prototype is separate and unscheduled.
- [Kali Linux research VM](kali-linux.md) — planned persistent VM for authorized testing and monitoring.
- [Malware-analysis lab](malware-analysis-lab.md) — furthest-horizon isolated research environment; not deployed.

## Exposure summary

| Service | Exposure status | Administrative path | Details |
| --- | --- | --- | --- |
| Minecraft Java server | Publicly reachable through playit.gg | Tailscale | [Record](minecraft-java.md) |
| Tailscale subnet router | Remote-access infrastructure; public endpoint details not documented | Owner-controlled Tailscale administration | [Record](tailscale.md) |
| Portfolio website | Not deployed; planned public domain apex via Cloudflare Tunnel | Planned private Lab-origin administration | [Planned record](portfolio-website.md) |
| Cloudflare Tunnel | Not deployed; multiple application routes planned | Connector and policy details `TODO` | [Planned record](cloudflare-tunnel.md) |
| Local AI service | Not deployed; installation deferred | Planned local console and Lab/Tailscale administration; authenticated chat access without Tailscale is `TODO` | [Planned record](local-ai.md) |
| Home Assistant | Private HomeLab access verified; public exposure not configured; future `iot` subdomain planned | Owner-created Home Assistant account; Tailscale path not yet verified | [Record](home-assistant.md) |
| Jellyfin | Not deployed | Planned LAN and Tailscale access | [Planned record](jellyfin.md) |
| Nextcloud | Not deployed; future `drive` subdomain planned after storage and recovery | Planned private Lab-origin administration | [Planned record](nextcloud.md) |
| Uptime Kuma | Not deployed | Planned LAN and Tailscale access | [Planned record](uptime-kuma.md) |
| Homepage | Not deployed | Planned LAN and Tailscale access | [Planned record](homepage.md) |
| Production Bitwarden | Not deployed; future production vault on `pass` subdomain is planned | Planned private Lab/Tailscale administration; HTTPS, MFA, and recovery required | [Planned record](password-manager.md) |
| Kali Linux research VM | Not deployed | Planned private administration | [Planned record](kali-linux.md) |
| Malware-analysis lab | Not deployed | Management and containment design `UNKNOWN` | [Planned record](malware-analysis-lab.md) |
