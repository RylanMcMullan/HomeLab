# 2026-10-06 — HP Ethernet Link and NIC Hangs

**Status:** 100 Mb/s link symptom `RESOLVED` at the 2026-10-06 check; prior `e1000e` hardware hangs `MONITORING`  
**First observed:** hardware hangs were first seen in the inspected prior-boot log on 2026-10-01  
**Last checked:** 2026-10-06  
**Affected systems:** HP EliteDesk running Proxmox VE; remote management was reported unreachable before reboot  
**Related current records:** [HP host](../../hosts/hp-elitedesk.md), [Proxmox VE](../../services/proxmox-ve.md), [switch topology](../../network/topology.md)

## Symptom and impact

The Proxmox web UI became unreachable from local Wi-Fi and Tailscale according to the operator's report. After a manual restart, the HP's NIC negotiated at 100 Mb/s and the prior boot's kernel log showed repeated Intel `e1000e` hardware hangs. The relationship between the management outage and those log events remains `UNKNOWN`.

## Chronology and evidence

| Date and source | Observation or test | Result and confidence | Detailed history |
| --- | --- | --- | --- |
| 2026-10-06, operator report | Management access failed and the HP was restarted | Reported outage; cause `UNKNOWN` | [Proxmox baseline](../proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) |
| 2026-10-06, host shell | Reviewed prior/current boot NIC logs and negotiated link | Verified prior-boot hangs and 100 Mb/s link; no current-boot matching hang at the check | [Proxmox baseline](../proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) |
| 2026-10-06, host shell | Applied reversible TSO/GSO/GRO workaround | Verified service active and live offloads disabled; root-cause effect unproved | [Mitigation detail and rollback](../proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) |
| 2026-10-06, operator and host shell | Compared direct cable, ports 2/3, coupler path, and coupler reseat | Reported 100 Mb/s only with the loose coupler path; HP later verified 1,000 Mb/s on final port 2 connection | [Network diagnosis](../network-discovery.md#2026-10-06--patch-coupler-seating-diagnosis) |
| 2026-10-06, host shell | Rechecked link, counters, current-boot hangs, and external ping | Verified 1,000 Mb/s full duplex, zero selected errors/timeouts and matching hangs, five probes with no loss | [Final Proxmox check](../proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption) |
| 2026-10-06, host shell | Inspected guest boot settings after the earlier restart | Verified the Tailscale LXC was stopped with automatic start disabled, while Home Assistant was running | [Guest startup follow-up](../proxmox-baseline.md#2026-10-06--guest-startup-resource-baseline-and-controlled-reboot) |
| 2026-10-06, host shell and controlled reboot | Enabled and prioritized Tailscale autostart, then rebooted Proxmox | Verified Tailscale started before Home Assistant, both ran, link returned at 1 Gb/s, offload mitigation persisted, and no new hang appeared at the check | [Controlled reboot](../proxmox-baseline.md#2026-10-06--guest-startup-resource-baseline-and-controlled-reboot) |

## Diagnosis and changes

- **Supported cause of the slow link:** an incompletely seated connection at the patch-panel coupler. The direct-path and reseat comparisons did not identify a defective cable or switch port.
- **Cause of older NIC hangs or initial management outage:** `UNKNOWN`. The shared HP uplink and repeated `e1000e` hardware hangs make a host-network failure plausible for both local and Tailscale paths, but no contemporaneous end-to-end reachability trace proves it. The physical repair and software workaround occurred close together, so their separate effects on the hangs are unproved.
- **Why Tailscale stayed unavailable after the earlier reboot:** verified `onboot: 0` left its LXC stopped. This was a separate recovery failure from the original outage.
- **Changes applied:** the operator reseated the coupler-side connection and returned the HP to switch port 2; an offload-disabling systemd service remains active on Proxmox. Tailscale LXC automatic start and priority 1 were enabled, with Home Assistant priority 2. The [host history](../proxmox-baseline.md#2026-10-06--guest-startup-resource-baseline-and-controlled-reboot) records the follow-up and reboot verification.

## Verification and remaining work

- **Verified outcome:** the HP negotiated 1,000 Mb/s full duplex on port 2 on 2026-10-06, with no selected current-boot NIC errors or hangs at the check. A five-packet external ping had no loss.
- **Remaining uncertainty:** sustained stability and cause of the older hangs. The offload service and guest startup survived one controlled reboot, but the other devices' final port assignments were reported or inferred rather than command-verified. External-client Tailscale route behavior remains untested.
- **Reopen if:** the HP negotiates 100 Mb/s again, management becomes unreachable without an explained maintenance event, or new NIC hangs or error/timeout counters appear.
- **Next check:** inspect link speed, counters, and kernel logs after normal operation; test remote-client reachability and an independent alert/recovery path under the [recovery plan](../../plans/establish-remote-recovery.md). Keep the public website route gated by the [portfolio plan](../../plans/publish-portfolio-website.md#tunnel-first-publication-gate).

## References

- Reusable procedure: [Troubleshoot an Ethernet Link](../../reference/troubleshoot-ethernet-link.md).
- Detailed topic histories: [network diagnosis](../network-discovery.md#2026-10-06--patch-coupler-seating-diagnosis) and [Proxmox baseline](../proxmox-baseline.md#2026-10-06--reported-management-reachability-interruption).
