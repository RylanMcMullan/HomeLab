# Evaluate Optional Home Assistant Devices

**Status:** Deferred until room devices and the network security baseline work. These integrations are optional, not part of the guaranteed near-term schedule.

**Parent / related plan:** [Onboard Home Assistant](onboard-home-assistant.md). Current configured integrations are in [Home Assistant](../services/home-assistant.md); dated discovery is in [device-inventory history](../history/device-inventory.md).

| Candidate | Known evidence | Possible integration | Remaining decision or test |
| --- | --- | --- | --- |
| Xbox Series X | Its Home Assistant integration and device record exist; entities were visible, but control was not tested. | Built-in [Xbox](https://www.home-assistant.io/integrations/xbox/) supports Series X status, media, and remote control through Xbox Network. | Adult Xbox account, cloud connectivity, and Remote Features are required for remote/media entities. Wake from energy-saving shutdown is unsupported; sleep has a power cost. Inventory entities and test commands only when scheduled. |
| Roku TV | Archer `TV` row matched SSDP advertising Roku ECP, Insignia model 5405X, and Roku/15.3.4; physical label unchecked. | Built-in [Roku](https://www.home-assistant.io/integrations/roku/) supports media status, remote commands, app launch, and TV-specific controls where available. | Local discovery was verified, but Roku integration was not configured and control was not tested. Check physical model and network-control setting. |
| Roku Stick 4K | Exact model and network placement `UNKNOWN`. | Built-in Roku integration is a candidate. | Match the physical unit to a network client and verify its own model and software; do not assume the TV's discovery represents the Stick. |
| Amazon Echo Dot | Generation `UNKNOWN`; the router alias `Alexa` is not a verified model. | Built-in [Alexa Devices](https://www.home-assistant.io/integrations/alexa_devices/) supports selected Echo media, announcements, routines, and sensors. | Requires Amazon authentication with app-based MFA; cloud and rate limits apply. Exposing Home Assistant entities for voice commands is a separate decision. |
| Spotify account | Subscription tier and playback target `UNKNOWN`. | Built-in [Spotify](https://www.home-assistant.io/integrations/spotify/) can control playback and browse media. | Requires Premium, developer-app/OAuth credentials, and a compatible known playback device. Keep credentials private. |

For each selected device, collect its brand/model, hardware/firmware/software version, app and access method immediately before setup. Keep MACs, IPs, account IDs, serials, and pairing codes outside Git. Verify control and state feedback before marking an integration complete.
