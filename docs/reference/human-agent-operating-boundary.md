# Human and Agent Operating Boundary

## Purpose

Define the default responsibility split for HomeLab work after the 2026-10-06 through 2026-10-07 portfolio VM attempt showed that end-to-end agent control of an interactive installer and sensitive host networking was too error-prone and disproportionately expensive in operator time and agent usage.

This policy does not prohibit agent assistance. It keeps the human operator in control of changes that can interrupt management access, expose services, destroy workloads, or handle authentication material.

## Human-operated by default

The human operator performs and validates:

- Hypervisor installation and interactive VM or container operating-system installation.
- Host, router, switch, bridge, VLAN, routing, NAT, firewall, and forwarding changes.
- Storage partitioning, formatting, pool changes, destructive workload lifecycle operations, and recovery actions.
- Account creation, credential entry, MFA, secret handling, access-control changes, DNS delegation, tunnel enrollment, and public exposure.
- Final execution of any change that could remove remote management or require local recovery.

Agents may prepare a reviewed procedure, commands, expected output, verification steps, and rollback instructions. During execution, agents may interpret operator-provided results and help choose the next step.

## Agent-operated by default

Agents may perform:

- Documentation creation and maintenance from reviewed evidence.
- Programming, static website work, tests, and repository-safe automation.
- Read-only inspection and observation of systems the operator owns and has authorized for access.
- Sanitized inventory analysis that does not alter infrastructure or expose private operational data.
- Option comparison, architecture review, troubleshooting analysis, command drafting, and post-change verification.

## Explicit exceptions

The operator may explicitly assign an agent a specific, bounded configuration action. Authorization should identify the target and intended change; broad permission to edit repository files, assist with a deployment, or continue a project does not authorize sensitive infrastructure modification.

Even with explicit authorization, preserve a recovery path, record the prior state and rollback, avoid credential entry, verify the result, and update the appropriate current, history, plan, and changelog records.
