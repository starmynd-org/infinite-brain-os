# Session Ledger Rules

Operative rules for the root `sessions/` layer. This file owns the checkable contract for
how AI chat sessions are registered, logged, closed out, and promoted into durable
structure. The reasoning lives in [[session-ledger-root-layer]],
[[open-and-close-ai-session]], [[surface-boundary]], and [[correction-loop-absorption]].

Scope: this file governs the durable git layer at `sessions/`. It does not govern the live
chat transport, tool runtime internals, or any vendor-specific conversation backend.

Metering posture: session-level token and cost data belongs to the runtime and observability
boundary, but the settled totals and source notes captured at closeout belong in `sessions/`
as part of the durable audit trail.

## The session layer (locked)

Rule SESSION-1: `sessions/` is a root OS layer, not a knowledge namespace and not a canon
surface. It stores durable session receipts, full transcripts, and closeout reviews for AI
conversations that touched this repo.

Tracked base folders:

- `sessions/active/`: open session records
- `sessions/closed/`: closed session records
- `sessions/logs/`: raw append-only transcripts and tool-event traces
- `sessions/reviews/`: closeout reviews and promotion notes
- `sessions/templates/`: operator-approved templates

Rule SESSION-2: live mutable chat state belongs to the surface that owns it. `sessions/`
stores the durable trail: registration, transcript copies, closeout summaries, and links to
what the session changed. It is an audit layer, not a live queue.

## Forced session start (locked)

Rule SESSION-3: every substantial AI work session that reads or writes this repo must begin
with session registration before meaningful work starts.

Required start actions:

1. Create a session record in `sessions/active/` named `YYYY-MM-DD-<topic>.md`.
2. Create or declare the transcript path in `sessions/logs/`.
3. Record the surface, model, operator, repo scope, intended goal, and linked project or
   task or sprint or namespace when known.
4. Record the initial context loaded: canon, skills, agents, workflows, or nodes.
5. Record the metering source and runtime session identifier when the surface exposes one.
6. Mark `status: active`.

Rule SESSION-4: full raw logs should be retained whenever the surface permits it. Transcript
copies may include user prompts, assistant replies, tool calls, tool outputs, wrong turns,
confusions, and intermediate ideas. If a surface cannot export full logs, the session record
must state the gap explicitly.

Rule SESSION-5: session logging is append-only by default. Corrections and summaries belong
in the session record or closeout review; do not rewrite the historical transcript except to
redact secrets or remove accidental credentials.

## Forced session end (locked)

Rule SESSION-6: every tracked session ends with an explicit closeout review before the
session record moves from `sessions/active/` to `sessions/closed/`.

Required end checks:

- outputs produced
- decisions made
- wrong turns, confusions, or dead ends worth preserving
- session usage and cost totals, or an explicit statement that the surface could not provide them
- memory candidates
- PKM or namespace candidates
- follow-up tasks
- swarm candidates or swarm follow-ups
- human review requirements
- system-improvement candidates
- unresolved risks or open questions

Required end actions:

1. Write a closeout review in `sessions/reviews/` named
   `YYYY-MM-DD-<topic>-closeout.md`.
2. Update the session record with links to transcripts, outputs, changed files, and the
   closeout review.
3. Write a usage receipt in the session record and closeout review with the metering source,
   capture time, and the best available totals for input tokens, output tokens, cached input
   tokens, tool charges, and estimated session cost.
4. Set `status` to one of `closed`, `handed_off`, or `needs_followup`.
5. Move the session record into `sessions/closed/`.

Rule SESSION-6A: token and cost capture is required at session closeout whenever the surface,
its SDK, or its gateway can provide it. If exact totals are unavailable, the session must
record one of:

- estimated totals plus the source of estimation
- a provider-side usage lookup reference
- an explicit `usage_capture_status: unavailable` note with the reason

Rule SESSION-6B: session usage receipts should be machine-readable enough to support later
aggregation. The preferred fields are:

