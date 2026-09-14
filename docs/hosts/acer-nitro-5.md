# Acer Nitro 5 AN515-54

**Status:** conversion to a dedicated HomeLab AI server is **in progress**, currently gated on preserving selected Windows files. Linux and the AI service are not deployed.

> Discovery boundary: the personal laptop used to maintain this repository is a separate computer, not this Acer node. Do not attribute local workstation inventory to the Acer.

## Hardware

- Model: Acer Nitro 5 AN515-54.
- CPU: Intel Core i5-9300H with 4 cores and 8 logical processors; command-verified on 2026-09-14.
- GPU: NVIDIA GeForce GTX 1650 with 4 GiB VRAM and CUDA compute capability 7.5; Intel UHD Graphics 630 is also present.
- Memory: one 8 GiB SK Hynix DDR4-2667 module, two slots total, and a firmware-reported 32 GiB maximum.
- Installed SSD: Kingston `RBUSNS8154P3128GJ1`, 128 GB-class (119.24 GiB reported). This conflicts with the earlier owner-reported stock 256 GB NVMe specification; whether the drive was replaced or the earlier capacity was mistaken is `UNKNOWN`.
- Installed HDD: Toshiba `MQ04ABF100`, 1 TB-class (931.51 GiB reported).
- Windows reported both internal disks online and healthy. This is not a substitute for a SMART/extended health test.
- Network hardware: Intel Wireless-AC 9560 160 MHz and Realtek Gaming GbE; the wired adapter negotiated 1 Gbps during collection.

## Current software state

- Operating system: Windows 11 Home.
- Hostname and network identity are intentionally omitted. Detailed software inventory and current usage remain `UNKNOWN`.
- Secure Boot was enabled and the TPM was present, enabled, and ready during the 2026-09-14 Windows inventory.
- CPU virtualization and second-level address translation were reported disabled. Whether this reflects firmware settings or the Windows reporting context is `UNKNOWN`; neither is required for direct Linux AI inference but both should be reviewed before hosting virtual machines.
- Pre-install hardware inventory was collected on 2026-09-14 using the read-only [Windows inventory collector](../../scripts/collect-windows-inventory.ps1). Its raw output remains private.

## Pre-install storage snapshot

- Windows system volume: 118.12 GiB capacity with 7.94 GiB free at collection time.
- HDD data volume: 931.51 GiB capacity with 635.84 GiB free at collection time.
- BitLocker protection was off and the reported volumes were fully decrypted at collection time.
- The attached removable USB device had 58.98 GiB capacity. It cannot hold all occupied space from both internal drives; required personal data must be audited before it is considered an adequate backup target.

## Planned role

The intended role is a dedicated, headed, 24/7 local AI server and HomeLab management station. Requirements reported by the owner:

- Use a lightweight Linux graphical environment with a local browser for router, Proxmox, Home Assistant, and other management interfaces.
- Remain available with the lid closed while turning off the built-in display appropriately; exact lid, suspend, external-display, airflow, and sustained-temperature behavior is `TODO` for the selected OS.
- Support SSH administration plus a primarily web-based AI chat interface and API.
- Prioritize response quality while retaining useful interactive speed.
- Support one primary user, at most two or three users, and up to approximately three owner-initiated processes. Actual safe concurrency remains `UNKNOWN` until model benchmarks are run.
- Initial AI uses: light coding, automation, and cybersecurity research assistance.
- Future uses: carefully controlled smart-home assistance and physical I/O through Raspberry Pi-connected speakers, microphones, cameras, or other devices.
- Both internal drives may be erased after the owner completes and verifies a private backup.

The planned memory upgrade is up to 32 GiB. Platform selection, migration, AI runtime, models, deployment, and verification remain [roadmap work](../../ROADMAP.md). See the [in-progress local AI service](../services/local-ai.md).

## Pre-install backup checklist

Before erasing either drive, review both the Windows system drive and the secondary drive. Common personal-data locations include:

- `%USERPROFILE%\Desktop`, `Documents`, `Downloads`, `Pictures`, `Videos`, `Music`, and `Saved Games`.
- OneDrive equivalents of those folders. Confirm Files On-Demand items are fully synchronized or downloaded before relying on a removable-drive copy.
- Select application data under `%APPDATA%` and `%LOCALAPPDATA%`, including browser profiles, editor settings, game saves, and application-specific databases. Do not blindly restore all Windows application data into Linux.
- Source-code repositories, scripts, virtual-machine disks, databases, media libraries, and project folders stored outside the standard user profile.
- WSL distributions and container data, if present. Inventory and export them separately rather than copying their internal package files.
- Browser bookmarks and required profile data. Prefer supported account sync or an explicit export.
- `%USERPROFILE%\.ssh` only if existing SSH keys must be retained. Store private keys on encrypted private media, never in this repository; generating replacement keys after migration is preferable when practical.
- The BitLocker recovery key, Windows license/account information, and any software-license records needed later. Keep these in an owner-controlled private location.

Use the read-only [Windows backup audit](../../scripts/audit-windows-backup.ps1) to measure common locations and identify non-standard top-level folders. Keep its raw report private because folder names and paths can reveal personal information.

Do not copy `C:\Windows`, `Program Files`, `Program Files (x86)`, or all of `ProgramData` as an application backup; reinstall required applications on the destination platform. Verify the backup by opening representative files from the removable drive before erasing either internal disk. Microsoft identifies Desktop, Documents, Pictures, Videos, and Music as standard Windows Backup folders; OneDrive folder status must still be checked explicitly. See [Microsoft Windows Backup](https://support.microsoft.com/en-us/windows/experience/backup-recovery/back-up-and-restore-with-windows-backup) and [OneDrive folder backup](https://support.microsoft.com/en-us/onedrive/back-up-your-folders-with-onedrive).

Do not add it to `CURRENT_STATE.md` as an AI service host until the operating platform, runtime, workload, and operating status have been verified.
