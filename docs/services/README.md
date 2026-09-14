# Services

## Current services

- [Tailscale subnet router](tailscale.md) — remote administration path running in a lightweight Proxmox LXC.
- [Minecraft Java server](minecraft-java.md) — hosted on the Raspberry Pi 5 and publicly reachable through playit.gg.
- [Home Assistant](home-assistant.md) — Home Assistant OS running in a dedicated Proxmox VM with private web access.

## In-progress services

- [Local AI service](local-ai.md) on the Acer Nitro 5 — host preparation is underway; Linux and the AI stack are not deployed.

## Planned services

- [Portfolio website](portfolio-website.md) — intended Proxmox-container workload; not deployed.
- [Cloudflare Tunnel](cloudflare-tunnel.md) — intended public exposure path for the planned website; not deployed.
- [Jellyfin](jellyfin.md) — future unprivileged Debian LXC; deferred until media storage is available.
- [Nextcloud](nextcloud.md) — future Nextcloud AIO deployment in a Debian Docker VM; deferred until durable storage and backups are available.
- [Uptime Kuma](uptime-kuma.md) — planned private availability monitoring; not deployed.
- [Homepage](homepage.md) — planned private HomeLab dashboard; not deployed.
- [Password manager](password-manager.md) — planned after reliable backup and recovery are established.
- [Kali Linux research VM](kali-linux.md) — planned persistent VM for authorized testing and monitoring.
- [Malware-analysis lab](malware-analysis-lab.md) — furthest-horizon isolated research environment; not deployed.

## Exposure summary

| Service | Exposure status | Administrative path | Details |
| --- | --- | --- | --- |
| Minecraft Java server | Publicly reachable through playit.gg | Tailscale | [Record](minecraft-java.md) |
| Tailscale subnet router | Remote-access infrastructure; public endpoint details not documented | Owner-controlled Tailscale administration | [Record](tailscale.md) |
| Portfolio website | Not deployed | `N/A` until deployed | [Planned record](portfolio-website.md) |
| Cloudflare Tunnel | Not deployed | `N/A` until deployed | [Planned record](cloudflare-tunnel.md) |
| Local AI service | Not deployed; host preparation in progress | Planned local console, LAN, and Tailscale access | [In-progress record](local-ai.md) |
| Home Assistant | Private HomeLab access verified; public exposure not configured | Owner-created Home Assistant account; Tailscale path not yet verified | [Record](home-assistant.md) |
| Jellyfin | Not deployed | Planned LAN and Tailscale access | [Planned record](jellyfin.md) |
| Nextcloud | Not deployed | Planned LAN and Tailscale access | [Planned record](nextcloud.md) |
| Uptime Kuma | Not deployed | Planned LAN and Tailscale access | [Planned record](uptime-kuma.md) |
| Homepage | Not deployed | Planned LAN and Tailscale access | [Planned record](homepage.md) |
| Password manager | Not deployed | Access design `UNKNOWN`; HTTPS and recovery required | [Planned record](password-manager.md) |
| Kali Linux research VM | Not deployed | Planned private administration | [Planned record](kali-linux.md) |
| Malware-analysis lab | Not deployed | Management and containment design `UNKNOWN` | [Planned record](malware-analysis-lab.md) |
