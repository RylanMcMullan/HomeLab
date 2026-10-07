# 0004 — Portfolio launch hosting

**Status:** Accepted for a conditional launch; implementation not deployed
**Date:** 2026-10-05

**2026-10-06 scope update:** The operator prioritizes a functional public site and two-way domain email now. VM backup, independent recovery, and monitoring are deferred to the NAS setup. This supersedes the recovery part of the original publication gate below; the guest and connector isolation checks still apply. Site source remains in a separate repository.

**2026-10-06 email update:** The operator wants a separate professional inbox accessible in Outlook. The prior Gmail destination preference below is superseded. The apparent Google Workspace selection was accidental; provider selection remains open in the [email plan](../plans/configure-portfolio-email.md).

**2026-10-06 provider update:** After comparing price and Outlook compatibility, the operator chose Zoho Mail Lite 5 GB for ordinary professional correspondence, pending domain registration, checkout, and testing. This supersedes the provider-open portion of the preceding update. The mailbox is not yet deployed.

**2026-10-06 recovery and sequencing update:** The operator later requested independent monitoring and remote recovery before the rack becomes inaccessible. This supersedes the earlier blanket deferral of those tasks to NAS delivery; [decision 0005](0005-independent-management-recovery.md) defines the target. VM backup remains deferred. Website publication is the immediate priority, while two-way email is optional for the first release. The GitHub Student Developer Pack may support development or a static fallback, but does not change the tunnel-first preference or the selected domain extension.

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
