# Network Discovery History

Related: [current topology](../network/topology.md), [Onboard Home Assistant](../plans/onboard-home-assistant.md), [Segment HomeLab Network](../plans/segment-homelab-network.md), [decision 0002](../decisions/0002-home-assistant-upstream-network-access.md).

## 2026-09-14 — Household and HomeLab Boundary Assessment

Windows client snapshots verified that the HomeLab and upstream household networks used different private IPv4 networks and gateways. Upstream 2.4 GHz and 5 GHz Wi-Fi observations matched on IPv4 network, prefix, gateway, DNS, and DHCP state, supporting one Layer 3 zone for inventory and unicast testing. Router UI inspection found intra-BSS blocking disabled on both radios; cross-band multicast/broadcast behavior remained `UNKNOWN`.

The Zyxel operated as a router without user-defined static routes. The Archer separated the HomeLab behind its WAN interface. A Windows client on the HomeLab LAN reached the upstream gateway by ICMP and HTTP through the expected route. This verified outbound unicast to that gateway only, not connectivity to each IoT device or cross-boundary multicast discovery. The Archer UI showed wireless-router mode, distinct upstream and HomeLab `/24` networks, DHCP and SPI firewall enabled, no user-defined static routes, port forwards, or DMZ host, and device isolation disabled. IGMP proxy/snooping and wireless multicast forwarding were enabled, but no mDNS or SSDP relay was exposed in the inspected settings. No supported mechanism for reflecting Home Assistant link-local discovery across the WAN boundary was verified.

The Archer also showed UPnP enabled with zero clients at inspection, WireGuard-server-associated host routes of unknown purpose, and a firmware update available but not applied pending backup and a maintenance window. The upstream WAN used provider shared IPv4 address space and showed no connected IPv6 address at observation time. Exact addressing, router exports, and raw command output remained private.

The historical collection compared one Windows client on HomeLab Wi-Fi, upstream 5 GHz, and upstream 2.4 GHz using the read-only [network collector](../../scripts/collect-windows-network.ps1), router management views, and Home Assistant DHCP/Zeroconf/SSDP browsers. An Archer-side phone app could control an upstream device, but that did not establish direct local control; a vendor-cloud path was possible. The nested routing/NAT boundary, rather than the upstream radio-band split, was the leading network-level explanation for failed broadcast discovery. See [decision 0002](../decisions/0002-home-assistant-upstream-network-access.md) for the alternative designs considered at the time.

## 2026-09-30 — Same-LAN Discovery Cross-Check

After the reported device move, a read-only Archer client snapshot and Home Assistant discovery browsers were inspected. The DHCP browser showed a subset of router clients and one cached client absent from the online snapshot. SSDP showed Xbox, Archer, and a Roku ECP-advertising TV; Zeroconf showed no matching services. The TV's SSDP details matched its router row and enriched the private device record. These lists did not prove that undiscovered devices were offline or unsupported. The Home Assistant HTTP port was confirmed from Network settings after an attempt at an assumed port was refused; no server setting changed.

A later read-only Windows IPv4 neighbor-cache check showed only the Archer gateway and the same Home Assistant MAC/IP as the router snapshot, both `Reachable` at that moment. A filtered DNS-client-cache check found no matching local/Home Assistant/Archer names. A neighbor cache is not a scan or complete client inventory. Exact values remain in the private inventory.
