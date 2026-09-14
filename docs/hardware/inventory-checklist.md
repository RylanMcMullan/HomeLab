# HomeLab inventory checklist

This checklist captures the information needed for sound container sizing, operating-system choices, local AI recommendations, capacity planning, and future projects. It is a discovery guide, not evidence that any item is deployed.

## Handling collected data

- Keep raw output private. It may contain hostnames, private addresses, MAC addresses, serial numbers, usernames, mount paths, tunnel details, or other sensitive values.
- Add only reviewed summaries to the relevant host, hardware, service, or network document.
- Replace sensitive identifiers with role-based descriptions or placeholders.
- Never collect or paste passwords, tokens, cookies, private keys, or credential files.
- Record the collection date and whether a fact was command-verified or owner-reported.

## Per physical host

- Exact manufacturer/model and CPU model, core/thread count, virtualization features, and architecture.
- Installed RAM, module arrangement, free slots, supported maximum, and typical utilization.
- Storage devices, capacities, media type, filesystem, mount purpose, free space, and health status. Omit serial numbers.
- GPU model, VRAM, driver/runtime compatibility, and whether the GPU is available to the intended workload.
- Network interface capabilities and negotiated link speed without publishing MAC or IP addresses.
- BIOS/UEFI and firmware update posture, cooling/temperature behavior, power constraints, and UPS coverage.
- Operating system/hypervisor and kernel versions, update posture, uptime expectations, and reboot tolerance.

## Proxmox node

- Proxmox VE and kernel versions; standalone or clustered status.
- CPU, memory, storage-pool capacity/utilization, and storage health.
- VM/LXC count and each guest's role, OS, vCPU, RAM, disk allocation, autostart, and current utilization.
- Whether containers are privileged, whether hardware passthrough is used, and any resource limits.
- Backup targets, schedule, retention, last successful restore test, and current monitoring/alerting.
- Normal and peak host utilization before assigning resources to another workload.

Do not publish guest IDs, hostnames, addresses, bridge details, or storage identifiers unless the owner explicitly approves them for public disclosure.

## Raspberry Pi / Minecraft

- Distribution, release, kernel, Java version, and Minecraft server implementation/version.
- Service-management method (for example systemd or a container runtime), without copying command lines that may contain tokens.
- JVM minimum/maximum heap, player count and concurrency expectations, mod/plugin count, world size, view/simulation distances, and observed CPU/RAM usage under load.
- SSD capacity, free space, filesystem, health indicators where supported, and whether USB boot is configured redundantly.
- Backup frequency, retention, off-device copy, restore procedure, and last restore test.
- playit.gg client update/health method without recording the public endpoint, tunnel ID, or credentials.

## AI node planning

- Exact CPU model, installed/maximum RAM, storage health/free capacity, and sustained temperature/power behavior.
- Exact GPU PCI identity, usable VRAM, supported NVIDIA driver/CUDA versions, and whether display use also consumes VRAM.
- Intended workloads: chat, coding, document retrieval, image generation, speech, automation, or experimentation.
- Required context length, acceptable latency, expected concurrent users, model-quality target, and whether CPU offload is acceptable.
- Desired management style: desktop, headless server, containers, virtual machines, or direct package installation.
- Availability, noise, energy-budget, remote-management, backup, and recovery requirements.

## Network and service planning

- Internet upload/download characteristics and whether the HomeLab is behind double NAT or CGNAT. Do not publish the public IP.
- Logical trust zones, desired isolation, router/switch VLAN capabilities, Wi-Fi needs, wired link speeds, and PoE requirements.
- DNS, DHCP, time synchronization, certificate, reverse-proxy, identity/access, monitoring, logging, and backup strategies.
- For each proposed service: users, exposure (internal/remote/public), data sensitivity, storage growth, recovery objective, maintenance owner, dependencies, and resource profile.

## Safe collection helper

The read-only [Linux inventory collector](../../scripts/collect-linux-inventory.sh) and [Windows inventory collector](../../scripts/collect-windows-inventory.ps1) gather a starting point without intentionally collecting IP addresses, MAC addresses, serial numbers, credential files, or application command lines. Their output must still be reviewed before publication.
