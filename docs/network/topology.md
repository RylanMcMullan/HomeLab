# Network Topology and Components

**Status:** current HomeLab boundary from reported placement and read-only observations dated 2026-09-14 and 2026-09-30. Exact addressing, identifiers, and live exports remain outside this public repository. Recheck mutable settings before changing the network.

## Network boundary

Metronet service reaches the **Zyxel gateway**, which provides the household LAN. The **TP-Link Archer BE3500** connects from its WAN port to a Zyxel LAN port and provides the separate HomeLab LAN for wired and wireless clients. The reported 2026-09-30 smart-device placement is on the HomeLab LAN, except a Sengled bulb paired directly to Alexa and absent from the Archer IP-client inventory. This separates the smart devices from the household LAN but does not isolate them from other HomeLab hosts. Exact client mappings are in the private inventory; public findings are in [device-inventory history](../history/device-inventory.md).

## Zyxel gateway

| Field | Last known state |
| --- | --- |
| Role | Primary household gateway |
| Exact model, firmware, ISP handoff | `UNKNOWN` |
| Wi-Fi | Separate 2.4 GHz and 5 GHz names; Windows comparison on 2026-09-14 showed the same private IPv4 network, prefix, gateway, DNS, and DHCP behavior on both |
| Router controls | Router mode, DHCP, and firewall enabled; no user-defined static routes shown; intra-BSS blocking disabled on both bands at 2026-09-14 UI inspection |
| Cross-band multicast/broadcast | `UNKNOWN` |

The WAN was observed in provider shared IPv4 space without a connected IPv6 address at inspection time; this is a dated observation, not a permanent service guarantee. Details of that baseline are in [network-discovery history](../history/network-discovery.md).

## TP-Link Archer BE3500

| Field | Last known state |
| --- | --- |
| Role | HomeLab router, Wi-Fi, DHCP, and boundary from the household LAN |
| Physical path | WAN port to Zyxel LAN port; LAN to managed switch reported |
| Router controls | Wireless-router mode, dynamic private WAN address, separate HomeLab `/24`, DHCP and SPI firewall enabled, no user-defined static routes/port forwards/DMZ host, device isolation disabled at 2026-09-14 inspection |
| Discovery controls | IGMP proxy/snooping and wireless multicast forwarding enabled; no mDNS or SSDP relay exposed in the inspected settings |
| UPnP | Enabled with zero clients at inspection; present necessity `UNKNOWN` |
| WireGuard-related routes | Host routes were present; purpose and use `UNKNOWN` |
| Hardware revision and firmware | `UNKNOWN` publicly; verify privately before any update |

No router VM, new inter-VLAN firewall, or general routed VLAN segmentation is deployed. The future design is in [Segment HomeLab Network](../plans/segment-homelab-network.md); it is not part of this current configuration.

## TP-Link TL-SG108PE managed switch

| Port | Reported connection on 2026-09-24 | Confidence |
| --- | --- | --- |
| 1 | Archer LAN uplink | Reported; cable trace unverified |
| 2 | HP EliteDesk | Reported; cable trace unverified |
| 3 | Acer Nitro 5 AN515-54 | Reported; cable trace unverified |
| 4 | Raspberry Pi 5 | Reported; cable trace unverified |
| 5–8 | Empty | Reported; current state unverified |

The switch is an 8-port managed model. Present VLAN/PVID membership, firmware/hardware revision, management placement, link speeds, and PoE use are `UNKNOWN`. A switch alone does not provide VLAN gateways or inter-VLAN firewall policy. Verify the cable trace and configuration before using its capabilities in the [network-segmentation plan](../plans/segment-homelab-network.md).
