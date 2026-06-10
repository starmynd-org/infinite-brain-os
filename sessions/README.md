# sessions

This root layer stores durable AI session records, transcript copies, and closeout reviews
for conversations that touched this repo. It is an audit and handoff surface, not a canon
surface and not a live runtime queue.

## Forced start

Before substantial AI work begins:

1. Create a session record in `active/` named `YYYY-MM-DD-<topic>.md`.
2. Create or declare a transcript path in `logs/`.
3. Record the surface, model, scope, goal, and linked project or task or sprint.
4. Record the initial canon, skills, agents, workflows, or nodes loaded.
5. Record the metering source and runtime session id when the surface exposes one.

## Forced end

Before a tracked session closes:

1. Write a closeout review in `reviews/`.
2. Capture usage and cost totals, or record why they are unavailable.
3. Extract memory, PKM, task, swarm, human-review, and system-improvement candidates.
4. Link outputs and changed files.
5. Move the session record from `active/` to `closed/`.

## Dual-write rule for swarm work

If a chat session is actively working inside a swarm sprint, it updates both surfaces:

- `sessions/`: the conversation archive, transcript trail, and closeout extraction
- `swarms/Sprints/...`: the execution package, sprint receipts, and sprint-facing work products

These are not duplicates. The session layer keeps the full conversation trail. The swarm
layer keeps the bounded execution state and artifacts the sprint itself needs.

When dual-write is in effect, cross-link both ways:

- the session record should name the sprint path
- the sprint README or sprint note should point back to the session record or closeout review

## Retrieval rule

Session records and closeout reviews are the first retrieval surface here. Raw transcripts
in `logs/` are opened only on demand for audit, debugging, or exact-history recovery.

## Map

- `active/`: open session records
- `closed/`: closed session records
- `logs/`: raw transcript and tool-event copies
- `reviews/`: structured closeout reviews
- `templates/`: reusable session templates

## Usage capture rule

Usage data belongs to the runtime and observability boundary, but the settled receipt belongs in
the durable session archive. Prefer direct session totals from the surface or SDK, then gateway
or provider-side lookup keyed by the runtime session id. If no reliable source exists, state that
explicitly in the session record and closeout review.
