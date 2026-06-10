---
id: "skill-migrate-legacy-knowledge-to-v2"
aliases: ["skill-migrate-legacy-knowledge-to-v2", "migrate-legacy-knowledge-to-v2"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Upgrade an existing namespace to V2 additively: assign a profile, add canon/ and synthesis/, upgrade INDEX, set v2_status upgraded, preserve edges and aliases, and validate."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to bring a legacy namespace up to the V2 shape without restructuring its existing folders, preserving every edge and alias and proving the upgrade with validate.sh."
edges:
  - target: "[[upgrade-a-namespace-to-v2]]"
    relation: "informed_by"
    confidence: 0.92
  - target: "[[migration-compatibility-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[skill-build-namespace]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[skill-build-profile-example-namespace]]"
    relation: "related_to"
    confidence: 0.65
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# migrate-legacy-knowledge-to-v2

Bring an existing namespace up to V2 without breaking what is already there. The upgrade
is additive (contract Part 12): add `canon/` and `synthesis/` alongside the existing
folders, never restructure `pillars/`, `concepts/`, `decisions/`, `playbooks/`,
`support/`, or `archive/`. The procedure doctrine lives in
[[upgrade-a-namespace-to-v2]]; the compatibility constraints (link preservation,
alias-on-rename, validator-in-the-same-wave) live in [[migration-compatibility-rules]].
This skill is the technique for one namespace.

## Use when

- an existing namespace (for example `ai-architecture`, `ooda-john-boyd`, `david-deutsch`,
  `garytan`, `example-marketing`) needs the V2 shape
- the registry entry shows `v2_status: queued` and the namespace is scheduled to upgrade
- a namespace has real retrieval use but lacks `canon/`, `synthesis/`, or a V2 `INDEX.md`

## Do not use when

- the namespace does not exist yet (use [[skill-build-namespace]] to create it
  V2-compliant from birth)
- the namespace is a deliberate starter or example with a reduced base that declares so
  (do not force full canon onto `personal-operator`)
- the change requires destructive restructuring of existing folders (that is out of
  scope; the upgrade is additive only)

## Goal

Produce a namespace that carries the shared base plus its profile folders, a disciplined
canon, within-namespace synthesis, a V2 `INDEX.md` retrieval router, and a registry entry
with `v2_status: upgraded`, with every pre-existing edge and alias preserved and
`validate.sh` clean.

## Required outputs

1. A `profile:` assignment for the namespace, chosen from the eight in
   [[namespace-profiles]], recorded in the `_system/namespaces/<ns>.md` registry entry.
2. New `canon/` and `synthesis/` folders added alongside existing folders, with canon
   files sized to the namespace `canon_posture` (full, thin, or none) per
   [[canon-layer-schema]].
3. A V2 `INDEX.md` following [[namespace-index-schema]] (Profile, Load first, Query
   classes, Stable vs stateful, Open disputes, What this namespace drives, Archive and
   provenance, Common misreadings, Map).
4. The registry entry updated: `profile`, `v2_status: upgraded`, `canon_posture`,
   `freshness_posture`, `archive_posture`, `expected_folders`, plus the `## Profile and
   folders` and `## Review posture` body sections, all preserving the existing `## Use
   for`, `## Do not use for`, `## Promotion path`, `## Notes`.
5. A passing `bash _system/validate.sh` run.

## Build steps

1. Assign the profile. Read [[namespace-profiles]], match the namespace job to one of the
   eight profiles, and record the choice and a one-line why.
2. Set canon posture. Decide full, thin, or none per the namespace priority in the canon
   contract. Stateful namespaces (for example `example-marketing`) may add
   `canon/current-truth.md`.
3. Add `canon/` additively. Write `canon/README.md` (navigational), `canon/core-doctrine.md`
   (a real knowledge node with `derived_from` edges, `verified_at`, `verified_by`, and a
   `## Changelog`), and `canon/agent-load-order.md` (navigational) for full posture; a
   thin posture ships a short core-doctrine. Do not paraphrase `pillars/` node by node;
   canon synthesizes and compresses (G3).
4. Add `synthesis/` additively. Seed it with `synthesis/README.md` and any existing
   derived thinking that currently sits wrongly in `support/` (move derived reading to
   `synthesis/`, leave provenance and migration receipts in `support/`, per G11).
5. Upgrade `INDEX.md` to the V2 schema. Keep it as a retrieval router, not a folder list.
6. Preserve edges and aliases. When any file is renamed or moved, add the old id to the
   new file's `aliases` or leave a stub with a `supersedes` pointer
   ([[migration-compatibility-rules]]). Reorganization must not drop any `edges`.
7. Update the registry entry with the V2 fields and body sections, setting
   `v2_status: upgraded`.
8. Run `bash _system/validate.sh`. Fix every error before closing; the validator carries
   the structural rules in the same wave they became doctrine.

## Quality checks

- existing `pillars/`, `concepts/`, `decisions/`, `playbooks/`, `support/`, `archive/`
  folders are untouched (additive only)
- no edge or alias was dropped; renamed files carry the old id as an alias or a stub
- canon synthesizes rather than copies `pillars/`, and full-posture namespaces have all
  required canon files
- derived thinking moved to `synthesis/`; provenance stayed in `support/`
- the registry entry shows `v2_status: upgraded` and lists `expected_folders` matching the
  folders actually present
- `bash _system/validate.sh` passes with no errors

## Anti-patterns

- restructuring existing folders instead of adding `canon/` and `synthesis/` beside them
- dropping edges or aliases during reorganization and breaking inbound links silently
- copying `pillars/` content into canon instead of compressing it
- leaving `v2_status: queued` after the upgrade is done
- declaring the upgrade complete without running the validator in the same wave
