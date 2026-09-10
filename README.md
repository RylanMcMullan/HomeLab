# HomeLab

This public repository is the canonical documentation source of truth for this personal HomeLab. It records what is deployed, what is planned, and what still needs verification. It intentionally contains no credentials, tokens, private addresses, or authentication material.

## Start here

- [Current state](CURRENT_STATE.md) — deployed infrastructure believed operational at the time it was documented.
- [Roadmap](ROADMAP.md) — planned, incomplete, blocked, and completed work. Items here are **not** evidence of deployment.
- [Agent onboarding](AGENTS.md) — required operating rules for future contributors and Codex agents.
- [Security policy](SECURITY.md) — public-repository threat model and secret-handling rules.
- [Changelog](CHANGELOG.md) — material infrastructure history.

## Documentation map

- [Architecture](docs/architecture/README.md) — boundaries and system relationships.
- [Hardware inventory](docs/hardware/README.md) — physical devices and known specifications.
- [Hosts](docs/hosts/README.md) — operating systems, hypervisors, and host roles.
- [Services](docs/services/README.md) — workloads, exposure, and administration methods.
- [Network](docs/network/README.md) — network devices and topology.
- [Architecture decisions](docs/decisions/README.md) — durable decisions and rationale.
- [Configuration guidance](configs/README.md) and [script guidance](scripts/README.md) — safe locations for future repository-managed artifacts.

## Status language

- **Current / deployed**: described in `CURRENT_STATE.md`; known to exist and believed operational based on owner-provided information unless a file says otherwise.
- **Planned**: intended work only; it is never deployed merely because it appears in documentation.
- **Historical**: a significant completed change recorded in `CHANGELOG.md`.
- **UNKNOWN**: not supplied or not verified. It must be resolved from an authoritative source before being represented as fact.
- **TODO**: a documented follow-up task.

## Public-repository notice

Do not add secrets or private access details. Use placeholders such as `<SECRET>`, `<API_TOKEN>`, `<PUBLIC_IP>`, `<USERNAME>`, and `<DOMAIN>` in examples. See [SECURITY.md](SECURITY.md) before adding configuration or operational notes.