- `usage_capture_status`
- `usage_source`
- `runtime_session_id`
- `captured_at`
- `input_tokens`
- `output_tokens`
- `cached_input_tokens`
- `tool_calls`
- `tool_cost_usd`
- `estimated_cost_usd`
- `usage_notes`

## Automatic capture patterns

Rule SESSION-6C: a tracked session should use the strongest available automatic capture pattern
rather than manual after-the-fact narration. The allowed source classes are:

- `direct`: the runtime itself emits final totals
- `sdk-derived`: a supervising SDK or wrapper accumulates usage during the run
- `gateway-derived`: a proxy or gateway aggregates calls by runtime session identifier
- `provider-lookup`: totals are joined back from a supported provider-side usage surface
- `unavailable`: no reliable source exists; the session must say why

Rule SESSION-6D: when the capture pattern is not `direct`, the session record must carry the join
key that makes deferred reconciliation possible. Preferred key: `runtime_session_id`. If a surface
cannot expose that field, it must record the substitute key and explain the limitation in
`usage_notes`.

Rule SESSION-6E: provider-specific implementation detail belongs in doctrine and tool-contract
material, not in this rule file. This contract cares only that the session declares the source
class, the join key, the capture time, and the resulting receipt.

## Promotion out of sessions

Rule SESSION-7: a session transcript is never canon and is never loaded by default as the
primary retrieval surface. Durable signal promoted out of a session must move into the right
home:

- `memory/` for reviewed learnings
- `projects/` or the runtime task system for follow-up work
- `swarms/` for approved swarm packaging
- `knowledge/<namespace>/support/` for provenance worth citing
- `knowledge/<namespace>/synthesis/` for derived interpretation
- `knowledge/<namespace>/` nodes or canon only through the normal promotion path

Rule SESSION-8: repeated corrections discovered in session closeout become structure, not
another transcript. Route them to a rule, playbook, decision, canon revision, workflow
change, or skill update per [[correction-loop-rules]].

Rule SESSION-8A: when a tracked chat is actively operating inside a swarm sprint, it
updates two surfaces on purpose:

1. `sessions/` for the conversation archive, transcript trail, and closeout extraction
2. an internal build record (not shipped) for the sprint-facing execution artifacts, receipts, and bounded
   state the sprint itself needs

This is an intentional dual-write boundary, not an integration defect. `sessions/` is the
archive and audit surface. `swarms/` is the execution package. Neither replaces the other.

Rule SESSION-8B: when dual-write is in effect, cross-link the two surfaces explicitly. The
session record should point to the sprint path, and the sprint README or sprint-facing note
should point back to the session record, transcript, or closeout review. The goal is
handoff and recoverability without loading the full transcript first.

## Retrieval boundary

Rule SESSION-9: session logs are searchable archive, not default context. The default
retrieval path is canon first, then namespace docs. Session transcripts are loaded only when
the task is provenance, debugging, audit, or handoff recovery.

Rule SESSION-10: every session record should carry a short summary and explicit links to the
high-signal artifacts it produced so agents can retrieve the session by receipt before
loading the raw transcript.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- `sessions/README.md` exists
- the five base folders in SESSION-1 exist
- session files are exempt from node-frontmatter checks because they are runtime receipts,
  not ontology nodes
- the em and en dash ban still applies to `.md` files in `sessions/`

Fuzzy (curator or closeout agent):

- whether a session should have been tracked at all
- whether the closeout extracted the right memory or PKM or swarm candidates
- whether the transcript is worth loading for a future task
- whether a session-born idea deserves promotion into doctrine or a namespace
- whether a reported usage total is exact, estimated, or incomplete when the source is ambiguous

## Notes

This contract intentionally preserves all session data while preventing transcript sludge
from becoming a second brain. `sessions/` keeps the audit trail. The ontology keeps the
meaning.
