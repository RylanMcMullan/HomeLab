# Self-hosted password manager

**Status:** later planned production service; product and deployment architecture are not selected. A separate educational implementation is also contemplated but will never hold real credentials.

## Goal

Provide an owner-controlled password vault with supported clients, strong authentication, reliable synchronization, and recoverable encrypted data. This is a high-impact service: availability and recovery are as important as initial deployment.

## Candidates and gates

- Compare official Bitwarden Lite, standard Bitwarden, and other reviewed options. Vaultwarden may be evaluated as a community implementation, but it must not be described as the official Bitwarden server and client compatibility/support differences must be considered.
- Prefer a maintained Linux/Docker deployment following the selected project's authoritative documentation. Bitwarden documents Lite as suitable for personal or HomeLab use; final selection remains `TODO`.
- The accepted target gives the production manager its own Vault VLAN and guest, with a Cloudflare Tunnel route on the owner's future `pass` subdomain for supported browser-extension and mobile clients. This is a planned remote-access path, not an operational endpoint. Verify each client and MFA flow before publication; any Cloudflare Access layer also needs compatibility testing.
- Require HTTPS, MFA, prompt updates, monitoring, encrypted exports, and an emergency recovery procedure. Keep guest administration reachable only from an approved Lab path and deny lateral access to other service VLANs.
- Establish automated backups and complete a restore test before migrating the sole copy of any credential. Bitwarden explicitly assigns backup responsibility to the self-hosting operator.

See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md) and [storage plan](../architecture/storage-plan.md). The current HP memory/storage footprint and lack of dedicated backup storage require review before deployment.

## Educational project boundary

The owner may program a password-manager prototype to learn the concepts. It is separate from the production manager, uses synthetic test data only, and must not store real passwords, recovery material, or keys. Its hosting, publication, and security claims remain `TODO`.

References: [Bitwarden self-hosting options](https://bitwarden.com/help/self-host-bitwarden/) and [self-hosted backup guidance](https://bitwarden.com/help/backup-on-premise/).

## Public-repository boundary

Never store vault data, exports, master-password hints, recovery codes, MFA seeds, installation IDs/keys, SMTP credentials, certificates/private keys, or administrative URLs in this repository.
