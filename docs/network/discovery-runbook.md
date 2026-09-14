# Network discovery and Home Assistant reachability runbook

**Status:** initial discovery complete; remediation deferred. No router, firewall, route, VLAN, Proxmox bridge, Tailscale route, or Home Assistant interface change has been made for this work.

## Verified observations

- A Windows client snapshot verified that the HomeLab network and upstream household network use different private IPv4 networks and different gateways.
- Windows client snapshots on the upstream 2.4 GHz and 5 GHz Wi-Fi bands verified matching IPv4 network, prefix length, gateway, DNS configuration, and DHCP state.
- The two upstream bands can therefore be treated as one Layer 3 zone for ordinary address inventory and unicast testing.
- Router-UI inspection verified that intra-BSS traffic blocking is disabled for both bands. Cross-band multicast/broadcast behavior remains `UNKNOWN`, but the radio-frequency split is not currently the leading explanation for failed Home Assistant discovery.
- The upstream gateway operates as a router and had no user-defined static routes. The Archer also separates the HomeLab behind its WAN interface, so the remaining focus is the nested routing/NAT boundary and each integration's protocol.
- From a Windows client on the HomeLab network, the upstream gateway responded to both ICMP and HTTP through the expected HomeLab Wi-Fi route. This verifies outbound unicast reachability from HomeLab to at least the upstream gateway; it does not prove that a particular IoT device accepts connections or that discovery traffic crosses the boundary.
- Archer UI inspection verified router mode, separate upstream and HomeLab `/24` networks, no user-defined static routes, and working stateful outbound routing. IGMP proxy/snooping and wireless multicast forwarding were enabled, but no mDNS or SSDP relay was exposed in the settings search.
- The current router interfaces therefore support ordinary HomeLab-to-upstream unicast but do not provide a verified mechanism for reflecting Home Assistant's link-local discovery protocols across the WAN boundary.
- Raw observations are stored only in ignored `inventory-output/` reports; exact addresses are intentionally absent here.

## Objective

Map the upstream household and HomeLab networks privately, determine how each intended smart device communicates, and give Home Assistant the minimum connectivity each supported integration requires. "A phone app works" is not treated as proof of local cross-network discovery because the app may use a vendor cloud service.

## Information handling

- Keep exact CIDRs, private addresses, gateways, DNS servers, DHCP scopes, device identifiers, and router screenshots in `inventory-output/`, which Git ignores.
- Use [the private map template](../../configs/network-map.example.md) as a local working copy named `inventory-output/network-map.private.md`.
- Never record Wi-Fi passwords, router passwords, tokens, public IP addresses, recovery data, or MAC addresses.
- Promote only roles, trust boundaries, verified capabilities, and sanitized outcomes to [topology.md](topology.md).

## Phase 1: read-only collection

1. From a Windows laptop connected to the HomeLab Wi-Fi, run:

   ```powershell
   .\scripts\collect-windows-network.ps1 -Network homelab |
       Set-Content .\inventory-output\network-homelab.private.txt
   ```

2. Disconnect from the HomeLab Wi-Fi, connect the same laptop to the upstream household 5 GHz Wi-Fi, and run:

   ```powershell
   powershell.exe -NoProfile -ExecutionPolicy Bypass `
       -File .\scripts\collect-windows-network.ps1 -Network upstream-5ghz |
       Set-Content .\inventory-output\network-upstream-5ghz.private.txt
   ```

3. Connect the laptop to the upstream 2.4 GHz Wi-Fi and repeat:

   ```powershell
   powershell.exe -NoProfile -ExecutionPolicy Bypass `
       -File .\scripts\collect-windows-network.ps1 -Network upstream-2.4ghz |
       Set-Content .\inventory-output\network-upstream-2.4ghz.private.txt
   ```

   If the laptop cannot join that band, compare a non-sensitive client entry in the router UI instead. Two SSIDs do not prove two IP networks. Matching CIDR, gateway, and DHCP behavior would support—but not alone prove—that both bands share one LAN. A different CIDR or an isolation/guest policy means they must be treated as separate zones.

4. In each router's management UI, transcribe only the following into the ignored private map:
   - exact model and hardware revision;
   - firmware version;
   - router/access-point operating mode;
   - LAN CIDR, DHCP range, and DNS mode;
   - the Archer WAN's private address and whether it is dynamic or reserved;
   - presence and current state of static-routing, guest/client-isolation, firewall, multicast, IGMP, mDNS, or service-discovery options.
