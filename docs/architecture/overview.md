# HomeLab boundary and service paths

**Status:** current architecture from reported placement and read-only observations. Exact addressing and some cable paths remain `UNKNOWN`; the reported switch port map is in [topology](../network/topology.md#tp-link-tl-sg108pe-managed-switch).

```text
Metronet
   |
Zyxel modem/router — primary household gateway
   |\
   | \__ Remaining household clients UNKNOWN
   |
   +-- LAN to WAN --> TP-Link Archer BE3500 — HomeLab router
                         |
                         +-- HomeLab wired and wireless devices, including reported smart-device placement
                         +-- TP-Link TL-SG108PE managed switch (presence known; connection details UNKNOWN)
                         +-- HP EliteDesk running Proxmox VE (exact connection details UNKNOWN)
                         |     +-- Tailscale subnet-router LXC
                         |     +-- Home Assistant OS VM
                         +-- Raspberry Pi 5 / Minecraft Java server (exact connection details UNKNOWN)
```

## Access and exposure paths

- **Remote administration (current):** Tailscale runs as a subnet router in a lightweight Proxmox LXC, providing secure remote access to the Proxmox management interface and internal HomeLab systems. See [Tailscale](../services/tailscale.md).
- **Minecraft public access (current):** the Raspberry Pi-hosted Minecraft Java server is publicly reachable through playit.gg. Administrative access is via Tailscale. See [Minecraft Java server](../services/minecraft-java.md).
- **Home automation (current):** Home Assistant OS runs in a dedicated Proxmox VM with verified private web access. Intended smart devices were reported moved to the Archer LAN; Xbox and Archer UPnP/IGD device records were observed. Plug/bulb control remains unverified. The shared Archer LAN is not an IoT-to-Lab security boundary. See [Home Assistant](../services/home-assistant.md).

Future segmentation and publishing are tracked in [Roadmap](../../ROADMAP.md) and [plans](../plans/README.md), not shown as deployed paths here.
