# Services

This directory contains **deployed** platforms and services only. Undeployed services, candidates, and procedures are in [plans](../plans/README.md). Physical specifications belong to [hosts](../hosts/README.md); dated observations belong to [history](../history/README.md).

| Service or platform | Host | Current access or exposure | Record |
| --- | --- | --- | --- |
| Proxmox VE | [HP EliteDesk](../hosts/hp-elitedesk.md) | Private management via reported Tailscale path | [Configuration](proxmox-ve.md) |
| Home Assistant | Proxmox VE VM | Private HomeLab web access verified; no public route configured | [Configuration](home-assistant.md) |
| Tailscale subnet router | Proxmox VE LXC, identity inferred | Private remote administration path reported; exact grants unverified | [Configuration](tailscale.md) |
| Minecraft Java server | [Raspberry Pi 5](../hosts/raspberry-pi-5.md) | Public game access via playit.gg; administration via Tailscale | [Configuration](minecraft-java.md) |
