# Raspberry Pi 5 server

**Status:** deployed service host. It currently hosts the public Minecraft Java server.

## Hardware

- Raspberry Pi 5.
- 8 GB RAM.
- External USB 3.0 SSD is used for the operating system and server environment.
- The owner proposes using available capacity on this SSD for interim Minecraft backups until NAS storage exists. Capacity, backup separation, retention, and restore success are unverified; a same-SSD copy does not protect against drive failure.
- Exact SSD make, model, capacity, filesystem, and health: `UNKNOWN`.

## Software and workloads

- Operating system: `UNKNOWN`.
- Hostname and internal network identity: `UNKNOWN`.
- Primary workload: [Minecraft Java server](../services/minecraft-java.md).
- Other workloads, service manager, backup process, monitoring, and patch status: `UNKNOWN`.

## Access

- Minecraft public reachability is provided by playit.gg.
- Administrative access is performed through Tailscale. See [Tailscale](../services/tailscale.md).
- Do not place playit.gg credentials or tokens in this repository.
- The owner reports this host on managed-switch port 4. Its current VLAN/PVID and cable path are unverified. A separate game VLAN is only a [candidate](../network/segmentation-plan.md), subject to playit.gg and Tailscale testing.

## Inventory TODO

Follow the ordered [Minecraft inventory](../services/minecraft-java.md#first-inventory-before-changes): host and storage health, exact server/Java/mod stack, process and update management, exposure/administration paths, and backup/restore. Keep raw outputs private.
