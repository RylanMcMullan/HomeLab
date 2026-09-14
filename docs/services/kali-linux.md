# Kali Linux security-research VM

**Status:** planned persistent Proxmox VM; not deployed.

## Authorized purpose

Provide an always-available environment for defensive monitoring, learning, and long-running security assessments against lab-owned systems or other targets covered by explicit authorization. Examples may include vulnerability validation and rate-controlled password-auditing exercises within the documented scope.

The VM is not an unrestricted attack host. Its existence does not authorize scanning, exploitation, credential testing, or monitoring of third-party systems.

## Proposed controls

- Use a dedicated VM rather than mixing offensive tooling into the Proxmox host or ordinary service containers.
- Download images only from official Kali sources and verify published checksums. Kali provides specific [Proxmox guest guidance](https://www.kali.org/docs/virtualization/install-proxmox-guest-vm/).
- Keep management private; do not publish guest identifiers, addresses, credentials, target lists, captures, wordlists containing real credentials, or assessment results.
- Define permitted targets, time windows, bandwidth/rate limits, logging, data retention, and an emergency stop procedure before long-running work.
- Determine network segmentation before deployment. Access to household, management, or public networks must be no broader than the approved test scope.
- Resource allocation, storage, guest version, tools, monitoring integrations, and autostart behavior remain `UNKNOWN` until designed and verified.
