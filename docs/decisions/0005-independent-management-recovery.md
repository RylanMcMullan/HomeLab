# 0005 — Independent management recovery

**Status:** Accepted target design; independent monitoring and power control are not deployed
**Date:** 2026-10-06

## Context

The HP Proxmox host became unreachable from local Wi-Fi and Tailscale during an episode with repeated NIC hangs. After reboot, its Tailscale LXC was stopped because automatic start was disabled. A dashboard, monitor, or subnet router hosted only on the HP cannot reliably diagnose or recover the HP when the host or its uplink is unavailable. The planned router VM could create a second dependency on the same host.

## Decision

Keep Homepage as a private navigation dashboard that may run on the HP. Place the primary Uptime Kuma observer and a scoped remote administrative endpoint on an independently powered device after capacity and security checks; the Raspberry Pi 5 and future NAS are candidates. Preserve an Archer-side recovery path that does not require the future router VM. Test host boot order, Tailscale route behavior, and an operator-controlled physical or remote power option before depending on unattended recovery. Keep every management endpoint private.

## Consequences

An independent observer can alert during an HP outage and may send Wake-on-LAN if the HP supports it and the shared LAN works. It does not survive a shared switch, router, power, or ISP failure without further independent infrastructure. Remote outlet/PDU cycling is a separate last-resort decision after hardware and data-safety review. The HP's local Tailscale LXC remains useful during normal operation, but is not the sole recovery route.

## Related documentation

- [Recovery plan](../plans/establish-remote-recovery.md)
- [Management services plan](../plans/deploy-management-services.md)
- [2026-10-06 HP incident](../history/incidents/2026-10-06-hp-ethernet-link.md)
- [Segmented services decision](0003-segmented-services-and-remote-access.md)
