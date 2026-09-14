# Changelog

This changelog records significant infrastructure changes only. Documentation-only edits, typo fixes, and formatting changes do not belong here.

## Unreleased

### 2026-09-14 — Home Assistant deployed on Proxmox

- What changed: a new Home Assistant OS virtual machine was created from the checksum-verified official 18.2 KVM image and completed private web onboarding.
- Scope / affected systems: HP EliteDesk Proxmox node and private HomeLab service access.
- Verification: owner reported successful VM boot, web access, account creation, and automatic recognition of the TP-Link Archer router integration. Other smart-device discovery, versions, backups, Tailscale access, and sustained resource use remain unverified.
- Documentation: [Home Assistant](docs/services/home-assistant.md) and [current state](CURRENT_STATE.md).

## Historical changes

Historical infrastructure changes have not yet been independently documented. Add dated entries only when the owner provides or verifies sufficient detail.

### Entry format

```md
## YYYY-MM-DD — Short change title

- What changed: ...
- Scope / affected systems: ...
- Verification: ...
- Documentation: `TODO — add a valid relative link`
```
