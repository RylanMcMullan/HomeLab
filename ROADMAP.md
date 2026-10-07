# Roadmap

This is a progress checklist, not an instruction manual. Each plan title links to its detailed procedure, dependencies, verification, and rollback. A checked item needs evidence of a completed change or verified state; an unchecked item is not deployed. Current facts are in [Current State](CURRENT_STATE.md), dated results in [history](docs/history/README.md), and significant changes in [CHANGELOG.md](CHANGELOG.md).

## Active

### [Onboard Home Assistant](docs/plans/onboard-home-assistant.md)

- [x] Deploy Home Assistant OS on Proxmox VE. [Deployment history](docs/history/home-assistant.md)
- [x] Identify the Govee H5083 and three Feit `Color Lights` units from reported app-MAC matching and a read-only Archer snapshot. [Device-inventory history](docs/history/device-inventory.md)
- [ ] Complete the private room-device inventory and Home Assistant backup baseline.
- [ ] Integrate one Govee plug and one Feit bulb through their verified paths, then extend only successful methods to the remaining selected room devices.
- [ ] Harden Home Assistant authentication, recovery, and approved remote access.

## Planned — next sequence

### [Establish Remote Recovery](docs/plans/establish-remote-recovery.md)

- [ ] Verify an independent observer and private management path that remain reachable when the HP is off.
- [ ] Test a supported HP power-on path and document a last-resort power-cycle option, if needed.
- [ ] Verify alerts, route failure behavior, and recovery without relying on the HP-hosted router or Tailscale LXC alone.

### [Segment HomeLab Network](docs/plans/segment-homelab-network.md)

- [ ] Deploy a staged router-VM and one test segment after the initial room-device tests.
- [ ] Migrate Lab management only after local Proxmox recovery and approved Tailscale administration work.
- [ ] Enforce and verify the selected inter-segment firewall policy.

### [Harden Minecraft Server](docs/plans/harden-minecraft-server.md)

- [ ] Record the Raspberry Pi and Minecraft runtime, exposure, and performance baseline.
- [ ] Establish a consistent backup and representative restore using the Pi USB SSD as interim storage, then an independent copy.
- [ ] Harden the server and adopt a private management panel if the inventoried stack supports a safe migration.
- [ ] Decide and test any separate game-network placement without losing playit.gg or Tailscale access.

### [Deploy Management Services](docs/plans/deploy-management-services.md)

- [ ] Deploy private Uptime Kuma monitoring on a verified host independent of the HP.
- [ ] Deploy a private Homepage dashboard with links and narrowly scoped optional widgets.
- [ ] Verify tailnet-only administration and approved cross-network health/status paths.

## Planned — foundation and storage

### [Verify Infrastructure Baseline](docs/plans/verify-infrastructure-baseline.md)

- [ ] Refresh current hardware, software, network, and storage specifications needed for compatibility decisions.
- [ ] Establish and record backup, restore, monitoring, and recovery baselines for deployed systems.

### [Establish NAS Storage](docs/plans/establish-nas-storage.md)

- [x] Select and purchase the NAS enclosure and initial SSD/HDD (reported 2026-10-02); verify the hardware after delivery. [Purchased hardware](docs/plans/establish-nas-storage.md#purchased-hardware--reported-2026-10-02)
- [ ] Deploy protected storage and separate application/management access as supported by the chosen platform.
- [ ] Establish an independent backup copy and verify a representative restore.

### [Deploy Jellyfin](docs/plans/deploy-jellyfin.md)

- [ ] Deploy Jellyfin on an approved host with durable media storage and private client access.
- [ ] Verify direct play, backup, and any hardware transcoding before enabling a broader route.

### [Deploy Nextcloud](docs/plans/deploy-nextcloud.md)

- [ ] Deploy isolated application/data storage with tested backup and restore.
- [ ] Verify authenticated browser and desktop/mobile synchronization through the approved access path.

### [Deploy Bitwarden](docs/plans/deploy-bitwarden.md)

- [ ] Deploy the selected official Bitwarden variant with HTTPS, MFA, isolation, and durable storage.
- [ ] Verify clients, independent backup, and restore before making it the sole copy of credentials.

## Planned — publishing (2026-10-06 first-page target)

### [Publish Portfolio Website](docs/plans/publish-portfolio-website.md)

- [ ] Build and review a small portfolio in a separate public repository.
- [ ] Verify the dedicated guest, isolation, connector, and external route; use Pages for the first public release if the security gate cannot pass in time.
- [ ] Publish the reviewed site at the domain apex and verify external HTTPS, content, and links.

### [Configure Portfolio Email](docs/plans/configure-portfolio-email.md)

- [ ] Select a custom-domain mailbox provider and verify `mail@<DOMAIN>` inbound delivery and replies through a separate professional inbox accessible in Outlook.

### [Configure Remote Application Access](docs/plans/configure-remote-application-access.md)

- [ ] Register and verify the domain; establish approved public HTTPS ingress only for reviewed application origins.
- [ ] Verify application authentication, native clients, and denial of public management access.

## Planned — authorized research

### [Deploy Kali Research VM](docs/plans/deploy-kali-research-vm.md)

- [ ] Deploy a scoped private research VM after target, network, logging, and stop controls are approved.

## Deferred — unscheduled

### [Convert Acer to AI Node](docs/plans/convert-acer-to-ai-node.md)

- [x] Inventory Acer hardware and the pre-install Windows baseline. [Acer history](docs/history/acer-preinstall.md)
- [ ] Preserve and open the selected files required before erasing either drive.
- [ ] Install and harden Linux, local AI runtime, private administration, and a tested web interface.
- [ ] Benchmark model fit, thermals, memory, and concurrent use before accepting continuous operation.

### [Evaluate Optional Home Assistant Devices](docs/plans/evaluate-optional-home-assistant-devices.md)

- [ ] Identify optional media, voice, and account devices before choosing integrations.
- [ ] Integrate only selected devices with verified behavior and acceptable authentication.

### [Build Password Manager Prototype](docs/plans/build-password-manager-prototype.md)

- [ ] Build and evaluate a separate educational prototype with synthetic data only.

### [Build Malware-Analysis Lab](docs/plans/build-malware-analysis-lab.md)

- [ ] Build and verify dedicated containment before any malware execution.

## Maintenance

Keep completed milestones here while their parent plan is active. When a plan finishes, preserve its dated implementation detail in history, add a significant-infrastructure changelog entry, update current state, and retain a short completion link here. Do not infer completion from a design or candidate worksheet.
