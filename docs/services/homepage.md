# Homepage

**Status:** planned private service; not deployed or verified.

## Purpose

Provide a private dashboard for links and selected status information from HomeLab services such as Proxmox, Home Assistant, Minecraft, and Uptime Kuma.

## Proposed architecture

- Deploy after the initial Home Assistant, router-VM/VLAN, and Minecraft inventory work; the Acer AI conversion is later.
- Consider sharing a small private Debian utility guest with [Uptime Kuma](uptime-kuma.md); dedicated versus shared guest remains `UNKNOWN` until selected.
- Use an installation method from the [official Homepage documentation](https://gethomepage.dev/installation/).
- Keep the dashboard private to authorized Lab and Tailscale clients. [MagicDNS](https://tailscale.com/docs/features/magicdns) or [Tailscale Serve](https://tailscale.com/docs/features/tailscale-serve) can provide named tailnet access after route, grant, and DNS verification. The owner's custom domain would require a separate private DNS/TLS design; a public DNS record alone does not make the dashboard private.
- Place it in the planned Lab management VLAN. Add cross-VLAN widgets only through narrowly scoped, read-only API identities and allow only their required destinations and ports. See [decision 0003](../decisions/0003-segmented-services-and-remote-access.md).
- Begin with links that require no API credentials. Add widgets only when their permissions and secret-storage method have been reviewed.
- Link to the separately authenticated Minecraft management panel after its migration is verified; Homepage is not the panel itself.

## Security and verification

- Never commit widget API keys, service credentials, private URLs, internal addresses, or authentication headers.
- Treat a dashboard inventory as sensitive because it maps administrative services, even when it contains no passwords.
- [ ] Deployment guest and runtime are documented.
- [ ] Configuration persistence and backup scope are documented.
- [ ] Private access is verified.
- [ ] Links and optional widgets are tested without placing secrets in this repository.
- [ ] Approved cross-VLAN widgets work without broad access to their service VLANs.
- [ ] Resource use is measured before resizing.
