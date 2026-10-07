# Portfolio VM installation attempt

## Scope

Chronological evidence from the 2026-10-06 through 2026-10-07 attempt to prepare an isolated Debian guest for the planned portfolio website. Private addressing, guest identifiers, credentials, and the intended public domain are intentionally omitted.

## Timeline

### 2026-10-06

- A Debian installation guest was created on the HP Proxmox node with 1 virtual CPU, 2 GiB RAM, and a 16 GiB virtual disk.
- The operator entered the guest account credentials privately.
- Guided whole-disk partitioning and base-system installation completed.
- Optional software installation and GRUB installation failed while the guest lacked usable package-mirror access. The guest was not bootable.

### 2026-10-07

- A temporary host-only Linux bridge was created for the guest. Temporary IPv4 forwarding, source NAT, and nftables restrictions allowed selected public egress while denying the Proxmox host and private network ranges.
- An automatic rollback timer was armed before the temporary network was applied.
- The guest received a static address inside the isolated subnet. Its default route and public DNS resolvers were verified, and a Debian mirror name resolved to a public IPv4 address.
- The initial return-traffic rule was found below a broader guest-bound drop rule. A temporary established/related return rule was inserted before that drop rule. This correction was not persisted.
- Debian mirror scanning succeeded, but repository configuration and software selection still failed. A final GRUB attempt reported that the `grub-pc` package could not be installed. The guest remained unbootable.
- The guest was stopped. The temporary bridge, nftables tables, NAT, and IPv4 forwarding were removed by the rollback script.
- Verification showed the temporary bridge absent, no remaining nftables tables from the attempt, and IPv4 forwarding disabled.
- After the installation was confirmed unbootable, the guest, its virtual disk, and the downloaded installer ISO were deleted. The temporary rollback units and staging files were also removed.

## Result

No website, tunnel, public listener, persistent guest network, or website guest remains deployed. A later attempt should begin with a clean guest and validate package-mirror access before partitioning or account setup. Network segmentation for the website is deferred to the broader HomeLab segmentation project.

The operator judged end-to-end agent execution of interactive VM installation and sensitive host-network configuration to be too error-prone and disproportionately expensive in time and agent usage for this environment. Future sensitive infrastructure setup remains a human-operated task with agents providing decision support, read-only observation, command and rollback preparation, review, and documentation unless a specific bounded change is explicitly assigned. The reusable policy is recorded in [Human and agent operating boundary](../reference/human-agent-operating-boundary.md).
