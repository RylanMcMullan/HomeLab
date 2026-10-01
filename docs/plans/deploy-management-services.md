# Deploy Management Services

**Status:** Planned after initial Home Assistant, network-segmentation, and Minecraft inventory work. Neither Uptime Kuma nor Homepage is deployed.

**Related plans:** [Segment HomeLab Network](segment-homelab-network.md) owns Lab access and firewall paths; [Harden Minecraft Server](harden-minecraft-server.md) owns the optional web panel. This plan provides monitoring and navigation, not Minecraft server administration.

## Uptime Kuma monitoring

Provide availability monitoring for selected HomeLab services, initially including Home Assistant. Targets, notifications, and retention remain `UNKNOWN`. Consider a small private Debian utility guest shared with Homepage; dedicated versus shared placement remains undecided. Prefer the project's [official Docker image](https://github.com/louislam/uptime-kuma) with a persistent local data volume. A suggested starting allocation for a shared utility guest was 1 vCPU, 1–2 GiB RAM, and a 16 GiB system disk; it was a planning estimate, not a verified requirement.

Keep the administrative interface private to authorized Lab and Tailscale clients. Use MagicDNS or Tailscale Serve for named browser access only after routes, grants, and DNS are verified. A custom-domain name needs a separate private DNS/TLS design. Place monitoring in the planned Lab VLAN and allow only recorded health-check destinations and protocols across other VLANs. A sanitized status-only page remains an open decision. Do not expose the Docker socket merely to monitor ordinary HTTP, TCP, ping, or DNS targets. Do not publish administrator credentials, notification tokens, private target addresses, or status-page secrets.

Verification: document guest/runtime, persistence and backup; verify authentication and private reachability; test at least one non-critical monitor through a controlled failure and recovery; confirm approved cross-VLAN checks work while unrelated management paths are blocked; measure resource use before resizing.

## Homepage dashboard

Provide private links and selected status from Proxmox, Home Assistant, Minecraft, and Uptime Kuma. Consider sharing the utility guest with Uptime Kuma. Follow the [official installation documentation](https://gethomepage.dev/installation/). Begin with links needing no API credentials; add widgets only after selecting a secret-storage method and narrowly scoped read-only service identities. A dashboard inventory itself can map administrative services and is sensitive even without passwords.

Keep the dashboard available only to authorized Lab/Tailscale clients. [MagicDNS](https://tailscale.com/docs/features/magicdns) or [Tailscale Serve](https://tailscale.com/docs/features/tailscale-serve) can provide tailnet-only names after grants and routing are verified. A custom domain requires private DNS/TLS design; a public DNS record does not make an endpoint private. Allow cross-VLAN widgets only to required read-only APIs and ports. Link to the separately authenticated Minecraft web panel after its migration is verified; Homepage is not that panel. Never commit widget API keys, service credentials, private URLs, internal addresses, or authentication headers.

Verification: document guest/runtime, persistence and backup; verify private access; test links/widgets without secrets in Git; confirm narrow cross-VLAN widgets; measure resource use before resizing.

## Common access gate

Before adding either service, verify which tailnet users/devices can reach it and that unrelated IoT or public-service networks cannot reach administrative endpoints. The current Tailscale routes, grants, DNS, and recovery behavior are `UNKNOWN`. The future Lab VLAN depends on the router VM, so a router-VM outage may remove remote access; verify a local console/port recovery path. Do not point public DNS to management endpoints for convenience.