5. Record each intended smart device's brand, exact model, controlling application, network zone, and whether the vendor documents a local Home Assistant integration. Do not record its account or device identifiers.
6. In Home Assistant, inspect the read-only browsers under **Settings > System > Network** for DHCP, Zeroconf, and SSDP. Record only whether the intended device appears and by which discovery method.

The collector uses local Windows tables only. It performs no port scan, public-IP lookup, packet capture, or configuration change.

## Phase 2: classify each integration

Classify every intended device before changing the network:

- **Cloud integration:** Home Assistant connects to the vendor service. Cross-network discovery may be irrelevant, but a scoped credential or OAuth grant may be required in Home Assistant; never store it here.
- **Local unicast:** Home Assistant needs a route and permitted device ports. Automatic discovery may be bypassed by entering a verified private host address if the official integration supports it.
- **Local multicast/broadcast:** mDNS, SSDP, HomeKit, and similar discovery generally require the same broadcast domain or an explicitly supported relay. A unicast route alone is insufficient.
- **Radio-local:** Bluetooth, Zigbee, Z-Wave, Thread, or another radio requires appropriate hardware and placement rather than IP routing.

## Phase 3: choose the least-privilege design

Evaluate solutions in this order:

1. Configure the device's official Home Assistant integration manually when it supports a known host or cloud setup.
2. Move only Home Assistant-managed IoT devices behind the Archer, subject to wireless coverage and isolation requirements.
3. If the routers explicitly support it, design narrowly scoped inter-network routing and firewall rules for the required source, destinations, and ports. Separately confirm whether a supported mDNS/SSDP relay is needed.
4. Consider changing router operating mode or adding a Home Assistant interface only as an architecture decision; either can weaken the existing boundary and requires a rollback plan.

For the verified topology, the preferred paths are:

- **Without additional hardware:** move only the Home Assistant-managed IoT devices behind the Archer and verify that they are not placed in a client-isolated group. This preserves the household/HomeLab router boundary but requires re-onboarding each selected device.
- **Keep IoT on the upstream network:** add a dedicated upstream network interface for the Home Assistant VM through a physically separate Proxmox NIC/bridge, preferably placing only the VM—not the Proxmox host management interface—on that network. This requires hardware/cabling and a separately reviewed Proxmox change.
- **Managed-switch variant:** use an isolated switch VLAN to carry the upstream LAN to a second Home Assistant VM interface while keeping the Proxmox host unnumbered on that segment. This is a proposed architecture only; see [decision 0002](../decisions/0002-home-assistant-upstream-network-access.md). Exact VLAN and port assignments remain `UNKNOWN`.

Do not change the Archer to access-point mode merely to obtain discovery: doing so would collapse the documented HomeLab boundary. Do not dual-home an existing public-facing or general-purpose host as an improvised multicast relay.

Do not use broad port forwarding, DMZ-host mode, UPnP exposure, or an unrestricted allow rule as a discovery fix. Do not expose Home Assistant directly to the internet.

## Change gate and verification

Before any change, record the current setting, exact proposed change, expected effect, security impact, and rollback step. After an owner-approved change, verify:

- Home Assistant reaches only the required device or vendor service;
- the device appears through its expected integration/discovery method;
- control and state updates work in both directions;
- the upstream household network cannot initiate unrelated access to HomeLab management systems;
- Home Assistant, Proxmox, and remote administration remain privately reachable;
- the router configuration backup or rollback procedure is available.

Update this runbook, [Home Assistant](../services/home-assistant.md), [current state](../../CURRENT_STATE.md), and the [roadmap](../../ROADMAP.md) only with observed results.

## Authoritative references

- Home Assistant: [Network configuration](https://www.home-assistant.io/integrations/network), [DHCP discovery](https://www.home-assistant.io/integrations/dhcp/), [Zeroconf/mDNS](https://www.home-assistant.io/integrations/zeroconf), and [SSDP/UPnP](https://www.home-assistant.io/integrations/ssdp).
- Home Assistant OS: [host network configuration](https://developers.home-assistant.io/docs/operating-system/network/).
- Proxmox VE: [Administration Guide](https://pve.proxmox.com/pve-docs/pve-admin-guide.pdf), including host-device and USB passthrough guidance.
- TP-Link: [Archer BE3500 support and version-specific downloads](https://www.tp-link.com/us/support/download/archer-be3500/). Confirm the unit's region and hardware revision before relying on a manual, emulator, or firmware file.
- IETF/RFC Editor: [RFC 6598 shared address space](https://www.rfc-editor.org/info/rfc6598/), used to identify provider-side carrier-grade NAT without publishing the observed address.
