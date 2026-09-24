# Architecture

The authoritative high-level current architecture record is [HomeLab boundary and service paths](overview.md). It separates the household network from the HomeLab and identifies externally reachable and remote-administration paths without publishing sensitive addressing or credentials. The future segmented design is recorded separately in [decision 0003](../decisions/0003-segmented-services-and-remote-access.md).

The [storage plan](storage-plan.md) records the shared dependency for the AI data pool, Jellyfin, Nextcloud, and service backups. The planned [malware-analysis lab](../services/malware-analysis-lab.md) has stricter isolation requirements and is not part of the current network.

For operational inventory, use [CURRENT_STATE.md](../../CURRENT_STATE.md). For intended changes, use [ROADMAP.md](../../ROADMAP.md).
