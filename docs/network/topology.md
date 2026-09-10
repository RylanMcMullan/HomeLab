# Topology and components

**Status:** owner-provided current-state baseline. Internal subnets, IP addresses, DHCP scopes/reservations, VLANs, Wi-Fi details, port forwarding, firewall rules, and physical port assignments are `UNKNOWN` and intentionally omitted.

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

## HomeLab router

- Device: TP-Link Archer BE3500.
- Responsibilities: HomeLab routing, DHCP, static/reserved IP management, and separation of HomeLab from the upstream household network.
- WAN relationship: WAN port connects to a Zyxel LAN port.
- Firmware, LAN/WAN addressing, DHCP ranges/reservations, Wi-Fi configuration, firewall rules, DNS, port forwarding, VLAN use, and device list: `UNKNOWN`.

## Managed switch

- Device: TP-Link TL-SG108PE, 8-port managed switch.
- VLAN configuration and individual port assignments: `UNKNOWN`.
- Uplink, firmware, management address, connected-device map, link speeds, and PoE usage: `UNKNOWN`.

## Inventory TODO

Build a non-sensitive, owner-approved network inventory that identifies devices and roles without exposing credentials or private management details in this public repository. Prefer documentation that links to a private authoritative record when precise addressing is needed.
