# Self-hosted password manager

**Status:** planned; product and deployment architecture are not selected.

## Goal

Provide an owner-controlled password vault with supported clients, strong authentication, reliable synchronization, and recoverable encrypted data. This is a high-impact service: availability and recovery are as important as initial deployment.

## Candidates and gates

- Compare official Bitwarden Lite, standard Bitwarden, and other reviewed options. Vaultwarden may be evaluated as a community implementation, but it must not be described as the official Bitwarden server and client compatibility/support differences must be considered.
- Prefer a maintained Linux/Docker deployment following the selected project's authoritative documentation. Bitwarden documents Lite as suitable for personal or HomeLab use; final selection remains `TODO`.
- Require HTTPS, MFA, a private or explicitly reviewed remote-access path, prompt updates, monitoring, encrypted exports, and an emergency recovery procedure.
- Establish automated backups and complete a restore test before migrating the sole copy of any credential. Bitwarden explicitly assigns backup responsibility to the self-hosting operator.

References: [Bitwarden self-hosting options](https://bitwarden.com/help/self-host-bitwarden/) and [self-hosted backup guidance](https://bitwarden.com/help/backup-on-premise/).

## Public-repository boundary

Never store vault data, exports, master-password hints, recovery codes, MFA seeds, installation IDs/keys, SMTP credentials, certificates/private keys, or administrative URLs in this repository.
