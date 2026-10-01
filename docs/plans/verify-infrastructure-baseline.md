# Verify Infrastructure Baseline

**Status:** Planned. Deployed systems have an initial inventory, but several hardware, software, backup, and recovery facts remain unverified.

**Related plans:** Supplies evidence to [Onboard Home Assistant](onboard-home-assistant.md), [Segment HomeLab Network](segment-homelab-network.md), [Harden Minecraft Server](harden-minecraft-server.md), and [Establish NAS Storage](establish-nas-storage.md). It is not itself permission to change network or service configuration.

Use the [inventory checklist](../reference/inventory-checklist.md) to refresh physical model/hardware revision, installed components, firmware, OS/platform versions, attached devices, network capabilities, storage capacity/health, backup/restore, and monitoring. Record source, collection date, and confidence for each fact. For new infrastructure such as a NAS, compare its requirements against these current device specifications; recheck facts likely to change before purchase or deployment. Retain raw output in the private reference directory and promote only sanitized current facts to the corresponding host, service, or network record.

First targets are the exact HP EliteDesk submodel and NIC/bridge capability, switch revision/firmware/VLAN state and cable trace, current Proxmox guest/resource and backup posture, Raspberry Pi OS/SSD health, Tailscale routes/grants, and Home Assistant backup/restore. Follow each service-specific plan for deeper tests. Do not infer current values from a dated low-load or free-space snapshot.
