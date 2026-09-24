# 0003 — Segmented services and remote access

**Status:** Accepted as a target design; not deployed
**Date:** 2026-09-24

## Context

The owner wants Home Assistant to discover Wi-Fi IoT devices, separate Lab administration from public applications, use the managed switch and Proxmox for VLAN experience, and reach selected applications from a phone or laptop without requiring Tailscale. The TP-Link Archer BE3500 currently provides a single HomeLab LAN and Wi-Fi network; general-purpose routed LAN VLANs have not been verified on it. The TL-SG108PE can carry 802.1Q VLANs, but does not provide their gateways or firewall policy.

The current HP Proxmox host has 16 GiB RAM and a 256 GB-class internal NVMe device. A dedicated storage and backup foundation is planned but not deployed. No VLAN, router VM, Cloudflare Tunnel, or new service in this decision is deployed merely because this design is accepted.

## Target design

- Keep the Zyxel as the household gateway and the Archer as the HomeLab Wi-Fi router. Move compatible, owner-owned IoT devices to the Archer in stages after testing their Home Assistant integrations; record exceptions that cannot move. Keep the Home Assistant OS VM on the same Archer-side network as those devices for local discovery. The Archer's guest or IoT SSID must not be assumed to bridge to Home Assistant until tested.
- Use a VLAN-aware switch-to-Proxmox link. A dedicated router/firewall VM on Proxmox has an Archer-side uplink and provides separate gateway, DHCP, internet routing, and firewall policy for downstream VLANs. Assign each Proxmox guest to its intended VLAN through a virtual NIC; wired access ports present one VLAN untagged to ordinary devices. The exact bridge design and whether the Archer-side network is carried tagged or untagged are `TODO` after physical and configuration inventory.
- Create a private Lab management VLAN for Proxmox management, the Tailscale subnet-router LXC, the Acer on switch port 3, and private Uptime Kuma and Homepage interfaces. During the initial VLAN rollout, the Acer is simply a Lab node; do not add an AI-specific cross-VLAN exception. Decide the AI web UI's client access, authentication, and firewall policy when the service is hosted.
- Current Archer Wi-Fi is a shared network for IoT and any ordinary Wi-Fi clients on it. A VLAN boundary alone cannot identify a trusted laptop among those clients. If AI access from Wi-Fi is later chosen, it needs its own authenticated, narrowly scoped application path or a separate trusted-client Wi-Fi segment; an IP reservation alone is not a strong identity control.
- Give the portfolio website, Nextcloud, and the future production password manager separate service VLANs and separate guests. Publish only their intended application endpoints through Cloudflare Tunnel and the owner's domain after each deployment and security review. Planned names are the domain apex for the portfolio and `drive`, `pass`, and `iot` subdomains for Nextcloud, the vault, and Home Assistant. These names do not imply that DNS records or tunnels exist today.
- Keep Home Assistant in the Archer IoT network as an explicit exception to one-service-per-VLAN. A later separate Home Assistant VLAN is conditional on device-by-device proof that discovery, callbacks, and control work across the boundary. A second Home Assistant NIC on the IoT network would not by itself isolate the VM from IoT devices.
- Evaluate a separate Minecraft/game VLAN for the Raspberry Pi before moving it. The playit.gg tunnel and private Tailscale administration must be retested after any move. Its VLAN assignment remains `TODO`.
- Use the planned network-attached storage for appropriately permissioned data and local backups after capacity, access control, recovery, and restore tests. A second independent or off-site copy of critical data remains a design requirement; a NAS alone is not a complete backup strategy. A dedicated storage VLAN and exact backup flows remain `TODO`.

## Intended traffic policy

| Source | Destination | Target rule |
| --- | --- | --- |
| IoT devices and public service VLANs | Lab management | Deny new connections. |
| Separate public service VLANs | One another | Deny by default; add only documented application dependencies. |
| Lab administrator devices | Service and IoT management endpoints | Allow only identified destinations and ports; require application authentication. |
| Uptime Kuma in Lab | Services and selected hosts | Allow only required health-check destinations and protocols; no general management reachability. |
| Homepage in Lab | Selected service APIs | Allow only required read-only API endpoints with scoped credentials. |
| Cloudflare Tunnel connector | Each published application | Allow only its required origin endpoint; connector placement and per-service isolation are `TODO`. |
| Tailscale clients | Lab and approved services | Advertise only necessary routes and enforce tailnet grants plus local firewall rules. Direct Tailscale on a guest is a separate, explicitly scoped option. |
| All zones | Internet and DNS/NTP | Allow per-service requirements while preserving inter-zone restrictions. |

These are policy goals, not deployed firewall rules. Published services still require their own authentication, MFA where supported, updates, and tested recovery. Cloudflare Tunnel does not itself provide application authentication. Browser-only Cloudflare Access policies may be useful, but native Home Assistant, Nextcloud, and password-manager clients must be tested before placing an additional login in their request path.

## Rollout and recovery gates

1. Verify the owner-reported port 1 Archer LAN uplink and other switch cabling; inventory the switch hardware revision, current VLAN/PVID configuration, HP NIC/bridge, router addresses, Tailscale routes, and a local Proxmox console path. Keep exact addresses and credentials private.
2. Test one owner-selected IoT device with Home Assistant on the Archer network. Preserve the existing working network until this is verified.
3. Back up switch and host network configuration, establish a known-good local recovery port, and create one test VLAN/port with the router VM. Verify DHCP, internet, isolation, and rollback before moving management or production devices.
4. Move the Acer and Lab management path only after local port 3 access to Proxmox survives router-VM failure. Verify Tailscale routes and least-privilege access after the move.
5. Consider the Raspberry Pi/game VLAN separately, including playit.gg and administrative-access tests.
6. Add public service VLANs one application at a time after sizing, storage, backup, restoration, application hardening, and remote client tests. The password manager is a late-stage service and must never become the sole credential copy before a restore test.

If the router VM is unavailable, Archer Wi-Fi and Home Assistant should continue to use the Archer gateway; downstream Lab and service VLANs lose routed internet and remote paths. This is an accepted availability trade-off for the initial design, with a physical VLAN-capable gateway as a possible later replacement. Exact failure behavior must be tested before relying on it.

## Open decisions

- Final VLAN IDs, private CIDRs, DHCP scopes, DNS, switch PVIDs/tagged memberships, bridge names, router VM platform/resources, and physical cable verification: `TODO`. The [worksheet](../network/segmentation-plan.md) supplies illustrative IDs only.
- Whether the Raspberry Pi gets a separate game VLAN, and how Tailscale administration reaches it: `TODO`.
- Whether and how to provide non-Tailscale access to a future Acer AI web UI without exposing Lab management or the inference API, including how trusted Wi-Fi clients would be distinguished from IoT devices: deferred until AI hosting.
- Switch management-plane placement in Lab, if the switch supports it, and emergency recovery access: `TODO`.
- Cloudflare connector placement, per-service tunnel design, authentication/Access compatibility with native apps, domain registration, and exact hostnames: `TODO`.
- NAS hardware, storage VLAN, permissions, backup retention, independent copy, and restore process: `TODO`.
- VLAN-aware Wi-Fi access point and a distinct trusted-client wireless network: optional future design; not selected.

## Related documentation

- [Roadmap](../../ROADMAP.md)
- [Current topology](../network/topology.md)
- [Home Assistant](../services/home-assistant.md)
- [Cloudflare Tunnel](../services/cloudflare-tunnel.md)
- [Storage and recovery](../architecture/storage-plan.md)
- [Earlier Home Assistant decision](0002-home-assistant-upstream-network-access.md)
