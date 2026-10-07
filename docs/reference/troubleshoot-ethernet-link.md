# Troubleshoot an Ethernet Link

**Scope:** a HomeLab device that is unreachable, drops offline, or negotiates below its expected wired speed. This is a reusable procedure, not a record of current switch configuration. The [HP Ethernet incident](../history/incidents/2026-10-06-hp-ethernet-link.md) is the worked example. Save raw output and exact identifiers outside this public repository.

## Establish the symptom

1. Note the observation time, affected device, expected speed, switch port, and full path from device to switch, including patch cables, wall jacks, patch panel, and couplers. Check whether other devices on the same switch are working. A switch LED must be interpreted using that model's legend; cable category and a product's advertised rate do not prove the negotiated rate.
2. Read the negotiated speed, duplex, autonegotiation, and link state on the affected host. On Linux, use `ethtool <INTERFACE>`; on Windows, inspect **Settings > Network & internet > Ethernet** or `Get-NetAdapter`. Compare the host result with the switch port's reported state. Record both as dated observations, without publishing addresses or MACs.
3. Check link drops and errors. On Linux, inspect `ethtool -S <INTERFACE>` for driver-supported error, CRC, and timeout counters, and `journalctl -k -b` for current-boot NIC/link events. If investigating an outage followed by reboot, also inspect `journalctl -k -b -1`. Counters reset on reboot and names vary by driver. A short ping can test reachability, but cannot establish link speed or sustained stability.

## Isolate the physical path

Change **one connection at a time**, allowing for a brief management interruption. Confirm the new speed after each step.

1. Use a known-good cable directly between the device and a known-good switch port. If this reaches the expected speed, the device NIC and that switch port can negotiate it under the test conditions.
2. Test the original switch port with the same known-good direct cable. Then test the original cable directly. This separates a port problem from a cable problem.
3. Reintroduce the path one segment at a time: short patch cable, coupler or panel termination, then the longer cable. Fully seat both coupler ends and check for strain, damaged latches, or a loose termination. Retest with another device if available. A change from 100 Mb/s to 1 Gb/s after a reseat supports a contact or termination problem at that junction; it does not by itself prove a cable or port is defective.
4. Restore the intended port arrangement, then recheck every displaced device's link and reachability. Record the final map with **reported** versus **command-verified** labels.

Gigabit copper links require all four twisted pairs to work correctly; a marginal connector can leave a link operating at 100 Mb/s. Do not force the NIC to 1 Gb/s or disable autonegotiation to conceal a physical fault. Replace a suspect cable or coupler only after the segment tests identify it, then repeat the direct and full-path checks.

## If the physical link is sound

Compare errors and link events across current and previous boots. Check the NIC model, driver, firmware, and kernel before applying a vendor-supported update or a reversible driver workaround. Record the prior setting, exact command, verification, and rollback in dated history. A software mitigation and a cable repair applied close together cannot establish which one stopped earlier hangs. Observe the link over normal use and, when a reboot is acceptable, verify that any persistent mitigation runs after boot. Keep public-service publication gated on the required isolation and stability checks in its plan.

## Record the outcome

Put the current port/cable state in [network topology](../network/topology.md), the dated test sequence and prior states in [network history](../history/network-discovery.md), and host-specific NIC facts in the host and service records. Keep raw logs, addresses, MACs, screenshots, and switch exports in the approved private reference location. State what was **verified**, **reported**, and still **UNKNOWN**.
