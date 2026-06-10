---
id: namespace-ai-architecture
name: ai-architecture
purpose: "Stable Infinite Brain AI-system architecture covering planning, execution routing, swarm governance, runtime boundaries, cockpit limits, and advisory-role authority."
owner: the-operator
lifecycle_state: research
created: 2026-05-29
group: operations
retrieval_class: explicit
export_class: internal
default_visibility: private
tags: [namespace, research, operations, ai-architecture]
supersedes: null
profile: doctrine
v2_status: upgraded
canon_posture: full
freshness_posture: review-on-edit
archive_posture: none
expected_folders: [INDEX.md, canon, pillars, concepts, decisions, playbooks, support, synthesis]
notes: "Created by sprint 2026-05-29-ai-architecture-namespace-buildout. V2-upgraded 2026-05-30 (ARCHITECTURE-CONTRACT-V2 Part 7.2). Lifecycle moved scratch to research 2026-05-31: the namespace is the validated reference implementation of the full V2 base and is worth refining and showing to others. Canon core-doctrine carries verified_by: operator-pending until the operator signs off; the namespace promotes toward candidate when that sign-off lands and the doctrine set is stable."
---

# ai-architecture

## Summary

Stable Infinite Brain AI-system architecture covering planning, execution routing,
swarm governance, runtime boundaries, cockpit limits, and advisory-role authority.

## Defaults

| Field | Default |
|-------|---------|
| `lifecycle_state` on nodes | `research` |
| `retrieval_class` on nodes | `domain` |
| `export_class` on nodes | `internal` |

## Profile and folders

Profile: `doctrine` (Profile A, Doctrine / Conceptual Canon). This namespace holds
durable architecture concepts, principles, and decisions for the Infinite Brain AI
system. The profile schema is registered in `_system/namespace-profiles.md`; the
reasoning for the profile model is in [[namespace-profiles]] and
[[profile-aware-knowledge-graph-design]].

Expected folders: `INDEX.md`, `canon/`, `pillars/`, `concepts/`, `decisions/`,
`playbooks/`, `support/`, `synthesis/`.

- Base surfaces (shared by every serious namespace): `INDEX.md`, `canon/`,
  `playbooks/`, `support/`, `synthesis/`. See [[required-namespace-surfaces]].
- Additive profile folders (doctrine profile): `pillars/`, `concepts/`, `decisions/`.
  These add to the base; they never replace it and never fork the ontology.
- This namespace is the doctrine home and reference implementation, so it carries full
  canon: `canon/README.md`, `canon/core-doctrine.md`, `canon/agent-load-order.md`. See
  [[canon-layer]] and [[what-canon-means]].
- No `archive/`: this namespace is doctrine-first, not archive-first. Its source corpus
  lives in `swarms/Sprints`, not in a tracked archive tree.

`validate.sh` deterministically checks that the base surfaces and the full-canon files
exist (canon_posture: full) and that no unexpected top-level folder appears outside
`expected_folders` (warning). Whether canon content is correctly compressed and
provenance-bearing is a curator-agent (fuzzy) judgment, not a validate.sh check.

## Review posture

Freshness posture: `review-on-edit`. This is stable doctrine, not decaying state, so
there is no periodic-staleness clock. Review is triggered by edits and by upstream
change, not by the calendar. See [[namespace-profiles]] for the freshness model.

Review is triggered when:

- a `canon/core-doctrine.md` edit lands (re-verify `derived_from` edges, refresh
  `verified_at` and `verified_by`, append a `## Changelog` entry per
  [[correction-loop-absorption]])
- a pillar, concept, or decision this canon compresses is added, changed, or superseded
- a contradiction is surfaced in `synthesis/` that the canon does not yet resolve
- a repeated correction in agent use crosses into structure (rule, playbook, decision,
  or canon revision) per [[correction-loop-absorption]]

`archive_posture: none` means there is no raw archive to age or re-verify here. The
deterministic em and en dash ban, frontmatter presence, and link resolution run on
every edit via `validate.sh`; contradiction surfacing and canon-candidate detection are
curator-agent (fuzzy) reviews per [[namespace-linting]].

## Use for

- canonical planning and execution-mode doctrine
- source-of-truth boundaries between git, runtime stores, and analytics
- session registration, transcript retention, and closeout promotion doctrine
- swarm launch, sprint linkage, and closeout contracts
- PM-agent, commander, and admiral authority limits
- Paperclip and other surface boundaries
- secret-reference and deterministic-workflow design rules when they shape the AI system

## Do not use for

- raw sprint histories or runtime receipts
- product or marketing doctrine
- live queue state, approvals-in-flight, or task rows
- secret values, credentials, or environment setup instructions
- low-level implementation details that do not define a reusable contract

## Promotion path

This namespace is at `lifecycle_state: research`: it is the validated reference
implementation of the full V2 base and is worth refining and showing to others. The next
gate is operator sign-off on `canon/core-doctrine.md` (it carries `verified_by:
operator-pending`). When that sign-off lands and the doctrine set is stable, promote from
research to candidate by opening a pull request against the reviewed system-doctrine home,
most likely `canon-system-ontology` or an adjacent operations-canon location. Keep volatile
readiness and rollout cautions in decision nodes so the namespace file stays stable.

## Notes

This namespace is doctrine-first rather than archive-first. The source corpus lives in
`swarms/Sprints`; this namespace distills the reusable architecture that survived the
completed 2026-05-27 to 2026-05-29 architecture cluster.
