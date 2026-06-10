---
id: "decision-ai-architecture-paperclip-boundary"
aliases: ["decision-ai-architecture-paperclip-boundary", "ai-architecture-paperclip-boundary"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Paperclip is the adopted runtime control plane that projects from and writes receipts back to git canon. It owns runtime, issue, approval, budget, run, and cost state, but never owns planning truth, launch authority, or canon, and never self-approves canon."
confidence: 0.94
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "derived_from"
    confidence: 0.93
  - target: "[[decision-ai-architecture-pm-agent-posture]]"
    relation: "constrains"
    confidence: 0.82
created: "2026-05-29"
---

# AI Architecture Paperclip Boundary

## Summary

Paperclip is the adopted runtime control plane over git canon. It is the runtime body for
AI departments, while the brain (git) stays the source of truth for planning, governance
policy, department definitions, and canon. Truth flows in by projection. Durable change
flows back as a human-accepted git promotion event. Paperclip owns runtime, issue,
approval, budget, run, and cost state, and never owns planning truth, launch authority, or
canon. It never self-approves canon.

## Content

Settled posture (2026-06-03 update: cockpit-only becomes runtime-control-plane-over-canon):

- Paperclip is adopted as the runtime control plane for AI departments. It owns the org
  chart, agents, issues, heartbeat runs, runtime state, budgets, approvals, run-log
  receipts, audit, and execution workspaces.
- Truth flows IN by projection: a git department definition is rendered to a portable
  Paperclip company markdown package and imported. The git definition is authoritative;
  Paperclip renders and runs it, it does not redefine it. Re-projection is an explicit
  re-import, never silent drift.
- Durable change flows BACK as a bounded git promotion event: human acceptance of a work
  product (an approved `issue_approvals` gate, the issue moved to `done`) is the only path
  by which agent work reaches mainline git, producing a real commit and a recorded receipt.
- Paperclip cannot become the only durable home of task intent, project scope, launch
  approval, or canon. A full `company export` is a snapshot for audit, not the source of
  truth.
- No department, head, or agent self-approves canon or its own work product. The decider on
  every acceptance approval is a human (`decidedByUserId`).

The safe implementation seam is projection in and a human-accepted promotion event back,
not doctrine ownership inside the control plane.

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped) (confirmed real schema)
- an internal build record (not shipped) (locked projection, writeback, governance, budget, and agent contracts)

## Edges

- `derived_from` the general surface boundary because Paperclip is one special case of
  that rule.
- `constrains` the PM-agent posture because routing outputs may be projected into
  Paperclip without granting Paperclip authority.

## Notes

If a later implementation introduces a wider Paperclip write path, review this node
first to confirm the runtime-control-plane-over-canon boundary still holds: projection in,
human-accepted promotion event back, no canon ownership and no self-approval inside the
control plane.

## Changelog

- 2026-06-03: Reconciled the boundary from cockpit-only to
  runtime-control-plane-over-canon, following operator approval to adopt Paperclip as the
  runtime body for AI departments and the confirmed schema. Truth flows in by
  projection (company import from a git department definition); durable change flows back as
  a human-accepted git promotion event. Paperclip owns runtime, issue, approval, budget,
  run, and cost state but never owns planning truth, launch authority, or canon, and never
  self-approves canon. Additive edit; frontmatter, id, aliases, and edges preserved.
  Candidate; promotion to canon is your call as operator.
