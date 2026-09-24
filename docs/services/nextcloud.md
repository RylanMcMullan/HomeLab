# Nextcloud

**Status:** future project; not deployed. Deployment is deferred until durable data storage and backups are available.

## Proposed architecture

- Run a small Debian virtual machine with Docker Engine and Nextcloud All-in-One (AIO), the official Nextcloud installation method.
- Prefer a VM over Docker nested inside LXC; Nextcloud AIO recommends KVM or a non-virtualized host for best compatibility.
- Initial compute recommendation for a small private deployment: 2 vCPUs and 4 GiB RAM, subject to optional AIO components and measured use.
- Use separate virtual disks for the VM system and Nextcloud data when practical, so data capacity and migration are not tied to the boot disk layout.
- Keep initial evaluation private until storage and recovery are tested. The accepted target places production Nextcloud in its own planned Files VLAN with a Cloudflare Tunnel route on the owner's future `drive` subdomain for browser and desktop/mobile clients. No VLAN, domain route, TLS configuration, or public access is deployed.
- Keep guest administration private through a narrow Lab-origin path. Deny Files-to-Lab, Files-to-IoT, and Files-to-other-service access except documented dependencies. See [decision 0003](../decisions/0003-segmented-services-and-remote-access.md) and the [VLAN worksheet](../network/segmentation-plan.md).

See the [official Nextcloud AIO repository](https://github.com/nextcloud/all-in-one).

## Storage and durability constraints

- Expected user count, initial data volume, growth rate, sync clients, and file-size profile are `UNKNOWN`.
- The current internal-only Proxmox storage is suitable for evaluation but must not become the only copy of important data.
- A durable deployment requires an owner-approved data location, backup destination, retention policy, and tested restore process.
- The planned NAS may hold primary data and local backups under separate permissions, but an independent recovery copy of critical data is still required.
- Optional AIO components such as office, antivirus, full-text search, Talk, and recording increase resource requirements and should remain disabled unless needed.

## Verification checklist

- [ ] Docker is installed from an officially supported source in the dedicated VM.
- [ ] AIO configuration and data locations are documented without credentials.
- [ ] HTTPS tunnel route, application MFA, and any additional edge authentication are selected and verified with intended clients.
- [ ] Desktop/mobile sync is tested with non-critical data.
- [ ] Inter-VLAN firewall rules allow only required administrative, health-check, and data/backup flows.
- [ ] Backup and restore are tested before storing important files.
