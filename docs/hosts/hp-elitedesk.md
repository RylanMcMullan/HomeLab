# HP EliteDesk 800 G5 Mini

**Status:** deployed physical host. Core hardware was command-verified on 2026-09-14, and its NIC, link, host resources, and guest startup were checked again on 2026-10-06. Confirm mutable values before capacity or compatibility decisions.

## Hardware

- HP EliteDesk 800 G5 Mini.
- Intel Core i5-9500 with 6 cores, 6 threads, and Intel VT-x.
- 16 GB DDR4-2667 RAM: one 16 GB SODIMM in the reported `DIMM1` locator and no module installed in the second reported locator.
- Integrated Intel UHD Graphics 630.
- Internal 256 GB-class Samsung NVMe SSD, model `MZVLB256HAHQ-000L7`; Linux reports 238.5 GiB usable device capacity.
- Intel Ethernet Connection (7) I219-LM, identified on 2026-10-06. The link verified 1,000 Mb/s after the operator reseated a patch-panel coupler connection and returned the HP to switch port 2, including after a subsequent controlled reboot. The [earlier 100 Mb/s link and NIC hangs](../history/proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) are documented separately; sustained NIC stability remains under investigation.
- The last recorded storage connection was internal-only; no NAS, SAN, or external array was connected. Recheck before relying on this for new workloads.

## Installed platform and hosted services

- Installed OS/platform: [Proxmox VE](../services/proxmox-ve.md) on Debian GNU/Linux 13 (`trixie`), x86-64; the last verified runtime versions and virtual storage layout are in the platform record.
- Hosted workloads: [Home Assistant](../services/home-assistant.md) VM, a verified [Tailscale subnet-router](../services/tailscale.md) LXC, and a stopped portfolio-preparation VM with no installed OS or virtual NIC. The LXC starts first and Home Assistant second after host boot, verified during a 2026-10-06 controlled reboot.
- Remote Proxmox administration is reached through Tailscale according to the reported state. Exact endpoint, addressing, guest IDs, and authentication material are not published.

The dated initial guest count, storage utilization, memory/load figures, and LXC usage remain in [Proxmox baseline history](../history/proxmox-baseline.md). A fresh low-load capacity snapshot was added there on 2026-10-06; it is not peak sizing evidence.

## Compatibility information still needed

- Full NIC count, expansion options, firmware, and detailed storage health: `UNKNOWN`. The exact 800 G5 Mini model is known; the 2026-10-06 NVMe overall SMART check passed, while deeper health and sustained behavior remain unverified.
- Sustained/peak utilization, backup/restore posture, and independent monitoring status: `UNKNOWN` until measured or verified. The [management plan](../plans/deploy-management-services.md) and [remote-recovery plan](../plans/establish-remote-recovery.md) own the next checks.
