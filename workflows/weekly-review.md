---
id: "workflow-weekly-review"
aliases: ["workflow-weekly-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Example weekly review workflow for intake triage and knowledge maintenance."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-research-assistant]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-summarize-source]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[namespace-lint-review]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[namespace-intake-review]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[monthly-canon-review]]"
    relation: "references"
    confidence: 0.8
  - target: "[[review-namespace-health]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-20"
runtime: "agentic"
---

# Workflow: Weekly Review

A reasoning pipeline for a structured weekly review. Run this in a Claude Code session
at the end of each work week. It produces a review Output and optionally creates new
Memory nodes from lessons learned.

## When to run

End of week, ideally Friday afternoon before you close out. Takes roughly 15 minutes
of your attention plus Claude Code time.

## Inputs

- The current date (Claude Code reads this automatically).
- Your `projects/` folder (current state of all projects).
- Your `intake/` folder (any items not yet triaged this week, plus the root `intake/`
  fabric: `sources/`, `processed/`, and `routing/`).
- Your `memory/` folder (recent learnings to review for updates).
- The namespace registry at `_system/namespaces/` (each entry declares `profile`,
  `v2_status`, `canon_posture`, and `freshness_posture`).
- The validator at `_system/validate.sh`.
- Optional: a text block of anything notable that happened this week that is not yet
  captured anywhere.

## Pipeline

### Step 1: Audit projects

For each project in `projects/`:
1. Read `STATUS.md`.
2. Classify the project as: on track, at risk, blocked, or complete.
3. For blocked or at risk: identify the blockers (from TASKS.md) and summarize
   the single most important next action.
4. For complete: flag it for archiving (move to `outputs/` with lineage).

Produce a table:
```
| Project | Status | Blockers | Most important next action |
|---------|--------|----------|---------------------------|
```

### Step 2: Review intake residue

Count items in `intake/` that are not yet triaged (no `routed_to` field in frontmatter).
For each one: classify it in one sentence. Group into: task, knowledge candidate, noise.
Produce a list sorted by priority.

If there are more than 10 untriaged items, flag this as a signal that triage frequency
needs to increase. Create a Memory stub.

### Step 3: Identify this week's lessons

Ask: what did I learn this week that is not yet captured in `memory/`?
Sources:
- Completed project steps (read TASKS.md for completed items with notes).
- Intake items classified as "knowledge candidate".
- Any optional context the user provided.

For each lesson candidate: apply `[[skill-summarize-source]]` to distill it.
Present the list to the user for confirmation before writing any Memory nodes.

### Step 4: Write confirmed Memory nodes

For each user-confirmed lesson, create a new Memory node in `memory/` with:
- `lifecycle_state: research` (not `scratch`, because the weekly review is already
  a refinement step)
- `confidence` set based on how certain the lesson is
- An edge to the project or knowledge node it came from

### Step 5: Lint review

Run the deterministic structural checks before any judgment-based maintenance, so
later steps work against a clean structure. This is the V2 hygiene gate. See
[[namespace-lint-review]] for the full triage workflow.

1. Run `bash _system/validate.sh` from the repo root.
2. If it exits non-zero, an error blocks the rest of the review. Fix the error (broken
   wikilink, missing required base surface, missing canon file for a `canon_posture: full`
   namespace, missing frontmatter key) before continuing.
3. Triage warnings into three buckets: fix now (cheap, like an orphan node or a stray
   profile folder), defer to a namespace audit (structural, like a missing `synthesis/`
   folder), or accept with a note.
4. Note that a namespace with `v2_status: queued` in its registry entry produces
   warnings rather than errors for its missing canon and synthesis. Do not treat those
   as failures; they are scheduled, not broken. List them so the queue stays visible.

Record the validator exit code, the count of errors fixed, and the warning buckets.

### Step 6: Canon review

Decide whether any namespace canon should change this week. See [[monthly-canon-review]]
for the deeper monthly pass; the weekly canon review is a lighter check that surfaces
candidates and stale canon between monthly reviews.

1. Scan each serious namespace `synthesis/` folder for `canon-candidate` artifacts that
   are ready for promotion into `canon/`. List them; do not promote unilaterally.
2. For each namespace with `canon_posture: full` or `thin`, read its
   `canon/core-doctrine.md` frontmatter `verified_at`. Flag any canon not verified in
   the namespace's review window as stale.
