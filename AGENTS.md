# HomeLab contributor and agent guide

This repository is the canonical, public documentation source of truth for the HomeLab. Follow these rules for every task. The [documentation model](docs/reference/documentation-model.md) defines each record's purpose and the [terminology register](docs/reference/terminology.md) defines canonical names.

## Required reading order

1. Read this file first.
2. Read [CURRENT_STATE.md](CURRENT_STATE.md).
3. Read [ROADMAP.md](ROADMAP.md).
4. Read the current host, service, network, plan, history, and decision records relevant to the task.
5. Inspect existing files before creating new documentation, so duplicate sources of truth are not introduced.

## State and evidence rules

- Treat `CURRENT_STATE.md` as deployed reality: infrastructure that exists and is believed operational when documented.
- Treat `ROADMAP.md` as planned or incomplete work. Never assume an item there has been deployed.
- Treat `docs/hosts/`, `docs/services/`, and `docs/network/` as current configuration only. Keep future procedures in `docs/plans/` and prior configurations or dated evidence in `docs/history/`.
- Preserve historical factual content and completed configuration evidence. Present any proposed factual correction to historical material for operator approval before editing it; adding a later dated state is not a correction to an earlier true report.
- Preserve the distinction between **verified**, **reported**, **inferred**, **planned**, **UNKNOWN**, and **TODO** information. Label source or confidence where it matters.
- Never fabricate missing IP addresses, hostnames, VLAN IDs, ports, device specifications, versions, credentials, configuration values, deployment status, or test results.
- If a fact is absent, write `UNKNOWN` or `TODO`; do not fill it from convention or guesswork.
- If one comparable device has a documented category, include a concise `UNKNOWN` placeholder for that category on comparable undocumented devices when useful.
- Keep physical device specifications sufficient for later compatibility decisions, including NAS selection. Date mutable observations and link services to their host devices. Plans should link to those specifications; repeat a dated value only when necessary to explain a specific constraint. Name physical devices by brand/model where known; name services independently. Use [terminology](docs/reference/terminology.md) for aliases.
- Use present tense for current state, past tense for dated history, and future/conditional language for plans. Prefer “reported state” or “reported on `<date>`” to “the owner reports/reported.”

## Documentation workflow

- Update documentation whenever implementation changes deployed state.
- Update `CURRENT_STATE.md` when deployed infrastructure changes.
- Update `ROADMAP.md` when work is added, completed, abandoned, blocked, or reprioritized.
- Give every roadmap objective a linked `docs/plans/` file. Plan titles use title-case verb + noun and files use imperative kebab-case names (for example `Onboard Home Assistant` / `onboard-home-assistant.md`). Status is written in the file, not encoded in its path. Keep roadmap actions broad: at most 15 checkable steps per plan and three substeps per step. Put detailed instructions, dependencies, verification, and rollback in the plan.
- Link significant changelog entries to detailed, chronological topic history. A plan may reference multiple history topics; do not compress or erase completed configuration evidence during relocation.
- Record major architecture decisions in [docs/decisions/](docs/decisions/README.md).
- Prefer links to authoritative documentation over copying facts into multiple files.
- Keep documents useful to humans and future AI agents. State scope, status, and unknowns plainly.
- Record significant completed infrastructure changes in `CHANGELOG.md`; do not log ordinary wording or formatting edits.

## Public repository security

- Never commit passwords, API keys, access tokens, session cookies, recovery codes, SSH private keys, private certificates, Cloudflare tokens, GitHub PATs, cloud-provider credentials, VPN credentials, `.env` files with secrets, or authentication material.
- Use placeholders such as `<SECRET>`, `<API_TOKEN>`, `<PUBLIC_IP>`, `<USERNAME>`, `<DOMAIN>`, and `<CREDENTIAL>`.
- If provided information appears unsafe to publish, stop and warn the owner instead of adding it.
- Follow [SECURITY.md](SECURITY.md).
- Keep **all raw/generated operational inventory and evidence outside this repository**, including data formerly written to `inventory-output/`. The approved local reference root is `C:\Projects\Personal\PrivateResources\HomeLab`; use its `inventory` child for current raw inventory. On other workstations, set `HOMELAB_PRIVATE_ROOT` to an approved external directory. Do not create a new in-repository private-output directory or rely on `.gitignore` as containment.
- The private reference directory is for non-secret operational data, not a credential store. A secret manager may be adopted when relevant; none is currently documented as deployed. Never place secrets in either the public repo or general private inventory.

## Security-research boundaries

- Perform security testing only against systems owned by the operator or covered by explicit authorization and scope.
- Do not infer permission to scan, exploit, monitor, or test third-party systems from the existence of security tooling or a Kali VM.
- Treat malware execution as prohibited until the dedicated isolation design is implemented and verified. Never execute samples on ordinary HomeLab, household, personal, or production-connected systems.
- Keep targets, captured data, credentials, wordlists containing real account material, malware samples, and engagement results out of this public repository.

## Before finishing any task

1. Inspect affected files and cross-links.
2. Review for secrets and accidentally added private configuration.
3. Run `git status` and review `git diff` (or explain if unavailable).
4. Check links and confirm no raw/private files were created in the repository; check any external move against the source inventory and file hashes.
5. Summarize files changed and unresolved assumptions.
6. Never commit or push unless explicitly instructed to do so.
