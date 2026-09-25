# Dedicated storage and recovery plan

**Status:** planned; no dedicated NAS, SAN, external array, or other network storage is deployed.

## Purpose and dependencies

The existing Proxmox node uses only its internal 256 GB-class NVMe device. A larger, durable storage foundation is required before data-heavy or recovery-critical services are treated as production-ready.

Planned consumers include:

- [Local AI](../services/local-ai.md): model files, datasets, knowledge bases, and selected migration data.
- [Jellyfin](../services/jellyfin.md): media libraries and growth capacity.
- [Nextcloud](../services/nextcloud.md): primary user data and database/application recovery.
- [Production Bitwarden](../services/password-manager.md): possible NAS-hosted application plus encrypted backups and tested recovery artifacts, not an unprotected vault export.
- Proxmox guests: backups with defined retention and restore tests.

Before the NAS is bought, the owner proposes using available Raspberry Pi USB-SSD capacity for interim Minecraft backups. Confirm free capacity, backup consistency, retention, and a restore. A copy on the same SSD is useful for rollback but does not survive SSD failure. The NAS is a candidate for service applications, data, and local backups, subject to separate permissions and capacity planning. Keep another independent or off-site recovery copy for critical data; a single NAS failure must not erase both primary data and every backup. See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md) for the optional storage VLAN and restricted cross-VLAN data/backup paths.

The owner is considering hosting Jellyfin, Nextcloud, and the maintained production password manager directly on the NAS. Before selecting hardware/software, verify support for isolated app/VM networks or VLAN-tagged interfaces, private NAS management, workload-specific permissions, updates, MFA/application authentication, backup/export, and full restore. A managed-switch access port places the entire NAS on one VLAN; the router VM cannot separate applications sharing that host's network stack. The final per-service placement and whether direct NAS hosting is appropriate remain `TODO`. The Acer remains a separate intended local-AI compute node; NAS storage for its model/data files is optional after access and performance tests.

## Decisions still required

- Hardware platform, drive count/type/capacity, filesystem, redundancy, and expansion strategy: `UNKNOWN`.
- Network protocol, link speed, permissions, encryption, monitoring, and power-protection requirements: `UNKNOWN`.
- NAS application/VM support, per-workload VLAN capability, private management interface, and resource isolation: `UNKNOWN`.
- Backup destination, off-device/off-site copy, retention, recovery objectives, and restore-test schedule: `UNKNOWN`.
- Budget, noise, physical space, energy use, and acceptable downtime: `UNKNOWN`.

RAID or drive redundancy must not be represented as backup. Deployment is complete only after access controls, monitoring, backup, and a representative restore are verified.
