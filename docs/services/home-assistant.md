# Home Assistant

**Status:** deployed Home Assistant OS VM on [Proxmox VE](proxmox-ve.md), hosted by the [HP EliteDesk](../hosts/hp-elitedesk.md). Private web onboarding succeeded. Runtime versions and integration records were last inspected on 2026-09-30; refresh them before compatibility or update work.

| Current-configuration field | Last verified or reported value |
| --- | --- |
| Core | 2026.9.4, read-only About page on 2026-09-30 |
| Supervisor | 2026.09.3, same observation |
| Home Assistant OS | 18.3, same observation |
| VM resources | 2 vCPUs, 2 GiB RAM, 32 GiB virtual disk |
| Virtual hardware | UEFI/OVMF, Q35, VirtIO SCSI, bridged VirtIO network adapter |
| Network and access | HomeLab LAN; private web access verified; Tailscale access verified |
| Configured integrations | Xbox and Archer UPnP/IGD device records observed; command behavior untested |
| Room plugs and bulbs | No device records or verified control at last inspection |

The Xbox integration exposed controls/storage entities and the Archer integration exposed status/traffic entities at inspection, but no control command was executed. Matter appeared only as an unconfigured discovery tile, without a named Sengled device; transient Tuya discovery was reported after the network move but not present at inspection. Neither tile proves a specific device's compatibility. The reported smart devices share the Archer-side network, which does not itself isolate them from Lab management.

USB radio passthrough for Bluetooth, Zigbee, Z-Wave, or Thread is not configured or verified. A USB Wi-Fi/Bluetooth adapter is available for the HP according to the reported state, but its identity and Home Assistant compatibility remain `UNKNOWN`. Backup target, retention, restore test, exact device/entity behavior, and resource utilization remain `UNKNOWN`.

The 2026-09-14 installation procedure and 2026-09-30 observations are preserved in [Home Assistant history](../history/home-assistant.md). Device-by-device compatibility research, backup gates, and remote-access steps are in [Onboard Home Assistant](../plans/onboard-home-assistant.md); optional media/account devices are in [Evaluate Optional Home Assistant Devices](../plans/evaluate-optional-home-assistant-devices.md). Exact guest identifiers, addresses, bridge/storage names, and credentials stay outside this public repository.
