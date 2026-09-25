# Minecraft Java server

**Status:** deployed and publicly reachable through playit.gg, based on owner-provided information.

## Hosting and access

- Host: [Raspberry Pi 5](../hosts/raspberry-pi-5.md).
- Edition: Minecraft Java.
- Public connectivity: playit.gg.
- Administrative access: Tailscale.

## First inventory, before changes

Collect privately from the Pi and service configuration; publish only sanitized findings. This inventory precedes tuning, management-panel migration, and any game-VLAN change.

1. Host baseline: Pi OS and kernel, update status, CPU/RAM/temperature under idle and player load, SSD model/capacity/free space/health, filesystem, and power stability.
2. Minecraft stack: Java runtime, exact Minecraft version and server distribution, installed mods/plugins and their versions, world names/sizes, configuration files and launch flags, and actual player count/load pattern.
3. Operations: service user, process supervisor and startup order, start/stop/restart commands, console/log access, file ownership, update method, scheduled tasks, and crash recovery.
4. Exposure: playit.gg process and outbound dependency, firewall/listening services, current Tailscale client/subnet path and grants, and who can administer the host. Keep addresses, identifiers, credentials, raw logs, and player data outside Git.
5. Recovery: current backup method, destination, retention, available SSD space, world consistency during backup, and a representative restore on non-production data.

The external USB SSD currently holds the Pi operating system and server environment. The owner proposes using available capacity there for interim backups. First verify free space and separate backups from live world files; a same-device copy can protect against a bad update or accidental deletion but cannot protect against SSD failure. An independent copy remains required for durable recovery.

## Easier administration; planned

[Crafty Controller](https://docs.craftycontrol.com/) is a candidate Minecraft-focused web panel with server import, console, file and server configuration, and role controls. Inventory the existing start method and create a restorable backup before choosing installation or migration; confirm compatibility with the exact server distribution. Keep the panel on a private Lab/Tailscale path with its own authentication and narrowly scoped access to the Pi. Homepage can link to it and Uptime Kuma can monitor it, but neither replaces server management. Panel placement, authentication, and rollback are `TODO`.

## Proposed network change; not deployed

The Raspberry Pi is owner-reported on switch port 4. A dedicated Minecraft/game VLAN is a candidate in the [segmentation worksheet](../network/segmentation-plan.md), not a selected or configured assignment. Before moving the Pi, verify that the playit.gg tunnel still establishes outbound connectivity, that authorized Tailscale administration remains reachable, and that only necessary monitoring/backup paths can cross from Lab. If the proposed router VM supplies the game VLAN gateway, its outage would interrupt the public game service. Record the current switch settings and rollback procedure before any port change.

## Unknowns and public-safe documentation

- Minecraft version, server distribution, world/mod/plugin inventory, process management, resource limits, backup plan, and patch status: `UNKNOWN` until the first inventory is complete.
- Public endpoint, tunnel identifier, listening port, IP address, hostname, and playit.gg account details: not documented; values are `UNKNOWN` or potentially sensitive.
- playit.gg credentials, tokens, and authentication material must never be committed.

## Verification TODO

Document a non-secret operational runbook: start/stop method, backup and restore process, update process, log location, health check, and maintenance owner. Record a public address only if the owner explicitly chooses to publish it.
