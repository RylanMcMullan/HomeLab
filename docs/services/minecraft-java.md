# Minecraft Java Server

**Status:** deployed on the [Raspberry Pi 5](../hosts/raspberry-pi-5.md), according to the reported state. Public game reachability uses playit.gg; administration uses [Tailscale](tailscale.md).

| Current-configuration field | Known value |
| --- | --- |
| Edition | Minecraft Java |
| Physical host | Raspberry Pi 5 with external USB 3.0 SSD for its OS and server environment |
| Public game path | playit.gg tunnel; exact endpoint and configuration not published |
| Administrative path | Tailscale, reported; exact grants and reachability not yet verified |
| Server version/distribution, Java, mods/plugins | `UNKNOWN` |
| Process supervisor, backup/restore, patch status | `UNKNOWN` |

The service's exact runtime, listener, world configuration, resource limits, and operational health require inventory. Raw logs, player data, identifiers, tokens, and endpoints remain outside Git. Inventory, backup, hardening, optional private web management, and any game-VLAN change are specified in [Harden Minecraft Server](../plans/harden-minecraft-server.md).
