# HomeLab boundary and service paths

**Status:** Current architecture based on owner-provided information. Addressing, VLANs, and precise cable paths are `UNKNOWN`; the reported switch port map is in [topology](../network/topology.md#managed-switch).

```text
Metronet
   |
Zyxel modem/router — primary household gateway
   |\
   | \__ Household IoT history; present device placement UNKNOWN
   |
   +-- LAN to WAN --> TP-Link Archer BE3500 — HomeLab router
                         |
                         +-- HomeLab wired and wireless devices
                         +-- TP-Link TL-SG108PE managed switch (presence known; connection details UNKNOWN)
                         +-- HP EliteDesk / Proxmox VE (exact connection details UNKNOWN)
                         |     +-- Tailscale subnet-router LXC
                         |     +-- Home Assistant OS VM
                         +-- Raspberry Pi 5 / Minecraft Java server (exact connection details UNKNOWN)
```

## Access and exposure paths

- **Remote administration (current):** Tailscale runs as a subnet router in a lightweight Proxmox LXC, providing secure remote access to the Proxmox management interface and internal HomeLab systems. See [Tailscale](../services/tailscale.md).
- **Minecraft public access (current):** the Raspberry Pi-hosted Minecraft Java server is publicly reachable through playit.gg. Administrative access is via Tailscale. See [Minecraft Java server](../services/minecraft-java.md).
- **Home automation (current):** Home Assistant OS runs in a dedicated Proxmox VM with verified private web access. Intended device integration remains unverified. The owner reported all HomeLab IoT devices disconnected on 2026-09-25 pending controlled tests and the security baseline; this has not been independently verified. See [Home Assistant](../services/home-assistant.md).
- **Portfolio website / Cloudflare Tunnel (planned):** neither the website container nor Cloudflare Tunnel is deployed. See [ROADMAP.md](../../ROADMAP.md).

## Planned segmentation

The accepted, undeployed [segmented-services decision](../decisions/0003-segmented-services-and-remote-access.md) keeps Home Assistant with compatible owner-owned Archer Wi-Fi IoT devices during controlled tests and places Lab management behind a router VM and firewall. Later public-service placement, especially apps hosted directly on a NAS, depends on the chosen platform's ability to isolate each workload. The [VLAN worksheet](../network/segmentation-plan.md) contains illustrative IDs and candidate switch port roles. None of those VLANs or service routes are current infrastructure.
