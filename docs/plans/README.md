# Plans

Plan filenames are stable. Each plan states its status and records related plans, dependencies, detailed work, verification, and rollback as applicable; unresolved gates stay `TODO`. Only [`ROADMAP.md`](../../ROADMAP.md) owns the broad progress checklist; plans may contain detailed procedural checks. An unchecked item is not deployed.

| Plan | Status | Relationship |
| --- | --- | --- |
| [Verify Infrastructure Baseline](verify-infrastructure-baseline.md) | Planned | Supplies current facts to all implementation plans |
| [Onboard Home Assistant](onboard-home-assistant.md) | Active | Precedes network segmentation |
| [Establish Remote Recovery](establish-remote-recovery.md) | Planned | Independent monitoring and control before management migration |
| [Segment HomeLab Network](segment-homelab-network.md) | Planned | Follows room-device onboarding |
| [Harden Minecraft Server](harden-minecraft-server.md) | Planned | Follows initial network baseline |
| [Deploy Management Services](deploy-management-services.md) | Planned | Depends on Lab access and Minecraft inventory |
| [Establish NAS Storage](establish-nas-storage.md) | Planned | Parent dependency for storage-backed services |
| [Convert Acer to AI Node](convert-acer-to-ai-node.md) | Deferred | Depends on preservation of selected files |
| [Deploy Jellyfin](deploy-jellyfin.md) | Planned | Depends on NAS/storage decision |
| [Deploy Nextcloud](deploy-nextcloud.md) | Planned | Depends on NAS/storage and remote access |
| [Deploy Bitwarden](deploy-bitwarden.md) | Planned | Depends on NAS/storage and tested recovery |
| [Publish Portfolio Website](publish-portfolio-website.md) | Planned | Tunnel first if isolation gate passes; Pages fallback for first public release |
| [Configure Portfolio Email](configure-portfolio-email.md) | Planned | Two-way custom-domain mail for the portfolio |
| [Configure Remote Application Access](configure-remote-application-access.md) | Planned | Related to published applications |
| [Evaluate Optional Home Assistant Devices](evaluate-optional-home-assistant-devices.md) | Deferred | Follows room devices and network baseline |
| [Build Password Manager Prototype](build-password-manager-prototype.md) | Deferred | Separate from production Bitwarden |
| [Deploy Kali Research VM](deploy-kali-research-vm.md) | Planned | Authorized security research only |
| [Build Malware-Analysis Lab](build-malware-analysis-lab.md) | Deferred | Requires verified containment |
