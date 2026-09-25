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
- The owner reports having a USB Wi-Fi + Bluetooth adapter available for the HP host. It has not been identified, passed through to the Home Assistant VM, or tested; Bluetooth availability in Home Assistant therefore remains `UNKNOWN`.
- Backup target, retention, and restore test: `UNKNOWN`.
- The TP-Link Archer router was automatically recognized and added as a network-device integration during initial onboarding.
- Other owner-reported name-brand smart devices were not discovered during initial onboarding. Their integration methods and network requirements remain `TODO`.
- The upstream gateway presents separate 2.4 GHz and 5 GHz Wi-Fi names. A Windows client comparison verified that both bands share the same private IPv4 network, gateway, DNS configuration, and DHCP behavior. Router-UI inspection verified that intra-BSS traffic blocking is disabled on both bands. The separate Archer routing/NAT boundary—not the radio band split—is therefore the leading network-level explanation for failed broadcast discovery; cross-band multicast behavior and individual device protocols remain unverified.
- A Windows client behind the Archer successfully reached the upstream gateway by ICMP and HTTP. This supports the possibility of manually configured local-unicast integrations, but it does not verify reachability to any individual IoT device or make multicast-based discovery available.
- Archer inspection found no exposed mDNS or SSDP relay control. Its enabled IGMP and wireless-multicast controls are not treated as equivalent to a service-discovery reflector. Full upstream discovery therefore requires moving selected devices behind the Archer or connecting the Home Assistant VM to the upstream LAN through a separately designed interface.
- During the initial network assessment, household IoT connectivity across the Zyxel–Archer boundary was investigated. An application on an Archer-side phone could control an upstream device, but that did not establish local control or Home Assistant discovery. Cross-boundary discovery remains incomplete; no routing, VLAN, multicast, or firewall change has been made. See the [network discovery runbook](../network/discovery-runbook.md) and [decision 0003](../decisions/0003-segmented-services-and-remote-access.md).

## Candidate device inventory and integration research

**Status:** owner-reported inventory and researched compatibility as of 2026-09-25. The owner reports all HomeLab IoT devices disconnected until controlled testing; independent verification and Home Assistant control remain outstanding. Keep them disconnected outside explicit test windows and recheck before each test.

