# Changelog

This changelog records significant infrastructure changes only. Documentation-only edits, typo fixes, and formatting changes do not belong here.

## Unreleased

### 2026-10-07 — Portfolio VM attempt removed

- What changed: removed the unsuccessful portfolio installation guest, its virtual disk and installer ISO, and all temporary bridge, forwarding, NAT, nftables, rollback-unit, and staging-file changes from the HP Proxmox host.
- Scope / affected systems: HP EliteDesk Proxmox host only. The host returned to its prior two-guest workload and management-network configuration; no website, tunnel, or public route was deployed.
- Verification: Proxmox showed only the running Tailscale LXC and Home Assistant VM; the temporary bridge was absent, IPv4 forwarding was disabled, no nftables tables from the attempt remained, and the HP link was up at 1,000 Mb/s full duplex.
- Documentation: [Portfolio VM attempt](docs/history/portfolio-vm-installation-attempt.md), [current state](CURRENT_STATE.md), and [portfolio plan](docs/plans/publish-portfolio-website.md).

### 2026-10-06 — HP link and guest startup recovered; portfolio VM prepared

- What changed: created a dedicated, powered-off portfolio VM with no virtual NIC; downloaded and checksum-verified the Debian installer; enabled a reversible NIC offload mitigation on the HP host. The operator's coupler reseat restored gigabit negotiation on the final port 2 connection. The Tailscale LXC, found stopped with automatic start disabled after the earlier reboot, was started and configured to boot before Home Assistant.
- Scope / affected systems: HP EliteDesk Proxmox host and private VM preparation only. No OS, portfolio service, tunnel, domain route, or public endpoint is deployed.
- Verification: Proxmox VM configuration and stopped state, official installer SHA-512 check, live offload state and service status, 1,000 Mb/s full-duplex HP link on port 2, zero selected current-boot NIC errors/hangs, and a five-packet external ping with no loss. A later controlled reboot verified Tailscale and Home Assistant started in order, the offload settings persisted, and the link returned at 1 Gb/s with no new hang at the check. The prior hang cause and sustained stability remain unverified.
- Documentation: [Proxmox history](docs/history/proxmox-baseline.md#2026-10-06--guest-startup-resource-baseline-and-controlled-reboot), [Ethernet incident](docs/history/incidents/2026-10-06-hp-ethernet-link.md), [network diagnosis](docs/history/network-discovery.md), [current state](CURRENT_STATE.md), and [remote-recovery plan](docs/plans/establish-remote-recovery.md).

### 2026-09-30 — Smart devices moved to the HomeLab network

- What changed: the reported state was that intended smart devices were powered on and moved to the Archer HomeLab network, owned clients were labeled in its management UI, and Xbox and Archer UPnP were connected in Home Assistant.
- Scope / affected systems: Archer shared LAN and Home Assistant. Device-by-device identity, room-device control, and any IoT-to-Lab isolation remain unverified; no router-VM or VLAN change is reported.
- Verification: reported state at the time; later read-only router and Home Assistant observations are in [device-inventory history](docs/history/device-inventory.md).
- Documentation: [current state](CURRENT_STATE.md), [device-inventory history](docs/history/device-inventory.md), and [Home Assistant](docs/services/home-assistant.md).

### 2026-09-25 — HomeLab IoT devices disconnected for staged testing

- What changed: the reported state was that all HomeLab IoT devices were disconnected until controlled Home Assistant tests began.
- Scope / affected systems: HomeLab IoT device connectivity; no Home Assistant integration or router/VLAN change was verified.
- Verification: reported state at the time; superseded by the 2026-09-30 reconnection report.
- Documentation: [device-inventory history](docs/history/device-inventory.md) and [Home Assistant](docs/services/home-assistant.md).

### 2026-09-14 — Home Assistant deployed on Proxmox

- What changed: a new Home Assistant OS virtual machine was created from the checksum-verified official 18.2 KVM image and completed private web onboarding.
- Scope / affected systems: HP EliteDesk Proxmox node and private HomeLab service access.
- Verification: the reported state included successful VM boot, web access, account creation, and automatic recognition of the TP-Link Archer router integration. Other smart-device discovery, versions, backups, Tailscale access, and sustained resource use were unverified at that time.
- Documentation: [Home Assistant deployment history](docs/history/home-assistant.md) and [current state](CURRENT_STATE.md).

## Historical changes

Detailed, dated public-safe evidence now lives in [history](docs/history/README.md). Add changelog entries only for significant infrastructure changes; do not use this file as a raw inventory or deployment procedure.

### Entry format

```md
## YYYY-MM-DD — Short change title

- What changed: ...
- Scope / affected systems: ...
- Verification: ...
- Documentation: `TODO — add a valid relative link`
```
