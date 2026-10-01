# Private Network Map Template

Copy this file to the approved private reference directory outside the repository (on this workstation, `C:\Projects\Personal\PrivateResources\HomeLab\inventory\network-map.private.md`) before filling it in. Never place credentials, public endpoints, Wi-Fi passwords, or router recovery data in either copy. If MAC addresses are needed for device matching, keep them only in the private [device inventory schema](iot-inventory.example.csv), never in this public template.

## Layer 3 map

| Zone | CIDR | Gateway | DHCP range | DNS | Verified from | Verified date |
| --- | --- | --- | --- | --- | --- | --- |
| Upstream household | `<UPSTREAM_CIDR>` | `<UPSTREAM_GATEWAY>` | `<UPSTREAM_DHCP_RANGE>` | `<UPSTREAM_DNS>` | `<SOURCE>` | `<YYYY-MM-DD>` |
| HomeLab | `<HOMELAB_CIDR>` | `<HOMELAB_GATEWAY>` | `<HOMELAB_DHCP_RANGE>` | `<HOMELAB_DNS>` | `<SOURCE>` | `<YYYY-MM-DD>` |

## Boundary and routing

| Item | Verified value |
| --- | --- |
| Zyxel exact model | `UNKNOWN` |
| Zyxel operating mode | `UNKNOWN` |
| Archer hardware revision | `UNKNOWN` |
| Archer firmware | `UNKNOWN` |
| Archer operating mode | `UNKNOWN` |
| Archer WAN address | `<ARCHER_WAN_PRIVATE_IP>` |
| Archer WAN address source | `UNKNOWN` |
| Archer NAT enabled | `UNKNOWN` |
| Static routes | `UNKNOWN` |
| Multicast/mDNS/SSDP relay support | `UNKNOWN` |
| Inter-network firewall policy | `UNKNOWN` |

## Relevant devices

Use stable roles rather than publishing identifiers. The ignored device inventory may hold operationally necessary MAC addresses, but it is not encrypted or suitable for credentials.

| Role | Zone | Private address | Address source/reservation | Local integration protocol | Verified date |
| --- | --- | --- | --- | --- | --- |
| Home Assistant VM | HomeLab | `<HA_PRIVATE_IP>` | `UNKNOWN` | Web UI; device protocols `UNKNOWN` | `<YYYY-MM-DD>` |
| IoT device 1 | HomeLab (reported; verify) | `<PRIVATE_IP>` | `UNKNOWN` | `UNKNOWN` | `<YYYY-MM-DD>` |

## Change record

Record router changes before applying them, including the exact old value, proposed new value, rollback procedure, and verification result. Promote only sanitized architectural facts to `docs/network/topology.md`.
