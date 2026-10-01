# Network Discovery Procedure

**Scope:** owner-controlled HomeLab clients and approved interfaces only. This is a reusable, read-only inventory procedure, not evidence that a device is compatible or currently online. Dated findings are in [network-discovery history](../history/network-discovery.md) and [device-inventory history](../history/device-inventory.md). Current configuration is in [topology](../network/topology.md).

## Private output

Set `HOMELAB_PRIVATE_ROOT` to the approved private directory outside the GitHub checkout. On this workstation that directory is `C:\Projects\Personal\PrivateResources\HomeLab`. Store inventories beneath its `inventory` child. Do not put raw output, screenshots, captures, IP/MAC tables, serials, account IDs, or credentials in this public repository. The [network map template](templates/network-map.example.md) and [IoT CSV schema](templates/iot-inventory.example.csv) are empty starting points; filled copies are private. A private directory is not a secret manager—never place passwords, tokens, pairing codes, private keys, or recovery material in general inventory files.

## Passive collection

1. On the trusted workstation, confirm the active interface and intended HomeLab LAN. The read-only `scripts/collect-windows-network.ps1 -Network homelab` prints local IPv4, route, DNS, and neighbor information; it does not discover every device. Redirect its output only to the approved private directory.
2. In the Archer management UI, save a dated client-list observation privately: router label, interface/band, private IP, MAC, and online state. Note reservation/static status if shown. Router labels are metadata, not independent manufacturer evidence. Do not change settings or export full router configuration merely for inventory.
   For network capability inventory, record the router's exact model/revision, firmware, mode, LAN CIDR, DHCP/DNS settings, private WAN address/source, and the observed state of routing, isolation, firewall, multicast, IGMP, mDNS, and SSDP controls in the private network map. Keep the current public summary in [topology](../network/topology.md).
3. For one physical device, inspect the package/label and app information screen. Match a documented app MAC or equivalent identifier to a router row, allowing for multiple radios/MACs. Record brand/model/SKU, hardware/firmware/software versions, app, connection type, source, and observation date. Mark ambiguous matches `unconfirmed` and absent fields `UNKNOWN`. An IP is a time-stamped observation, not an identity.
4. In Home Assistant, inspect **Settings > Devices & services** and device/entity pages. Record integration, discovery method, device association, and tested control/state behavior separately. A Matter or Tuya discovery tile does not identify a particular device. Do not pair, reset, install an integration, or create a credential during read-only inventory.
5. Reconcile physical units, router rows, and Home Assistant records. Investigate unmatched entries through approved UI/app sources before assigning identity. Keep exact identifiers in the private CSV, with source/confidence and observation time; publish only sanitized conclusions.

The Windows workstation's existing neighbor cache may provide a limited cross-check:

```powershell
if (-not $env:HOMELAB_PRIVATE_ROOT) { throw 'Set HOMELAB_PRIVATE_ROOT to the approved private directory first.' }
$privateInventory = Join-Path $env:HOMELAB_PRIVATE_ROOT 'inventory'
if (-not (Test-Path -LiteralPath $privateInventory)) { throw 'The approved private inventory directory does not exist.' }
Get-NetNeighbor -AddressFamily IPv4 |
  Where-Object { $_.State -notin @('Unreachable', 'Permanent') } |
  Select-Object IPAddress, LinkLayerAddress, InterfaceAlias, State |
  Export-Csv (Join-Path $privateInventory 'neighbors-homelab.private.csv') -NoTypeInformation
```

This reads existing cache entries only, is not a scan, and is not a complete client list. The [Windows collector](../../scripts/collect-windows-network.ps1) similarly reads local tables without an active scan. The historical three-network comparison and its results are preserved in [network-discovery history](../history/network-discovery.md); do not move a laptop onto the household LAN merely to repeat it.

## Connection-method classification

| Method | What to verify |
| --- | --- |
| Vendor cloud | Account/OAuth/API grant scope and remote service dependency; same-LAN discovery may not matter |
| Local unicast | Approved route and required device ports; manually supplied host address only if the documented integration supports it |
| Local multicast/broadcast | Same discovery domain or a separately reviewed relay for mDNS, SSDP, HomeKit, and similar protocols |
| Radio-local | Appropriate Bluetooth, Zigbee, Z-Wave, Thread, or other hardware and device support |

A working phone app may use a vendor cloud and does not prove local Home Assistant control. Wireshark is a later, separately approved diagnostic for one identified device: define interface, device, duration, filter, retention, and the expected privacy impact first. A normal laptop capture on switched Ethernet or associated Wi-Fi is not a complete LAN inventory; TLS may hide payloads, while captures can expose identifiers or authentication material. Keep captures private and do not capture the upstream household network without explicit scope. See Wireshark's [capture setup](https://wiki.wireshark.org/CaptureSetup) and [WLAN limitations](https://wiki.wireshark.org/CaptureSetup/WLAN).

Ask for approval before any active ping sweep, port scan, packet capture, login, pairing reset, API-key creation, or router/security-setting change. Any configuration change needs a recorded prior setting, expected effect, rollback, and verification. The implementation gates are in [Onboard Home Assistant](../plans/onboard-home-assistant.md) and [Segment HomeLab Network](../plans/segment-homelab-network.md).
