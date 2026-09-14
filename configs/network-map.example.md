# Private network map template

Copy this file to `inventory-output/network-map.private.md` before filling it in. The copied file is ignored by Git. Never place credentials, public endpoints, Wi-Fi passwords, MAC addresses, or router recovery data in either copy.

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

Use stable roles rather than publishing identifiers. Record MAC addresses only in a credential-protected system if they are operationally necessary.

| Role | Zone | Private address | Address source/reservation | Local integration protocol | Verified date |
| --- | --- | --- | --- | --- | --- |
| Home Assistant VM | HomeLab | `<HA_PRIVATE_IP>` | `UNKNOWN` | Web UI; device protocols `UNKNOWN` | `<YYYY-MM-DD>` |
| IoT device 1 | Upstream household | `<PRIVATE_IP>` | `UNKNOWN` | `UNKNOWN` | `<YYYY-MM-DD>` |

## Change record

Record router changes before applying them, including the exact old value, proposed new value, rollback procedure, and verification result. Promote only sanitized architectural facts to `docs/network/topology.md`.
