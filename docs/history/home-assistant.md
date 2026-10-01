# Home Assistant History

Related: [Home Assistant current configuration](../services/home-assistant.md), [Onboard Home Assistant](../plans/onboard-home-assistant.md), [decision 0001](../decisions/0001-home-assistant-os-vm.md).

## 2026-09-14 — Home Assistant OS VM Deployment

A new Home Assistant OS VM was created from the checksum-verified official 18.2 KVM (`qcow2`) image; this was not a migration. The documented procedure specified manual Proxmox controls rather than a community convenience script; the complete execution path was not separately recorded. UEFI/OVMF, Q35, VirtIO SCSI, a bridged VirtIO adapter, 2 vCPUs, 2 GiB RAM, and a 32 GiB disk were selected. Successful VM boot and private web onboarding were reported, an account was created, and the TP-Link Archer router integration was recognized. The procedure called for checking a healthy console prompt, but a separate console-result record is not available. Other smart-device discovery, backups, Tailscale access, and sustained resource use were not verified at that time.

The original deployment procedure was:

1. Open the official [Home Assistant OS releases](https://github.com/home-assistant/operating-system/releases) and select the latest stable, non-release-candidate version.
2. Download the x86-64 Open Virtual Appliance image named `haos_ova-<VERSION>.qcow2.xz` and verify it against the checksum published with that release.
3. Create a VM without installation media. Select an unused VM ID, the approved storage, and the existing LAN bridge; these environment-specific values were not recorded publicly.
4. Configure UEFI/OVMF firmware, a VirtIO SCSI controller, 2 vCPUs, 2 GiB RAM, and no installation CD/DVD. Do not enable USB passthrough unless a specific radio is physically present and identified.
5. Decompress and import the verified QCOW2 image, attach it as the boot disk, set the boot order, and retain its 32 GiB capacity initially.
6. Start the VM and use its console to verify a healthy Home Assistant OS prompt.
7. Determine the guest address from a controlled local source, then perform onboarding from a trusted LAN or Tailscale client. Do not publish the address, account name, recovery data, or credentials.
8. Complete verification before updating current-state documentation.

Exact Proxmox commands depended on the selected VM ID, storage, bridge, image version, checksum, and temporary image path; no example identifiers were copied into production commands. The procedure is historical evidence of the deployment method, not a claim that the current image or runtime still has version 18.2.

## 2026-09-30 — Runtime and Integration Observation

The read-only About page showed Home Assistant Core 2026.9.4, Supervisor 2026.09.3, and OS 18.3. The Xbox and Archer UPnP/IGD integrations had device records. Xbox controls/storage entities and router status/traffic entities were present, but no command was executed. Matter was an unconfigured discovery tile with no named Sengled device. Tuya had appeared transiently after the network move according to the reported state, but was no longer visible. No room plug or bulb appeared in the 11-device registry. Those observations did not establish control of the Xbox or any room device.
