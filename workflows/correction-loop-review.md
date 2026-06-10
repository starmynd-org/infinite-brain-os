---
id: "workflow-correction-loop-review"
aliases: ["workflow-correction-loop-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Periodic pass that finds recurring human corrections in session history and absorbs each one into durable structure."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-apply-correction-loop]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[correction-loop-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[correction-loop-absorption]]"
    relation: "informed_by"
    confidence: 0.88
  - target: "[[agent-brain-curator]]"
    relation: "uses"
    confidence: 0.7
  - target: "[[contradiction-and-gap-review]]"
    relation: "related_to"
    confidence: 0.65
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Correction Loop Review

A reasoning pipeline that scans recent session history for corrections the operator made
more than once, then converts each recurring correction into a rule, playbook, decision,
or canon revision. This is the operative implementation of the correction-to-structure
doctrine: a repeated correction is a defect in the structure, not a fact about the
operator. Pay it once by changing the structure, not every session in chat.

The fuzzy work, deciding which corrections are real and which structure should absorb
them, belongs to this workflow and to [[skill-apply-correction-loop]]. Deterministic
checks (frontmatter, dead links, dash ban) stay in `_system/validate.sh` and are not
re-run here.

## When to run

- On a periodic cadence, monthly by default, or whenever the operator notices they have
  corrected the same agent behavior or output pattern several times.
- After a burst of sessions on a new namespace or workflow, when correction volume is
  highest and the structure is least settled.
- Do not run this for a one-off correction. A single correction is noise; run it when a
  pattern is plausible.

## Inputs

- Session history for the review window. Sources, in priority order: any session notes
  under `outputs/`, the operator's recollection of repeated corrections, and any
  correction stubs that landed in `intake/` or `memory/`.
- The current `_system/` rule set, so a candidate correction can be matched against an
  existing rule before a new one is written.
- The namespace registry at `_system/namespaces/` to locate the right home namespace for
  a correction that is namespace-scoped.
- The correction-loop doctrine: operative rules in [[correction-loop-rules]], the
  reasoning and three-question test in [[correction-loop-absorption]].

## Pipeline

### Step 1: Gather correction candidates

Read the session history for the window. Extract every instance where the operator
overrode, rejected, or re-specified an agent action or output. Record each as a one-line
candidate with the date and the session it came from. Do not interpret yet; just list.

### Step 2: Cluster into recurring patterns

Group the candidates by what they correct (a tone, a routing choice, a default value, a
missing step, a format). A cluster of two or more across distinct sessions is a recurring
correction. Singletons are held, not promoted. Produce a table:

```
| Pattern | Count | First seen | Last seen | What gets corrected |
|---------|-------|-----------|-----------|---------------------|
```

### Step 3: Apply the three-question test per cluster

For each recurring pattern, apply [[skill-apply-correction-loop]], which runs the
three-question test from [[correction-loop-absorption]]: is this correction durable, is
it general, and which structure should own it. The skill returns the target structure
(rule, playbook, decision, or canon revision) and the home namespace.

### Step 4: Draft the absorbing change

For each pattern that passes, draft the concrete structural change the skill identified:

- a new or amended `entities/rules/` rule, when the correction is a standing behavior
- a new or amended `knowledge/<namespace>/playbooks/` step, when it is a procedure
- a new `knowledge/<namespace>/decisions/` node, when it settles a choice
- a `canon/core-doctrine.md` changelog revision, when it changes compressed doctrine
  (route this through [[canonize-namespace]] rather than editing canon inline)

Each draft cites the correction cluster as its source so the absorption is auditable.

### Step 5: Confirm with the operator, then write

Present the drafted changes as a list with the cluster evidence behind each. The operator
confirms, edits, or rejects each one. Write only confirmed changes. A canon revision
always requires operator approval per [[correction-loop-rules]].

### Step 6: Produce the review Output

Save to `outputs/correction-loop-review-{date}.md` with the pattern table (Step 2), the
disposition of each cluster (absorbed, held, or rejected), and links to every structural
change written.

Output frontmatter:
```yaml
---
id: "output-correction-loop-review-{date}"
type: "Output"
namespace: "personal-operator"
lifecycle_state: "scratch"
produced_by: "[[workflow-correction-loop-review]]"
created: "{date}"
---
```

## Output format

A single Output node at `outputs/correction-loop-review-{date}.md`. Body sections, in
order: recurring-pattern table, per-cluster disposition, structural changes written (with
wikilinks), and held singletons to watch next cycle.

## Notes

- Human confirmation is required before any structural change is written (Step 5). The
  workflow never edits a rule, decision, or canon node without it.
- A held singleton is not discarded. It carries forward; if it recurs next cycle it joins
  a cluster and may then be absorbed.
- This workflow changes structure to remove the need for the correction. It does not file
  the same correction as a fresh Memory node each cycle, which would re-pay the cost
  instead of eliminating it.
- For contradictions surfaced while clustering (two corrections that pull in opposite
  directions), hand them to [[contradiction-and-gap-review]] rather than forcing a
  resolution here.
