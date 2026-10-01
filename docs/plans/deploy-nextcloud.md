# Deploy Nextcloud

**Status:** Planned; not deployed. Depends on [Establish NAS Storage](establish-nas-storage.md) and a tested backup/restore path.

## Proposed architecture

- Candidate placements are a small Debian VM with Docker Engine and Nextcloud All-in-One (AIO), or a NAS-hosted workload if the chosen NAS supports AIO, persistent data, backups, and the shared NAS VLAN controls. Final placement is `TODO`.
- If using Proxmox, prefer a VM over Docker nested inside LXC; Nextcloud AIO recommends KVM or a non-virtualized host for best compatibility.
- Initial compute estimate for a small VM deployment: 2 vCPUs and 4 GiB RAM, subject to optional AIO components and measured use. NAS-hosted capacity is `UNKNOWN`.
- Keep application/database data separate from bulk files in the backup and restore plan, regardless of host.
- Keep initial evaluation private until storage and recovery are tested. A separate Files VLAN is a candidate if the final host can enforce it. A Cloudflare Tunnel route on the owner's future `drive` subdomain is planned for browser and desktop/mobile clients after authentication and recovery tests. No VLAN, domain route, TLS configuration, or public access is deployed.
- Keep application and NAS administration private through narrow Lab/Tailscale paths. Deny Files-to-Lab, Files-to-IoT, and Files-to-other-service access except documented dependencies if the chosen platform can enforce a separate Files network. See [decision 0003](../decisions/0003-segmented-services-and-remote-access.md) and the [VLAN worksheet](segment-homelab-network.md).

See the [official Nextcloud AIO repository](https://github.com/nextcloud/all-in-one).

## Storage and durability constraints

- Expected user count, initial data volume, growth rate, sync clients, and file-size profile are `UNKNOWN`.
- The [HP EliteDesk](../hosts/hp-elitedesk.md) had internal-only storage at last verification. It may support evaluation but must not become the only copy of important data.
- A durable deployment requires an owner-approved data location, backup destination, retention policy, and tested restore process.
- The planned NAS may hold primary data and local backups under separate permissions, but an independent recovery copy of critical data is still required.
- Optional AIO components such as office, antivirus, full-text search, Talk, and recording increase resource requirements and should remain disabled unless needed.
- On a NAS, verify AIO's Docker-socket access, container orchestration, SSD-backed application/database volumes, HDD data path, backup scope, and upgrade behavior before accepting direct hosting. [AIO's own Cloudflare notes](https://github.com/nextcloud/all-in-one#notes-on-cloudflare-proxytunnel) identify upload size, timeout, domain-validation, and local access constraints; test representative large-file sync through the proposed public route.

## Verification checklist

- [ ] The selected VM or NAS app runtime supports the official deployment method and workload isolation.
- [ ] AIO configuration and data locations are documented without credentials.
- [ ] HTTPS tunnel route, application MFA, and any additional edge authentication are selected and verified with intended clients.
- [ ] Desktop/mobile sync is tested with non-critical data.
- [ ] Inter-VLAN firewall rules allow only required administrative, health-check, and data/backup flows.
- [ ] Backup and restore are tested before storing important files.
