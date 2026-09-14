# Security policy

## Scope and threat model

This is a public GitHub repository. Assume its full history, branches, issues, pull requests, rendered files, and copied snippets may be visible indefinitely. The repository may document architecture and operational intent, but it must not provide authentication material or private configuration that makes unauthorized access easier.

## Never store

- Passwords, passphrases, recovery codes, or session cookies.
- API keys, access tokens, GitHub PATs, Cloudflare tokens, or cloud-provider credentials.
- SSH private keys; private certificates; VPN credentials; authentication keys.
- `.env` files that contain secrets or complete production configuration containing secrets.
- Unredacted router exports, service configs, logs, backups, QR codes, or screenshots that contain sensitive values.
- Password-vault databases, exports, recovery kits, master-password hints, real password-auditing wordlists, malware samples, packet captures, and security-assessment target lists.

Use placeholders such as `<SECRET>`, `<API_TOKEN>`, `<PUBLIC_IP>`, `<USERNAME>`, `<DOMAIN>`, and `<CREDENTIAL>`.

## Safe documentation practice

- Do not publish private IP addresses, hostnames, Tailscale addresses, tailnet names, subnet routes, DHCP reservations, administrative endpoints, or public tunnel credentials unless the owner explicitly determines a value is safe and wants it public.
- Document a service’s exposure architecturally; link to vendor documentation where detailed setup would require secret values.
- Put repository-safe templates in `configs/` only when all secrets are placeholders. Put no live secret-bearing configuration here.
- Keep secrets in a dedicated secret manager or another owner-controlled private location.

## Security lab and password-manager requirements

- Security testing is limited to owner-controlled systems or targets covered by explicit authorization and scope. Do not publish target lists, captured data, or credentials.
- A Kali or other research VM is not authorization to test third-party systems. Keep its management plane private and define resource limits, logging, and an emergency stop procedure before long-running activity.
- Do not execute malware until a dedicated containment design has been reviewed and verified. The planned lab must not have a route to household devices, HomeLab management, production services, or uncontrolled internet access.
- A self-hosted password manager must not become the sole credential copy until encrypted exports, backups, updates, HTTPS, MFA, recovery access, and a restore test are established.

## If a secret is found

1. Do not commit, push, paste, or repeat the value.
2. Stop the documentation change and alert the owner.
3. If the value has already reached Git history or a public remote, treat it as compromised: revoke or rotate it through the relevant provider, then seek guidance before rewriting history.

## Review before publication

Before committing, inspect `git diff` and check staged and untracked files for credentials, `.env` files, key material, copied configs, logs, and screenshots. `.gitignore` is convenience, not a security control.
