# Harden Minecraft Server

**Status:** Planned after the first Home Assistant and network baseline. The [Minecraft Java server](../services/minecraft-java.md) is already public through playit.gg; this plan does not authorize a new public route.

**Related plans:** [Segment HomeLab Network](segment-homelab-network.md) may affect the Raspberry Pi's placement; [Deploy Management Services](deploy-management-services.md) may later link to or monitor a private web panel; [Establish NAS Storage](establish-nas-storage.md) provides a later backup target.

## Inventory before changes

Collect privately from the Raspberry Pi and service configuration; publish only sanitized findings. This precedes tuning, panel migration, or a game-VLAN decision.

1. Record Pi OS/kernel, update status, CPU/RAM/temperature at idle and under player load, SSD model/capacity/free space/health, filesystem, and power stability.
2. Record Java runtime, exact Minecraft version/distribution, mods/plugins and versions, world names/sizes, server configuration, launch flags, and actual player count/load pattern.
3. Record service user, file ownership/permissions, process supervisor and startup order, start/stop/restart method, console/log access, update method, scheduled tasks, and crash recovery.
4. Map the playit.gg client/outbound dependency, firewall/listening services, present Tailscale client/subnet path and grants, and who can administer the host. Keep endpoints, credentials, raw logs, and player data private.
5. Determine backup method, destination, retention, available SSD capacity, world consistency during backup, and a representative restore on non-production data.

The external USB SSD currently holds the Pi OS and server environment. Available space is a candidate for interim backups only after capacity, separation from live world files, retention, and restore are verified. A same-device copy may help recover from a bad update or accidental deletion but cannot survive SSD failure; an independent copy is required for durable recovery.

## Easier administration

[Crafty Controller](https://docs.craftycontrol.com/) is a Minecraft-focused web-panel candidate with server import, console, file/server configuration, and role controls. Inventory the existing start method and make a restorable backup before choosing installation or migration; verify compatibility with the exact server distribution. Keep the panel on a private Lab/Tailscale path with its own authentication and narrowly scoped Pi access. Homepage can link to it and Uptime Kuma can monitor it, but neither replaces server management. Panel placement, authentication, and rollback remain `TODO`.

## Network and recovery gates

The Raspberry Pi is reported on switch port 4. A dedicated game VLAN is a candidate in [Segment HomeLab Network](segment-homelab-network.md), not a selected setting. Before moving the Pi, back up the switch configuration and verify its cable/port path. After any move, verify the outbound playit.gg tunnel, private Tailscale administration, and only necessary monitoring/backup paths from Lab. If the router VM supplies the game gateway, its outage may interrupt the public game service; test the actual failure behavior and rollback.

Document a non-secret operational runbook after inventory: start/stop, backup/restore, update, log location, health check, and maintenance responsibility. Establish baseline performance and a tested backup before changing JVM/server tuning. Exact Minecraft version, distribution, world/mod/plugin inventory, resource limits, backups, and patch status are `UNKNOWN` until inventoried. Never publish playit.gg credentials, tunnel IDs, endpoint, listening port, or raw player data without a separate disclosure decision.
