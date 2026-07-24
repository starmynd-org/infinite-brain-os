---
id: "knowledge-ai-architecture-graduate-a-department-to-its-own-brain-repo"
aliases: ["knowledge-ai-architecture-graduate-a-department-to-its-own-brain-repo", "graduate-a-department-to-its-own-brain-repo", "department-graduation-playbook"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Step-by-step procedure for moving a department from a folder inside the company brain to its own sibling repo once the trust-boundary trigger has fired, generalizing the field-tested client-release mechanics (strip and overlay, vendoring provenance, drift check) for the internal case."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[department-graduates-to-repo-on-trust-boundary]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[reflexive-brain-topology]]"
    relation: "derived_from"
    confidence: 0.88
created: "2026-07-13"
---

## Before starting

Confirm the trigger actually fired per [[department-graduates-to-repo-on-trust-boundary]].
This playbook assumes the decision is already made; it does not re-argue it.

## 1. Scope what ships

Enumerate what the new repo needs from the department folder (its `INDEX.md`, `CHARTER.md`,
namespaces, agents, skills, workflows, projects, outputs) versus what it must vendor from
the company brain (shared architecture doctrine it depends on, shared entities it uses
unmodified, the reporting and signal-vocabulary rules). Write this as a manifest (a ship
list of what copies over and a prune list of what never does) rather than copying the whole
company brain.

## 2. Strip and reword, do not just delete

Follow the strip-and-overlay discipline proven by the upstream deployment's client releases:
remove meta-builder material the new repo does not need (namespace-authoring skills,
company-wide architecture doctrine beyond what is vendored), and reword rather than silently
delete where orientation docs reference stripped paths. Keep the stripped material and the
manifest in the company brain (an overlay, not a deletion) so future re-releases are one
command, not a rebuild.

## 3. Create the sibling repo

Place it under `internal/` if it stays fully owned and operated by the company, or
`external/` if it now belongs to or is co-operated with a client or contractor team, per the
existing internal-versus-external convention in `_system/repo-registry-rules.md`. Give it the
same base shape as any serious repo: root `CLAUDE.md`/`AGENTS.md`, `entities/`, `.claude/`
and `.codex/` adapters, and whichever of `knowledge/`, `departments/`, `intake/`, `sessions/`
the department actually needs. Do not copy folders the department has no use for.

## 4. Seed entities with provenance

For every vendored entity (a shared agent, skill, command, or rule the department uses
unmodified), copy the canonical file into the new repo's `entities/` and mark it as vendored:
where it came from and when it was last synced, per the provenance discipline in
[[reflexive-brain-topology]]. Wire the `.claude/` and `.codex/` shims per the existing
pattern in `entities/README.md`. Locally-authored entities (the department's own agents and
skills) carry no provenance field and follow the normal lifecycle.

## 5. Register the graduation

Add or update the `repo-registry/<slug>.md` entry with `repo_kind: brain` and
`brain_tier: department`, per `_system/repo-registry-rules.md`. Update the department's
former `INDEX.md` entry in the company brain (or its successor pointer) to state it has
graduated and link to the new repo. Update the company brain's own repo-registry entry's
department linkage if the graduated department was listed there.

## 6. Validate before treating it as live

Run `_system/validate.sh` in both the company brain and the new repo. Adversarially check
the new repo the way a client release is checked before handoff: read it
cold, follow every path a first session would follow, and sweep for anything that should
have been stripped (internal-only references, other departments' data, credentials).

## 7. Set the sync direction and keep it a repo, not a fork of the standard

Decide, per the same field rules: does this department read updates from the company brain
via a per-graduation branch that periodically merges down (the shared-spine pattern), or is
it a fork with shared ancestry and no remotes (the full-isolation pattern)? Either way, architecture-standard changes still escalate upstream per
`upstream-downstream-split`; graduation is an access boundary, not a license to fork the
core.

## What this playbook is not

It is not the mechanism for shipping a public starter or a paying-client release; the
upstream deployment already has working procedures for both. This is the same shape applied
to an internal department graduation, and all three should eventually share one manifest-driven exporter
per [[reflexive-brain-topology]] rather than staying three separately maintained scripts.

## Relationship

`implements` the trigger decision in [[department-graduates-to-repo-on-trust-boundary]].
`derived_from` [[reflexive-brain-topology]] and the upstream deployment's field-tested
client-release procedure. The registry fields this playbook writes are
defined in `_system/repo-registry-rules.md`. A graduated department brain is often mounted
alongside a person's individual brain in a parent workspace, per
[[stand-up-a-multi-brain-parent-workspace]] and `_system/multi-brain-workspace-contract.md`.
