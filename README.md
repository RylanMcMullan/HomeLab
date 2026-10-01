```text
 ____             ___                     __             __                __
/\  _`\          /\_ \                   /\ \           /\ \              /\ \
\ \ \L\ \  __  __\//\ \      __      ___ \ \/    ____   \ \ \         __  \ \ \____
 \ \ ,  / /\ \/\ \ \ \ \   /'__`\  /' _ `\\/    /',__\   \ \ \  __  /'__`\ \ \ '__`\
  \ \ \\ \\ \ \_\ \ \_\ \_/\ \L\.\_/\ \/\ \    /\__, `\   \ \ \L\ \/\ \L\.\_\ \ \L\ \
   \ \_\ \_\/`____ \/\____\ \__/.\_\ \_\ \_\   \/\____/    \ \____/\ \__/.\_\\ \_,__/
    \/_/\/ /`/___/> \/____/\/__/\/_/\/_/\/_/    \/___/      \/___/  \/__/\/_/ \/___/
               /\___/
               \/__/
```

# HomeLab

A documentation-first personal infrastructure lab built around virtualization, secure remote access, home automation, self-hosted services, local AI, and authorized security research.

This public repository is the canonical source of truth for the lab. It separates deployed systems from future work, records the evidence behind infrastructure claims, and gives future human and AI contributors a safe operating model.

## Current highlights

- Proxmox VE virtualization on an HP EliteDesk with documented CPU, memory, storage, and guest allocations.
- Home Assistant OS running in a dedicated Proxmox VM, installed from a checksum-verified official image.
- Tailscale subnet routing in a lightweight LXC for private remote administration.
- A Raspberry Pi 5 hosting a public Minecraft Java server through playit.gg while administration remains private.
- A layered household/HomeLab network boundary using Zyxel and TP-Link routing with a managed TP-Link switch.

The active work is Home Assistant room-device onboarding, followed by staged network segmentation and Minecraft hardening. The Acer AI conversion is deferred. See the [roadmap](ROADMAP.md) for status and dependencies.

## Repository model

| Record | Authority |
| --- | --- |
| [Current state](CURRENT_STATE.md) | Infrastructure deployed and operational |
| [Roadmap](ROADMAP.md) | Broad progress checkboxes linked to stable plans |
| [Changelog](CHANGELOG.md) | Significant infrastructure changes that already occurred |
| [Architecture decisions](docs/decisions/README.md) | Durable technical choices and their trade-offs |
| [History](docs/history/README.md) | Detailed dated observations and prior configurations |
| [Agent guide](AGENTS.md) | Required workflow for future human and AI contributors |
| [Security policy](SECURITY.md) | Public-repository threat model and secret-handling requirements |

## Documentation map

- [Architecture](docs/architecture/README.md) — boundaries, service paths, and storage planning.
- [Hosts](docs/hosts/README.md) — physical inventory, hardware capabilities, and installed platforms.
- [Services](docs/services/README.md) — workloads, exposure, and administration paths.
- [Network](docs/network/README.md) — gateways, routing boundary, switch, and topology.
- [Plans](docs/plans/README.md) — one stable file per planned objective.
- [Reference](docs/reference/README.md) — terminology, documentation model, inventory guidance, and safe templates.
- [Scripts](scripts/README.md) — reviewed discovery tools.

## Evidence and status language

- **Deployed:** running and believed operational from reported or directly verified evidence.
- **Verified:** directly observed through a documented command or test.
- **Reported:** supplied by the operator but not independently tested.
- **Planned:** intended work only; never evidence of deployment.
- **UNKNOWN / TODO:** absent, unresolved, or awaiting verification.

The repository intentionally excludes credentials, tokens, private addresses, hostnames, device identifiers, raw output, and live secret-bearing configuration. The private reference directory is outside this checkout; a secret manager will be selected when needed. Refer to [SECURITY.md](SECURITY.md) before publishing operational details.
