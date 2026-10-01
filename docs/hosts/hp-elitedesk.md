# HP EliteDesk

**Status:** deployed physical host. Hardware was last command-verified on 2026-09-14; confirm mutable values before capacity or compatibility decisions.

## Hardware

- HP EliteDesk; exact model: 800 G5 Mini.
- Intel Core i5-9500 with 6 cores, 6 threads, and Intel VT-x.
- 16 GB DDR4-2667 RAM: one 16 GB SODIMM in the reported `DIMM1` locator and no module installed in the second reported locator.
- Integrated Intel UHD Graphics 630.
- Internal 256 GB-class Samsung NVMe SSD, model `MZVLB256HAHQ-000L7`; Linux reports 238.5 GiB usable device capacity.
- The last recorded storage connection was internal-only; no NAS, SAN, or external array was connected. Recheck before relying on this for new workloads.

## Installed platform and hosted services

- Installed OS/platform: [Proxmox VE](../services/proxmox-ve.md) on Debian GNU/Linux 13 (`trixie`), x86-64; the last verified runtime versions and virtual storage layout are in the platform record.
- Hosted workloads: [Home Assistant](../services/home-assistant.md) VM and a [Tailscale subnet-router](../services/tailscale.md) LXC, with the LXC identity still inferred rather than verified inside the guest.
- Remote Proxmox administration is reached through Tailscale according to the reported state. Exact endpoint, addressing, guest IDs, and authentication material are not published.

The dated initial guest count, storage utilization, memory/load figures, and LXC usage remain in [Proxmox baseline history](../history/proxmox-baseline.md). They are not current sizing measurements.

## Compatibility information still needed

- Exact submodel, NIC count/capabilities, expansion options, firmware and storage health: `UNKNOWN`.
- Sustained/peak utilization, backup/restore posture, and monitoring status: `UNKNOWN` until measured or verified.
