# Topology and components

**Status:** owner-provided current-state baseline. Internal subnets, IP addresses, DHCP scopes/reservations, VLAN memberships, Wi-Fi details, port forwarding, and firewall rules are `UNKNOWN` and intentionally omitted. Physical port roles below are owner-reported, not a verified cable trace.

## Network boundary

1. Metronet is the ISP.
2. A Zyxel modem/router is the primary household gateway.
3. Residential IoT devices are connected to the upstream household network managed by the Zyxel gateway.
4. The TP-Link Archer BE3500 HomeLab router connects from its WAN port to a LAN port on the Zyxel gateway.
5. HomeLab wired and wireless devices operate behind the TP-Link router.

See [architecture overview](../architecture/overview.md) for the relationship diagram.

## Upstream household gateway

- Device: Zyxel modem/router; exact model, ISP handoff type, firmware, address, and configuration: `UNKNOWN`.
- Role: primary household gateway.
- Connected household IoT devices: present; inventory and connection details: `UNKNOWN`.
- The upstream gateway presents separate 2.4 GHz and 5 GHz Wi-Fi network names, with smart devices generally using 2.4 GHz and computers/phones generally using 5 GHz.
- Command-verified from the same Windows client on 2026-09-14: both upstream bands use the same private IPv4 network, prefix length, default gateway, IPv4 DNS configuration, and DHCP state. This supports treating them as one Layer 3 network for inventory and unicast testing. Wireless client isolation and multicast/broadcast forwarding between the bands remain `UNKNOWN`.
- Management-UI verified on 2026-09-14: the upstream gateway operates in router mode with DHCP and its firewall enabled; both wireless radios operate as access points; intra-BSS traffic blocking is disabled on both bands; and no user-defined static routes were shown.
- The upstream WAN used provider shared IPv4 address space and showed no connected IPv6 address at the observation time. Exact addressing, model, firmware, Wi-Fi names, and device identifiers are intentionally omitted from this public record.
- Gateway lifecycle, ISP support, firmware provenance, cross-band multicast/broadcast behavior, and replacement requirements remain `TODO` security-review items.

## HomeLab router

- Device: TP-Link Archer BE3500.
- Responsibilities: HomeLab routing, DHCP, static/reserved IP management, and separation of HomeLab from the upstream household network.
- WAN relationship: WAN port connects to a Zyxel LAN port.
- Management-UI verified on 2026-09-14: wireless-router mode; dynamic private WAN addressing from the upstream household network; separate private HomeLab `/24`; DHCP and SPI firewall enabled; no user-defined static routes, port forwards, or DMZ host; and device isolation disabled.
- IGMP proxy, IGMP snooping, and wireless multicast forwarding are enabled. No mDNS or SSDP relay appeared in the router's settings search, so these IGMP-related controls are not represented as solving Home Assistant service discovery across the WAN boundary.
- UPnP is enabled but reported zero clients at the observation time. Its necessity remains `TODO`; do not disable it until dependent applications are reviewed.
- The routing table contained host routes associated with the router's WireGuard-server interface. Their purpose and current use are `UNKNOWN`; they were not modified.
- Exact firmware, LAN/WAN addressing, DHCP ranges/reservations, Wi-Fi configuration, DNS, device identifiers, and device list are intentionally omitted. A firmware update was available at inspection time and remains unapplied pending a configuration backup and owner-approved maintenance window.

## Managed switch

- Device: TP-Link TL-SG108PE, 8-port managed switch.
- Owner-reported port map on 2026-09-24: port 1 = Archer LAN uplink, port 2 = HP EliteDesk, port 3 = Acer Nitro 5, port 4 = Raspberry Pi 5, and ports 5–8 = empty. This is not an independently verified cable trace.
- VLAN/PVID configuration, firmware and hardware revision, management address, link speeds, and PoE usage: `UNKNOWN`.
- The switch can carry planned segments but cannot independently provide their gateways or firewall policy. The proposed port and VLAN roles are in the [undeployed segmentation worksheet](segmentation-plan.md); the earlier upstream-IoT design in [decision 0002](../decisions/0002-home-assistant-upstream-network-access.md) was superseded.

## Inventory TODO

Build a non-sensitive, owner-approved network inventory that identifies devices and roles without exposing credentials or private management details in this public repository. Prefer documentation that links to a private authoritative record when precise addressing is needed.

Read-only collection and the decision path for Home Assistant are defined in the [network discovery runbook](discovery-runbook.md). Exact addressing is kept in an ignored local working map created from [the public placeholder template](../../configs/network-map.example.md).
