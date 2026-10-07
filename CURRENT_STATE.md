# Current state

> Scope: deployed infrastructure believed operational from reported or verified evidence. This is the authoritative summary of **current**, not planned, state. Last reviewed: 2026-10-07 for HP link and guest inventory; the resource baseline was last reviewed on 2026-10-06, and the IoT move and Home Assistant integrations were last reviewed on 2026-09-30. The switch cable map remains partly untraced.

## Deployed infrastructure

| Area | Current state | Detailed record |
| --- | --- | --- |
| Internet / household gateway | Metronet service reaches a Zyxel modem/router that acts as the primary household gateway. The intended smart devices were reported moved to the Archer HomeLab LAN on 2026-09-30; any remaining household-LAN inventory is `UNKNOWN`. | [Network topology](docs/network/topology.md) |
| HomeLab boundary | A TP-Link Archer BE3500 connects its WAN port to a LAN port on the Zyxel gateway. HomeLab wired and wireless devices operate behind it. | [HomeLab router](docs/network/topology.md#tp-link-archer-be3500) |
| Switch | TP-Link TL-SG108PE, an 8-port managed switch, is present. After the 2026-10-06 coupler reseat, the operator reported all four devices connected on ports 1–4, with the HP returned to port 2. The HP verified 1,000 Mb/s there; the remaining port assignments are reported or inferred and the complete cable trace and VLAN configuration remain unverified. | [Managed switch](docs/network/topology.md#tp-link-tl-sg108pe-managed-switch) |
| Virtualization | An [HP EliteDesk 800 G5 Mini](docs/hosts/hp-elitedesk.md) with Intel Core i5-9500, 16 GB RAM, and internal NVMe storage runs [Proxmox VE](docs/services/proxmox-ve.md). It hosts a Home Assistant OS VM and a verified Tailscale LXC. A [failed portfolio VM installation](docs/history/portfolio-vm-installation-attempt.md) was fully removed on 2026-10-07, including its disk and all temporary bridge, forwarding, NAT, firewall, rollback-unit, and staging-file changes. After a 2026-10-06 outage, the prior kernel log showed repeated NIC hangs. A reversible offload mitigation is active; a later controlled reboot verified that it persisted and that the host returned at 1,000 Mb/s with no new hang at the check. Sustained NIC stability and the earlier hang cause remain unverified. | [HP host](docs/hosts/hp-elitedesk.md), [Proxmox VE](docs/services/proxmox-ve.md) |
| Raspberry Pi service host | Raspberry Pi 5 with external USB 3.0 SSD hosts a public Minecraft Java server. | [Raspberry Pi host](docs/hosts/raspberry-pi-5.md), [Minecraft](docs/services/minecraft-java.md) |
| Remote administration | The Tailscale subnet-router LXC is running and its backend reported online with no health messages after the 2026-10-06 controlled reboot. The container is configured to start first after host boot, ahead of the Home Assistant VM. Actual remote-client route and least-privilege behavior remain unverified. | [Tailscale](docs/services/tailscale.md) |
| Home automation | Home Assistant OS runs on Proxmox VE. Its About page showed Core 2026.9.4, Supervisor 2026.09.3, and OS 18.3 on 2026-09-30. Xbox and Archer UPnP/IGD device records exist; Matter was only discovered and Tuya appeared transiently. The reported smart-device move excludes one Sengled bulb paired directly to Alexa. Feit and Govee router labels are reported as app-MAC matched; room-device control remains unverified. | [Home Assistant](docs/services/home-assistant.md), [device history](docs/history/device-inventory.md) |
| Public exposure | The Minecraft Java server is publicly reachable through playit.gg. Administrative access uses Tailscale. | [Minecraft Java server](docs/services/minecraft-java.md) |

## Explicitly not deployed

- Cloudflare Tunnel is **not deployed** for the website or any other planned HomeLab application.
- A portfolio website and dedicated website guest are **not deployed**. No temporary guest bridge or website firewall/NAT policy remains active.
- The Acer Nitro 5 is **not functioning as the dedicated HomeLab AI server**.
- Dedicated network storage, the Linux AI service, Jellyfin, Nextcloud, Uptime Kuma, Homepage, the password manager, the Kali research VM, and the malware-analysis lab are **not deployed**.

These are planned efforts, tracked in [ROADMAP.md](ROADMAP.md), rather than current state.

## Known unknowns requiring inventory

- Exact addresses, hostnames, MAC addresses, DHCP reservations, and raw device-level inventory are kept in the external private reference directory. The September 30 Archer snapshot, Feit/Govee identity confirmations, and remaining unmatched clients are summarized in [device-inventory history](docs/history/device-inventory.md). The Alexa-paired Sengled bulb is outside that IP-client inventory.
- HP peak utilization, detailed storage health, backup/restore posture, independent monitoring, and cause of the prior NIC hangs. A low-load resource snapshot and successful controlled reboot were recorded on 2026-10-06; neither proves multi-day stability or capacity for any five unspecified workloads. Private host identity, addressing, and guest IDs are intentionally not documented.
- Raspberry Pi OS patch level, hostname/IP, Minecraft version, server configuration, and backup status. Raspberry Pi OS Lite (64-bit) is recorded in the [host record](docs/hosts/raspberry-pi-5.md), but its current release/version was not rechecked in this incident.
- Managed-switch VLAN/PVID configuration, complete cable trace, hardware revision, firmware, and management placement. The Archer, Acer, and Pi port assignments remain reported or inferred rather than independently traced.
- Tailscale version, tailnet name, client-side subnet-route behavior, exit-node status, and ACL/DNS posture. The service identity and online backend were verified inside its LXC on 2026-10-06. Private addressing and the LXC ID are intentionally not documented.
- Public Minecraft endpoint and playit.gg tunnel details (do not document credentials or tokens).
