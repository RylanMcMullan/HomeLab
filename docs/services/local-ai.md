# Local AI service

**Status:** preparation in progress; not deployed. Hardware inventory is complete and selected Windows files are being preserved. No Linux operating system, runtime, model, web interface, or automation framework has been selected or installed.

## Intended service profile

- Host: [Acer Nitro 5 AN515-54](../hosts/acer-nitro-5.md).
- Availability: dedicated 24/7 node with a lightweight local graphical session.
- Interfaces: local browser, private web interface, SSH administration, and an API for future integrations.
- Users: primarily the owner, with at most two or three users; up to approximately three owner-initiated processes.
- Priorities: model quality first, then useful interactive response speed.
- Initial workloads: light coding, automation, and cybersecurity research assistance.
- Future workloads: smart-home assistance and Raspberry Pi-connected audio, camera, and physical I/O.

## Capacity constraints

- The NVIDIA GeForce GTX 1650 was command-verified with 4 GiB VRAM and CUDA compute capability 7.5. Linux driver behavior and usable VRAM under the intended graphical workload remain `TODO`.
- The current 8 GB system RAM is restrictive for larger models, long contexts, and concurrent requests. An upgrade up to 32 GB is planned but not installed.
- The installed system SSD is only 128 GB-class, not the previously reported 256 GB. The 1 TB-class HDD can hold model files and bulk data, but its slower loading performance and backup role must be considered.
- Model size, quantization, context length, GPU offload, throughput, and concurrency must be selected from measured benchmarks on this host. Do not claim a model fits or performs adequately before testing it.
- Initial concurrency should be conservative; simultaneous contexts can increase memory demand substantially even when model weights are shared.

## Candidate platform shape

These are candidates, not decisions:

- A lightweight Ubuntu-family LTS desktop is the leading OS direction because the node must be both a server and a locally usable management station. Xubuntu 26.04 LTS offers an Xfce desktop and is supported through April 2029; final selection awaits hardware inventory and installer/driver review. See the [official Xubuntu release record](https://xubuntu.org/release/26.04/).
- Ollama is a candidate inference manager with a local API. Its current hardware documentation supports NVIDIA GPUs with compute capability 5.0 or newer subject to driver requirements; the Acer's exact compatibility must be verified. See [Ollama hardware support](https://docs.ollama.com/gpu).
- `llama.cpp` is a candidate when lower-level control over quantization, GPU-layer offload, context, and an OpenAI-compatible local server is valuable. See its [official CUDA build documentation](https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md).
- Open WebUI is a candidate multi-user browser interface compatible with Ollama and OpenAI-compatible APIs. See [Open WebUI documentation](https://docs.openwebui.com/).

Specific model families and quantizations remain `TODO` until current candidates are evaluated and benchmarked on the Linux installation.

## Security boundaries for future agentic use

- Keep the chat UI, inference API, and management interfaces private to the local network and/or Tailscale unless a separate security review approves another exposure path.
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
