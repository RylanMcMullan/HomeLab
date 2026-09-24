# Minecraft Java server

**Status:** deployed and publicly reachable through playit.gg, based on owner-provided information.

## Hosting and access

- Host: [Raspberry Pi 5](../hosts/raspberry-pi-5.md).
- Edition: Minecraft Java.
- Public connectivity: playit.gg.
- Administrative access: Tailscale.

## Proposed network change; not deployed

The Raspberry Pi is owner-reported on switch port 4. A dedicated Minecraft/game VLAN is a candidate in the [segmentation worksheet](../network/segmentation-plan.md), not a selected or configured assignment. Before moving the Pi, verify that the playit.gg tunnel still establishes outbound connectivity, that authorized Tailscale administration remains reachable, and that only necessary monitoring/backup paths can cross from Lab. If the proposed router VM supplies the game VLAN gateway, its outage would interrupt the public game service. Record the current switch settings and rollback procedure before any port change.

## Unknowns and public-safe documentation

- Minecraft version, server distribution, world/mod/plugin inventory, process management, resource limits, backup plan, and patch status: `UNKNOWN`.
- Public endpoint, tunnel identifier, listening port, IP address, hostname, and playit.gg account details: not documented; values are `UNKNOWN` or potentially sensitive.
- playit.gg credentials, tokens, and authentication material must never be committed.

## Verification TODO

Document a non-secret operational runbook: start/stop method, backup and restore process, update process, log location, health check, and maintenance owner. Record a public address only if the owner explicitly chooses to publish it.
