# Roadmap

> This is the authority for planned and incomplete work. An unchecked item is **not deployed**. Dependencies and verification gates are intentional; planned work must not be promoted to current state without evidence.

## In progress — next up

- [ ] Make Home Assistant work with one owner-selected IoT device on the Archer network.
  - [ ] Record the device's integration and discovery method privately; keep credentials and identifiers out of Git.
  - [ ] Move or onboard one device to the Archer's ordinary Wi-Fi only after confirming its connectivity and rollback path.
  - [ ] Verify discovery, control, state updates, internet access, and the Home Assistant app before moving additional devices.

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
  - [ ] When the AI service is hosted, decide whether and how approved clients should reach its web UI without Tailscale. Keep host administration and the inference API private; authentication, firewall, and Wi-Fi trust-zone details remain `TODO`.

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
  - [x] Select the target network design: keep Home Assistant with compatible, owner-owned Archer Wi-Fi IoT devices for local discovery; see [decision 0003](docs/decisions/0003-segmented-services-and-remote-access.md). The move is not deployed.
  - [ ] Verify IoT devices one at a time, record any that cannot move, then decide whether an exception needs a narrower routed path.
  - [ ] After domain and tunnel setup, test authenticated browser and companion-app access through the planned Home Assistant subdomain without exposing Proxmox management.
  - [ ] Verify Tailscale access, backups, restore procedure, updates, and resource utilization.
  - [ ] Review the upstream gateway's security lifecycle, ISP support, wireless compatibility, and replacement options without publishing its exact firmware or identifiers.

- [ ] Stage the [theoretical VLAN and firewall plan](docs/network/segmentation-plan.md) using the managed switch and a Proxmox router VM.
  - [ ] Verify the owner-reported switch map (1 Archer LAN uplink, 2 HP, 3 Acer, 4 Pi, 5–8 empty), switch revision/configuration, HP bridge, and local recovery path. Proposed VLAN IDs are not live settings.
  - [ ] Back up switch and Proxmox network configuration; test one downstream VLAN and one port before moving management.
  - [ ] Verify DHCP, internet, default-deny inter-VLAN rules, port 3 local Proxmox recovery, and expected router-VM outage behavior.
  - [ ] Move Lab management and Tailscale only after the recovery path works; review advertised routes and tailnet grants.
  - [ ] Decide whether the Raspberry Pi needs its own game VLAN; preserve and retest playit.gg public reachability and Tailscale administration.
  - [ ] Define narrowly scoped Uptime Kuma checks and Homepage read-only API access across VLANs.
  - [ ] Keep the Acer on the Lab VLAN without an AI-specific cross-VLAN rule during the initial network rollout; revisit AI web access when the service is hosted.

- [ ] Add dedicated network storage and a tested backup foundation.
  - [ ] Define capacity, performance, redundancy, growth, power, and budget requirements.
  - [ ] Select storage hardware and protocol without assuming that RAID replaces backup.
  - [ ] Define backup destinations, retention, recovery objectives, and restore tests.
  - [ ] Decide whether the NAS needs a dedicated storage VLAN and specify service-by-service shares and backup flows.
  - [ ] Keep an independent or off-site copy of critical data; the NAS must not be the only recovery copy.
  - [ ] Use the larger storage pool for AI data only after access, backup, and performance are verified.

- [ ] Deploy lightweight private utility services.
  - [ ] Decide whether Uptime Kuma and Homepage should share a small Debian utility guest or use separate guests.
  - [ ] Deploy and verify Uptime Kuma for availability monitoring.
  - [ ] Deploy and verify Homepage as the private service dashboard.
  - [ ] Back up required state and keep both interfaces private to the HomeLab and/or Tailscale.
  - [ ] Permit only selected health checks and read-only widget APIs across VLANs; verify unrelated paths are blocked.

### Storage-backed applications

- [ ] Deploy Jellyfin after dedicated media storage is available.
  - [ ] Define media capacity, permissions, backup scope, direct-play clients, and transcoding requirements.
  - [ ] Verify Intel hardware acceleration before representing it as enabled.

- [ ] Deploy Nextcloud after durable data storage and backups are available.
  - [ ] Define users, capacity, sync clients, TLS, recovery objectives, and restore testing.
  - [ ] Store non-critical test data until recovery is verified.
  - [ ] Place the service on its own planned VLAN, then test its Cloudflare-hosted HTTPS subdomain, browser MFA, desktop/mobile sync, and any client app passwords.

### Publishing

- [ ] Deploy a portfolio website in an appropriately isolated Proxmox guest.
  - [ ] Select the web stack, deployment method, monitoring, patching, and backup approach.
  - [ ] Place the public site in its own planned VLAN with no access to Lab, files, vault, or IoT devices.
  - [ ] Record guest details only after deployment is verified.

- [ ] Establish the owner's domain and use Cloudflare Tunnel for separately reviewed public applications.
  - [ ] Configure each tunnel route only after its origin service exists, is hardened, and has a tested recovery path.
  - [ ] Plan the domain apex for the portfolio and separate subdomains for Home Assistant, Nextcloud, and the later production password manager; exact domain and DNS values remain unconfigured.
  - [ ] Test application authentication/MFA and native client compatibility before adding Cloudflare Access to any route.
  - [ ] Keep tunnel connectors and their origin reachability narrowly scoped; never publish management interfaces or tunnel credentials.

### Later sensitive and experimental work

- [ ] Deploy a production self-hosted password manager only after reliable backup and recovery exist.
  - [ ] Compare official Bitwarden Lite, standard Bitwarden, and other reviewed candidates with supported browser-extension/mobile clients.
  - [ ] Place it in its own planned VLAN and define HTTPS, remote app access, MFA, update, emergency-access, export, and restore requirements.
  - [ ] Complete a tested restore before making it the sole copy of any credential.

- [ ] Explore a separate educational password-manager implementation.
  - [ ] Use synthetic test data only; do not store real credentials or use it as the production vault.
  - [ ] Keep its deployment and access design separate from the selected maintained production manager.

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

No project is formally blocked. The AI-node installation is gated on completion of the owner's selective file preservation. Nextcloud, Jellyfin, and the production password manager remain gated on appropriate storage, backup, and tested recovery. VLAN migration is gated on a verified port map and local Proxmox recovery path.

## Completed

- [x] Bootstrap the repository structure, safety rules, current-state inventory, roadmap, and documentation indexes.
- [x] Deploy and privately access a new Home Assistant OS VM on Proxmox.

## Roadmap maintenance

When deployment changes reality, update this file, [CURRENT_STATE.md](CURRENT_STATE.md), the detailed host/service record, and [CHANGELOG.md](CHANGELOG.md) when the change is significant. Retain a short explanation for abandoned or blocked work rather than silently deleting it.
