---
id: "workflow-contradiction-and-gap-review"
aliases: ["workflow-contradiction-and-gap-review", "contradiction-and-gap-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Scheduled pipeline that detects contradictions and coverage gaps across a namespace or the corpus, then records the synthesis as contradiction maps and gap notes."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-corpus-synthesizer]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[detect-contradictions]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-detect-contradictions]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[skill-cross-synthesize-corpus]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[contradiction-review-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.8
  - target: "[[correction-loop-absorption]]"
    relation: "informed_by"
    confidence: 0.8
  - target: "[[monthly-canon-review]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Contradiction And Gap Review

A scheduled review pipeline that finds where the knowledge graph disagrees with itself and
where it has holes, then records the result as durable synthesis. Contradictions and coverage
gaps are the two failure modes that deterministic linting cannot catch: both require reading
nodes and judging whether they conflict or whether a topic the namespace claims to cover is
actually missing. This workflow is the fuzzy counterpart to [[namespace-lint-review]]; lint
finds broken structure, this finds broken meaning.

## When to run

- On a schedule (monthly by default) for namespaces with `freshness_posture: live` or
  `periodic`, where state decays and disagreement accumulates.
- Out of cadence after a large intake batch lands new synthesis into a namespace, since fresh
  material is where contradictions appear.
- Before [[monthly-canon-review]], so contradiction maps are recorded as synthesis before the
  canon pass tries to compress disputed material into canon.

## Inputs

- The current date.
- The target scope: a single namespace, or the cross-namespace corpus (the root `synthesis/`
  layer plus all serious namespaces).
- For the in-scope namespaces: `pillars/`, `concepts/`, `decisions/`, `canon/`, and existing
  `synthesis/` (to avoid re-recording a contradiction already mapped).
- The operative rules: [[contradiction-review-rules]] and [[promotion-path-rules]].
- The doctrine: [[correction-loop-absorption]] (repeated disagreement becomes a rule or
  decision, not repeated chat).

## Pipeline

### Step 1: Scope the review

Decide whether this run is single-namespace or cross-corpus. For cross-corpus, the synthesis
home is the root `synthesis/`; for single-namespace, it is
`knowledge/<namespace>/synthesis/`. Read the existing synthesis in the chosen home so the run
extends prior contradiction maps rather than duplicating them.

### Step 2: Detect contradictions

Invoke [[agent-corpus-synthesizer]] and apply [[skill-detect-contradictions]] to read the
in-scope nodes and surface pairs or clusters of nodes that disagree: a decision that
contradicts a newer decision, a concept defined two ways, a canon claim a synthesis note now
disputes, or two thinker namespaces that take opposite positions on the same question. For
each, record the conflicting nodes, the nature of the disagreement, and the current best
resolution if one exists.

### Step 3: Detect coverage gaps

Apply [[skill-cross-synthesize-corpus]] to compare what the namespace's `INDEX.md` Query
classes claim it answers against what nodes actually exist. A gap is a query class the
namespace promises to answer but has no node for, or a topic that downstream outputs
repeatedly need and the corpus does not cover. Record each gap with the missing topic and the
query class or output that exposed it.

### Step 4: Record synthesis

Write the findings as durable synthesis, not as a throwaway report:

1. Contradiction maps go to the synthesis home as `contradiction-map` artifacts with full node
   frontmatter, naming the conflicting nodes and the current best resolution.
2. Gap notes go to the synthesis home as `best-current-reading` or gap artifacts, naming the
   missing topic and a proposed next action (capture via intake, write a node, or accept the
   gap).

Each synthesis node links the nodes it reconciles via edges so the contradiction is traceable.

### Step 5: Route durable actions

For each contradiction with a clear resolution, propose the structural fix per
[[correction-loop-absorption]]: update the losing node with a `supersedes` or `qualifies`
edge, or draft a decision that settles it. For each gap, propose a capture or a node. Present
these as an operator decision list; do not silently rewrite settled nodes.

## Output format

A contradiction-and-gap review summary printed to the session, plus the synthesis nodes
written in Step 4. The summary contains:

- a contradiction table:

```
| Node A | Node B | Disagreement | Current best resolution |
|--------|--------|--------------|-------------------------|
```

- a gap table:

```
| Missing topic | Exposed by (query class or output) | Proposed action |
|---------------|-------------------------------------|-----------------|
```

- the operator decision list from Step 5
- a one-line note for any contradiction that touches `canon/`, flagged for the next
  [[monthly-canon-review]]

The synthesis nodes are the durable artifact. The summary is a point-in-time record and is not
a knowledge node.

## Notes

- This is fuzzy work by design: judging contradiction and absence requires reading meaning, so
  it stays with the agent and this workflow, not `validate.sh`. The deterministic orphan and
  broken-link checks belong to [[namespace-lint-review]].
- Synthesis is first-class. Contradiction maps and gap notes are derived intellectual work and
  live in `synthesis/`, never in `support/` (which is provenance and migration only).
- A contradiction with no resolution is recorded honestly as an open dispute; it is not forced
  to a conclusion. Open disputes also surface in the namespace `INDEX.md` Open disputes section.
- See [[contradiction-review-rules]] for the operative rules on what counts as a contradiction
  and when one becomes a structural correction.
