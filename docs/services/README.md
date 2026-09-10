# Services

## Current services

- [Tailscale subnet router](tailscale.md) — remote administration path running in a lightweight Proxmox LXC.
- [Minecraft Java server](minecraft-java.md) — hosted on the Raspberry Pi 5 and publicly reachable through playit.gg.

## Planned services

- [Portfolio website](portfolio-website.md) — intended Proxmox-container workload; not deployed.
- [Cloudflare Tunnel](cloudflare-tunnel.md) — intended public exposure path for the planned website; not deployed.
- Local AI inference on the Acer Nitro 5 — planned; see [Acer host record](../hosts/acer-nitro-5.md) and [ROADMAP.md](../../ROADMAP.md).

## Exposure summary

| Service | Exposure status | Administrative path | Details |
| --- | --- | --- | --- |
| Minecraft Java server | Publicly reachable through playit.gg | Tailscale | [Record](minecraft-java.md) |
| Tailscale subnet router | Remote-access infrastructure; public endpoint details not documented | Owner-controlled Tailscale administration | [Record](tailscale.md) |
| Portfolio website | Not deployed | `N/A` until deployed | [Planned record](portfolio-website.md) |
| Cloudflare Tunnel | Not deployed | `N/A` until deployed | [Planned record](cloudflare-tunnel.md) |
