# 0004 — Portfolio launch hosting

**Status:** Accepted for a conditional launch; implementation not deployed
**Date:** 2026-10-05

## Context

The operator wants a public portfolio by 2026-10-06 while learning secure Cloudflare Tunnel hosting and later network segmentation. The Portfolio VLAN, router VM, site guest, domain, and tunnel are not deployed. Current Proxmox capacity, backup, and isolation posture require verification.

## Decision

Attempt the first public release from a dedicated Proxmox website guest through Cloudflare Tunnel, using a separate public source repository. Publish only after the [portfolio plan's isolation and recovery gate](../plans/publish-portfolio-website.md#tunnel-first-publication-gate) passes. If the gate cannot pass before the deadline, use Cloudflare Pages for the first public static release and continue the tunnel exercise privately. The public website will not require visitor login; its application surface must remain limited to reviewed content.

Use a custom-domain email mailbox capable of receiving and sending as `mail@<DOMAIN>`; make incoming messages available in the operator's existing Gmail as feasible. Provider selection remains open in the [email plan](../plans/configure-portfolio-email.md).

## Consequences

The tunnel route depends on home power, internet, the HP host, guest, connector, and Cloudflare. Neither the tunnel nor the current shared LAN supplies the planned Portfolio VLAN isolation. The launch gate may force use of Pages to meet the public deadline. The exact domain purchase, billing, content, provider, and launch date remain `TODO` until live checks. Moving the apex between hosting paths requires DNS/route changes and external verification.

## Related documentation

- [Portfolio plan](../plans/publish-portfolio-website.md)
- [Portfolio email plan](../plans/configure-portfolio-email.md)
- [Remote application access plan](../plans/configure-remote-application-access.md)
- [Segmentation decision](0003-segmented-services-and-remote-access.md)
