# Proxmox VE

**Status:** deployed virtualization platform on the [HP EliteDesk](../hosts/hp-elitedesk.md). Runtime values below were last command-verified on 2026-09-14; they require refresh before capacity or upgrade decisions.

| Current-configuration field | Last verified value |
| --- | --- |
| Base OS | Debian GNU/Linux 13 (`trixie`), x86-64 |
| Platform | Proxmox VE 9.2.0; `pve-manager` 9.2.2 |
| Running kernel | `7.0.2-6-pve` |
| Physical host | [HP EliteDesk](../hosts/hp-elitedesk.md) |
| Storage | Internal Samsung NVMe only at last verification; 1 GiB EFI, 69.2 GiB ext4 root, 8 GiB swap LV, 140.9 GiB LVM-thin pool |
| Hosted workloads | [Home Assistant OS VM](home-assistant.md) and one LXC inferred to run the [Tailscale subnet router](tailscale.md) |

The known LXC was unprivileged and Debian-based, with nesting enabled and allocations of 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem. Its service identity needs direct verification inside the guest. A Home Assistant OS VM was deployed later on 2026-09-14; the initial one-LXC/zero-VM observation is kept in [history](../history/proxmox-baseline.md), not treated as the current guest count.

Tailscale provides the reported remote administration path. Exact host/guest identifiers, bridge names, private addresses, storage-volume names, endpoints, and authentication material stay outside this public repository. Current backup, restore, update, monitoring, and peak-resource behavior remain `UNKNOWN`. Related work is in [Segment HomeLab Network](../plans/segment-homelab-network.md) and [Establish NAS Storage](../plans/establish-nas-storage.md).
