# Proxmox VE

**Status:** deployed virtualization platform on the [HP EliteDesk 800 G5 Mini](../hosts/hp-elitedesk.md). Platform and current guest/resource values below were command-verified on 2026-10-06; deeper storage-health and peak-load sizing remain open.

| Current-configuration field | Last verified value |
| --- | --- |
| Base OS | Debian GNU/Linux 13 (`trixie`), x86-64 |
| Platform | `pve-manager` 9.2.2 on 2026-10-06; earlier `proxmox-ve` package observation was 9.2.0 on 2026-09-14 and was not rechecked |
| Running kernel | `7.0.2-6-pve` |
| Physical host | [HP EliteDesk 800 G5 Mini](../hosts/hp-elitedesk.md) |
| Storage | Internal Samsung NVMe only at last verification; 1 GiB EFI, 69.2 GiB ext4 root, 8 GiB swap LV, 140.9 GiB LVM-thin pool |
| Hosted workloads | [Home Assistant OS VM](home-assistant.md), verified [Tailscale subnet-router LXC](tailscale.md), and a stopped, uninstalled portfolio VM with no virtual NIC |

The known LXC is unprivileged and Debian-based, with 1 CPU core, 256 MiB RAM, 256 MiB swap, and a 2 GiB root filesystem. Its Tailscale identity was verified inside the guest on 2026-10-06. Nesting was observed on 2026-09-14 but was not rechecked. The initial one-LXC/zero-VM observation is kept in [history](../history/proxmox-baseline.md), not treated as the current guest count.

On 2026-10-06, the Tailscale LXC and Home Assistant VM were verified to start automatically in that order after a controlled host reboot. The portfolio VM stayed stopped. The Home Assistant VM has two configured vCPUs and 2 GiB RAM. The [dated startup and resource check](../history/proxmox-baseline.md#2026-10-06--guest-startup-resource-baseline-and-controlled-reboot) records the exact evidence.

Tailscale provides the reported remote administration path. Exact host/guest identifiers, bridge names, private addresses, storage-volume names, endpoints, and authentication material stay outside this public repository. At a 2026-10-06 low-load check with Home Assistant and Tailscale running, host memory was about 3.3 GiB used with 12 GiB available, swap unused, and load average below 0.1. The root filesystem was about 10% used; the 140.9 GiB thin pool was about 5.7% physically allocated. These are snapshots, not guaranteed capacity or peak figures. Current backup, restore, update, monitoring, peak-resource behavior, and detailed NVMe health remain `UNKNOWN`. Related work is in [Segment HomeLab Network](../plans/segment-homelab-network.md), [Establish Remote Recovery](../plans/establish-remote-recovery.md), and [Establish NAS Storage](../plans/establish-nas-storage.md).

**2026-10-06 reachability and NIC status:** Web UI and shell reachability returned after the reported outage and restart. The prior boot logged repeated Intel `e1000e` NIC hardware hangs. After the operator reseated the patch-panel coupler connection and returned the HP to switch port 2, the Intel I219-LM link verified 1,000 Mb/s full duplex, selected error and timeout counters were zero, and a five-packet external ping had no loss. A reversible `nic0-offloads.service` disables TSO, GSO, and GRO at boot; a later controlled reboot verified its persistence, the 1 Gb/s link, and no matching NIC hang at the check. The [dated evidence and rollback](../history/proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) do not establish sustained stability or the root cause of the earlier hangs. Monitor before public hosting.

**2026-10-06 portfolio VM status:** A dedicated, powered-off VM has an official checksum-verified Debian installer attached, a 16 GiB disk, one vCPU, and 2 GiB RAM. It has no virtual NIC and no installed OS. See the [preparation evidence](../history/proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) and [publication plan](../plans/publish-portfolio-website.md).
