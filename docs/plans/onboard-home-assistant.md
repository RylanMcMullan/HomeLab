# Onboard Home Assistant

**Status:** Active. Home Assistant OS is deployed, but no room plug or bulb is verified under Home Assistant control.

**Related plans:** [Segment HomeLab Network](segment-homelab-network.md) follows the initial room-device tests; [Configure Remote Application Access](configure-remote-application-access.md) owns any future public application route; [Evaluate Optional Home Assistant Devices](evaluate-optional-home-assistant-devices.md) is deferred. Current runtime facts are in [Home Assistant](../services/home-assistant.md). Deployment and discovery evidence are in [Home Assistant history](../history/home-assistant.md) and [device-inventory history](../history/device-inventory.md).

## Goal and gates

Verify room-device identity, compatibility, control, state feedback, and recovery one device at a time. Before changing enrollment or installing an integration, reconcile private device-app identifiers with the Archer snapshot, back up Home Assistant, review management exposure on the shared HomeLab LAN, and record a rollback path. No installed USB Wi-Fi/Bluetooth adapter or VM passthrough has been identified or tested. A discovery tile is not proof of a particular device's support.

The reported state is that intended Wi-Fi smart devices are powered on behind the Archer, while the Sengled bulb remains paired directly to Alexa outside its IP-client list. Home Assistant currently shares the Archer-side network with those clients and potentially with the Proxmox management interface; this is not IoT-to-Lab isolation. Consider powering off devices not needed for a test until the network security baseline is verified.

## Candidate room devices

| Device | Identity and current evidence | Candidate Home Assistant path | Limitation / next test |
| --- | --- | --- | --- |
| Govee H5083 smart plug | Hardware 1.02.00 and firmware 1.00.30 were reported earlier. The router alias `Miscellaneous Smart Plug` was confirmed through manual MAC matching; exact identifiers remain private. | The community [Govee Cloud Integration](https://github.com/lasswellt/govee-homeassistant) lists H5083 as a switch. Its API-key-only mode uses cloud control and polling; optional account login can provide real-time updates. | Third-party HACS integration, not built in. Review it and back up Home Assistant first. Obtain an API key only in the Govee app and keep it private. Built-in [Govee lights local](https://www.home-assistant.io/integrations/govee_light_local/) is lights-only and does not list H5083. Built-in [Govee Bluetooth](https://www.home-assistant.io/integrations/govee_ble/) does not list H5083; a separate direct-BLE plug integration lists other models only. Bluetooth passthrough is not a prerequisite for this plug test. |
| Three Feit Electric G30/E26 color-changing bulbs | 60 W-equivalent one-pack product; exact SKU, hardware, and firmware remain `UNKNOWN`. `Color Lights 1`–`3` are the confirmed router labels. | Test whether one bulb can enroll in Smart Life or Tuya Smart, then try built-in [Tuya](https://www.home-assistant.io/integrations/tuya/) with that account. | No built-in Feit integration. A Feit `SmartLife` temporary AP-mode setup network does not prove consumer Smart Life/Tuya account enrollment. Pair/reset one bulb only; it may leave the Feit app. If it fails, leave the other two unchanged and evaluate device-specific local Tuya separately. A MAC alone does not enable local control. |
| Desk RGB bulb | Brand, model, app, and protocol `UNKNOWN`. | Identify exact model and transport first. | Do not assume Wi-Fi, Bluetooth, Zigbee, Matter, or Tuya from its appearance. |
| Sengled Alexa-paired bulb | Not an Archer IP client according to the reported state. Model, hardware/firmware, and radio protocol `UNKNOWN`. | Identify bulb model and pairing transport. A [Sengled Bluetooth Mesh/Echo manual](https://eu.sengled.com/upload/produkte/Bluetooth/BLE_mesh_User_Manual.pdf) is a candidate reference, not proof of this bulb's model. | Matter requires an actual Matter-capable bulb/bridge; a direct radio path needs appropriate hardware and support. The Matter tile does not identify this bulb. Check packaging/Alexa details privately for protocol and any Matter logo/code. Do not reset or unpair during inventory. |

## Inventory and test procedure

1. Use the [network inventory procedure](../reference/network-discovery.md) and private device CSV to verify one physical device's brand, model/SKU, hardware/firmware, app, MAC match, current network placement, and evidence date. Keep identifiers out of Git.
2. Confirm Home Assistant backup destination, retention, and a representative restore path. Review Archer Wi-Fi isolation, Proxmox/Home Assistant firewall posture, management authentication, and exposure on the shared LAN before changing device enrollment.
3. Start with one identified Govee H5083. Review the third-party integration and scoped credential path, then test Home Assistant control, state updates, vendor-app control, physical-button state, and internet access. Record whether the path is cloud or local. Revert or disconnect the device if the test fails.
4. Test one Feit bulb next. Record the enrollment outcome before touching the other two. Identify the desk bulb before selecting its integration. Inventory the Alexa-paired Sengled bulb without resetting it.
5. Record integration/device/entity association and actual behavior separately from discovery. A transient Tuya card or persistent Matter card is not an identity or compatibility test.
6. Update the [current service record](../services/home-assistant.md), private inventory, dated [history](../history/device-inventory.md), and [roadmap](../../ROADMAP.md) only after verification.

Use the least access an integration requires: vendor-cloud authentication when necessary, narrow local unicast when supported, or an explicitly reviewed radio/discovery path. The Archer guest/IoT SSID cannot be assumed to permit Home Assistant access. Do not add a broad port forward, DMZ host, unrestricted firewall rule, or direct public Home Assistant exposure as a discovery fix.

## Operational hardening and remote access

Verify updates, MFA/unique authentication where applicable, backup and restore, resource use, and Tailscale reachability. A future authenticated Cloudflare Tunnel route on the `iot` subdomain is proposed for browser and companion-app access, but no domain, route, or public Home Assistant access is configured. Test any additional Cloudflare Access login with the companion app before adoption. Keep Proxmox and Lab administration off that application route. Connector placement and firewall path remain `TODO`; the path should not depend on the future Lab router VM if an Archer-side connector can meet the security design.
