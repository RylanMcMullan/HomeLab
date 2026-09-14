# Uptime Kuma

**Status:** planned private service; not deployed or verified.

## Purpose

Provide simple availability monitoring for selected HomeLab services, initially including the deployed Home Assistant service. Monitoring targets, notification channels, and retention remain `UNKNOWN` until configured and verified.

## Proposed architecture

- Deploy after the higher-priority AI-node migration or when the owner reprioritizes it.
- Consider a small private Debian utility guest shared with [Homepage](homepage.md); dedicated versus shared guest remains `UNKNOWN` until selected.
- Prefer the project's official Docker image and a persistent local data volume. See the [official Uptime Kuma repository](https://github.com/louislam/uptime-kuma).
- Keep the interface private to the HomeLab and/or Tailscale.
- Do not expose the Docker socket merely to monitor ordinary HTTP, TCP, ping, or DNS targets.
- Suggested starting allocation for a shared lightweight utility guest: 1 vCPU, 1–2 GiB RAM, and a 16 GiB system disk. This is a planning estimate, not a verified requirement.

## Security and verification

- Never publish administrator credentials, notification tokens, private target addresses, or status-page secrets.
- [ ] Deployment guest and runtime are documented.
- [ ] Persistent data location and backup scope are documented.
- [ ] Authentication and private reachability are verified.
- [ ] At least one non-critical monitor is tested through a controlled failure and recovery.
- [ ] Resource use is measured before resizing.
