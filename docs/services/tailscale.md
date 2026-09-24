# Tailscale subnet router

**Status:** deployed.

## Purpose

Tailscale runs as a subnet router inside a lightweight Proxmox LXC container. It provides secure remote access to the Proxmox management interface and internal HomeLab systems.

## Known configuration boundaries

- Proxmox host: [HP EliteDesk](../hosts/proxmox-node.md).
- The Proxmox inventory recorded one running, unprivileged Debian LXC with nesting enabled, 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem. Based on the owner's report that Tailscale occupies a lightweight LXC, this guest is inferred to be the Tailscale subnet router; the service identity has not yet been command-verified inside the guest.
- LXC ID and private addressing are intentionally not documented. Tailscale version, tailnet name, advertised subnet routes, exit-node status, ACLs, and DNS configuration remain `UNKNOWN`.
- Authentication keys, login URLs, device keys, and configuration tokens are sensitive and must never be committed.

## Verification TODO

Verify active route(s), reachability scope, update posture, least-privilege access policy, and recovery/maintenance process through owner-approved administration channels. Document only safe, non-secret conclusions.

## Proposed placement; not deployed

The [segmented target](../decisions/0003-segmented-services-and-remote-access.md) keeps this LXC in the Lab management VLAN. Before moving it, inspect actual advertised routes and tailnet grants, then verify remote administration to permitted destinations and denial to unrelated service VLANs. If its internet gateway depends on the proposed router VM, Tailscale access through this LXC is expected to stop during router-VM failure; local switch port 3 and a Proxmox console form the recovery path. Direct Tailscale clients in other guests would be separate, explicitly scoped tailnet members, not an automatic bridge between VLANs.
