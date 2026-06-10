---
id: "skill-lint-namespace"
aliases: ["skill-lint-namespace", "lint-namespace"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Run validate.sh for deterministic structural checks, then do the fuzzy namespace review the validator cannot: section presence and order, canon compression not copy, and profile-folder fit."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to lint a namespace: first the deterministic validate.sh pass, then the judgment-based review of canon discipline, INDEX.md sections, and profile-folder fit that no script can decide."
edges:
  - target: "[[namespace-lint-rules]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[profile-lint-rules]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[namespace-linting]]"
    relation: "informed_by"
    confidence: 0.88
  - target: "[[skill-refine-namespace-index]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[skill-detect-contradictions]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# lint-namespace

Use this skill to lint one namespace. The split is the point: deterministic checks belong
to `_system/validate.sh` (G5), and this skill runs them first, then does only the fuzzy
review a script cannot make. The deterministic rule set is in [[namespace-lint-rules]];
the profile-specific emphases are in [[profile-lint-rules]]; the reasoning for keeping the
two layers separate is in [[namespace-linting]]. Do not reimplement frontmatter, dash, or
broken-link checks here; delegate them to the validator.

## Use when

- a namespace was just built, upgraded, or canonized and needs a quality gate
- the namespace lint review workflow runs this skill on a namespace in scope
- an agent suspects canon is paraphrasing rather than compressing
- folders look present that may not belong to the namespace profile

## Do not use when

- you only need the deterministic pass; run `bash _system/validate.sh` directly
- the namespace is mid-build and not yet meant to validate; lint after the build wave
- the issue is a contradiction across nodes; use [[skill-detect-contradictions]]
- the issue is staleness by freshness posture; use [[skill-review-knowledge-freshness]]

## Goal

Produce a lint report that separates deterministic failures (from `validate.sh`) from
fuzzy findings (section order, canon compression, profile-folder fit), each with a
specific proposed fix, so the operator or a follow-up skill can act.

## Required outputs

1. the captured `validate.sh` result for the namespace (pass or the exact errors)
2. a fuzzy-findings list with one proposed fix per finding
3. a section-presence-and-order check against [[namespace-index-schema]]
4. a canon-compression judgment (compresses vs copies) per [[canon-layer-schema]]
5. a profile-folder-fit check against the registry `expected_folders` and
   [[profile-lint-rules]]

## Build steps

1. Run `bash _system/validate.sh` and capture the result. Treat its errors as the
   deterministic floor: do not duplicate them, do not re-judge them. Route any fix to the
   owning skill.
2. Read the namespace `INDEX.md`. Check the ten sections are present and in order per
   [[namespace-index-schema]]. This is fuzzy because order and fit are judgment, not a
   key-presence test. Route fixes to [[skill-refine-namespace-index]].
3. Read `canon/core-doctrine.md`. Judge whether it compresses the pillars and concepts or
   paraphrases them node by node (G3). Flag copy-not-compression as a finding.
4. Read the registry `expected_folders` for the namespace. Compare to the folders present.
   Apply the profile-specific emphasis from [[profile-lint-rules]]: for Data System, does
   each metric have source lineage; for Tool Contract, are payload examples present; for
   Operating Library, does each SOP have a trigger and escalation. These are content-fit
   judgments the validator cannot make.
5. Check that `synthesis/` holds derived thinking and `support/` holds provenance only
   (G11). Flag misfiled material.
6. Write the report with the two layers clearly separated.

## Quality checks

- deterministic checks were delegated to `validate.sh`, not reimplemented here (G5)
- every fuzzy finding names a specific file and a specific proposed fix
- canon-compression judgment is stated explicitly, not skipped
- profile-folder fit uses the registry `expected_folders`, not a guess
- the report distinguishes errors (must fix) from warnings (should review)
- no em dashes, no en dashes

## Anti-patterns

- reimplementing dash, frontmatter, or broken-link checks the validator already runs
- reporting "looks fine" without the canon-compression and section-order judgments
- treating an `expected_folders` warning as a hard failure
- linting content the validator should own, or skipping the fuzzy review the validator cannot
