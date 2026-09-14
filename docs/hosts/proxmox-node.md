# HP EliteDesk Proxmox node

**Status:** deployed primary virtualization server. Platform and resource inventory was command-verified on 2026-09-14. The exact EliteDesk model remains `UNKNOWN`; hostname, IP address, and guest ID are intentionally omitted from this public repository.

## Hardware

- HP EliteDesk; exact model: `UNKNOWN`.
- Intel Core i5-9500 with 6 cores, 6 threads, and Intel VT-x.
- 16 GB DDR4-2667 RAM: one 16 GB SODIMM in the reported `DIMM1` locator and no module installed in the second reported locator.
- Integrated Intel UHD Graphics 630.
- Internal 256 GB-class Samsung NVMe SSD, model `MZVLB256HAHQ-000L7`; Linux reports 238.5 GiB usable device capacity.
- Uses internal storage only. No NAS, SAN, external array, or other network storage is currently connected to this Proxmox node.

## Storage layout

- EFI system partition: 1 GiB, approximately 1% used at collection time.
- Root filesystem: 69.2 GiB ext4, with 59.8 GiB available and approximately 6% used at collection time.
- Swap logical volume: 8 GiB; unused at collection time.
- Internal LVM-thin data pool: 140.9 GiB, approximately 0.73% allocated at collection time.

Storage figures are point-in-time observations from 2026-09-14, not capacity guarantees.

## Platform and workloads

- Base operating system: Debian GNU/Linux 13 (`trixie`), x86-64.
- Virtualization platform: Proxmox VE 9.2.0; `pve-manager` 9.2.2; running kernel `7.0.2-6-pve`.
- Guest inventory at initial collection time: one running LXC and zero virtual machines. A Home Assistant OS VM was subsequently deployed and owner-verified operational on 2026-09-14.
- The LXC is unprivileged, uses Debian, has nesting enabled, and is allocated 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem.
- The sole LXC is consistent with the owner-reported [Tailscale subnet router](../services/tailscale.md), but this collection did not verify the service inside the guest.

## Point-in-time utilization

- Host memory: approximately 1.7 GiB used, 13 GiB available, and no swap in use.
- Load average: `0.03`, `0.01`, `0.00` after approximately 20 days of host uptime.
- LXC memory: approximately 48 MiB used; root filesystem approximately 815 MiB used; no guest swap in use.

These measurements are an idle or low-load snapshot from 2026-09-14. They are insufficient by themselves for peak-capacity sizing.

## Administration and security

- Tailscale provides secure remote access to the Proxmox management interface and internal HomeLab systems. See [Tailscale](../services/tailscale.md).
- Management endpoint, account names, certificates, and authentication configuration: `UNKNOWN` and must not be stored here if sensitive.

## Update checklist

Still `TODO`: verify the exact EliteDesk model, sustained/peak utilization, storage health, backup and restore posture, monitoring, firmware posture, and whether the LXC workload is directly verified as Tailscale. Do not add passwords, private addresses, guest IDs, tokens, or private keys.
