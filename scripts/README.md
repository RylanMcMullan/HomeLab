# Script guidance

This directory is reserved for safe, reviewable operational scripts.

- Add a short usage section, prerequisites, expected effects, and rollback/recovery notes to every script.
- Scripts must not contain credentials, private keys, tokens, or hard-coded private infrastructure details.
- Default to dry-run or confirmation behavior for destructive operations where practical.
- Link scripts to the relevant host or service record and keep their deployment status clear.

## Available discovery scripts

- [`collect-linux-inventory.sh`](collect-linux-inventory.sh) gathers read-only hardware, operating-system, capacity, and Proxmox resource information. Keep its raw output private and sanitize it before updating documentation.
- [`collect-windows-inventory.ps1`](collect-windows-inventory.ps1) gathers read-only Windows hardware, firmware, storage, GPU, and platform information for pre-install planning. Run it on the machine being inventoried, not another workstation.
- [`audit-windows-backup.ps1`](audit-windows-backup.ps1) measures common personal-data locations and non-system top-level folders before an OS migration. Its output contains private paths and folder names and must not be committed.
- [`collect-windows-network.ps1`](collect-windows-network.ps1) captures private addressing, gateways, DNS, routes, and cached neighbors without scanning. Follow the [network discovery runbook](../docs/network/discovery-runbook.md) and keep its output private.

### Windows backup audit

Run this only on the Windows computer being migrated. It reads file metadata to calculate counts and approximate sizes; it does not read file contents, copy data, or modify files. Large directories can take several minutes to enumerate.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\audit-windows-backup.ps1 |
  Set-Content .\inventory-output\acer-backup-audit.txt
```

When using a USB copy of the script, replace the paths with the removable drive letter. The raw report lists personal paths and must remain private. No rollback is necessary because the script is read-only; the wrapper command creates or replaces only the chosen report file.

### Windows inventory collector

Prerequisites: Windows PowerShell 5.1 or PowerShell 7. Run PowerShell as Administrator when practical; the script still runs without elevation but may mark Secure Boot, TPM, BitLocker, or some hardware details unavailable.

From a repository checkout located on the Windows host being inventoried:

```powershell
New-Item -ItemType Directory -Force .\inventory-output | Out-Null
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\collect-windows-inventory.ps1 |
  Set-Content .\inventory-output\acer-preinstall.inventory.txt
```

`-ExecutionPolicy Bypass` applies only to that PowerShell process; it does not change the machine's configured execution policy. Expected effects: the script performs read-only system queries and prints a report. The command creates or replaces only the specified ignored output file. No system rollback is necessary.

Do not run this collector on the personal laptop used to maintain the repository—the report must come from the Acer Nitro 5 AI node. Do not commit the raw report.

### Linux inventory collector

Prerequisites: Bash and the ordinary Linux utilities available on the target. Root access is not required, but memory-slot and some Proxmox details may be unavailable without it.

Run it on a Linux host from a private copy of the repository:

```sh
bash scripts/collect-linux-inventory.sh > /tmp/homelab.inventory.txt
```

Or stream it from a local PowerShell repository checkout to a host without copying the script there:

```powershell
Get-Content -Raw .\scripts\collect-linux-inventory.sh |
  ssh <USERNAME>@<HOST> "sed 's/\r$//' | bash -s" |
  Set-Content .\inventory-output\host.inventory.txt
```

Create `inventory-output/` locally before using the PowerShell example. The directory and `*.inventory.txt` files are ignored by Git. Enter any SSH password only in the terminal's password prompt, never in the command or a repository file.

The remote `sed` step removes carriage returns that Windows PowerShell may append while streaming text. Without it, Bash can finish the collector but report a harmless final error such as `$'\r': command not found`.

Expected effects: the script reads local system interfaces and prints a report. It makes no configuration or filesystem changes. No rollback is necessary. Review raw output for private identifiers before using any facts in public documentation.
