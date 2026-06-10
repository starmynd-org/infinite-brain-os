---
id: "skill-manage-ai-session"
aliases: ["skill-manage-ai-session", "manage-ai-session"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Run the forced start and closeout discipline for AI chat sessions so transcripts are preserved, context is declared, and durable signal is promoted into memory, tasks, swarms, or knowledge surfaces."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when an AI chat session will do meaningful work against the repo and needs durable registration, transcript retention, and structured closeout."
edges:
  - target: "[[session-ledger-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[open-and-close-ai-session]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[skill-shape-ai-work]]"
    relation: "paired_with"
    confidence: 0.78
  - target: "[[skill-build-swarm-sprint]]"
    relation: "related_to"
    confidence: 0.76
created: "2026-05-31"
---

# manage-ai-session

Use this skill to force the correct start and end discipline for any meaningful AI chat
session that touches this repo.

## Use when

- Codex, Claude Code, a browser chat, or a phone app is about to do substantial repo work
- you need full transcript retention or at least explicit logging of what cannot be captured
- the session may produce memory candidates, tasks, swarm proposals, or knowledge changes

## Do not use when

- the exchange is truly trivial and leaves no durable change or follow-up
- the work is already fully captured in another durable record and no repo touch is involved

## Goal

Preserve the session as durable audit trail without letting transcript files become a second
brain.

## Required outputs

1. A session record in `sessions/active/` or `sessions/closed/`.
2. A transcript path in `sessions/logs/` or an explicit note that the surface could not
   export the full log.
3. A closeout review in `sessions/reviews/`.
4. Links to any promoted outputs: memory, tasks, swarms, support, synthesis, or structural
   improvements.

## Build steps

1. Register the session before meaningful work begins. Name it `YYYY-MM-DD-<topic>.md`,
   record the surface, model, goal, repo scope, linked project or task or sprint, and the
   initial context loaded.
2. Start transcript retention immediately. Capture raw chat, tool calls, tool outputs,
   notable errors, and wrong turns when the surface allows it.
3. If the session is operating inside a swarm sprint, dual-write intentionally:
   update `sessions/` for the conversation archive and update the sprint folder for the
   execution-facing artifacts or receipts the sprint needs.
4. Work the task and keep concise running notes in the session record when something
   important changes: decision, correction, roadblock, candidate follow-up, or possible
   swarm boundary.
5. At closeout, extract:
   - outputs produced
   - decisions made
   - wrong turns
   - memory candidates
   - PKM or namespace candidates
   - follow-up tasks
   - swarm candidates
   - human-review needs
   - system-improvement candidates
6. Promote each extracted item into the right durable home. Do not leave the useful signal
   trapped in the transcript.
7. Link the closeout review, set final status, and move the session record into
   `sessions/closed/` unless it remains open by design.

## Quality checks

- session registration happened before substantial work
- transcript path exists or the logging gap is declared
- closeout extracted follow-up and memory candidates explicitly
- raw transcript was not treated as canon or default retrieval context
- repeated correction was routed toward structure rather than left as another chat note
- swarm work updated the sprint surface as well as the session surface

## Anti-patterns

- doing the work first and writing the session record later from memory
- keeping only a summary when full logs were available
- storing raw transcript files in a knowledge namespace
- closing a session without extracting tasks, memory, or system improvements
- asking future agents to grep raw transcript sludge because no session record was written
