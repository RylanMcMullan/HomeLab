# Deploy Bitwarden

**Status:** Planned with the future NAS implementation. Bitwarden variant and deployment architecture are not selected. The separate [educational prototype](build-password-manager-prototype.md) is deferred and will never hold real credentials.

**Dependencies:** [Establish NAS Storage](establish-nas-storage.md) and a tested restore; [Configure Remote Application Access](configure-remote-application-access.md) for any approved public application route.

## Goal

Provide an owner-controlled password vault with supported clients, strong authentication, reliable synchronization, and recoverable encrypted data. This is a high-impact service: availability and recovery are as important as initial deployment.

## Candidates and gates

- Compare official Bitwarden Lite and standard Bitwarden. Vaultwarden is a different community implementation and is not the selected production product.
- Follow the selected Bitwarden variant's authoritative Linux/Docker documentation. Bitwarden documents Lite as suitable for personal or HomeLab use; variant selection remains `TODO`. Evaluate a separately isolated NAS-hosted app/VM or a dedicated guest using NAS storage after the NAS platform is selected.
- The target is a distinct Vault security boundary if the selected host can enforce it, with a Cloudflare Tunnel route on the owner's future `pass` subdomain for supported browser-extension and mobile clients. This is a planned remote-access path, not an operational endpoint. Verify each client and MFA flow before publication; any Cloudflare Access layer also needs compatibility testing.
- Require HTTPS, MFA, prompt updates, monitoring, encrypted exports, and an emergency recovery procedure. Keep application and NAS administration reachable only from approved Lab/Tailscale paths and deny lateral access to other service networks where enforceable.
- Establish automated backups and complete a restore test before migrating the sole copy of any credential. Bitwarden explicitly assigns backup responsibility to the self-hosting operator.

See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md) and [storage plan](establish-nas-storage.md). The current HP memory/storage footprint and lack of dedicated backup storage require review before deployment.

References: [Bitwarden self-hosting options](https://bitwarden.com/help/self-host-bitwarden/) and [self-hosted backup guidance](https://bitwarden.com/help/backup-on-premise/).

## Public-repository boundary

Never store vault data, exports, master-password hints, recovery codes, MFA seeds, installation IDs/keys, SMTP credentials, certificates/private keys, or administrative URLs in this repository.
