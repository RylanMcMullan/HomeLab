# Network

The primary network record is [Topology and components](topology.md). It describes the upstream household gateway, HomeLab boundary router, and managed switch without inventing addressing, VLANs, or port maps.

The accepted but undeployed [network-segmentation plan](../plans/segment-homelab-network.md) records theoretical segment IDs, candidate switch port roles, and verification gates. Do not treat it as the active switch configuration.

| Topic | Authoritative record |
| --- | --- |
| Household-to-HomeLab boundary | [Topology](topology.md#network-boundary) |
| HomeLab router | [Topology](topology.md#tp-link-archer-be3500) |
| Managed switch | [Topology](topology.md#tp-link-tl-sg108pe-managed-switch) |
| Remote access | [Tailscale service](../services/tailscale.md) |
| Private addressing capture and cross-network discovery | [Network discovery procedure](../reference/network-discovery.md) and [dated history](../history/network-discovery.md) |

Exact addressing belongs only in the ignored private-map copy described by the runbook. This public directory records topology, trust boundaries, and verified behavior without publishing a reconnaissance-ready device map.
