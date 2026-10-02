# Deploy Jellyfin

**Status:** Planned; not deployed. Depends on suitable media storage under [Establish NAS Storage](establish-nas-storage.md).

## Proposed architecture

- Candidate placements are a dedicated unprivileged Debian LXC using NAS media storage or an isolated NAS-hosted app/VM if the selected NAS supports it. Decide after NAS platform, transcoding, backup, and network capabilities are known.
- Prefer Jellyfin's official Debian/Ubuntu packaging or official container image; do not run an unaudited third-party installer. See the [official Linux installation guide](https://jellyfin.org/docs/general/installation/linux/) and [official container documentation](https://jellyfin.org/docs/general/installation/container/).
- Initial compute recommendation for light use: 2 vCPUs and 2 GiB RAM. Measure playback and transcoding before resizing.
- Keep configuration/cache separate from media data so storage can be migrated later.
- Keep initial access private to the HomeLab and Tailscale while storage, isolation, and recovery are tested. The owner later wants browser and native-client access without a VPN on those devices. Strong MFA is required for Nextcloud and Bitwarden; Jellyfin may use its own account authentication without MFA, provided its service and storage are isolated, the public route uses HTTPS, account lockout and access revocation are tested, and NAS management remains private. A browser-only Cloudflare Access challenge may block Roku. [Cloudflare's Tunnel FAQ](https://developers.cloudflare.com/cloudflare-one/faq/cloudflare-tunnels-faq/#large-file-and-streaming-traffic-through-tunnel) says public hostname routes for video and other large files on Free, Pro, and Business plans require an applicable paid service.
- The [remote-access plan](configure-remote-application-access.md) favors a public HTTPS VPS reverse proxy with a private origin link and DNS-only media record as the candidate that can carry Jellyfin traffic to Roku without a client VPN or Cloudflare video proxy. This is a design, not an implemented or tested route. Jellyfin's [official Roku client supports Quick Connect login](https://jellyfin.org/docs/general/server/quick-connect/) approved from an already authenticated device. Use a strong unique password for each relevant Jellyfin account, limit public account privileges, and verify failed-login lockout and device revocation. A third-party MFA plugin is optional rather than a publication gate.
- The planned NAS is the likely durable media source after capacity and permissions are verified. Its application host, network segment, any cross-VLAN media path, and public route remain `TODO`.

## Storage and transcoding constraints

- Media source, library size, growth rate, and backup expectations are `UNKNOWN`.
- The [HP EliteDesk](../hosts/hp-elitedesk.md) had internal-only storage at last verification. A small trial library may be possible; durable media capacity requires a separate storage decision.
- The host's Intel UHD Graphics 630 may be useful for Quick Sync/VA-API transcoding, but LXC device access and codec support must be verified before claiming hardware acceleration. See [Jellyfin Intel GPU guidance](https://jellyfin.org/docs/general/post-install/transcoding/hardware-acceleration/intel/).
- Initial deployment should favor direct play; transcoding demand, simultaneous streams, client formats, and remote-streaming requirements are `UNKNOWN`.

## Verification checklist

- [ ] Persistent configuration and cache locations are documented.
- [ ] Media storage and permissions are verified without exposing private paths publicly.
- [ ] Direct-play test succeeds from intended clients.
- [ ] Hardware transcoding is either tested successfully or explicitly left disabled.
- [ ] Before any public route, verify its streaming terms, HTTPS, browser and native clients, service isolation, account access controls, and denied public NAS management.
- [ ] Test public HTTPS playback and sign-in on the actual Roku and a phone from an external network, including account lockout, device revocation, and proxy failure behavior.
- [ ] Backup scope for metadata/configuration is defined.
