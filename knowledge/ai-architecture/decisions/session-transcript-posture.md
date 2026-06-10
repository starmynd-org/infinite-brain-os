---
id: "decision-ai-architecture-session-transcript-posture"
aliases: ["decision-ai-architecture-session-transcript-posture", "session-transcript-posture", "ai-architecture-session-transcript-posture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Store full AI session logs in the repo when available, but isolate them in the root sessions layer and never treat raw transcripts as default retrieval context or canon."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[session-ledger-root-layer]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[retrieval-over-raw-memory]]"
    relation: "bounded_by"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.86
created: "2026-05-31"
---

# Session Transcript Posture

## Summary

The Infinite Brain should preserve full AI session history whenever the surface permits it,
but raw transcripts belong in a root session ledger and are loaded only on demand.

## Decision

Settled posture:

- store full transcript copies and tool-event traces locally when export is possible
- keep them under `sessions/logs/`, linked from a structured session record
- require a start record and an end closeout review for tracked sessions
- never treat raw transcript files as canon, current truth, or default retrieval context
- promote durable signal out of sessions into memory, tasks, swarms, support, synthesis, or canon through the normal path

## Why this is the right call

Chat history is valuable provenance and often the only record of tool traces, confusion,
mid-course corrections, and design reasoning. Losing it is avoidable. But treating raw chat
as a first-class knowledge surface would degrade retrieval and create a second brain made of
noise. The right compromise is full retention plus strict layering.

## Rejected alternative

Rejected: ephemeral chat with no durable logs. It throws away useful audit material, blocks
higher-quality handoff, and makes future system improvement depend on memory and screenshots.

Rejected: make transcripts default retrieval input. It would bury canon beneath raw
conversation and make the retrieval system worse as the repo grows.

## Status

Locked for the root `sessions/` layer introduction on 2026-05-31.
