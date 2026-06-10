---
id: "workflow-session-closeout-review"
aliases: ["workflow-session-closeout-review", "session-closeout-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Forced closeout pipeline for a tracked AI session: read the session record and transcript, extract durable signal, write the closeout review, and route follow-up work."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-session-archivist]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[skill-manage-ai-session]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[session-ledger-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[open-and-close-ai-session]]"
    relation: "informed_by"
    confidence: 0.88
  - target: "[[swarm-launch-governance]]"
    relation: "references"
    confidence: 0.78
created: "2026-05-31"
runtime: "agentic"
---

# Workflow: Session Closeout Review

Forced closeout pipeline for a tracked AI session. It reads the session record and the
transcript trail, extracts the durable signal, writes the closeout review, and routes the
follow-up into the right homes.

## When to run

- before ending any tracked AI work session
- when recovering a long session whose useful findings risk being lost in scrollback
- when handing a session off to another agent or to a swarm proposal

## Inputs

- one session record under `sessions/active/`
- linked transcript path or explicit note that full export was unavailable
- any changed files, outputs, or linked project or task or sprint
- the `sessions/` templates and the session-ledger rules

## Pipeline

### Step 1: Read the durable trail

Read the session record first. Then read the closeout target template. Open the raw
transcript only as needed to recover exact history, tool traces, or forgotten decisions.

### Step 2: Extract what happened

Write a concise narrative of:

- the goal
- what was attempted
- what succeeded
- what failed or confused the operator
- what changed in the repo or in the plan

### Step 3: Extract promotion candidates

Pull out explicit candidates for:

- memory nodes
- PKM or namespace work
- follow-up tasks
- swarm follow-up or swarm scoping
- human review
- structural system improvement

### Step 4: Write the closeout review

Create `sessions/reviews/YYYY-MM-DD-topic-closeout.md` and populate every required section.
Keep the review high-signal enough that a future agent can understand the session without
opening the raw log first.

### Step 5: Finalize the session record

Link the closeout review, final outputs, changed files, and promoted follow-ups. Set final
status and move the record to `sessions/closed/` unless the session is intentionally kept
open.

## Output format

- one closeout review in `sessions/reviews/`
- one finalized session record in `sessions/closed/` or `sessions/active/`
- a short checklist of promotion candidates and where each was routed

## Notes

- The session record and closeout review are the primary retrieval surface. The raw
  transcript is provenance, not default context.
- A swarm recommendation stays a recommendation until the normal launch gate approves it.
