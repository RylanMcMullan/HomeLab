# Network

The primary network record is [Topology and components](topology.md). It describes the upstream household gateway, HomeLab boundary router, and managed switch without inventing addressing, VLANs, or port maps.

The accepted but undeployed [VLAN and firewall worksheet](segmentation-plan.md) records theoretical segment IDs, candidate switch port roles, and verification gates. Do not treat it as the active switch configuration.

| Topic | Authoritative record |
| --- | --- |
| Household-to-HomeLab boundary | [Topology](topology.md#network-boundary) |
| HomeLab router | [Topology](topology.md#homelab-router) |
| Managed switch | [Topology](topology.md#managed-switch) |
| Remote access | [Tailscale service](../services/tailscale.md) |
| Private addressing capture and cross-network discovery | [Network discovery runbook](discovery-runbook.md) |

Exact addressing belongs only in the ignored private-map copy described by the runbook. This public directory records topology, trust boundaries, and verified behavior without publishing a reconnaissance-ready device map.
