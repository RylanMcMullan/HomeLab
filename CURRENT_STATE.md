# Current state

> Scope: deployed infrastructure believed operational from the owner-provided bootstrap inventory. This is the authoritative snapshot of **current**, not planned, state. Last reviewed: 2026-09-14.

## Deployed infrastructure

| Area | Current state | Detailed record |
| --- | --- | --- |
| Internet / household gateway | Metronet service reaches a Zyxel modem/router that acts as the primary household gateway. Residential IoT devices use this upstream household network. | [Network topology](docs/network/topology.md) |
| HomeLab boundary | A TP-Link Archer BE3500 connects its WAN port to a LAN port on the Zyxel gateway. HomeLab wired and wireless devices operate behind it. | [HomeLab router](docs/network/topology.md#homelab-router) |
| Switch | TP-Link TL-SG108PE, an 8-port managed switch, is present. VLANs and port assignments are `UNKNOWN`. | [Managed switch](docs/network/topology.md#managed-switch) |
| Virtualization | An HP EliteDesk with an Intel Core i5-9500, 16 GB RAM, and internal NVMe storage runs Proxmox VE 9.2. It hosts the Tailscale LXC and a Home Assistant OS VM. | [Proxmox host](docs/hosts/proxmox-node.md) |
| Raspberry Pi service host | Raspberry Pi 5 with external USB 3.0 SSD hosts a public Minecraft Java server. | [Raspberry Pi host](docs/hosts/raspberry-pi-5.md), [Minecraft](docs/services/minecraft-java.md) |
| Remote administration | Tailscale is deployed as a subnet router in a lightweight Proxmox LXC and enables secure remote access to Proxmox management and internal HomeLab systems. | [Tailscale](docs/services/tailscale.md) |
| Home automation | A new Home Assistant OS VM is running on Proxmox. Private web onboarding succeeded, and Home Assistant discovered the TP-Link Archer router integration. HomeLab-to-upstream unicast is verified, but cross-boundary IoT discovery remains incomplete. | [Home Assistant](docs/services/home-assistant.md) |
| Public exposure | The Minecraft Java server is publicly reachable through playit.gg. Administrative access uses Tailscale. | [Service exposure](docs/services/README.md#exposure-summary) |

## Explicitly not deployed

- Cloudflare Tunnel is **not deployed** for the HomeLab website.
- A portfolio website hosted in a Proxmox container is **not deployed**.
- The Acer Nitro 5 is **not functioning as the dedicated HomeLab AI server**.
- Dedicated network storage, the Linux AI service, Jellyfin, Nextcloud, Uptime Kuma, Homepage, the password manager, the Kali research VM, and the malware-analysis lab are **not deployed**.

These are planned efforts, tracked in [ROADMAP.md](ROADMAP.md), rather than current state.

## Known unknowns requiring inventory

- Exact addresses, hostnames, DHCP reservations, and device-level network inventory are intentionally kept outside the public record. Router modes, network boundaries, `/24` sizing, and selected security/discovery behavior have been privately verified and sanitized in the network documentation.
- Exact HP EliteDesk model, storage health, peak utilization, backup/restore posture, and monitoring status. Private host identity, addressing, and guest IDs are intentionally not documented.
- Raspberry Pi OS, hostname/IP, Minecraft version, server configuration, and backup status.
- Managed-switch VLAN configuration and individual port assignments.
- Tailscale version, tailnet name, subnet-route behavior, exit-node status, ACL/DNS posture, and direct verification inside its inferred LXC. Private addressing and the LXC ID are intentionally not documented.
- Public Minecraft endpoint and playit.gg tunnel details (do not document credentials or tokens).
