# Changelog

This changelog records significant infrastructure changes only. Documentation-only edits, typo fixes, and formatting changes do not belong here.

## Unreleased

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
