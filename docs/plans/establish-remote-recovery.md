# Establish Remote Recovery

**Status:** Planned. The HP's Tailscale LXC now has automatic start configured, but independent monitoring and remote power control are not deployed. See the [2026-10-06 incident](../history/incidents/2026-10-06-hp-ethernet-link.md).

**Purpose:** Detect whether the HP, its guests, the LAN path, or the public website is failing, and provide a recovery route when the rack is inaccessible. This is separate from service navigation in [Deploy Management Services](deploy-management-services.md).

## Recovery design

1. **Independent observer:** Run Uptime Kuma on a device that stays reachable when the HP is off. The Raspberry Pi 5 is a candidate only after its spare resources, current Minecraft load, SSD health, and security posture are measured; the future NAS is another candidate. Monitor the HP management endpoint, Home Assistant, the portfolio origin/public route after launch, the Archer or switch where reachable, and the observer's own health through an external notification path. Keep the interface private. A monitor on the HP can supply local detail but cannot reliably report that its own host is dead.
2. **Independent administrative path:** Put a separately scoped Tailscale client on the observer or another always-on device, then test private access with the HP stopped. If a second subnet router advertises the same approved routes, verify Tailscale route failover and policy rather than assuming it works. A working tailnet on the HP's LXC alone cannot recover an HP or switch failure. The management path must not depend solely on a router VM hosted by the HP.
3. **Power options:** First verify the HP model's BIOS Wake-on-LAN and power-after-AC-loss settings and whether this unit supports any authenticated hardware management capability. Test Wake-on-LAN from the independent device for soft-off recovery. A remotely controlled outlet or managed PDU is an optional last-resort power-cycle tool; confirm its independent control path and safe shutdown policy before use. An ordinary non-PoE HP power cord cannot be cycled through a switch port. Neither Wake-on-LAN nor a network PDU works if the shared LAN or its power has failed.
4. **Known-good local fallback:** Document a tested console/cable/port path and label the patch-panel connection. Preserve direct access to the Archer-side network before moving management behind the planned router VM. An independent network/power path would be required for true recovery from whole-rack or ISP failure.

## Verification gates

- Configure every deployed, intended always-on Proxmox container for automatic start. Current priority is Tailscale LXC first, then the Home Assistant VM. When deployed, start the portfolio origin and its connector before convenience services such as Homepage; use explicit dependency/readiness checks within guests. Leave uninstalled or intentionally test-only guests off until commissioned. Recheck the full start order after adding a guest.
- Record separate checks for host reachable, Tailscale LXC online, Home Assistant reachable, public site reachable after deployment, and notifications delivered. A status page on the failed host is not a failure alert.
- Test a controlled guest stop, a controlled HP shutdown/start, and a simulated route failure from an external client. Verify the independent observer and remote control still work where expected. Stop tests before risking production data.
- Confirm the HP returns to 1 Gb/s, has no new `e1000e` hangs or NIC error counters, starts its intended guests, and runs the NIC mitigation after an acceptable reboot. Revisit the mitigation only after sustained physical-path evidence and a controlled change window.
- Keep credentials, exact addresses, monitoring targets, notifications, switch exports, and recovery keys outside this public repository.

## Rollback and limits

Remove a failed second subnet-router advertisement before changing the original route. Disable any newly configured power control if it cycles the wrong outlet or lacks authentication. Revert a monitoring guest without affecting the HP's current Tailscale LXC. A remote power cycle is a last resort because it can interrupt writes and does not repair an unplugged or degraded cable.

## Dependencies and references

- [HP host](../hosts/hp-elitedesk.md) and [Raspberry Pi 5](../hosts/raspberry-pi-5.md) capacity and interfaces.
- [Segment HomeLab Network](segment-homelab-network.md) for later VLAN and router-VM changes.
- [Decision 0005](../decisions/0005-independent-management-recovery.md) for the independent control-plane rule.
- [Tailscale subnet-router high availability](https://tailscale.com/docs/how-to/set-up-high-availability), [Uptime Kuma](https://github.com/louislam/uptime-kuma), and [HP EliteDesk 800 G5 Desktop Mini maintenance guide](https://h10032.www1.hp.com/ctg/Manual/c06439994.pdf). Product documentation describes available features; this specific unit's BIOS options and external route behavior still require testing.
