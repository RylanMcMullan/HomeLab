# Terminology

Canonical display names and aliases only. Specifications, status, and exact identifiers belong in their linked records or the private inventory. `UNKNOWN` is a deliberate placeholder, not a proposed model.

| Kind | Canonical name | Alias or distinction | Authoritative record |
| --- | --- | --- | --- |
| Project | HomeLab | Do not alternate with “Homelab” in prose | [Current state](../../CURRENT_STATE.md) |
| Network | Household LAN | Upstream Zyxel-side network; not the HomeLab LAN | [Topology](../network/topology.md) |
| Network | HomeLab LAN | Archer-side network; not equivalent to a future isolated IoT VLAN | [Topology](../network/topology.md) |
| Device | Zyxel gateway | Exact model `UNKNOWN` | [Topology](../network/topology.md) |
| Device | TP-Link Archer BE3500 | HomeLab router; “Archer” is a short alias | [Topology](../network/topology.md) |
| Device | TP-Link TL-SG108PE | Managed switch | [Topology](../network/topology.md) |
| Device | HP EliteDesk 800 G5 Mini | Physical host, not synonymous with Proxmox VE; model verified in the [host record](../hosts/hp-elitedesk.md) | [Host](../hosts/hp-elitedesk.md) |
| Device | Raspberry Pi 5 | Physical Minecraft host | [Host](../hosts/raspberry-pi-5.md) |
| Device | Acer Nitro 5 AN515-54 | Physical Acer host; distinct from the repository workstation | [Host](../hosts/acer-nitro-5.md) |
| Device | Govee H5083 smart plug | Router alias “Miscellaneous Smart Plug” | [Home Assistant plan](../plans/onboard-home-assistant.md) |
| Devices | Feit Electric G30/E26 bulbs | `Color Lights 1`–`3` are the established unit labels; “Color Lamps” meant the same group | [Home Assistant plan](../plans/onboard-home-assistant.md) |
| Device | Desk RGB bulb | Brand/model `UNKNOWN` | [Home Assistant plan](../plans/onboard-home-assistant.md) |
| Device | Sengled Alexa-paired bulb | Model/radio `UNKNOWN`; not identified by the Matter tile | [Home Assistant plan](../plans/onboard-home-assistant.md) |
| Devices | Fan; LEGO Lights | Router labels only; manufacturer/model `UNKNOWN` | [Device inventory history](../history/device-inventory.md) |
| Device | Xbox Series X | Media device, not a Home Assistant integration name | [Home Assistant](../services/home-assistant.md) |
| Device | Roku TV | Advertised Insignia 5405X; physical label not checked | [Home Assistant plan](../plans/evaluate-optional-home-assistant-devices.md) |
| Device | Roku Stick 4K | Exact model and network placement `UNKNOWN` | [Home Assistant plan](../plans/evaluate-optional-home-assistant-devices.md) |
| Device | Amazon Echo Dot | Generation `UNKNOWN` | [Home Assistant plan](../plans/evaluate-optional-home-assistant-devices.md) |
| Platform | Proxmox VE | Installed platform on the HP EliteDesk; separate mutable record | [Proxmox VE](../services/proxmox-ve.md) |
| Service | Home Assistant | Home Assistant OS VM on Proxmox VE | [Home Assistant](../services/home-assistant.md) |
| Service | Tailscale subnet router | LXC role; not the HP hardware name | [Tailscale](../services/tailscale.md) |
| Service | Minecraft Java server | Hosted on the Raspberry Pi 5; public game access uses playit.gg | [Minecraft](../services/minecraft-java.md) |
| Future service | Production Bitwarden | Separate from the educational password-manager prototype; not deployed | [Plan](../plans/deploy-bitwarden.md) |

Use official product names for other planned tools and integrations—Uptime Kuma, Homepage, Crafty Controller, Jellyfin, Nextcloud, Cloudflare Tunnel, Spotify, Tuya, Roku, Alexa Devices, and playit.gg—without implying that candidate services are deployed. Plan titles and filenames are indexed in [`docs/plans/README.md`](../plans/README.md).
