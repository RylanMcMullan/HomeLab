# Documentation Model

Each fact has one authoritative home. Link to it instead of copying it into several files. Markdown is the default for narrative records and GitHub tables; CSV is appropriate for a machine-readable inventory schema. Keep both editable in VS Code.

| Record | Purpose | Timeframe |
| --- | --- | --- |
| [`CURRENT_STATE.md`](../../CURRENT_STATE.md) | Short index of deployed infrastructure | Present; qualify the date of the last observation |
| `docs/hosts/` | Physical device identity, installed hardware, capabilities, attached hardware, and current OS/platform | Present or last verified; date and source matter |
| `docs/services/` | Current deployed platform/service configuration, host link, access, and verified behavior | Present; no future deployment procedure |
| `docs/network/` | Current topology and network-component state | Present; no proposed VLANs |
| [`ROADMAP.md`](../../ROADMAP.md) | Progress checklist of broad actions, each linked to a plan | Future and in progress |
| `docs/plans/` | One stable file per objective: status, parent/related plans, dependencies, procedure, verification, and rollback where applicable; unresolved gates stay `TODO` | Future until evidence confirms completion |
| `docs/history/` | Chronological evidence and prior configurations by topic; a broad plan may link to several topics | Past, with dated entries and provenance |
| `docs/decisions/` | Durable architecture choices and trade-offs | The decision at its date; status may change |
| [`CHANGELOG.md`](../../CHANGELOG.md) | Brief significant infrastructure changes, linking to detailed history | Past |
| `docs/reference/` | Terminology, reusable procedures, and safe templates | Time-independent guidance |
| `scripts/` | Reviewable operational helpers; raw output goes outside the repository | Tool behavior and usage |

## Editing rules

- Use title-case verb + noun for plan titles and imperative kebab-case filenames, such as `Onboard Home Assistant` in `onboard-home-assistant.md`. Keep status in the file, not in its path.
- Keep roadmap steps as checkable actions that change configuration or verified current state: no more than 15 steps per plan, with at most three substeps when necessary. Dependencies and verification gates belong in the linked plan.
- Name physical devices by brand/model where known. Name a service or platform independently and link to its host; one device may host many services. Keep aliases in [Terminology](terminology.md), not duplicate specifications.
- Present current facts in present tense with an observation date where they might age. Use past tense for dated history and future/conditional language for plans. Prefer “reported state” or “reported on `<date>`” to referring to an owner as narrator.
- Distinguish verified, reported, inferred, planned, `UNKNOWN`, and `TODO`. A past observation is not proof of a current software version or live status.
- Preserve historical facts and completed configuration evidence during relocation. Propose any factual correction to historical material for operator approval before editing it. Rewording for tense or links must not change what was observed.
- Publish only reviewed, sanitized findings. Raw operational evidence belongs under the private reference root described in [`SECURITY.md`](../../SECURITY.md); secrets belong in a secret manager when one is established.

## Change sequence

1. Record the prior state and evidence privately before a configuration change.
2. Follow the linked plan and its rollback gate.
3. Verify the result; update current host/service/network records and the roadmap.
4. Preserve the dated prior configuration and verification details in the relevant history topic.
5. Add a brief changelog entry for a significant infrastructure change, linking to that history entry.
