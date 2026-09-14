# Homepage

**Status:** planned private service; not deployed or verified.

## Purpose

Provide a private dashboard for links and selected status information from HomeLab services such as Proxmox, Home Assistant, Minecraft, and Uptime Kuma.

## Proposed architecture

- Deploy after the higher-priority AI-node migration or when the owner reprioritizes it.
- Consider sharing a small private Debian utility guest with [Uptime Kuma](uptime-kuma.md); dedicated versus shared guest remains `UNKNOWN` until selected.
- Use an installation method from the [official Homepage documentation](https://gethomepage.dev/installation/).
- Keep the dashboard private to the HomeLab and/or Tailscale.
- Begin with links that require no API credentials. Add widgets only when their permissions and secret-storage method have been reviewed.

## Security and verification

- Never commit widget API keys, service credentials, private URLs, internal addresses, or authentication headers.
- Treat a dashboard inventory as sensitive because it maps administrative services, even when it contains no passwords.
- [ ] Deployment guest and runtime are documented.
- [ ] Configuration persistence and backup scope are documented.
- [ ] Private access is verified.
- [ ] Links and optional widgets are tested without placing secrets in this repository.
- [ ] Resource use is measured before resizing.
