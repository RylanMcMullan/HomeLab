# Tailscale Subnet Router

**Status:** deployed subnet-router service in a lightweight [Proxmox VE](proxmox-ve.md) LXC hosted by the [HP EliteDesk 800 G5 Mini](../hosts/hp-elitedesk.md). The guest's Tailscale service identity and online state were command-verified on 2026-10-06.

## Purpose

Tailscale provides private remote access to the Proxmox management interface and internal HomeLab systems.

## Known configuration boundaries

- The 2026-10-06 Proxmox configuration check found one unprivileged Debian LXC with 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem. The 2026-09-14 nesting observation is in [history](../history/proxmox-baseline.md); it was not rechecked on 2026-10-06.
- After the first 2026-10-06 reboot, the container was found stopped with automatic start disabled. It was started and automatic start was enabled at priority 1. `tailscaled` was active and enabled within the LXC. A later controlled host reboot verified that the LXC started ahead of Home Assistant and Tailscale reported a running backend, an online local node, and no health messages; see [history](../history/proxmox-baseline.md).
- LXC ID and private addressing are intentionally not documented. Tailscale version, tailnet name, advertised subnet routes, exit-node status, ACLs, and DNS configuration remain `UNKNOWN`.
- Authentication keys, login URLs, device keys, and configuration tokens are sensitive and must never be committed.

Current advertised routes, tailnet name, exit-node status, ACL/grants, DNS, version, update posture, and end-to-end remote-client reachability remain `UNKNOWN`. Verification and future placement are covered by [Segment HomeLab Network](../plans/segment-homelab-network.md), [Deploy Management Services](../plans/deploy-management-services.md), and [Establish Remote Recovery](../plans/establish-remote-recovery.md). The online backend observation does not verify least-privilege policy or a client-side subnet route.
