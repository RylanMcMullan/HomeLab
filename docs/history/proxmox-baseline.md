# Proxmox Baseline History

Related: [HP EliteDesk](../hosts/hp-elitedesk.md), [Proxmox VE](../services/proxmox-ve.md), [Home Assistant](../services/home-assistant.md).

## 2026-09-14 — Initial Host and LXC Inventory

The platform and resource inventory was command-verified on 2026-09-14. At initial collection, one LXC was running and no virtual machines existed. A Home Assistant OS VM was subsequently deployed and reported operational on the same date. This is an initial snapshot, not a current guest count.

| Observation | Recorded value |
| --- | --- |
| EFI system partition | 1 GiB, approximately 1% used |
| Root filesystem | 69.2 GiB ext4, 59.8 GiB available, approximately 6% used |
| Swap logical volume | 8 GiB, unused |
| Internal LVM-thin data pool | 140.9 GiB, approximately 0.73% allocated |
| Host memory | Approximately 1.7 GiB used, 13 GiB available, no swap in use |
| Load average | `0.03`, `0.01`, `0.00` after approximately 20 days of uptime |
| LXC memory and storage | Approximately 48 MiB memory used, 815 MiB root filesystem used, no guest swap in use |

The LXC was unprivileged, Debian-based, and had nesting enabled with 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem allocated. Its identity as the Tailscale subnet router was inferred from the reported workload, not verified inside the guest. These low-load measurements were insufficient for peak-capacity sizing. Raw command output is held in the private inventory.
