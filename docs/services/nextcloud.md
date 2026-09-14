# Nextcloud

**Status:** future project; not deployed. Deployment is deferred until durable data storage and backups are available.

## Proposed architecture

- Run a small Debian virtual machine with Docker Engine and Nextcloud All-in-One (AIO), the official Nextcloud installation method.
- Prefer a VM over Docker nested inside LXC; Nextcloud AIO recommends KVM or a non-virtualized host for best compatibility.
- Initial compute recommendation for a small private deployment: 2 vCPUs and 4 GiB RAM, subject to optional AIO components and measured use.
- Use separate virtual disks for the VM system and Nextcloud data when practical, so data capacity and migration are not tied to the boot disk layout.
- Keep initial access private to the HomeLab and Tailscale. Domain, TLS, reverse-proxy, and public-exposure design remain `UNKNOWN`.

See the [official Nextcloud AIO repository](https://github.com/nextcloud/all-in-one).

## Storage and durability constraints

- Expected user count, initial data volume, growth rate, sync clients, and file-size profile are `UNKNOWN`.
- The current internal-only Proxmox storage is suitable for evaluation but must not become the only copy of important data.
- A durable deployment requires an owner-approved data location, backup destination, retention policy, and tested restore process.
- Optional AIO components such as office, antivirus, full-text search, Talk, and recording increase resource requirements and should remain disabled unless needed.

## Verification checklist

- [ ] Docker is installed from an officially supported source in the dedicated VM.
- [ ] AIO configuration and data locations are documented without credentials.
- [ ] Private DNS/TLS access approach is selected and verified.
- [ ] Desktop/mobile sync is tested with non-critical data.
- [ ] Backup and restore are tested before storing important files.
