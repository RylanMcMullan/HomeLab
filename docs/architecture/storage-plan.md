# Dedicated storage and recovery plan

**Status:** planned; no dedicated NAS, SAN, external array, or other network storage is deployed.

## Purpose and dependencies

The existing Proxmox node uses only its internal 256 GB-class NVMe device. A larger, durable storage foundation is required before data-heavy or recovery-critical services are treated as production-ready.

Planned consumers include:

- [Local AI](../services/local-ai.md): model files, datasets, knowledge bases, and selected migration data.
- [Jellyfin](../services/jellyfin.md): media libraries and growth capacity.
- [Nextcloud](../services/nextcloud.md): primary user data and database/application recovery.
- [Password manager](../services/password-manager.md): encrypted backups and tested recovery artifacts, not an unprotected vault export.
- Proxmox guests: backups with defined retention and restore tests.

## Decisions still required

- Hardware platform, drive count/type/capacity, filesystem, redundancy, and expansion strategy: `UNKNOWN`.
- Network protocol, link speed, permissions, encryption, monitoring, and power-protection requirements: `UNKNOWN`.
- Backup destination, off-device/off-site copy, retention, recovery objectives, and restore-test schedule: `UNKNOWN`.
- Budget, noise, physical space, energy use, and acceptable downtime: `UNKNOWN`.

RAID or drive redundancy must not be represented as backup. Deployment is complete only after access controls, monitoring, backup, and a representative restore are verified.
