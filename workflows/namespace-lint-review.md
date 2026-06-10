---
id: "workflow-namespace-lint-review"
aliases: ["workflow-namespace-lint-review", "namespace-lint-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Monthly pipeline that runs validate.sh across all namespaces, triages the warnings including queued-V2-gaps, and files structural fixes for operator approval."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-namespace-linter]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-lint-namespace]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[namespace-lint-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[profile-lint-rules]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[migration-compatibility-rules]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[namespace-linting]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[review-namespace-health]]"
    relation: "informed_by"
    confidence: 0.8
  - target: "[[contradiction-and-gap-review]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Namespace Lint Review

A monthly review pipeline that runs the deterministic validator across every namespace, then
applies agent judgment to triage the output into real fixes versus accepted-by-design states.
The validator is the source of truth for structural health; this workflow turns its raw output
into a prioritized, operator-approvable fix list. It is the deterministic counterpart to
[[contradiction-and-gap-review]]: lint finds broken structure, that finds broken meaning.

## When to run

- Monthly, across all namespaces, as the standing structural health pass.
- As a scoped step inside [[workflow-weekly-review]] when structural drift is the focus.
- After any large migration or bulk node creation, since that is when structural rules break
  (broken links on rename, missing required base surfaces, profile folder drift).

## Inputs

- The current date.
- The validator at `_system/validate.sh` (the V2 extension with profile-aware structural
  checks).
- The namespace registry at `_system/namespaces/`. Each entry declares `profile`,
  `v2_status`, `canon_posture`, and `expected_folders`; the validator reads these to know what
  each namespace should contain.
- The operative rules: [[namespace-lint-rules]], [[profile-lint-rules]], and
  [[migration-compatibility-rules]].
- The doctrine: [[namespace-linting]] (why deterministic checks and fuzzy checks are split).

## Pipeline

### Step 1: Run the validator

Run `bash _system/validate.sh` at the repo root. Capture the full output: errors (exit 1),
warnings (do not fail), and the per-check summary. The validator covers: missing required base
surfaces for serious namespaces, missing required canon files for `canon_posture: full`, broken
relative links and broken `[[wikilinks]]`, orphan nodes (warning), profile folder drift
(folders not in `expected_folders`, warning), intake receipt completeness (error in `intake/`),
plus the legacy checks (frontmatter keys, em and en dash ban, n8n pairing, JSON validity,
lifecycle enum, Obsidian alias compatibility).

### Step 2: Triage errors

For each error, [[agent-namespace-linter]] reads the offending file and applies
[[skill-lint-namespace]] to classify the fix: broken link (repath or add an alias per
[[migration-compatibility-rules]]), missing required surface (create the folder or canon file),
missing frontmatter key (add it), dash violation (rewrite the line), or invalid intake receipt
(add the missing routing decision or destination link). Every error gets a proposed fix; errors
block the green validator run until resolved.

### Step 3: Triage warnings, including queued-V2-gaps

For each warning, decide whether it is a real fix or an accepted-by-design state:

1. Orphan warnings: judge whether the node is genuinely orphaned (propose an edge or archive)
   or intentionally standalone (accept with a note).
2. Profile folder drift: judge whether the extra folder is a mistake (remove or fold in) or a
   legitimate addition the registry `expected_folders` should learn (propose a registry edit).
3. Queued-V2-gap warnings: a namespace with `v2_status: queued` is scheduled for upgrade but
   not yet upgraded, so it legitimately lacks `canon/` or `synthesis/`. The validator warns
   rather than errors on these. Accept the warning, confirm the namespace is still on the
   upgrade queue, and do not file a fix; filing fixes against queued namespaces creates churn.

### Step 4: File fixes

Group the proposed fixes from Steps 2 and 3 by namespace. For each, draft the exact edit. Apply
the unambiguous, low-risk fixes directly (broken self-links, dash violations, missing alias on a
renamed file). Hold structural fixes that change folder shape or registry posture for operator
approval. Re-run `bash _system/validate.sh` after applying fixes to confirm the error count
dropped and no new error appeared.

### Step 5: Report

Produce the triage report and the operator decision list for the held fixes. Confirm the
post-fix validator state: errors should be zero or reduced with each remaining error explained.

## Output format

A lint review report printed to the session, plus any low-risk fixes applied in Step 4. The
report contains:

- the validator summary: error count before and after, warning count by category
- an error triage table:

```
| File | Error | Classification | Fix (applied or proposed) |
|------|-------|----------------|---------------------------|
```

- a warning triage table separating real fixes from accepted-by-design states, with
  queued-V2-gaps called out as accepted
- the operator decision list for held structural fixes

Applied fixes and the green (or explained) validator run are the durable artifact. The report is
a point-in-time record and is not a knowledge node.

## Notes

- The validator owns deterministic truth. This workflow never relitigates whether a check is
  correct; it triages the output and proposes fixes. New structural rules land in `validate.sh`
  in the same wave they become doctrine, so the validator and the rules never drift.
- Fuzzy checks (contradiction surfacing, canon-candidate detection, freshness judgment) are out
  of scope here; they belong to [[contradiction-and-gap-review]] and [[monthly-canon-review]].
- Queued-V2-gaps are not failures. A namespace upgraded incrementally will show warnings until
  its upgrade wave runs; treating those as errors would block the green run and force premature
  upgrades.
- Delta discipline: when the repo already carries pre-existing warnings, confirm the swarm or
  edit under review added no new violation rather than demanding absolute zero.
- See [[namespace-lint-rules]] and [[profile-lint-rules]] for the operative check definitions
  and [[review-namespace-health]] for the broader health doctrine this lint pass feeds.
