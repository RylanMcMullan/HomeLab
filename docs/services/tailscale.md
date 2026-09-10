# Tailscale subnet router

**Status:** deployed.

## Purpose

Tailscale runs as a subnet router inside a lightweight Proxmox LXC container. It provides secure remote access to the Proxmox management interface and internal HomeLab systems.

## Known configuration boundaries

- Proxmox host: [HP EliteDesk](../hosts/proxmox-node.md).
- LXC ID, guest OS, tailnet name, Tailscale IP addresses, advertised subnet routes, exit-node status, ACLs, and DNS configuration: `UNKNOWN`.
- Authentication keys, login URLs, device keys, and configuration tokens are sensitive and must never be committed.

## Verification TODO

Verify active route(s), reachability scope, update posture, least-privilege access policy, and recovery/maintenance process through owner-approved administration channels. Document only safe, non-secret conclusions.
