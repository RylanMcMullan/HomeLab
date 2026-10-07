# Segment HomeLab Network

**Status:** Planned. No VLAN, port membership, router VM, or firewall rule below is deployed. The IDs are working labels for review, not approved device configuration. See [decision 0003](../decisions/0003-segmented-services-and-remote-access.md) for the accepted architecture and rollout gates.

**Dependency:** Complete initial room-device tests under [Onboard Home Assistant](onboard-home-assistant.md). Related: [Harden Minecraft Server](harden-minecraft-server.md) for any later Pi game-VLAN move; [Establish NAS Storage](establish-nas-storage.md) for NAS placement.

## Proposed segments

| Working VLAN ID | Role | Intended members | Gateway and exposure |
| --- | --- | --- | --- |
| 10 | Archer / IoT / Home Assistant | Archer LAN and Wi-Fi, reported smart devices pending full inventory, Home Assistant VM, router VM uplink | Archer remains the gateway and DHCP server. Home Assistant may later have a narrowly scoped Cloudflare Tunnel route. |
| 20 | Lab management | Proxmox management, Tailscale LXC, Acer on switch port 3, private Homepage; an independent Uptime Kuma observer needs separately scoped access from its eventual host segment | Router VM gateway; no public management route. |
| 30 | Portfolio | Dedicated website guest | Router VM gateway; planned public domain apex via Cloudflare Tunnel. |
| 40 | Files candidate | Nextcloud as a separate Proxmox guest, or a NAS-hosted workload only if per-workload VLAN attachment is verified | Router VM gateway; planned `drive` subdomain via Cloudflare Tunnel after storage and restore tests. Deferred if Nextcloud shares a NAS service VLAN. |
| 50 | Vault candidate | Production password manager as a separate Proxmox guest, or a NAS-hosted workload only if per-workload VLAN attachment is verified | Router VM gateway; planned `pass` subdomain only after product, client, MFA, and recovery review. Deferred if Bitwarden shares a NAS service VLAN. |
| 60 | Minecraft/game candidate | Raspberry Pi on switch port 4, if the dedicated VLAN is accepted | Router VM gateway; playit.gg and Tailscale access require retesting. |
| 70 | NAS services/storage candidate | Future NAS and directly hosted applications through one access port if separate guest VLANs are unavailable | Router VM gateway; exact access rules remain `TODO`. This is a shared trust zone, not per-application network isolation. Keep NAS administration private and publish only reviewed application origins. |
| 90 | Parking candidate | Unused switch ports only if disabling them is unavailable | No gateway or DHCP. Confirm switch behavior before use. |

Do not reuse these IDs on real equipment until the switch's existing configuration, VLAN limits, PVID behavior, and any overlapping network have been inspected. The Archer's Wi-Fi clients are not individually VLAN-tagged: VLAN 10 would simply carry its existing LAN to the switch and Proxmox. VLAN IDs do not determine IP subnet numbers.

## Reported switch port map and candidate port roles

| Switch port | Reported connection | Candidate role after staged migration |
| --- | --- | --- |
| 1 | Archer LAN uplink | Candidate untagged VLAN 10 / PVID 10. Do not change until the cable is traced and existing switch settings are backed up. |
| 2 | HP EliteDesk / Proxmox | One trunk: untagged VLAN 10 for the Archer-facing path, tagged VLANs 20/30/40/50 and any later accepted 60/70. PVID/native behavior must match Proxmox. |
| 3 | Acer Nitro 5, including the planned AI service | Untagged Lab VLAN 20 / PVID 20 after the Acer and Proxmox management recovery path are tested. This wired VLAN separates the Acer from the Archer/IoT network. |
| 4 | Raspberry Pi 5 | Keep the current configuration until the Minecraft/game VLAN decision and tunnel/administration tests; candidate untagged VLAN 60 / PVID 60. |
| 5–8 | Empty | Disable if supported, or evaluate an un-routed parking VLAN. Reserve a future trusted-laptop port only after selecting its policy. |

