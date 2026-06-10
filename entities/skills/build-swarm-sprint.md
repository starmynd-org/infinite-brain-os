---
id: "skill-build-swarm-sprint"
aliases: ["skill-build-swarm-sprint", "build-swarm-sprint"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build a swarm or sprint execution package that preserves canonical task meaning, explicit gates, and approval-safe governance."
confidence: 0.94
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when work is clearly swarm-shaped and needs a durable sprint package with governance artifacts."
edges:
  - target: "[[skill-build-project-and-task]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[upgrade-a-namespace-to-v2]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-29"
---

# build-swarm-sprint

Use this skill when a task has already been identified as swarm-shaped and needs a sprint execution package.

## Use when

- multiple specialist lanes are needed
- governance artifacts and checkpoints matter
- the work spans many files, repos, or operating surfaces
- closeout and handoff need durable packaging

## Do not use when

- one agent can finish in one coherent pass
- a workflow is sufficient
- the task is still too vague to scope

## Build steps

1. Confirm the parent task and project anchor.
2. Decide whether to reuse an existing sprint pattern or scope a new one.
3. Create the sprint folder with charter, plan, swarm map, launch sheet, risk policy, gates, current ops, and pickup file.
4. Put new canonical sprint work under `infinite-brain-os/swarms/Sprints/`, not the
   legacy standalone `Repos/swarms/` repo, unless the task explicitly needs legacy source-material.
5. Record the single `parent_task` anchor and additive `cross_refs` on the sprint README metadata.
6. Define what is canonical versus runtime-only state.
7. Keep launch approval explicit.

## Namespace upgrade sprints (V2)

A swarm sprint may produce namespace upgrades, not just app or doc work. When the sprint
target is one or more knowledge namespaces moving to V2 structure (canon, synthesis,
profile-aware folders, upgraded INDEX), shape it as an upgrade sprint:

- Follow [[upgrade-a-namespace-to-v2]] for the per-namespace upgrade procedure. Each
  serious namespace in scope gets its own lane or wave.
- Use the audit-packet pattern. Before mass migration, each namespace gets an audit
  packet that records current state, target profile, the gap to V2, the rollout order,
  and the dependency map. The packet is the durable brief the upgrade lanes execute
  against; it is canonical, not runtime.
- Sequence builders before mass migration. Upgrade the builder skills and curator agents
  in an early wave so the later namespace-upgrade waves are V2-aligned by default.
- Treat the registry `v2_status` field as the rollout ledger. A namespace marked
  `queued` is scoped for upgrade but not yet done; the validator warns rather than errors
  on its missing canon and synthesis. Flip it to `upgraded` only when the namespace
  passes its acceptance checks.

## Canonical versus runtime rule

Canonical:

- task meaning
- durable briefs
- decisions
- summaries

Runtime-only:

- queue state
- run receipts
- wakeups
- approvals in flight

## Quality checks

- sprint artifacts exist
- launch boundary is human-gated
- runtime state is not confused with canon
