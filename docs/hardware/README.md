# Hardware inventory

**Inventory status:** owner-provided baseline; complete model, serial, firmware, and network inventory remains `TODO`.

| Device | Known hardware | Current purpose | Detailed record |
| --- | --- | --- | --- |
| Zyxel modem/router | Exact model: `UNKNOWN` | Primary household gateway | [Network record](../network/topology.md#upstream-household-gateway) |
| TP-Link Archer BE3500 | Exact revision / firmware: `UNKNOWN` | HomeLab router | [Network record](../network/topology.md#homelab-router) |
| TP-Link TL-SG108PE | 8-port managed switch; firmware: `UNKNOWN` | HomeLab switching | [Network record](../network/topology.md#managed-switch) |
| HP EliteDesk | Intel Core i5 vPro (9th generation); 16 GB DDR4 (one 16 GB DIMM); Samsung 256 GB NVMe SSD, MZVLB256HAHQ-000L7 | Proxmox VE virtualization node | [Host record](../hosts/proxmox-node.md) |
| Raspberry Pi 5 | 8 GB RAM; external USB 3.0 SSD used for OS/server environment | Minecraft Java server host | [Host record](../hosts/raspberry-pi-5.md) |
| Acer Nitro 5 AN515-54 | 9th-gen Intel Core i5; GeForce GTX 1650 (4 GB VRAM); 8 GB DDR4; two RAM slots; 256 GB NVMe SSD; 1 TB internal HDD | Windows laptop; planned AI node | [Host record](../hosts/acer-nitro-5.md) |

Do not add serial numbers, MAC addresses, private network information, or sensitive inventory exports to this public repository.
