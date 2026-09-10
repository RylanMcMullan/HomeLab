# HomeLab boundary and service paths

**Status:** Current architecture based on owner-provided information. Addressing, port mappings, VLANs, and precise host-to-switch connections are `UNKNOWN`.

```text
Metronet
   |
Zyxel modem/router — primary household gateway
   |\
   | \__ Residential IoT devices (upstream household network)
   |
   +-- LAN to WAN --> TP-Link Archer BE3500 — HomeLab router
                         |
                         +-- HomeLab wired and wireless devices
                         +-- TP-Link TL-SG108PE managed switch (presence known; connection details UNKNOWN)
                         +-- HP EliteDesk / Proxmox VE (exact connection details UNKNOWN)
                         +-- Raspberry Pi 5 / Minecraft Java server (exact connection details UNKNOWN)
```

## Access and exposure paths

- **Remote administration (current):** Tailscale runs as a subnet router in a lightweight Proxmox LXC, providing secure remote access to the Proxmox management interface and internal HomeLab systems. See [Tailscale](../services/tailscale.md).
- **Minecraft public access (current):** the Raspberry Pi-hosted Minecraft Java server is publicly reachable through playit.gg. Administrative access is via Tailscale. See [Minecraft Java server](../services/minecraft-java.md).
- **Portfolio website / Cloudflare Tunnel (planned):** neither the website container nor Cloudflare Tunnel is deployed. See [ROADMAP.md](../../ROADMAP.md).
