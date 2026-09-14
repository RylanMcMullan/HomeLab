# Architecture decisions

Use this directory for major, durable decisions that affect topology, hosting, exposure, storage, identity/access, backup strategy, or platform choices. Do not create a decision record merely for a transient task or documentation wording change.

## Records

- [0001 — Run Home Assistant OS in a dedicated Proxmox VM](0001-home-assistant-os-vm.md) — accepted and deployed; operational hardening remains planned.
- [0002 — Home Assistant access to upstream IoT devices](0002-home-assistant-upstream-network-access.md) — proposed; no network change has been made.

## Record format

Create files using `NNNN-short-title.md`, for example `0001-remote-access-approach.md`.

```md
# NNNN — Decision title

**Status:** Proposed | Accepted | Superseded | Deprecated
**Date:** YYYY-MM-DD

## Context

What problem or constraint prompted the decision?

## Decision

What was chosen? Identify any unknowns explicitly.

## Consequences

What trade-offs, operating requirements, and follow-up work result?

## Related documentation

- Relevant record: `TODO — add a valid relative link`
```
