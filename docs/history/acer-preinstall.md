# Acer Pre-Install History

Related: [Acer Nitro 5 AN515-54](../hosts/acer-nitro-5.md), [Convert Acer to AI Node](../plans/convert-acer-to-ai-node.md).

## 2026-09-14 — Windows Inventory and Storage Snapshot

The read-only [Windows inventory collector](../../scripts/collect-windows-inventory.ps1) captured the Acer hardware and platform baseline. The Acer was not the personal workstation used to maintain this repository. The raw report remains private.

- The CPU was command-verified as Intel Core i5-9300H with 4 cores and 8 logical processors. The NVIDIA GeForce GTX 1650 reported 4 GiB VRAM and CUDA compute capability 7.5; Intel UHD Graphics 630 was also present.
- One 8 GiB SK Hynix DDR4-2667 memory module was installed in a two-slot machine; firmware reported 32 GiB maximum.
- The installed Kingston `RBUSNS8154P3128GJ1` SSD was 128 GB-class (119.24 GiB reported), conflicting with an earlier reported stock 256 GB NVMe specification. Whether it was replaced or the earlier capacity was mistaken remained `UNKNOWN`.
- The Toshiba `MQ04ABF100` HDD was 1 TB-class (931.51 GiB reported). Windows reported both internal disks online and healthy; this was not a SMART/extended health test.
- Intel Wireless-AC 9560 160 MHz and Realtek Gaming GbE were present. The wired adapter negotiated 1 Gbps during collection.
- Windows 11 Home was installed. Secure Boot was enabled and the TPM was present, enabled, and ready. CPU virtualization and second-level address translation were reported disabled; whether this reflected firmware settings or the Windows reporting context remained `UNKNOWN`.
- The Windows system volume had 118.12 GiB capacity and 7.94 GiB free. The HDD data volume had 931.51 GiB capacity and 635.84 GiB free. BitLocker protection was off and the reported volumes were fully decrypted.
- An attached removable USB device had 58.98 GiB capacity. It could not hold all occupied space from both internal drives, so required personal data needed an audit before treating it as an adequate backup target.

These were point-in-time observations, not a current free-space, health, firmware, or backup claim. Use the [current device record](../hosts/acer-nitro-5.md) for the latest known hardware and the [plan](../plans/convert-acer-to-ai-node.md) for migration gates.