| Device | Owner-reported details | Candidate Home Assistant path | Important limitations / next test |
| --- | --- | --- | --- |
| Govee smart plug | Model H5083; hardware version 1.02.00; firmware version 1.00.30; one plug identified for the first test. The owner can view its hardware address in the app; it must not be committed. | The community [Govee Cloud Integration](https://github.com/lasswellt/govee-homeassistant) lists H5083 support as a switch. Its Govee API-key-only mode provides cloud control and polling; optional Govee-account login can provide real-time updates. | This is a third-party HACS integration, not a built-in Home Assistant integration; review it and back up Home Assistant before installation. Obtain an API key only in the Govee app and keep it private. The built-in [Govee lights local](https://www.home-assistant.io/integrations/govee_light_local/) integration is lights-only and does not list H5083. The built-in [Govee Bluetooth](https://www.home-assistant.io/integrations/govee_ble/) integration does not list H5083, and a separate direct-BLE plug integration lists other models only. Do not make Bluetooth passthrough a prerequisite for this plug test. |
| Feit Electric smart bulb | Three bulbs; G30/E26 color-changing, 60 W-equivalent, one-pack product. The precise package/SKU identifier is `TODO`. | Test whether one bulb can be enrolled in the Smart Life or Tuya Smart app, then use Home Assistant's built-in [Tuya](https://www.home-assistant.io/integrations/tuya/) cloud integration with that account. | Feit has no built-in Home Assistant integration. The Feit setup documentation's `SmartLife` temporary AP-mode network does not prove that this model is enrollable in a consumer Smart Life/Tuya account. Test one bulb only; pairing/resetting may remove it from the Feit app. If that fails, leave the other two unchanged and evaluate a device-specific local-Tuya route separately. A MAC address alone is insufficient for local control and must remain private. |
| Desk lamp RGB bulb | Brand, model, app, and protocol: `UNKNOWN`; owner will identify it. | Select an integration after the exact model and protocol are known. | Do not assume Wi-Fi, Bluetooth, Zigbee, Matter, or Tuya support from its appearance. |
| Xbox Series X | Owner-reported. | Built-in [Xbox](https://www.home-assistant.io/integrations/xbox/) integration supports Series X status, media, and remote control through Xbox Network. | Requires an adult Xbox account, cloud connectivity, and Remote Features for remote/media entities. Wake from energy-saving shutdown is unsupported; sleep mode has a power cost. Optional, unscheduled. |
| Roku Stick 4K and Roku TV | Owner-reported; exact models and network placement: `UNKNOWN`. | Built-in [Roku](https://www.home-assistant.io/integrations/roku/) integration supports media status, remote commands, app launch, and TV-specific controls where available. | Local network access and Roku's mobile-app network-control setting must be checked; discovery across the Archer boundary is not assumed. Optional, unscheduled. |
| Amazon Echo Dot | Owner-reported; generation: `UNKNOWN`. | Built-in [Alexa Devices](https://www.home-assistant.io/integrations/alexa_devices/) supports selected Echo media, announcement, routine, and sensor functions. | Requires Amazon account authentication with app-based MFA; Amazon cloud and rate limits apply. Exposing Home Assistant entities for Alexa voice commands is a separate integration decision. Optional, unscheduled. |
| Spotify account | Subscription tier and playback target: `UNKNOWN`. | Built-in [Spotify](https://www.home-assistant.io/integrations/spotify/) integration can control account playback and browse media. | Requires Spotify Premium, a developer app/OAuth credentials, and a compatible known playback device. Keep credentials private. Optional, unscheduled. |

The intended order is to confirm disconnection, back up Home Assistant, connect only the H5083 to the Archer's ordinary, non-isolated 2.4 GHz Wi-Fi, and verify Home Assistant control, state updates, app control, physical-button state, and internet access. Disconnect it if the test fails. Then test one Feit bulb and the desk bulb after identification. The Archer guest/IoT SSID must not be used unless its local access to Home Assistant has been explicitly verified. Review the remaining media and account integrations after the room devices and network security baseline are working.

Until Lab management moves behind the tested router-VM firewall, an Archer-side IoT test device may share a network with the Proxmox host. Limit each test window, review host/service firewalls and management authentication first, and disconnect the device afterward. Same-LAN discovery does not itself provide isolation.

## Accepted target; not deployed

- Connect compatible owner-owned IoT devices to the Archer's ordinary Wi-Fi one at a time during controlled tests and verify their actual Home Assistant integrations; document exceptions. Keep them disconnected outside test windows until the network security baseline is reviewed. Keep the Home Assistant VM on that Archer-side network for local discovery; it is the exception to the planned one-service-per-VLAN pattern. The Archer's guest or IoT SSID is not assumed to permit local discovery until tested.
- Plan remote browser and companion-app access through an authenticated Cloudflare Tunnel route on the owner's future `iot` subdomain. Home Assistant Cloud is not required for this target, and no domain, route, or public Home Assistant access is configured yet.
- Use unique credentials, MFA, updates, and a tested Home Assistant backup/restore. Verify any extra Cloudflare Access login against the companion app before adopting it.
- Keep Proxmox and Lab administration off Home Assistant's published application route. The connector's location and exact firewall path remain `TODO`; the remote path should not depend on the proposed Lab router VM if it can be placed on the Archer side.

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
- [ ] Selected device integrations work on the intended Archer-side network during controlled tests.
- [ ] One selected Archer Wi-Fi IoT device is discovered and controlled, with state updates verified.
- [ ] Planned remote browser and companion-app path is authenticated and tested off-site after the tunnel is deployed.
- [ ] Backup destination and restore procedure are verified.
- [ ] Resource utilization is measured before changing allocations.

## Follow-up unknowns

- Selected VM ID, Proxmox storage, network bridge, and private guest addressing: `UNKNOWN` and not for publication.
- Home Assistant OS, Core, and Supervisor versions after installation: `UNKNOWN` until verified.
- Initial integrations, device discovery results, USB radio requirements, and backup target: `UNKNOWN`.
