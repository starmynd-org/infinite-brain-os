---
id: "playbook-ai-architecture-open-and-close-ai-session"
aliases: ["playbook-ai-architecture-open-and-close-ai-session", "open-and-close-ai-session", "session-open-closeout"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Procedure for forcing AI session registration, transcript capture, and structured closeout so sessions produce durable trail, follow-up tasks, memory candidates, and swarm candidates without becoming canon."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[session-ledger-root-layer]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[session-transcript-posture]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.86
  - target: "[[swarm-launch-governance]]"
    relation: "references"
    confidence: 0.82
created: "2026-05-31"
---

# Open And Close AI Session

## Summary

Use this procedure whenever an AI chat surface will do meaningful work against the repo.
Register the session up front, keep the transcript durable, and force a closeout that
extracts the reusable signal.

## When to run

- any substantial Codex or Claude Code session
- any browser or phone-app AI session whose output is intended to affect the repo
- any chat likely to produce follow-up tasks, knowledge, swarm proposals, or system changes

## Procedure

### Step 1: Register the session

Create a session record in `sessions/active/` named `YYYY-MM-DD-<topic>.md`. Record the
surface, model, operator, goal, linked project or task or sprint or namespace, and the
transcript path. Also record the metering source and the runtime session id when the surface
or gateway exposes one. Mark `status: active`.

### Step 2: Start transcript retention

Open the raw log path under `sessions/logs/`. Capture the full exchange when the surface
permits it: user prompts, assistant replies, tool calls, tool outputs, notable failures,
wrong turns, and reversals. If full capture is impossible, write that limitation into the
session record immediately.

### Step 3: Load the right context

Before substantial work, load the minimum sufficient canon, skills, agents, workflows, and
knowledge nodes for the task. Record the initial context set in the session record so a
future agent can reconstruct how the session was oriented.

### Step 4: Work the task

Proceed with the task. Keep short running notes in the session record when notable things
happen:

- key decision made
- wrong assumption corrected
- roadblock encountered
- candidate memory or task surfaced
- reason the work may need swarm packaging

Do not narrate every thought. Record only what will matter later.

### Step 5: Decide whether the work is swarm-shaped

If the task has several coordinated lanes, high coupling, or durable governance needs, mark
it as swarm-shaped and prepare the follow-up for [[swarm-launch-governance]]. The session may
recommend a swarm; it may not silently launch one.

If the session is already operating inside a sprint, update both places on purpose:

- `sessions/` for the full conversation archive and closeout extraction
- an internal build record (not shipped) for the sprint-facing artifacts, receipts, and execution updates

Cross-link the two surfaces explicitly: the session record should name the sprint path, and
the sprint README or sprint-facing note should point back to the session record or closeout
review.

### Step 6: Run forced closeout

Before ending the session, write a closeout review under `sessions/reviews/`. Cover:

- outputs produced
- decisions made
- wrong turns or confusion
- usage totals and cost, or the reason they could not be captured
- memory candidates
- PKM or namespace candidates
- follow-up tasks
- swarm candidates or follow-ups
- human review needed
- system improvements
- unresolved risks

### Step 7: Promote the signal

Move the durable signal into the right home:

- `memory/` for reviewed learnings
- `projects/` or task system for follow-up work
- `swarms/` for approved swarm packaging
- `knowledge/<namespace>/support/` or `synthesis/` for provenance or derived reading
- rules, playbooks, skills, workflows, decisions, or canon revisions when repeated
  correction becomes structure

### Step 8: Close the record

Link the closeout review from the session record, set `status` to `closed`,
`handed_off`, or `needs_followup`, then move the record from `sessions/active/` to
`sessions/closed/`.

## Usage capture note

At closeout, capture the best available usage receipt for the session. The preferred order is:

1. direct session totals from the surface or SDK
2. gateway or proxy aggregation keyed by the runtime session id
3. provider-side usage lookup
4. explicit unavailability note when none of the above exists

The session record and closeout review should both carry the metering source, capture time,
and the best available totals for input tokens, output tokens, cached input tokens, tool
charges, and estimated cost. If the numbers are estimates rather than exact receipts, say so
plainly.

## Success test

The session is complete when a future agent can answer:

- what this session was for
- what context it used
- what happened
- what changed
- what follow-up remains

without reading the raw transcript unless exact history is needed.
