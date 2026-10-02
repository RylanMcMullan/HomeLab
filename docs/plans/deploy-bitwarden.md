# Deploy Bitwarden

**Status:** Planned with the future NAS implementation. Bitwarden variant and deployment architecture are not selected. The separate [educational prototype](build-password-manager-prototype.md) is deferred and will never hold real credentials.

**Dependencies:** [Establish NAS Storage](establish-nas-storage.md) and a tested restore; [Configure Remote Application Access](configure-remote-application-access.md) for any approved public application route.

## Goal

Provide an owner-controlled password vault with supported clients, strong authentication, reliable synchronization, and recoverable encrypted data. This is a high-impact service: availability and recovery are as important as initial deployment.

## Candidates and gates

- Compare official Bitwarden Lite and standard Bitwarden. Vaultwarden is a different community implementation and is not the selected production product.
- [Official Bitwarden Lite](https://bitwarden.com/help/install-and-deploy-lite/) is the provisional NAS-hosted variant because it is a single Docker image intended for personal/HomeLab use and lists at least 200 MB RAM, 1 GB storage, and Docker Engine 26+. These are product minimums, not an allocation or verified DXP2800 result. Standard Bitwarden remains an option if its features are needed; compare actual requirements and client behavior before final selection.
- Follow the selected Bitwarden variant's authoritative Linux/Docker documentation. Variant selection and the final host remain `TODO` until NAS compatibility and recovery are tested.
- The initial NAS-hosting candidate shares a NAS service VLAN with other NAS applications. Give Bitwarden a separate container network and persistent data scope, keep NAS administration private, and publish only its reviewed application origin. A distinct Vault VLAN remains possible if Bitwarden moves to a separate Proxmox guest or the chosen NAS proves tagged guest networking. The [remote-access plan](configure-remote-application-access.md) favors an ordinary public HTTPS route on the owner's future `pass` subdomain through a VPS reverse proxy and private origin link; no route is operational. Verify browser extension, mobile, desktop, and MFA flows before publication; any Cloudflare Access layer also needs compatibility testing.
- Require HTTPS, MFA, prompt updates, monitoring, encrypted exports, and an emergency recovery procedure. Keep application and NAS administration reachable only from approved Lab/Tailscale paths and deny lateral access to other service networks where enforceable.
- Establish automated backups and complete a restore test before migrating the sole copy of any credential. Bitwarden explicitly assigns backup responsibility to the self-hosting operator.
- For full replacement use, verify the official browser extension, desktop and mobile apps against the ordinary public HTTPS `pass` route, including two-step login, initial sync, offline unlock, reconnection, and mobile push sync. [Bitwarden documents self-hosted client URL selection](https://bitwarden.com/help/change-client-environment/) and [push-relay effects on automatic mobile synchronization](https://bitwarden.com/help/configure-push-relay/). Do not put a browser-only reverse-proxy identity challenge in front of these clients. A dedicated Proxmox Vault guest remains an isolation candidate because the vault needs little bulk storage; send encrypted, restore-tested backups to the NAS rather than assuming the vault must run on it.

See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md) and [storage plan](establish-nas-storage.md). The current HP memory/storage footprint and lack of dedicated backup storage require review before deployment.

References: [Bitwarden self-hosting options](https://bitwarden.com/help/self-host-bitwarden/) and [self-hosted backup guidance](https://bitwarden.com/help/backup-on-premise/).

## Public-repository boundary

Never store vault data, exports, master-password hints, recovery codes, MFA seeds, installation IDs/keys, SMTP credentials, certificates/private keys, or administrative URLs in this repository.
