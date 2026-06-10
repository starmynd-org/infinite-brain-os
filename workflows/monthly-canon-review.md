---
id: "workflow-monthly-canon-review"
aliases: ["workflow-monthly-canon-review", "monthly-canon-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Monthly pipeline that surfaces canon candidates, checks canon freshness and changelog, and proposes promotions for operator approval across all serious namespaces."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-canon-editor]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[promote-support-to-canon]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-promote-support-to-canon]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[canon-layer-schema]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[freshness-review-rules]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[canonize-a-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[canon-layer]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[namespace-intake-review]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Monthly Canon Review

A monthly review pipeline over the canon layer. It surfaces synthesis that is ready to be
promoted into canon, checks that existing `canon/core-doctrine.md` files are fresh and carry
an honest changelog, and produces a promotion proposal for operator approval. Promotion is
never automatic. This workflow proposes; the operator approves; only then does canon change.

## When to run

- Monthly, on a fixed day, across every namespace with `canon_posture: full` or `thin`.
- After a [[namespace-intake-review]] run that flagged canon candidates, so the candidates
  are already recorded as synthesis before this pass reads them.
- Out of cadence when a namespace has absorbed a large batch of new synthesis and the
  operator wants an early canon pass.

## Inputs

- The current date.
- The namespace registry at `_system/namespaces/`. Filter to entries with
  `canon_posture: full` or `thin`; skip `none` (for example `personal-operator`).
- For each in-scope namespace: `knowledge/<namespace>/canon/` (README, core-doctrine,
  agent-load-order, and current-truth where present) and
  `knowledge/<namespace>/synthesis/` (the canon-candidate packages and best-current-reading
  notes).
- The operative rules: [[canon-layer-schema]], [[promotion-path-rules]],
  [[freshness-review-rules]], and the changelog rules in `_system/canon-changelog-rules.md`.
- The doctrine: [[canon-layer]] (why canon is compressed synthesis, not paraphrase).

## Pipeline

### Step 1: Select in-scope namespaces

Read `_system/namespaces/INDEX.md` and each registry entry. Build the list of namespaces
with `canon_posture: full` or `thin`. For each, note `freshness_posture` so Step 3 knows
whether canon facts decay (`live`) or are stable doctrine (`review-on-edit`).

### Step 2: Surface canon candidates

For each in-scope namespace, invoke [[agent-canon-editor]] to read
`knowledge/<namespace>/synthesis/` and identify synthesis nodes tagged or shaped as
canon-candidate per the promotion path. Apply [[skill-promote-support-to-canon]] to assess
each candidate against the canon contract: is it compressed first-principles synthesis (not
a paraphrase of `pillars/`), is it operator-approvable, does it cite the pillars, concepts,
decisions, and archive it derives from. Reject candidates that are open questions or raw
parking lots; those stay in `synthesis/` or `intake/`.

### Step 3: Check canon freshness and changelog

For each existing `canon/core-doctrine.md` (and `current-truth.md` where present), check:

1. `verified_at` is within the freshness window for the namespace's `freshness_posture`
   (`live` facts decay fast; `review-on-edit` doctrine decays slowly).
2. The `## Changelog` section exists and its last entry matches the last real revision.
3. `derived_from` edges still resolve to live pillars, concepts, decisions, or archive.

Flag any canon file that is stale, has a missing or drifted changelog, or has a broken
`derived_from` edge. Stale `live` facts in `current-truth.md` are the highest-priority flag.

### Step 4: Draft promotion proposals

For each accepted candidate from Step 2, [[agent-canon-editor]] drafts the proposed canon
edit: the compressed synthesis to add or revise, the `derived_from` edges, the new changelog
line (date plus one-line reason), and the proposed `verified_at` and `verified_by`. The
draft is a proposal, not a committed change. It links the synthesis source so the operator
can audit the compression.

### Step 5: Present for operator approval

Assemble all proposals and all freshness flags into one review packet. Present it to the
operator as a decision list. Each item is either: promote (apply the drafted canon edit),
refresh (re-verify a stale canon file), hold (leave in synthesis), or reject (not canon).
Apply only the items the operator approves. Record each applied promotion in the canon
file's changelog with the operator approval date.

## Output format

A monthly canon review packet printed to the session, plus any operator-approved canon edits
applied in Step 5. The packet contains:

- a per-namespace canon health line: canon_posture, freshness_posture, verified_at, changelog
  status, broken-edge count
- a promotion proposal table:

```
| Namespace | Candidate (synthesis) | Proposed canon target | Recommendation |
|-----------|------------------------|-----------------------|----------------|
```

- a freshness flag list sorted by severity (stale `live` facts first)
- the operator decision list

Approved canon edits are the durable artifact. The packet is a point-in-time record and is
not a knowledge node.

## Notes

- Canon is small relative to the graph it sits over. If a namespace's canon is growing faster
  than its `pillars/` and `concepts/`, that is a signal the canon is becoming a parking lot;
  flag it for the operator.
- This workflow is fuzzy work: judging whether synthesis is ready for compression into canon.
  Deterministic checks (missing required canon files for `canon_posture: full`, broken
  `derived_from` links) stay in `validate.sh` and are surfaced by [[namespace-lint-review]].
- Never edit canon in a department or company-canon repo from here. This repo proposes;
  promotion to a canon repo is a separate operator-gated step. See [[canonize-a-namespace]].
- See [[canon-layer]] for the doctrine on what canon is and is not.
