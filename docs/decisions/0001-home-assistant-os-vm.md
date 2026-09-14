# 0001 — Run Home Assistant OS in a dedicated Proxmox VM

**Status:** Accepted
**Date:** 2026-09-14

## Context

The owner wants a first Home Assistant installation that gives the existing Proxmox node a useful 24/7 automation workload. The installation should be approachable for a first-time Home Assistant user, remain private during initial setup, and preserve access to Home Assistant's managed apps and update experience.

The Proxmox host has sufficient verified idle CPU and memory capacity for the documented Home Assistant VM starting allocation. Its internal-only storage and lack of a verified backup target remain constraints.

## Decision

Deploy a new Home Assistant Operating System instance in a dedicated Proxmox virtual machine using the official x86-64 KVM/Open Virtual Appliance image.

Start with 2 vCPUs, 2 GiB RAM, the image's 32 GiB virtual disk, UEFI/OVMF firmware, and private HomeLab/Tailscale access. Environment-specific identifiers and addressing will be selected during deployment and will not be published.

## Consequences

- Home Assistant receives the Supervisor-managed operating environment and app support recommended for most users.
- The VM has more overhead than a Home Assistant container but reduces host-level application maintenance and keeps the workload isolated.
- Integration discovery across the upstream household and downstream HomeLab network boundary must be tested; existing phone-to-IoT control does not prove multicast discovery support.
- A backup destination and restore procedure must be established before the installation is treated as resilient.
- Jellyfin and Nextcloud remain deferred until suitable storage is available.

## Related documentation

- [Home Assistant service record](../services/home-assistant.md)
- [Proxmox host](../hosts/proxmox-node.md)
- [Network topology](../network/topology.md)
- [Roadmap](../../ROADMAP.md)
