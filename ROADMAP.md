# Roadmap

> This is the authority for planned and incomplete work. An unchecked item is **not deployed**. Dependencies and verification gates are intentional; planned work must not be promoted to current state without evidence.

## In progress — next up

- [ ] Convert the Acer Nitro 5 (AN515-54) into a headed, 24/7 Linux AI node.
  - [x] Collect and review the pre-install hardware inventory.
  - [ ] Finish preserving and opening the selected Windows files that must survive the migration.
  - [ ] Select and install the Linux operating system without erasing the secondary HDD until its retained data is reviewed.
  - [ ] Configure the lightweight desktop, local management browser, SSH, Tailscale, updates, and safe 24/7 lid/display behavior.
  - [ ] Install and verify the NVIDIA driver and local AI runtime.
  - [ ] Deploy a private web chat interface and local API.
  - [ ] Benchmark candidate models for coding, automation, quality, latency, context size, and safe concurrency.
  - [ ] Upgrade memory up to the planned 32 GiB and re-run capacity tests.
  - [ ] Verify sustained temperature, airflow, recovery, and private access before declaring the node operational.

## Planned — dependency ordered

### Foundation and private operations

- [ ] Complete the verified inventory and recovery baseline for deployed infrastructure.
  - [ ] Verify remaining host models, software versions, storage health, backups, and restore procedures.
  - [ ] Record only sanitized, durable results in public documentation.

- [ ] Finish Home Assistant integration and operational hardening.
  - [x] Deploy Home Assistant OS in a private Proxmox VM and complete onboarding.
  - [ ] Verify Home Assistant OS, Core, and Supervisor versions.
  - [x] Privately map both network zones and verify the relevant router capabilities.
  - [ ] Inventory intended smart-device brands, models, apps, and integration protocols.
  - [ ] Select a least-privilege cross-network design; the managed-switch VLAN option remains proposed with VLAN IDs and ports `UNKNOWN`.
  - [ ] Implement and verify the selected design without disrupting private HomeLab management, Tailscale access, or existing tunnels.
  - [ ] Verify Tailscale access, backups, restore procedure, updates, and resource utilization.
  - [ ] Review the upstream gateway's security lifecycle, ISP support, wireless compatibility, and replacement options without publishing its exact firmware or identifiers.

- [ ] Add dedicated network storage and a tested backup foundation.
  - [ ] Define capacity, performance, redundancy, growth, power, and budget requirements.
  - [ ] Select storage hardware and protocol without assuming that RAID replaces backup.
  - [ ] Define backup destinations, retention, recovery objectives, and restore tests.
  - [ ] Use the larger storage pool for AI data only after access, backup, and performance are verified.

- [ ] Deploy lightweight private utility services.
  - [ ] Decide whether Uptime Kuma and Homepage should share a small Debian utility guest or use separate guests.
  - [ ] Deploy and verify Uptime Kuma for availability monitoring.
  - [ ] Deploy and verify Homepage as the private service dashboard.
  - [ ] Back up required state and keep both interfaces private to the HomeLab and/or Tailscale.

- [ ] Deploy a self-hosted password manager after reliable backup and recovery exist.
  - [ ] Compare official Bitwarden Lite, standard Bitwarden, and other reviewed candidates.
  - [ ] Define HTTPS, private/remote access, MFA, update, emergency-access, export, and restore requirements.
  - [ ] Complete a tested restore before making it the sole copy of any credential.

### Storage-backed applications

- [ ] Deploy Jellyfin after dedicated media storage is available.
  - [ ] Define media capacity, permissions, backup scope, direct-play clients, and transcoding requirements.
  - [ ] Verify Intel hardware acceleration before representing it as enabled.

- [ ] Deploy Nextcloud after durable data storage and backups are available.
  - [ ] Define users, capacity, sync clients, TLS, recovery objectives, and restore testing.
  - [ ] Store non-critical test data until recovery is verified.

### Publishing

- [ ] Deploy a portfolio website in an appropriately isolated Proxmox guest.
  - [ ] Select the web stack, deployment method, monitoring, patching, and backup approach.
  - [ ] Record guest details only after deployment is verified.

- [ ] Expose the website using Cloudflare Tunnel.
  - [ ] Configure the tunnel only after the origin service exists and is hardened.
  - [ ] Document the public architecture without publishing tunnel credentials, tokens, or private endpoints.

### Authorized security research

- [ ] Deploy a persistent Kali Linux VM for authorized security testing and monitoring.
  - [ ] Define permitted lab-owned targets, resource limits, logging, retention, and an emergency stop procedure.
  - [ ] Design network placement before enabling long-running scans or password-auditing exercises.
  - [ ] Keep the VM and its management interfaces private; never store target credentials or engagement data in this repository.

- [ ] Build a dedicated malware-analysis lab as the furthest-horizon project.
  - [ ] Prefer separate physical hardware and a network design with no route to household, HomeLab management, or production services.
  - [ ] Define clean-image restoration, snapshots, sample handling, telemetry, legal scope, and incident containment before executing malware.
  - [ ] Prohibit production credentials, shared folders, shared clipboard, automatic USB attachment, and uncontrolled internet access.

## Blocked

No project is formally blocked. The AI-node installation is gated on completion of the owner's selective file preservation; storage-backed services are gated on dedicated storage and recovery design.

## Completed

- [x] Bootstrap the repository structure, safety rules, current-state inventory, roadmap, and documentation indexes.
- [x] Deploy and privately access a new Home Assistant OS VM on Proxmox.

## Roadmap maintenance

When deployment changes reality, update this file, [CURRENT_STATE.md](CURRENT_STATE.md), the detailed host/service record, and [CHANGELOG.md](CHANGELOG.md) when the change is significant. Retain a short explanation for abandoned or blocked work rather than silently deleting it.
