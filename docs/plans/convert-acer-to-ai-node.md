# Convert Acer to AI Node

**Status:** Deferred. Hardware inventory is complete, but selected Windows files still need preservation and verification before installation. No Linux operating system, runtime, model, web interface, or automation framework has been selected or installed.

**Parent / related plans:** [Segment HomeLab Network](segment-homelab-network.md) establishes the private management path; [Establish NAS Storage](establish-nas-storage.md) may later provide AI data storage. The Acer remains a separate compute device.

## Intended service profile

- Host: [Acer Nitro 5 AN515-54](../hosts/acer-nitro-5.md).
- Availability: dedicated 24/7 node with a lightweight local graphical session.
- Interfaces: local browser, private web interface, SSH administration, and an API for future integrations.
- Local management browser: router, Proxmox, Home Assistant, and other management interfaces.
- Closed-lid operation: turn off the built-in display without unintended suspend; verify airflow and sustained temperatures before continuous inference.
- Network target: the Acer is reported on wired switch port 3, proposed as an untagged Lab VLAN 20 access port. That placement separates the host from the Archer/IoT VLAN. For the initial network rollout, treat it only as a Lab node. Decide any AI chat access from other VLANs when the service is hosted; no such firewall exception is selected yet.
- Users: primarily the owner, with at most two or three users; up to approximately three owner-initiated processes.
- Priorities: model quality first, then useful interactive response speed.
- Initial workloads: light coding, automation, and cybersecurity research assistance.
- Future workloads: smart-home assistance and Raspberry Pi-connected audio, camera, and physical I/O.
- The two installed internal drives may be erased only after selected personal files have been preserved and opened from the backup copy.

## Capacity constraints

- The NVIDIA GeForce GTX 1650 was command-verified with 4 GiB VRAM and CUDA compute capability 7.5. Linux driver behavior and usable VRAM under the intended graphical workload remain `TODO`.
- The current 8 GB system RAM is restrictive for larger models, long contexts, and concurrent requests. An upgrade up to 32 GB is planned but not installed.
- The installed system SSD is only 128 GB-class, not the previously reported 256 GB. The 1 TB-class HDD can hold model files and bulk data, but its slower loading performance and backup role must be considered.
- Model size, quantization, context length, GPU offload, throughput, and concurrency must be selected from measured benchmarks on this host. Do not claim a model fits or performs adequately before testing it.
- Initial concurrency should be conservative; simultaneous contexts can increase memory demand substantially even when model weights are shared.

## Candidate platform shape

These are candidates, not decisions:

- A lightweight Ubuntu-family LTS desktop is the leading OS direction because the node must be both a server and a locally usable management station. Xubuntu 26.04 LTS offers an Xfce desktop and was documented with support through April 2029; final selection awaits an updated compatibility and installer/driver review. See the [official Xubuntu release record](https://xubuntu.org/release/26.04/).
- Ollama is a candidate inference manager with a local API. Its current hardware documentation supports NVIDIA GPUs with compute capability 5.0 or newer subject to driver requirements; the Acer's exact compatibility must be verified. See [Ollama hardware support](https://docs.ollama.com/gpu).
- `llama.cpp` is a candidate when lower-level control over quantization, GPU-layer offload, context, and an OpenAI-compatible local server is valuable. See its [official CUDA build documentation](https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md).
- Open WebUI is a candidate multi-user browser interface compatible with Ollama and OpenAI-compatible APIs. See [Open WebUI documentation](https://docs.openwebui.com/).

Specific model families and quantizations remain `TODO` until current candidates are evaluated and benchmarked on the Linux installation.

## Security boundaries for future agentic use

- Keep the inference API and host management interfaces on the private Lab path. When the AI service is hosted, decide whether a distinct authenticated chat-UI route for other clients is needed; a public Cloudflare route has not been approved. See the [segmentation decision](../decisions/0003-segmented-services-and-remote-access.md).
- Separate research/chat capability from device actuation. The model should not receive unrestricted router, hypervisor, Home Assistant, camera, lock, alarm, or network-administration credentials.
- Use a dedicated integration identity, least-privilege permissions, action allowlists, validation, audit logs, and explicit human approval for consequential actions.
- Start Home Assistant integration read-only. Add narrowly scoped actions only after threat modeling and testing.
- Keep tokens outside prompts, model context, chat logs, source control, and repository-managed configuration. Home Assistant's REST API uses bearer tokens, which must remain in private secret storage. See the [Home Assistant REST API documentation](https://developers.home-assistant.io/docs/api/rest/).
- Define retention and consent rules before storing microphone audio, camera imagery, transcripts, or observations about household members and guests.

## Verification gates

- [x] Collect and sanitize the Acer pre-install inventory.
- [ ] Confirm backup completeness and recovery information before erasing disks.
- [ ] Select the Linux distribution and document the decision.
- [ ] Verify NVIDIA driver and GPU compute support.
- [ ] Install and benchmark candidate runtime/model combinations.
- [ ] Select model, quantization, context limit, and concurrency from measured results.
- [ ] Configure lid/display behavior without suspending the 24/7 service unintentionally.
- [ ] Measure sustained CPU/GPU temperatures and verify unobstructed airflow before approving closed-lid inference.
- [ ] Restrict and verify local/Tailscale access before enabling integrations.
- [ ] At AI deployment, decide and test any approved non-Tailscale chat access while denying unrelated Lab and inference endpoints.

## Pre-install file-preservation procedure

Before erasing either drive, review both the Windows system drive and the secondary drive. The 2026-09-14 storage snapshot and media-size mismatch are preserved in [Acer pre-install history](../history/acer-preinstall.md). Use the read-only [Windows backup audit](../../scripts/audit-windows-backup.ps1) to measure common locations and identify non-standard top-level folders. Raw reports can expose personal paths and belong in the private reference directory.

- Review `%USERPROFILE%\Desktop`, `Documents`, `Downloads`, `Pictures`, `Videos`, `Music`, and `Saved Games`, plus OneDrive equivalents. Confirm Files On-Demand items are actually downloaded or synchronized before relying on a removable copy.
- Review selected `%APPDATA%` and `%LOCALAPPDATA%` data: browser profiles, editor settings, game saves, and application databases. Do not blindly restore all Windows app data into Linux.
- Review repositories, scripts, VM disks, databases, media libraries, and project folders outside the standard profile. Inventory and export WSL distributions and containers separately.
- Preserve browser bookmarks and required profile data through supported sync or explicit export. Preserve existing SSH keys only if needed and only in encrypted private storage; replacement keys may be safer.
- Keep any required BitLocker recovery key, Windows license/account information, and software-license records in a suitable secret manager or other protected location, never in this repository.

Do not copy `C:\Windows`, `Program Files`, `Program Files (x86)`, or all of `ProgramData` as an application backup. Reinstall applications on the destination OS. Verify the backup by opening representative files from the removable drive before erasing either internal disk. Microsoft identifies Desktop, Documents, Pictures, Videos, and Music as standard Windows Backup folders; OneDrive folder status still needs explicit review. See [Microsoft Windows Backup](https://support.microsoft.com/en-us/windows/experience/backup-recovery/back-up-and-restore-with-windows-backup) and [OneDrive folder backup](https://support.microsoft.com/en-us/onedrive/back-up-your-folders-with-onedrive).
