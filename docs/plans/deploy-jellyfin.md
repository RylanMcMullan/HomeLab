# Deploy Jellyfin

**Status:** Planned; not deployed. Depends on suitable media storage under [Establish NAS Storage](establish-nas-storage.md).

## Proposed architecture

- Candidate placements are a dedicated unprivileged Debian LXC using NAS media storage or an isolated NAS-hosted app/VM if the selected NAS supports it. Decide after NAS platform, transcoding, backup, and network capabilities are known.
- Prefer Jellyfin's official Debian/Ubuntu packaging or official container image; do not run an unaudited third-party installer. See the [official Linux installation guide](https://jellyfin.org/docs/general/installation/linux/) and [official container documentation](https://jellyfin.org/docs/general/installation/container/).
- Initial compute recommendation for light use: 2 vCPUs and 2 GiB RAM. Measure playback and transcoding before resizing.
- Keep configuration/cache separate from media data so storage can be migrated later.
- Keep initial access private to the HomeLab and Tailscale. A later browser route on a public-facing domain remains under evaluation; authentication, client behavior, and exposure policy remain `TODO` until the service and storage are tested.
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
- [ ] Backup scope for metadata/configuration is defined.
