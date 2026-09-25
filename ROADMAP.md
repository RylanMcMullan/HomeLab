# Roadmap

> This is the authority for planned and incomplete work. An unchecked item is **not deployed**. Dependencies and verification gates are intentional; planned work must not be promoted to current state without evidence.

## In progress — next up

- [ ] Establish Home Assistant control of the selected room devices, one device at a time.
  - [x] Owner reported all HomeLab IoT devices disconnected on 2026-09-25, pending controlled tests; independent verification remains open.
  - [ ] Recheck disconnection before each test and keep devices disconnected outside explicitly controlled test windows.
  - [ ] Back up Home Assistant, verify updates and recovery access, and review Archer Wi-Fi isolation and management exposure before reconnecting a test device.
  - [ ] Review Proxmox and Home Assistant host/service firewalls and management authentication for the temporary shared-Archer-LAN test; end each test window by disconnecting the IoT device until the router-VM baseline is verified.
  - [ ] Record the device's integration and discovery method privately; keep credentials and identifiers out of Git.
  - [ ] Connect one device to the Archer's ordinary Wi-Fi only after confirming its connectivity and rollback path; disconnect it again if the test fails.
  - [ ] Verify control, state updates, internet access, the Home Assistant app, and the intended local/cloud path before connecting additional devices.
  - [ ] First candidate: test one Govee H5083 smart plug through the researched Govee cloud/API integration path; Bluetooth passthrough is not required for that model.
  - [ ] Next: test one Feit G30/E26 smart bulb for Smart Life/Tuya enrollment before considering any device-specific local-control route. Do not reset or connect the other two bulbs until the first test succeeds.
  - [ ] Identify the desk lamp's RGB bulb by exact model, app, and radio/network protocol before selecting an integration.

- [ ] Immediately after the Home Assistant/IoT test, build and verify the router VM and staged VLAN security baseline.
  - [ ] First inventory: trace switch ports and current VLAN/PVIDs; identify the switch revision/firmware, HP NIC and Proxmox bridges, Archer uplink/DHCP, current Tailscale routes/grants, and a local Proxmox recovery path. Keep exact addresses and credentials private.
  - [ ] Back up switch and Proxmox network settings; test one downstream VLAN and one port before moving management.
  - [ ] Verify DHCP, DNS, internet, default-deny inter-VLAN rules, allowed administrative paths, and recovery during router-VM failure.
  - [ ] Move Lab management and Tailscale only after local recovery works; verify approved remote administration and denial from untrusted zones.
  - [ ] Decide whether the Raspberry Pi needs a game VLAN after its service inventory, then retest playit.gg and Tailscale if moved.

- [ ] Inventory, back up, and harden the Raspberry Pi Minecraft service before performance changes or web-panel migration.
  - [ ] Inventory first: Pi OS/kernel, Minecraft edition/version/distribution, Java runtime, start/stop supervisor, user and file permissions, world/mod/plugin list, configuration, storage capacity/health, CPU/RAM/temperature under load, logs, update process, and playit.gg/Tailscale paths. Keep identifiers, credentials, and raw logs private.
  - [ ] Use the existing Pi USB SSD as an interim backup destination only after confirming free space, backup separation from live worlds, retention, and a representative restore; add an independent copy as soon as practical.
  - [ ] Choose a private Minecraft management web panel after inventory; evaluate Crafty Controller against the current server and migration/rollback requirements.
  - [ ] Establish baseline performance and a tested backup before changing server settings or software.

- [ ] Deploy a private management dashboard and monitoring after the network and Minecraft baseline.
  - [ ] Deploy Uptime Kuma for selected health checks and Homepage for links/status, or justify a smaller alternative after the target inventory.
  - [ ] Keep administration restricted to the Lab and authorized Tailscale clients; test tailnet grants plus firewall rules for each service.
  - [ ] Use MagicDNS/Tailscale Serve as the first named browser access path. Evaluate private DNS under the owner's domain separately; do not create a public DNS route to management pages.

## Planned — dependency ordered

### Foundation and private operations

- [ ] Complete the verified inventory and recovery baseline for deployed infrastructure.
  - [ ] Verify remaining host models, software versions, storage health, backups, and restore procedures.
  - [ ] Record only sanitized, durable results in public documentation.

