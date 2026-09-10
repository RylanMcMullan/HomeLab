# HomeLab contributor and agent guide

This repository is the canonical, public documentation source of truth for the HomeLab. Follow these rules for every task.

## Required reading order

1. Read this file first.
2. Read [CURRENT_STATE.md](CURRENT_STATE.md).
3. Read [ROADMAP.md](ROADMAP.md).
4. Read the documentation for every host, service, network component, and configuration you are about to modify.
5. Inspect existing files before creating new documentation, so duplicate sources of truth are not introduced.

## State and evidence rules

- Treat `CURRENT_STATE.md` as deployed reality: infrastructure that exists and is believed operational when documented.
- Treat `ROADMAP.md` as planned or incomplete work. Never assume an item there has been deployed.
- Preserve the distinction between **verified**, **reported**, **inferred**, **planned**, **UNKNOWN**, and **TODO** information. Label source or confidence where it matters.
- Never fabricate missing IP addresses, hostnames, VLAN IDs, ports, device specifications, versions, credentials, configuration values, deployment status, or test results.
- If a fact is absent, write `UNKNOWN` or `TODO`; do not fill it from convention or guesswork.
- If one comparable device has a documented category, include a concise `UNKNOWN` placeholder for that category on comparable undocumented devices when useful.

## Documentation workflow

- Update documentation whenever implementation changes deployed state.
- Update `CURRENT_STATE.md` when deployed infrastructure changes.
- Update `ROADMAP.md` when work is added, completed, abandoned, blocked, or reprioritized.
- Record major architecture decisions in [docs/decisions/](docs/decisions/README.md).
- Prefer links to authoritative documentation over copying facts into multiple files.
- Keep documents useful to humans and future AI agents. State scope, status, and unknowns plainly.
- Record significant completed infrastructure changes in `CHANGELOG.md`; do not log ordinary wording or formatting edits.

## Public repository security

- Never commit passwords, API keys, access tokens, session cookies, recovery codes, SSH private keys, private certificates, Cloudflare tokens, GitHub PATs, cloud-provider credentials, VPN credentials, `.env` files with secrets, or authentication material.
- Use placeholders such as `<SECRET>`, `<API_TOKEN>`, `<PUBLIC_IP>`, `<USERNAME>`, `<DOMAIN>`, and `<CREDENTIAL>`.
- If provided information appears unsafe to publish, stop and warn the owner instead of adding it.
- Follow [SECURITY.md](SECURITY.md).

## Before finishing any task

1. Inspect affected files and cross-links.
2. Review for secrets and accidentally added private configuration.
3. Run `git status` and review `git diff` (or explain if unavailable).
4. Summarize files changed and unresolved assumptions.
5. Never commit or push unless the owner explicitly instructs you to do so.
