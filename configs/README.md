# Configuration guidance

This directory is reserved for repository-safe configuration examples, templates, and non-secret declarative configuration.

- Use placeholders for every credential and sensitive endpoint, for example `<SECRET>` and `<DOMAIN>`.
- Do not add live router exports, Cloudflare Tunnel credentials, Tailscale keys, `.env` files, private certificates, or production configuration containing secrets.
- Link each configuration file to the host or service documentation it supports.
- Do not imply a template has been deployed; deployed status belongs in [CURRENT_STATE.md](../CURRENT_STATE.md).

No configuration files are currently tracked.