The reported connections, including the Archer LAN uplink on port 1, are not an independently verified cable trace. Exact current PVIDs, VLAN memberships, switch management access, and PoE use remain `UNKNOWN`. No command or UI setting should be copied from this worksheet to the switch without a current configuration backup and a port-by-port rollback plan.

## Virtual networking and service placement

- Proxmox would use a VLAN-aware bridge on the switch-facing NIC. Its own management address belongs only to the Lab VLAN after migration. Its current bridge, NIC, and management placement remain `UNKNOWN` and must be inspected first.
- The router VM would have an Archer-facing virtual NIC and one or more downstream tagged VLAN interfaces/NICs. It would supply DHCP, routing, internet NAT where required, and stateful firewall policy for downstream segments. Keep Archer DHCP confined to VLAN 10 and prevent downstream DHCP leakage.
- Home Assistant would remain an Archer-side VM peer of the inventoried IoT devices for discovery. A separate Home Assistant VLAN is deferred until each required integration can be verified across a routed boundary.
- Assign each future Proxmox-hosted public service guest only to its own service VLAN; its management access must be a narrow Lab-origin rule, not a second unrestricted Lab NIC.
- If future services run directly on the NAS, the initial candidate is one access VLAN for that host and its workloads, subject to narrow router and NAS firewall rules, separate Docker networks, private NAS administration, and tested application authentication. The router VM cannot separate applications sharing the NAS host network. Use distinct Files/Vault VLANs only if the selected NAS proves per-workload tagged networking or those applications run as separate Proxmox guests. See the [dated decision update](../decisions/0003-segmented-services-and-remote-access.md).
- Give the independent Uptime Kuma observer selected health-check paths from its eventual segment and Homepage selected read-only API paths from Lab. Confirm successful checks and denied unrelated access. Preserve an Archer-side recovery path if the router VM fails; see [Establish Remote Recovery](establish-remote-recovery.md).
- Consider the Raspberry Pi's playit.gg outbound path and private administration separately before assigning VLAN 60.
- Keep switch management reachable only on an approved management path if the hardware supports that policy; verify its recovery behavior before changing its management VLAN.
- The Acer on wired port 3 can be isolated from Archer/IoT traffic by VLAN 20. No AI-specific cross-VLAN rule is part of the initial rollout. Ordinary Archer Wi-Fi clients and moved IoT devices remain in the same Layer 2 zone. If Wi-Fi-to-AI access is chosen after the AI service is hosted, design an authenticated, narrowly scoped path or a separate trusted Wi-Fi segment; an IP reservation alone is not proof of trust.

## Firewall behavior to prove in tests

1. VLANs 20/30/40/50 and any accepted 60/70 obtain the intended DHCP, DNS, time, and internet access through the router VM.
2. New connections from IoT, public services, and game hosts cannot reach Proxmox, switch management, Tailscale administration, or unrelated Lab devices.
3. Separate public service VLANs cannot initiate connections to one another without a recorded exception.
4. Authorized Lab clients can administer selected services on specific ports. Uptime Kuma and Homepage can read only their selected targets.
5. Authorized remote clients can reach only approved Tailscale routes or direct tailnet guests; the tailnet policy and local firewall agree.
6. If the router VM stops, an Acer connected to port 3 can still reach Proxmox locally, while Archer Wi-Fi and Home Assistant retain Archer internet. Routed Lab/service access is expected to stop.

## Information needed before configuration

- Switch hardware revision and firmware, exported current configuration, exact cable trace, and management-plane VLAN capability.
- HP NIC and Proxmox bridge state; router VM platform, resources, console access, and startup order.
- Private CIDRs, DHCP scopes, DNS, reservations, firewall source/destination/port matrix, and recovery addresses, kept outside this public repository.
- Actual IoT integration protocols; separate trusted Wi-Fi/AP decision. Defer the Acer AI web-access decision until the service is hosted.
- Pi game VLAN decision; NAS app/VM VLAN capabilities and backup flows; Cloudflare connector location and native-client compatibility.

The [current topology](../network/topology.md) and [current state](../../CURRENT_STATE.md) remain the deployed record. Update them only after each physical or network change has been verified.