- [ ] Finish Home Assistant operational hardening.
  - [x] Deploy Home Assistant OS in a private Proxmox VM and complete onboarding.
  - [ ] Verify Home Assistant OS, Core, and Supervisor versions.
  - [x] Privately map both network zones and verify the relevant router capabilities.
  - [ ] Complete the [candidate-device inventory](docs/services/home-assistant.md#candidate-device-inventory-and-integration-research) and verify actual integrations only during controlled tests.
  - [x] Select the target network design: test Home Assistant with compatible, owner-owned Archer Wi-Fi IoT devices for local discovery; see [decision 0003](docs/decisions/0003-segmented-services-and-remote-access.md). Staged onboarding is not deployed.
  - [ ] Verify IoT devices one at a time, record any that cannot use the selected network/integration, then decide whether an exception needs a narrower routed path.
  - [ ] After domain and tunnel setup, test authenticated browser and companion-app access through the planned Home Assistant subdomain without exposing Proxmox management.
  - [ ] Verify Tailscale access, backups, restore procedure, updates, and resource utilization.
  - [ ] Review the upstream gateway's security lifecycle, ISP support, wireless compatibility, and replacement options without publishing its exact firmware or identifiers.

- [ ] Refine the [theoretical VLAN and firewall worksheet](docs/network/segmentation-plan.md) from measured service paths after the staged router-VM rollout; proposed VLAN IDs are not live settings.

- [ ] Add dedicated network storage and a tested backup foundation.
  - [ ] Define capacity, performance, redundancy, growth, power, and budget requirements.
  - [ ] Select storage hardware and protocol without assuming that RAID replaces backup.
  - [ ] Define backup destinations, retention, recovery objectives, and restore tests.
  - [ ] Evaluate whether the chosen NAS can attach separate VMs/apps to tagged VLANs while keeping its management interface private; decide per-service placement and firewall paths before purchase.
  - [ ] Decide whether the NAS needs a dedicated storage VLAN and specify service-by-service shares and backup flows. One untagged switch port/VLAN isolates the NAS as a whole, not the apps within it.
  - [ ] Keep an independent or off-site copy of critical data; the NAS must not be the only recovery copy.
  - [ ] Use the larger storage pool for AI data only after access, backup, and performance are verified.

- [ ] Convert the Acer Nitro 5 (AN515-54) into a headed, 24/7 Linux AI node after the security and Minecraft work; preserve the [existing preparation and verification gates](docs/services/local-ai.md).
  - [x] Collect and review the pre-install hardware inventory.
  - [ ] Finish preserving and opening the selected Windows files that must survive the migration before erasing either drive.
  - [ ] Install and harden Linux, SSH, Tailscale, the local AI runtime, and a private chat interface; benchmark models, upgrade RAM if needed, and verify cooling and recovery.

### NAS-backed applications

- [ ] Deploy Jellyfin after dedicated media storage is available.
  - [ ] Decide whether to run its application on the NAS or on a separate compute guest using NAS media storage; choose network access from actual NAS capabilities.
  - [ ] Define media capacity, permissions, backup scope, direct-play clients, and transcoding requirements.
  - [ ] Verify Intel hardware acceleration before representing it as enabled.

- [ ] Deploy Nextcloud after durable data storage and backups are available.
  - [ ] Decide whether to run Nextcloud on the NAS or a separate guest using NAS storage; require independently recoverable application/database data and tested client access.
  - [ ] Define users, capacity, sync clients, TLS, recovery objectives, and restore testing.
  - [ ] Store non-critical test data until recovery is verified.
  - [ ] Select a separate Files network if the host can enforce it, then test its Cloudflare-hosted HTTPS subdomain, browser MFA, desktop/mobile sync, and any client app passwords.

- [ ] Deploy production Bitwarden in the NAS implementation phase, only after reliable backup and recovery exist.
  - [ ] Revisit NAS application support, isolation, authentication, and recovery when selecting the Bitwarden variant and host; keep it separate from the educational prototype.
  - [ ] Compare official Bitwarden Lite and standard Bitwarden for the owner's required browser-extension/mobile clients and NAS platform.
  - [ ] Select a separate Vault network if the host can enforce it, and define HTTPS, remote app access, MFA, update, emergency-access, export, and restore requirements.
  - [ ] Complete a tested restore before making it the sole copy of any credential.

### Publishing

- [ ] Deploy a portfolio website in an appropriately isolated Proxmox guest.
  - [ ] Select the web stack, deployment method, monitoring, patching, and backup approach.
  - [ ] Place the public site in its own planned VLAN with no access to Lab, files, vault, or IoT devices.
  - [ ] Record guest details only after deployment is verified.

- [ ] Establish the owner's domain and use Cloudflare Tunnel for separately reviewed public applications.
  - [ ] Configure each tunnel route only after its origin service exists, is hardened, and has a tested recovery path.
  - [ ] Plan the domain apex for the portfolio and separate subdomains for selected user-facing applications; management dashboards and the Minecraft web panel remain tailnet-only. Exact domain and DNS values remain unconfigured.
  - [ ] Evaluate whether Jellyfin needs a public browser route after its client, authentication, and streaming requirements are known.
  - [ ] Test application authentication/MFA and native client compatibility before adding Cloudflare Access to any route.
  - [ ] Keep tunnel connectors and their origin reachability narrowly scoped; never publish management interfaces or tunnel credentials.

### Tentative and eventual projects — unscheduled

- [ ] Evaluate the Xbox Series X, Roku Stick 4K, Roku TV, Echo Dot, and Spotify as optional Home Assistant integrations after the room devices and network baseline; research is in the [Home Assistant inventory](docs/services/home-assistant.md#candidate-device-inventory-and-integration-research).
- [ ] Explore a separate educational password-manager implementation after most infrastructure work.
  - [ ] Use synthetic test data only; never use it as the production vault.
  - [ ] Decide its hosting and access independently of the selected maintained password manager.

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

No project is formally blocked. IoT testing is gated on rechecking disconnection outside test windows and on a Home Assistant backup. VLAN migration is gated on a verified port map, configuration backups, and local Proxmox recovery. The AI-node installation is gated on completion of the owner's selective file preservation. NAS-backed applications and production Bitwarden are gated on appropriate storage, isolation, backup, and tested recovery.

## Completed

- [x] Bootstrap the repository structure, safety rules, current-state inventory, roadmap, and documentation indexes.
- [x] Deploy and privately access a new Home Assistant OS VM on Proxmox.

## Roadmap maintenance

When deployment changes reality, update this file, [CURRENT_STATE.md](CURRENT_STATE.md), the detailed host/service record, and [CHANGELOG.md](CHANGELOG.md) when the change is significant. Retain a short explanation for abandoned or blocked work rather than silently deleting it.
