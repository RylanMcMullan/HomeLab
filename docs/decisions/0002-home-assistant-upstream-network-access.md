# 0002 — Home Assistant access to upstream IoT devices

**Status:** Superseded by [decision 0003](0003-segmented-services-and-remote-access.md); not deployed
**Date:** 2026-09-14

## Context

At the time of this 2026-09-14 decision, Home Assistant ran behind the dedicated HomeLab router while the intended household IoT devices used the upstream household network. The reported state changed on 2026-09-30 when those devices moved to the Archer; this paragraph is historical context, not current placement. Read-only discovery confirmed that ordinary outbound unicast could cross the former boundary, but no supported mDNS or SSDP reflection mechanism was found.

The managed switch supports further investigation, but a switch cannot by itself create firewall policy or isolate wireless clients connected directly to either router. Any design must preserve private HomeLab management, Tailscale access, and the existing tunnel-based services.

## Candidate designs

### Move selected IoT devices behind the HomeLab router

Re-onboard only the devices intended for Home Assistant to an appropriate non-isolated HomeLab wireless network. This is the simplest option that places Home Assistant and those devices in the same routed environment, but coverage, device trust, and vendor-cloud dependencies must be reviewed first.

### Extend the upstream LAN to Home Assistant through an isolated switch VLAN

Use a dedicated cable from the upstream gateway to an isolated access VLAN on the managed switch, carry that VLAN to Proxmox, and attach a second virtual interface only to the Home Assistant VM. The Proxmox management host must not receive an address or default route on that network, and Home Assistant should retain its existing HomeLab interface as its primary management path.

This may make upstream discovery possible while preserving the broader router boundary, but it introduces dual-homing and risks DHCP leakage, accidental Layer 2 bridging, routing ambiguity, or wider access than intended. Exact switch ports, VLAN ID, Proxmox bridge design, Home Assistant interface behavior, and firewall controls are all `UNKNOWN` and require a reviewed implementation and rollback plan.

### Collapse the router boundary

Changing the HomeLab router to access-point mode would simplify discovery by placing systems on one network, but would remove the documented separation between household and HomeLab systems. This option is not preferred.

## Historical proposed direction

This proposal was not deployed. The accepted target design moves compatible owner-owned IoT devices behind the Archer in stages and keeps Home Assistant on the same network for discovery. The following steps remain as historical alternatives if that move proves unsuitable:

1. Inventory each intended IoT device and determine whether its official integration is cloud-based, local unicast, multicast/broadcast, or radio-local.
2. Prefer manual, scoped integrations or moving selected devices behind the HomeLab router when practical.
3. If devices must stay upstream, create a full physical port map and review the isolated-VLAN/secondary-interface design before changing the switch or Proxmox networking.
4. Define verification and rollback steps that prove Home Assistant discovery works while HomeLab management and Tailscale access remain private and operational.

## Consequences

- Cross-network Home Assistant discovery remains unverified and is not a current capability.
- No VLAN ID, switch port assignment, bridge name, address, route, or firewall rule is selected here.
- A managed-switch VLAN can carry a separate Layer 2 segment, but routing and security enforcement still require correctly configured endpoints or a firewall/router.
- Any implementation must be owner-approved and documented only after it is verified.

## Related documentation

- [Network-discovery history](../history/network-discovery.md) and [procedure](../reference/network-discovery.md)
- [Network topology](../network/topology.md)
- [Home Assistant](../services/home-assistant.md)
- [Roadmap](../../ROADMAP.md)
