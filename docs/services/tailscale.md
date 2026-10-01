# Tailscale Subnet Router

**Status:** deployed subnet-router service in a lightweight [Proxmox VE](proxmox-ve.md) LXC hosted by the [HP EliteDesk](../hosts/hp-elitedesk.md), according to the reported state. Guest identity has not been command-verified inside the container.

## Purpose

Tailscale provides private remote access to the Proxmox management interface and internal HomeLab systems.

## Known configuration boundaries

- The 2026-09-14 Proxmox inventory recorded one running, unprivileged Debian LXC with nesting enabled, 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem. Its association with Tailscale is inferred from the reported deployment and requires direct guest verification. The dated usage snapshot is in [history](../history/proxmox-baseline.md).
- LXC ID and private addressing are intentionally not documented. Tailscale version, tailnet name, advertised subnet routes, exit-node status, ACLs, and DNS configuration remain `UNKNOWN`.
- Authentication keys, login URLs, device keys, and configuration tokens are sensitive and must never be committed.

Current advertised routes, tailnet name, exit-node status, ACL/grants, DNS, version, update posture, and recovery behavior remain `UNKNOWN`. Verification and future placement are covered by [Segment HomeLab Network](../plans/segment-homelab-network.md) and [Deploy Management Services](../plans/deploy-management-services.md). The reported remote access must not be treated as a verified least-privilege policy.
