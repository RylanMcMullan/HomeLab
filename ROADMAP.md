# Roadmap

> This file tracks intended, incomplete, blocked, and completed work. An unchecked item is **not deployed**. A checked deployed item must be corroborated by current-state documentation and, when significant, `CHANGELOG.md`.

## In progress

- [ ] Establish this repository as the HomeLab source of truth.
- [ ] Complete a verified inventory of existing HomeLab infrastructure.

## Planned

- [ ] Prepare the Acer Nitro 5 (AN515-54) for local AI inference.
  - [ ] Select and install an appropriate Linux or server operating system.
  - [ ] Determine the suitable local AI runtime and models for its hardware.
  - [ ] Upgrade memory, planned up to 32 GB RAM.
  - [ ] Verify host, runtime, model(s), network configuration, and operating status before adding them to current state.
- [ ] Deploy a portfolio website in an appropriate Proxmox container.
  - [ ] Define hosting, service, and maintenance requirements.
  - [ ] Record container details only after deployment is verified.
- [ ] Expose the portfolio website securely using Cloudflare Tunnel.
  - [ ] Create and configure the tunnel after the website exists.
  - [ ] Document the public design without recording Cloudflare credentials or tunnel tokens.
- [ ] Continue documenting infrastructure changes as they are deployed.

## Blocked

No current blockers documented.

## Completed

- [x] Initial HomeLab baseline information was provided for this documentation bootstrap.

## Roadmap maintenance

When an item is deployed, update its checkbox and scope here, update [CURRENT_STATE.md](CURRENT_STATE.md), update detailed documentation, and add a [CHANGELOG.md](CHANGELOG.md) entry if significant. If work is abandoned or blocked, retain a short explanation rather than silently removing it.