3. For stateful namespaces carrying `canon/current-truth.md` (for example
   `example-marketing`), check whether the current offer, positioning, or public
   claims still match reality. Flag drift.
4. Skip namespaces with `v2_status: queued` for missing canon; note them as scheduled,
   not as findings.

Present canon candidates and stale-canon flags to the user. Canon promotion and canon
edits require operator approval and are not auto-applied here.

### Step 7: Intake review

Process the root `intake/` fabric and write receipts. This is distinct from Step 2,
which counts personal `intake/` residue; this step works the source-aware capture trail.
See [[namespace-intake-review]] for the full processing workflow.

1. List unprocessed items under `intake/sources/*` (items with no matching receipt under
   `intake/processed/`).
2. For each, apply the routing doctrine in `intake/routing/destination-rules.md` to
   choose a destination namespace, then process per the matching
   `intake/playbooks/process-*.md`.
3. Write a processed receipt under `intake/processed/<source-family>/` recording what
   came in, why it mattered, what was done, whether it changed archive, support,
   synthesis, canon, or nothing, which files were created or updated, what remains
   unresolved, and a link back to the source record.
4. Each receipt must carry a routing decision and a destination link; the validator
   treats a receipt missing either as an error.

Record the count of items processed and any items that need operator routing approval.

### Step 8: Freshness review (scoped by posture)

Review namespace freshness only where state decays. Scope by each namespace's
`freshness_posture` in its `_system/namespaces/<ns>.md` registry entry. See
[[review-namespace-health]] for the per-namespace health check this step calls.

1. `live` namespaces (for example `example-marketing`): review every run. Confirm the
   live-but-canonical facts in `canon/current-truth.md` are current; flag anything stale.
2. `periodic` namespaces: review only when the namespace's review window has elapsed
   since its last freshness check.
3. `review-on-edit` namespaces (most doctrine, for example `ooda-john-boyd`,
   `david-deutsch`): review only namespaces edited since the last weekly review. Stable
   doctrine that did not change is not re-reviewed.
4. For each in-scope namespace, run the health check: orphan nodes, stale links,
   duplicates, and contradictions. Surface findings; do not auto-fix interpretive
   issues.

Record which namespaces were in scope, which were skipped by posture, and the findings.

### Step 9: Produce the weekly review Output

Save to `outputs/weekly-review-{date}.md` with:
- The project audit table (Step 1)
- The intake residue summary (Step 2)
- The lint review result: validator exit code, errors fixed, warning buckets (Step 5)
- Canon candidates and stale-canon flags (Step 6)
- The intake fabric processing summary: items processed, receipts written (Step 7)
- The freshness review summary: namespaces in scope versus skipped by posture, and
  findings (Step 8)
- Links to any new Memory nodes created (Step 4)
- One paragraph: your stated priority for next week

Output frontmatter:
```yaml
---
id: "output-weekly-review-{date}"
type: "Output"
namespace: "personal-operator"
lifecycle_state: "scratch"
produced_by: "[[workflow-weekly-review]]"
created: "{date}"
---
```

## Notes

- This workflow requires human confirmation at Step 4 before writing Memory nodes.
  Do not auto-create Memory nodes without confirmation.
- The V2 maintenance steps (5 to 8) keep the namespace graph healthy as it expands.
  Step 5 (lint) is deterministic and runs first as the hygiene gate. Steps 6 to 8
  layer judgment-based review on top of a clean structure.
- Canon promotion and canon edits (Step 6) require operator approval. Surface candidates
  and stale flags; do not promote or rewrite canon unilaterally. The deeper pass is
  [[monthly-canon-review]]; the weekly check only surfaces between monthly reviews.
- Step 8 is scoped by `freshness_posture`, not blanket. `live` namespaces are reviewed
  every run; `periodic` only when their window elapsed; `review-on-edit` only when
  edited. This keeps stable doctrine from being re-reviewed for no reason.
- A namespace with `v2_status: queued` is scheduled for V2 upgrade but not yet upgraded.
  Its missing canon and synthesis produce warnings, not errors. List queued namespaces
  in the lint and canon steps so the upgrade queue stays visible; do not treat them as
  failures.
- If the user runs this mid-week, adjust step 1 to report "in-week progress" rather
  than end-of-week assessment.
- The output file is `scratch` because it is a time-bound artifact. It is not a node
  in the long-term knowledge graph; it is a record of a point in time.
