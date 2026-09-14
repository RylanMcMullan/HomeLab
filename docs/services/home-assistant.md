# Home Assistant

**Status:** deployed and owner-verified operational on 2026-09-14. This is a new Home Assistant instance, not a migration.

## Deployed architecture

- Home Assistant Operating System runs in a dedicated Proxmox virtual machine imported from the official KVM (`qcow2`) image.
- The installation used the checksum-verified Home Assistant OS 18.2 OVA image. Runtime OS, Core, and Supervisor versions remain unverified because the system may update independently.
- Allocated resources: 2 vCPUs, 2 GiB RAM, and a 32 GiB virtual disk.
- Firmware and virtual hardware: UEFI/OVMF, Q35 machine type, VirtIO SCSI, and a bridged VirtIO network adapter.
- Guest ID, bridge name, storage-volume names, generated MAC address, hostname, private addressing, and owner credentials are intentionally omitted from this public repository.
- Owner-verified access is private from the HomeLab network using the local Home Assistant name and standard web interface. Tailscale access is not yet verified.

Home Assistant OS is the preferred installation because it includes Supervisor and supports apps while managing its own lifecycle. See the [official Linux VM installation guide](https://www.home-assistant.io/installation/linux).

## Current integrations and limitations

- Required USB radios or passthrough for Zigbee, Z-Wave, Bluetooth, Thread, or other protocols: `UNKNOWN`.
- Backup target, retention, and restore test: `UNKNOWN`.
- The TP-Link Archer router was automatically recognized and added as a network-device integration during initial onboarding.
- Other owner-reported name-brand smart devices were not discovered during initial onboarding. Their integration methods and network requirements remain `TODO`.
- The upstream gateway presents separate 2.4 GHz and 5 GHz Wi-Fi names. A Windows client comparison verified that both bands share the same private IPv4 network, gateway, DNS configuration, and DHCP behavior. Router-UI inspection verified that intra-BSS traffic blocking is disabled on both bands. The separate Archer routing/NAT boundary—not the radio band split—is therefore the leading network-level explanation for failed broadcast discovery; cross-band multicast behavior and individual device protocols remain unverified.
- A Windows client behind the Archer successfully reached the upstream gateway by ICMP and HTTP. This supports the possibility of manually configured local-unicast integrations, but it does not verify reachability to any individual IoT device or make multicast-based discovery available.
- Archer inspection found no exposed mDNS or SSDP relay control. Its enabled IGMP and wireless-multicast controls are not treated as equivalent to a service-discovery reflector. Full upstream discovery therefore requires moving selected devices behind the Archer or connecting the Home Assistant VM to the upstream LAN through a separately designed interface.
- Residential IoT devices are reported on the upstream Zyxel household network while the deployed VM is behind the TP-Link HomeLab router. The owner reports that a phone on HomeLab Wi-Fi, with Bluetooth disabled, can currently control IoT devices on the upstream network. This verifies some application connectivity, but does not establish whether it is local or cloud-mediated and does not verify Home Assistant discovery, callbacks, mDNS, SSDP, or every vendor-local protocol. Initial cross-network discovery is complete and remediation is deferred; no routing, VLAN, multicast, or firewall change has been made. See the [network discovery runbook](../network/discovery-runbook.md) and [proposed architecture decision](../decisions/0002-home-assistant-upstream-network-access.md).

## Deployment procedure

Use the official Home Assistant OS KVM image and manual Proxmox controls. Avoid community convenience scripts for the initial deployment so every setting and downloaded artifact can be reviewed.

1. Open the official [Home Assistant OS releases](https://github.com/home-assistant/operating-system/releases) and select the latest stable, non-release-candidate version.
2. Download the x86-64 Open Virtual Appliance image named `haos_ova-<VERSION>.qcow2.xz` and verify it against the checksum published with that release.
3. Create a VM without installation media. Select an unused VM ID, the owner-approved storage, and the existing LAN bridge in Proxmox; these environment-specific values remain `UNKNOWN` until selected.
4. Configure UEFI/OVMF firmware, a VirtIO SCSI controller, 2 vCPUs, 2 GiB RAM, and no installation CD/DVD. Do not enable USB passthrough unless a specific radio is physically present and identified.
5. Decompress and import the verified QCOW2 image, attach it as the VM's boot disk, set the boot order to that disk, and retain its 32 GiB capacity initially.
6. Start the VM and use its console to verify that Home Assistant OS reaches a healthy prompt.
7. Determine the guest address from an owner-controlled local source, then perform onboarding from a trusted LAN or Tailscale client. Do not publish the address, account name, recovery data, or credentials.
8. Complete the verification checklist below before updating current-state documentation.

Exact Proxmox commands must be generated only after confirming the unused VM ID, target storage name, bridge name, image version, checksum, and temporary image path. Never copy example identifiers into production commands.

## Verification checklist

- [x] VM boots using Home Assistant OS and UEFI.
- [x] Web onboarding is reachable privately and the owner account was created.
- [ ] Required device discovery and integrations work across the intended network boundary.
- [ ] Backup destination and restore procedure are verified.
- [ ] Resource utilization is measured before changing allocations.

## Follow-up unknowns

- Selected VM ID, Proxmox storage, network bridge, and private guest addressing: `UNKNOWN` and not for publication.
- Home Assistant OS, Core, and Supervisor versions after installation: `UNKNOWN` until verified.
- Initial integrations, device discovery results, USB radio requirements, and backup target: `UNKNOWN`.
