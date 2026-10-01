# Establish NAS Storage

**Status:** Planned; no dedicated NAS, SAN, external array, or other network storage is deployed.

**Related plans:** [Deploy Jellyfin](deploy-jellyfin.md), [Deploy Nextcloud](deploy-nextcloud.md), and [Deploy Bitwarden](deploy-bitwarden.md) depend on the storage and recovery decision. [Segment HomeLab Network](segment-homelab-network.md) governs any NAS network placement.

## Purpose and dependencies

The existing [HP EliteDesk](../hosts/hp-elitedesk.md) uses internal-only storage at last verification. Its exact installed storage specification belongs in the host record. A larger, durable storage foundation is required before data-heavy or recovery-critical services are treated as production-ready.

Planned consumers include:

- [Convert Acer to AI Node](convert-acer-to-ai-node.md): model files, datasets, knowledge bases, and selected migration data.
- [Deploy Jellyfin](deploy-jellyfin.md): media libraries and growth capacity.
- [Deploy Nextcloud](deploy-nextcloud.md): primary user data and database/application recovery.
- [Deploy Bitwarden](deploy-bitwarden.md): possible NAS-hosted application plus encrypted backups and tested recovery artifacts, not an unprotected vault export.
- Proxmox guests: backups with defined retention and restore tests.

Before the NAS is bought, available Raspberry Pi USB-SSD capacity is a proposed interim Minecraft backup destination. Confirm free capacity, backup consistency, retention, and a restore. A copy on the same SSD is useful for rollback but does not survive SSD failure. The NAS is a candidate for service applications, data, and local backups, subject to separate permissions and capacity planning. Keep another independent or off-site recovery copy for critical data; a single NAS failure must not erase both primary data and every backup. See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md) for the optional storage VLAN and restricted cross-VLAN data/backup paths.

Direct NAS hosting is a candidate for Jellyfin, Nextcloud, and maintained production Bitwarden. Before selecting hardware/software, verify support for isolated app/VM networks or VLAN-tagged interfaces, private NAS management, workload-specific permissions, updates, MFA/application authentication, backup/export, and full restore. A managed-switch access port places the entire NAS on one VLAN; the router VM cannot separate applications sharing that host's network stack. The final per-service placement and whether direct NAS hosting is appropriate remain `TODO`. The Acer remains a separate intended local-AI compute node; NAS storage for its model/data files is optional after access and performance tests.

## Compatibility evidence to collect before purchase

Use the [current device specifications](../hosts/README.md), [network component record](../network/topology.md), and [infrastructure inventory checklist](../reference/inventory-checklist.md) as inputs rather than copying possibly stale values into this plan. Confirm each relevant device's exact model/hardware revision, firmware, network interfaces and negotiated speeds, VLAN/tagged-interface support, compute and memory limits, storage buses/bays/filesystem, application/VM isolation capability, power/UPS needs, update support, and backup/export/restore path. Distinguish advertised vendor capability from tested behavior on the selected firmware. Keep exact addresses, serials, exports, and credentials private. A candidate specification is planning evidence; it becomes current-state data only after the hardware is acquired and verified.

## Decisions still required

- Hardware platform, drive count/type/capacity, filesystem, redundancy, and expansion strategy: `UNKNOWN`.
- Network protocol, link speed, permissions, encryption, monitoring, and power-protection requirements: `UNKNOWN`.
- NAS application/VM support, per-workload VLAN capability, private management interface, and resource isolation: `UNKNOWN`.
- Backup destination, off-device/off-site copy, retention, recovery objectives, and restore-test schedule: `UNKNOWN`.
- Budget, noise, physical space, energy use, and acceptable downtime: `UNKNOWN`.

RAID or drive redundancy must not be represented as backup. Deployment is complete only after access controls, monitoring, backup, and a representative restore are verified.
