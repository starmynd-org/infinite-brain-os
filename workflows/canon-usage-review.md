---
id: "workflow-canon-usage-review"
aliases: ["workflow-canon-usage-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Periodic check that each namespace canon actually drives real outputs, flagging canon that no output depends on."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-review-output-linkage]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[output-linkage-review-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[freshness-review-rules]]"
    relation: "related_to"
    confidence: 0.7
  - target: "[[review-namespace-health]]"
    relation: "informed_by"
    confidence: 0.75
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Canon Usage Review

A reasoning pipeline that verifies the canon of each namespace is doing work. Output is
first-class: a namespace exists to drive outputs, projects, and decisions. Canon that no
output depends on is either dead weight or a signal that the output linkage was never
wired. This workflow reads each namespace's declared output linkage, checks it against
the actual graph, and flags canon that drives nothing and outputs that cite no canon.

The deterministic edge checks (does a declared target file resolve) stay in
`_system/validate.sh`. The fuzzy judgment, whether a real output meaningfully depends on
the canon it cites, is the work of this workflow and [[skill-review-output-linkage]].

## When to run

- On a periodic cadence, quarterly by default, or per a namespace's `freshness_posture`
  when that namespace declares a tighter loop.
- After a namespace is upgraded to V2, to confirm its new `## What this namespace drives`
  section in `INDEX.md` reflects reality and not aspiration.
- Before proposing a namespace for canonization, to prove its canon is load-bearing.

## Inputs

- The namespace set to review. Default: every namespace in `_system/namespaces/` with
  `v2_status: upgraded`. The operator may scope it to one namespace.
- Each namespace's `INDEX.md`, specifically the `## What this namespace drives` section,
  which is the declared output-linkage surface (`namespace-index-schema`).
- Each namespace's `canon/` folder (`core-doctrine.md` and, when present,
  `current-truth.md`).
- The `outputs/` folder and any `projects/` that cite the namespace, so declared linkage
  can be checked against real artifacts.
- Operative rules in [[output-linkage-review-rules]]; the reasoning behind output as
  first-class lives in the ai-architecture doctrine and is summarized by
  [[review-namespace-health]].

## Pipeline

### Step 1: Read the declared linkage

For each namespace in scope, read the `## What this namespace drives` section of its
`INDEX.md`. Record the declared outputs, projects, and decisions the canon claims to
improve. If the section is missing or empty, flag the namespace as undeclared and skip to
Step 4 for it.

### Step 2: Trace canon to real outputs

For each canon node, apply [[skill-review-output-linkage]] to trace whether any output in
`outputs/`, any project in `projects/`, or any decision node actually depends on it. A
dependency counts when the output cites the canon by edge or by wikilink and the
dependency is substantive, not decorative. Produce a table:

```
| Namespace | Canon node | Declared driver | Real dependent found | Verdict |
|-----------|-----------|-----------------|----------------------|---------|
```

Verdicts: driving (real dependent exists), declared-only (claimed but no dependent
found), undeclared (dependent found but not declared in INDEX), or orphan canon (no
declared driver and no dependent).

### Step 3: Check outputs cite their canon

Sample recent outputs that fall within the namespace's domain. For each, check whether it
cites the namespace canon it should have used. An output that reinvents reasoning the
canon already holds is a linkage gap in the other direction.

### Step 4: Draft the corrective actions

For each finding, draft the fix:

- declared-only: either wire a real output to the canon, or remove the unsupported claim
  from `INDEX.md`
- undeclared: add the real driver to the `## What this namespace drives` section
- orphan canon: flag for the operator to decide keep, demote to `synthesis/`, or archive
- output gap: note that future outputs in this domain should load the canon first

### Step 5: Produce the review Output

Save to `outputs/canon-usage-review-{date}.md` with the linkage table (Step 2), the
output-side gaps (Step 3), and the drafted corrective actions (Step 4). Present
INDEX.md edits and any demote-or-archive proposals to the operator for confirmation.

Output frontmatter:
```yaml
---
id: "output-canon-usage-review-{date}"
type: "Output"
namespace: "personal-operator"
lifecycle_state: "scratch"
produced_by: "[[workflow-canon-usage-review]]"
created: "{date}"
---
```

## Output format

A single Output node at `outputs/canon-usage-review-{date}.md`. Body sections, in order:
canon-to-output linkage table, output-side citation gaps, corrective actions (with
wikilinks), and a one-line health verdict per namespace (canon is load-bearing, or canon
needs wiring).

## Notes

- This review does not judge whether canon is true or fresh. Truth and freshness are the
  job of [[freshness-review-rules]] and the freshness reviewer. This review judges only
  whether canon is connected to real work.
- An INDEX.md edit that removes an unsupported driver claim or adds a discovered one is
  presented for operator confirmation before writing, because `INDEX.md` is the
  retrieval router and changes to it affect every agent that loads the namespace.
- Demote-or-archive of orphan canon is always operator-confirmed. Canon is
  operator-approved by definition, so removing it is too.
