# Uptime Kuma

**Status:** planned private service; not deployed or verified.

## Purpose

Provide simple availability monitoring for selected HomeLab services, initially including the deployed Home Assistant service. Monitoring targets, notification channels, and retention remain `UNKNOWN` until configured and verified.

## Proposed architecture

- Deploy after the initial Home Assistant, router-VM/VLAN, and Minecraft inventory work; the Acer AI conversion is later.
- Consider a small private Debian utility guest shared with [Homepage](homepage.md); dedicated versus shared guest remains `UNKNOWN` until selected.
- Prefer the project's official Docker image and a persistent local data volume. See the [official Uptime Kuma repository](https://github.com/louislam/uptime-kuma).
- Keep the administrative interface private to authorized Lab and Tailscale clients. Use MagicDNS or Tailscale Serve for named tailnet browser access only after grants and routing are verified; a custom-domain name requires separate private DNS/TLS design.
- Place the administrative interface in the planned Lab management VLAN. Reach selected services and hosts across VLANs only through recorded health-check destinations and protocols; do not grant a blanket cross-VLAN rule. Whether to publish a sanitized status-only page is `TODO`.
- Do not expose the Docker socket merely to monitor ordinary HTTP, TCP, ping, or DNS targets.
- Suggested starting allocation for a shared lightweight utility guest: 1 vCPU, 1–2 GiB RAM, and a 16 GiB system disk. This is a planning estimate, not a verified requirement.

## Security and verification

- Never publish administrator credentials, notification tokens, private target addresses, or status-page secrets.
- [ ] Deployment guest and runtime are documented.
- [ ] Persistent data location and backup scope are documented.
- [ ] Authentication and private reachability are verified.
- [ ] At least one non-critical monitor is tested through a controlled failure and recovery.
- [ ] Monitoring succeeds across approved VLAN paths while unrelated management paths remain blocked.
- [ ] Resource use is measured before resizing.
