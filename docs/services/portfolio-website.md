# Portfolio website

**Status:** planned; not deployed.

The intended project is a portfolio website hosted in a dedicated Proxmox guest on its own planned Portfolio VLAN. The website is intended to be public at the owner's domain apex through Cloudflare Tunnel and will not require a visitor login. Its guest and tunnel connector must have no general route to Lab management, IoT devices, Nextcloud, or the future password manager. Administration remains on an approved private Lab path.

Guest type, ID, operating system, web stack, exact domain, source location, tunnel connector, backup strategy, monitoring, and publication date remain `TODO` until designed and verified. See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md).

The work is tracked in [ROADMAP.md](../../ROADMAP.md). Do not represent this service as operational in current-state documentation before verification.
