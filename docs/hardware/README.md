# Hardware inventory

**Inventory status:** owner-provided baseline supplemented by sanitized command-verified Proxmox and Acer inventories. Remaining unknowns are tracked in the detailed host records.

Use the [inventory checklist](inventory-checklist.md) when collecting additional facts. Raw command output may contain private identifiers and must be sanitized before it is copied into this public repository.

| Device | Known hardware | Current purpose | Detailed record |
| --- | --- | --- | --- |
| Zyxel modem/router | Exact model: `UNKNOWN` | Primary household gateway | [Network record](../network/topology.md#upstream-household-gateway) |
| TP-Link Archer BE3500 | Exact revision / firmware: `UNKNOWN` | HomeLab router | [Network record](../network/topology.md#homelab-router) |
| TP-Link TL-SG108PE | 8-port managed switch; firmware: `UNKNOWN` | HomeLab switching | [Network record](../network/topology.md#managed-switch) |
| HP EliteDesk | Intel Core i5-9500 (6 cores / 6 threads); 16 GB DDR4-2667 (one 16 GB SODIMM, one reported empty slot); Samsung 256 GB NVMe SSD, MZVLB256HAHQ-000L7 | Proxmox VE virtualization node | [Host record](../hosts/proxmox-node.md) |
| Raspberry Pi 5 | 8 GB RAM; external USB 3.0 SSD used for OS/server environment | Minecraft Java server host | [Host record](../hosts/raspberry-pi-5.md) |
| Acer Nitro 5 AN515-54 | Intel Core i5-9300H (4 cores / 8 threads); GeForce GTX 1650 (4 GiB VRAM); one 8 GiB DDR4-2667 module; two slots / 32 GiB firmware-reported maximum; installed 128 GB-class Kingston SSD; 1 TB-class Toshiba HDD | Windows laptop being prepared as a Linux AI node | [Host record](../hosts/acer-nitro-5.md) |

Do not add serial numbers, MAC addresses, private network information, or sensitive inventory exports to this public repository.
