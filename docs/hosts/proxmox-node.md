# HP EliteDesk Proxmox node

**Status:** deployed primary virtualization server. The current hostname, IP address, Proxmox VE version, exact EliteDesk model, and VM/LXC inventory are `UNKNOWN`.

## Hardware

- HP EliteDesk; exact model: `UNKNOWN`.
- Intel Core i5 vPro, 9th generation.
- 16 GB DDR4 RAM, currently one 16 GB DIMM.
- Internal 256 GB Samsung NVMe SSD, model `MZVLB256HAHQ-000L7`.
- Uses internal storage only. No NAS, SAN, external array, or other network storage is currently connected to this Proxmox node.

## Platform and workloads

- Virtualization platform: Proxmox VE; version: `UNKNOWN`.
- A lightweight LXC hosts the Tailscale subnet router. LXC ID, OS, resource allocation, and route configuration: `UNKNOWN`.
- Other VM/LXC workloads and IDs: `UNKNOWN`; inventory is `TODO`.

## Administration and security

- Tailscale provides secure remote access to the Proxmox management interface and internal HomeLab systems. See [Tailscale](../services/tailscale.md).
- Management endpoint, account names, certificates, and authentication configuration: `UNKNOWN` and must not be stored here if sensitive.

## Update checklist

When verified, add the non-sensitive host identity, Proxmox version, storage layout, VM/LXC inventory, backup status, and monitoring status. Do not add passwords, private addresses, tokens, or private keys.
