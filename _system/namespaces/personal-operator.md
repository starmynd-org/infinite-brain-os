---
id: namespace-personal-operator
name: personal-operator
purpose: "The durable operator model (the chief-of-staff role's Core Knowledge): the operator profile, tuning decisions, goals, and the operator-review PKM graph. Ships as a reduced skeleton the adopter fills in with their own profile and tuning values. Retains fictional teaching templates in _examples/ only."
owner: the-operator
lifecycle_state: research
created: 2026-05-30
group: personal
retrieval_class: explicit
export_class: internal
default_visibility: private
tags: [namespace, personal, personal-operator, operator-model]
supersedes: null
profile: doctrine
v2_status: upgraded
canon_posture: full
freshness_posture: review-on-edit
archive_posture: none
expected_folders: [INDEX.md, canon, pillars, concepts, decisions, playbooks, support, synthesis, _examples]
notes: "The operator's own namespace: the chief-of-staff role names it as its Core Knowledge (the durable operator model). Carries the full serious base plus the doctrine-profile folders, with profile and lifecycle posture fields per ARCHITECTURE-CONTRACT-V2 Part 7.2. canon/ is authored at verified_by operator-pending until the adopter verifies it as their own. The fictional about-this-company and example-concept templates live in _examples/, off the load-bearing path (ids and edges preserved). validate.sh enforces the serious base: personal-operator is not in REDUCED_BASE_NAMESPACES."
---

# personal-operator

## Summary

Serious namespace holding the durable operator model, owned by the chief-of-staff role: the operator
profile, the operator-tuning decisions, the goals knowledge, and the operator-review PKM graph. It
ships as a reduced skeleton: the adopter fills in their own profile, tuning values, and goals. Retains
two fictional teaching templates in `_examples/`, off the load-bearing path.

## Defaults

| Field | Default |
|-------|---------|
| `lifecycle_state` on nodes | `research` |
| `retrieval_class` on nodes | `domain` |
| `export_class` on nodes | `internal` |

## Profile and folders

Profile: `doctrine` (Profile A, Doctrine / Conceptual Canon), serious base. The profile model is
explained in [[namespace-profiles]] and [[profile-aware-knowledge-graph-design]].

Expected folders: `INDEX.md`, `canon/`, `pillars/`, `concepts/`, `decisions/`, `playbooks/`,
`support/`, `synthesis/`, `_examples/`.

- This carries the full serious base (`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`)
  plus the doctrine-profile folders (`pillars/`, `concepts/`, `decisions/`). See
  [[required-namespace-surfaces]].
- `canon_posture: full`: `canon/core-doctrine.md`, `canon/README.md`, and `canon/agent-load-order.md`
  exist, authored at `verified_by: operator-pending` until the adopter verifies them. See
  [[canon-layer]] and [[what-canon-means]].
- `archive_posture: none`: no preserved raw corpus.
- `_examples/` holds the two fictional teaching templates (`about-this-company`, `example-concept`),
  off the load-bearing path. They are never load-bearing and never cited as fact.

`validate.sh` enforces the serious base for this namespace: `personal-operator` is not in
`REDUCED_BASE_NAMESPACES` in `_system/validate.sh`. Whether a node here should promote into a
different namespace is a curator-agent (fuzzy) judgment per [[review-namespace-health]].

## Review posture

Freshness posture: `review-on-edit`. The operator model is durable doctrine, not decaying state, so
there is no periodic clock. Review is triggered by edits.

Review is triggered when:

- the operator profile or a tuning decision is edited (the values are operator-set and load-bearing)
- a repo convention a teaching template demonstrates changes, so the `_examples/` templates must follow
- canon changes (re-verify with the operator)

`archive_posture: none` means no archive to age. `canon_posture: full` means the canon is re-verified
with the operator on edit. The deterministic em and en dash ban, frontmatter presence, and link
resolution run on every edit via `validate.sh`.

## Use for

- the durable operator model (deep-work windows, communication style, risk posture, default item
  classes)
- the operator-tuning decisions, the goals knowledge, and the operator-review PKM graph
- operator-local methodology and migration playbooks
- fictional teaching templates, in `_examples/` only

## Do not use for

- live queue state, in-flight approvals, or the learned-rules live registry (runtime substrate)
- raw time or metric values (the data layer holds values; git holds the Data-node pointer)
- secrets, credentials, or environment state (the root `secrets/` registry holds references)
- citing a teaching template as fact

## Notes

This namespace is the chief-of-staff role's Core Knowledge: the durable model of the operator. The
adopter replaces the skeleton profile and tuning placeholders with their own values as a first
buildout step.
