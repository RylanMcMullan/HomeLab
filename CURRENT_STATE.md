# Current state

> Scope: deployed infrastructure believed operational from reported or verified evidence. This is the authoritative summary of **current**, not planned, state. Last reviewed: 2026-09-30 for the reported IoT move and observed Home Assistant integrations; the switch port map was reported on 2026-09-24 and remains untraced.

## Deployed infrastructure

| Area | Current state | Detailed record |
| --- | --- | --- |
| Internet / household gateway | Metronet service reaches a Zyxel modem/router that acts as the primary household gateway. The intended smart devices were reported moved to the Archer HomeLab LAN on 2026-09-30; any remaining household-LAN inventory is `UNKNOWN`. | [Network topology](docs/network/topology.md) |
| HomeLab boundary | A TP-Link Archer BE3500 connects its WAN port to a LAN port on the Zyxel gateway. HomeLab wired and wireless devices operate behind it. | [HomeLab router](docs/network/topology.md#tp-link-archer-be3500) |
| Switch | TP-Link TL-SG108PE, an 8-port managed switch, is present. Reported connections are port 1 to Archer LAN, 2 to HP, 3 to Acer, 4 to Pi, and 5–8 empty; cable trace and VLAN configuration are unverified. | [Managed switch](docs/network/topology.md#tp-link-tl-sg108pe-managed-switch) |
| Virtualization | An [HP EliteDesk](docs/hosts/hp-elitedesk.md) with Intel Core i5-9500, 16 GB RAM, and internal NVMe storage runs [Proxmox VE](docs/services/proxmox-ve.md). It hosts a Home Assistant OS VM and an LXC inferred to run Tailscale. Platform versions were last verified on 2026-09-14. | [HP host](docs/hosts/hp-elitedesk.md), [Proxmox VE](docs/services/proxmox-ve.md) |
| Raspberry Pi service host | Raspberry Pi 5 with external USB 3.0 SSD hosts a public Minecraft Java server. | [Raspberry Pi host](docs/hosts/raspberry-pi-5.md), [Minecraft](docs/services/minecraft-java.md) |
| Remote administration | Tailscale is deployed as a subnet router in a lightweight Proxmox LXC and enables secure remote access to Proxmox management and internal HomeLab systems. | [Tailscale](docs/services/tailscale.md) |
| Home automation | Home Assistant OS runs on Proxmox VE. Its About page showed Core 2026.9.4, Supervisor 2026.09.3, and OS 18.3 on 2026-09-30. Xbox and Archer UPnP/IGD device records exist; Matter was only discovered and Tuya appeared transiently. The reported smart-device move excludes one Sengled bulb paired directly to Alexa. Feit and Govee router labels are reported as app-MAC matched; room-device control remains unverified. | [Home Assistant](docs/services/home-assistant.md), [device history](docs/history/device-inventory.md) |
| Public exposure | The Minecraft Java server is publicly reachable through playit.gg. Administrative access uses Tailscale. | [Minecraft Java server](docs/services/minecraft-java.md) |

## Explicitly not deployed

- Cloudflare Tunnel is **not deployed** for the website or any other planned HomeLab application.
- A portfolio website hosted in a Proxmox container is **not deployed**.
- The Acer Nitro 5 is **not functioning as the dedicated HomeLab AI server**.
- Dedicated network storage, the Linux AI service, Jellyfin, Nextcloud, Uptime Kuma, Homepage, the password manager, the Kali research VM, and the malware-analysis lab are **not deployed**.

These are planned efforts, tracked in [ROADMAP.md](ROADMAP.md), rather than current state.

## Known unknowns requiring inventory

- Exact addresses, hostnames, MAC addresses, DHCP reservations, and raw device-level inventory are kept in the external private reference directory. The September 30 Archer snapshot, Feit/Govee identity confirmations, and remaining unmatched clients are summarized in [device-inventory history](docs/history/device-inventory.md). The Alexa-paired Sengled bulb is outside that IP-client inventory.
- Exact HP EliteDesk model, storage health, peak utilization, backup/restore posture, and monitoring status. Private host identity, addressing, and guest IDs are intentionally not documented.
- Raspberry Pi OS, hostname/IP, Minecraft version, server configuration, and backup status.
- Managed-switch VLAN/PVID configuration, cable trace, hardware revision, firmware, and management placement. The reported port map, including the Archer LAN uplink, has not been independently verified.
- Tailscale version, tailnet name, subnet-route behavior, exit-node status, ACL/DNS posture, and direct verification inside its inferred LXC. Private addressing and the LXC ID are intentionally not documented.
- Public Minecraft endpoint and playit.gg tunnel details (do not document credentials or tokens).
