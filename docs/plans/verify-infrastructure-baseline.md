# Verify Infrastructure Baseline

**Status:** Planned. Deployed systems have an initial inventory, but several hardware, software, backup, and recovery facts remain unverified.

**Related plans:** Supplies evidence to [Onboard Home Assistant](onboard-home-assistant.md), [Segment HomeLab Network](segment-homelab-network.md), [Harden Minecraft Server](harden-minecraft-server.md), and [Establish NAS Storage](establish-nas-storage.md). It is not itself permission to change network or service configuration.

Use the [inventory checklist](../reference/inventory-checklist.md) to refresh physical model/hardware revision, installed components, firmware, OS/platform versions, attached devices, network capabilities, storage capacity/health, backup/restore, and monitoring. Record source, collection date, and confidence for each fact. For new infrastructure such as a NAS, compare its requirements against these current device specifications; recheck facts likely to change before purchase or deployment. Retain raw output in the private reference directory and promote only sanitized current facts to the corresponding host, service, or network record.

The HP EliteDesk 800 G5 Mini model, Intel I219-LM NIC, and a 2026-10-06 low-load Proxmox snapshot are now verified. Remaining first targets are HP firmware/bridge capability, switch revision/firmware/VLAN state and cable trace, guest peak resource and backup posture, Raspberry Pi OS patch level/SSD health, Tailscale routes/grants, and Home Assistant backup/restore. Follow each service-specific plan for deeper tests. Do not infer current values from a dated low-load or free-space snapshot.

## Capacity admission for additional services

At the 2026-10-06 low-load check, the HP had about 12 GiB memory available, six CPU threads with minimal load, and a 140.9 GiB thin pool with about 5.7% physical allocation. Five small services appear plausible if they use measured, lean guests and storage, but that snapshot cannot guarantee five full VMs or five data-heavy workloads. The primary Uptime Kuma observer should be independent of the HP under [Establish Remote Recovery](establish-remote-recovery.md); Homepage is a candidate HP workload. The portfolio VM already reserves a 2 GiB RAM allocation when started.

Before commissioning each additional guest, list its actual vCPU, RAM, system/data disk, peak load, retention, and network/exposure needs; compare the sum with the HP's measured peak plus a host reserve. Inspect thin-pool **data and metadata** utilization and real guest growth, not just nominal free space. Start one service at a time, measure concurrent CPU pressure, available memory, swap, I/O delay, and disk growth, then set limits and alerts. Reassess before a storage-heavy application, transcoding, AI work, or a router VM. A future NAS may change data placement; its delivery alone does not add compute or memory to the HP.
