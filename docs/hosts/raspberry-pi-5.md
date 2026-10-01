# Raspberry Pi 5

**Status:** deployed physical host. Its current known workload is the [Minecraft Java server](../services/minecraft-java.md).

## Hardware

- Raspberry Pi 5.
- 8 GB RAM.
- External fanxiang S101 128GB SSD 2.5" SATA attached via USB 3.0 is used for the operating system and server environment.
- Connector: StarTech SATA to USB Adapter, USB 5Gbps, 2.5in SATA III (USB3S2SAT3CB)
- Exact SSD filesystem, and health: `UNKNOWN`.

## Software and workloads

- Operating system: Raspberry Pi OS Lite (64-bit).
- Primary workload: [Minecraft Java server](../services/minecraft-java.md).
- Other workloads, service manager, backup process, monitoring, and patch status: `UNKNOWN`.

## Access

- Minecraft public reachability is provided by playit.gg; administration is performed through [Tailscale](../services/tailscale.md).
- Reported switch connection: port 4 of the [managed switch](../network/topology.md#tp-link-tl-sg108pe-managed-switch). The cable path and present VLAN/PVID remain unverified.

## Compatibility information still needed

CPU/temperature under load, SSD free space/health, backup/restore status, and present switch configuration remain `UNKNOWN`. The inventory procedure is in [Harden Minecraft Server](../plans/harden-minecraft-server.md).
