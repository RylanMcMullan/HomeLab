# Acer Nitro 5 AN515-54

**Status:** existing physical laptop running Windows 11 Home. Hardware and security-state values were last collected on 2026-09-14; refresh mutable measurements before making compatibility, storage, or installation decisions. This is not the personal workstation used to maintain the repository.

## Hardware and capabilities

| Component | Last verified or reported specification |
| --- | --- |
| CPU | Intel Core i5-9300H; 4 cores, 8 logical processors (command-verified) |
| GPU | NVIDIA GeForce GTX 1650, 4 GiB VRAM, CUDA compute capability 7.5; Intel UHD Graphics 630 also present |
| Memory | One 8 GiB SK Hynix DDR4-2667 module; two slots; firmware-reported 32 GiB maximum |
| SSD | Kingston `RBUSNS8154P3128GJ1`, 128 GB-class, 119.24 GiB reported |
| HDD | Toshiba `MQ04ABF100`, 1 TB-class, 931.51 GiB reported |
| Networking | Intel Wireless-AC 9560 160 MHz and Realtek Gaming GbE; wired link negotiated 1 Gbps at collection |
| Security hardware | Secure Boot enabled; TPM present, enabled, and ready at collection |

Windows reported both internal disks online and healthy, which was not a SMART/extended health test. CPU virtualization and second-level address translation were reported disabled; firmware setting versus Windows reporting context remains `UNKNOWN`.

## Current platform and links

- Operating system: Windows 11 Home at last verification. Detailed software inventory and current usage remain `UNKNOWN`.
- Reported switch connection: port 3 of the [TP-Link managed switch](../network/topology.md#tp-link-tl-sg108pe-managed-switch); current VLAN/PVID and cable trace are unverified.
- The [2026-09-14 pre-install history](../history/acer-preinstall.md) retains point-in-time free space, BitLocker, removable-media, and collection evidence. None is treated as a current capacity guarantee.
- Linux and a local AI service are not deployed. Future conversion steps and file-preservation gates are in [Convert Acer to AI Node](../plans/convert-acer-to-ai-node.md).

Hostname, private addressing, and identifiers are not published. BIOS/UEFI version, current disk health, thermals, power/cooling behavior, and sustained workload capacity remain `UNKNOWN` for later compatibility review.
