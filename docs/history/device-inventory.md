# Device Inventory History

Related: [Onboard Home Assistant](../plans/onboard-home-assistant.md), [Evaluate Optional Home Assistant Devices](../plans/evaluate-optional-home-assistant-devices.md), [current topology](../network/topology.md).

## 2026-09-25 — IoT Devices Disconnected

The reported state was that all HomeLab IoT devices had been disconnected pending controlled Home Assistant testing. No integration, router, or VLAN change was verified. This dated state was superseded by the September 30 report; it is not a current disconnection claim. See the [changelog](../../CHANGELOG.md).

## 2026-09-30 — Smart Devices Moved to the HomeLab LAN

The reported state was that intended Wi-Fi smart devices were powered on and moved to the Archer HomeLab LAN, and the connected clients were manually labeled after MAC comparisons with device apps. The Sengled bulb remained paired directly to Alexa and was outside the Archer IP-client count. This moved devices away from the household LAN but did **not** isolate them from other hosts on the shared HomeLab LAN. No router VM, VLAN, Proxmox bridge, Tailscale route, or Home Assistant interface change occurred as part of this inventory work.

The read-only Archer client list showed 17 online clients at the 18:34 UTC observation; the count had changed from 16 while viewing. It displayed labels, IP/MAC values, and wired/2.4/5 GHz connection types. An expanded `Color Lights 1` row showed link rate and duration, not brand, model, or firmware. Exact client addresses and identifiers are retained only in the private inventory. The router category icons were not used as manufacturer evidence.

The reported app-MAC matching confirmed `Color Lights 1`–`3` as the three Feit G30/E26 bulbs and `Miscellaneous Smart Plug` as the Govee H5083. `Color Lamps` was another name for the same Feit group; `Color Lights` is the chosen unit label. The Govee hardware 1.02.00 and firmware 1.00.30 were supplied earlier. Exact Feit SKU, hardware, firmware, app enrollment, and Home Assistant control remained unverified. `Fan` and `LEGO Lights` remained router labels with unknown brands/models. No snapshot client was explicitly labeled Roku Stick 4K or desk RGB bulb; absence of those labels did not establish that either device was offline.

Home Assistant's DHCP browser showed a subset of router clients plus a cached `Watch` entry not in the router's online snapshot. Its SSDP browser showed Xbox, Archer, and a TV. The TV's SSDP IP/MAC matched the Archer TV row and advertised Roku ECP, Insignia manufacturer/model 5405X, and Roku/15.3.4 in the Server header. The serial number shown there was deliberately not copied. Zeroconf showed no matching services at observation time. The Roku integration was not configured and TV control was not tested. The Matter discovery tile did not identify the Sengled bulb.

The private inventory holds the raw router snapshot and stable device CSV with time-stamped address observations and separate identity provenance. Discovery lists are dynamic: no missing item should be called incompatible merely because it did not appear in this snapshot.
