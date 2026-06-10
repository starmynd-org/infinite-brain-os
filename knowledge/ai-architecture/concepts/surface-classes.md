---
id: "knowledge-ai-architecture-surface-classes"
aliases: ["knowledge-ai-architecture-surface-classes", "ai-architecture-surface-classes", "surface-classes"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The five domain-free surface classes (read, cockpit, authoring, agent-runtime, deterministic) that apply the surface boundary, with the rule that a real product is a composite of classes, not a class of its own. Held provisional until a first real surface validates it."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[surface-boundary]]"
    relation: "depends_on"
    confidence: 0.93
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.85
  - target: "[[decision-ai-architecture-paperclip-boundary]]"
    relation: "supports"
    confidence: 0.85
created: "2026-06-01"
---

# AI Architecture Surface Classes

## Summary

Surfaces divide into five classes by their posture toward truth, not by their domain. A real
product such as a CRM or an SMM cockpit is a composite of these classes, not a class of its own.
Keeping the classes domain-free is what stops domain specifics from collapsing into meta
doctrine.

## Status

Provisional. This taxonomy is research-state and held until a first real surface validates it,
per the Provisional discipline in [[profile-aware-knowledge-graph-design]]. It is not promoted
to canon. The reasoning, the per-class contracts, and the applied CRM and SMM test live in the
2026-05-31 surface-architecture-refinement sprint and feed this node.

## Content

The classes apply [[surface-boundary]]: each reads the truth plane, owns state only in the
runtime plane, renders through the render plane, and writes durable change back only through a
visible promotion event.

- **S1 Reading and visualization surface.** Projects the truth plane into a view. Owns only view
  and preference state and a read-through cache keyed to a commit. No writeback, no human gate.
  Examples: an Obsidian graph view, a department dashboard, a CRM client-360 read view, an SMM
  KPI dashboard.
- **S2 Cockpit and operational surface.** Owns operational queue, review, and approval-in-flight
  state and projects the truth plane. Stages proposals; durable change goes through a promotion
  event under a human gate. This is the Paperclip class, settled in
  [[decision-ai-architecture-paperclip-boundary]]. Examples: Paperclip, an intake inbox, a CRM
  pipeline board, an SMM content calendar.
- **S3 Authoring and composer surface.** Produces drafts destined for the truth plane. Owns the
  draft; writes back through a promotion event with a human gate on canon-class change. May also
  author executable entities (agent or skill markdown), writing the canonical `entities/` file,
  never the runtime shim. Examples: an SMM post composer, a CRM note editor, an agent or skill
  builder.
- **S4 Agent and chat runtime surface.** The embedded Claude Code, Codex, or Agent SDK process
  that serves a surface chat and write path. Reads the whole working tree, owns only ephemeral
  session state, and promotes through git under approval receipts. Every composite surface that
  has a chat embeds an S4 runtime rather than building its own model backend.
- **S5 Deterministic runtime surface.** Runs deterministic flows (n8n workflows, report and sync
  scripts). Owns run and telemetry state, produces output nodes, and promotes only distilled
  lessons as memory nodes after review. Holds no canon authority and references metrics by
  `metric_id` rather than inlining a definition.

## Composites are the norm

A shipped product combines classes. A CRM app is an S1 read view plus an S2 pipeline cockpit plus
an S3 note composer in its render plane, with an embedded S4 chat runtime, backed by S5 sync
scripts. The contract applies per plane and per class, not to the product as a monolith. This is
how a CRM or SMM system is specified without inventing a domain-specific surface primitive.

## Edges

- `depends_on` [[surface-boundary]], which defines the three planes, the eight-item declaration,
  and the promotion taxonomy the classes apply.
- `derived_from` [[core-doctrine]], whose control model and retrieval-over-raw-memory thesis the
  classes operationalize (the S4 chat is a grep-and-read agent over the repo).
- `supports` [[decision-ai-architecture-paperclip-boundary]], which is the worked S2 instance.
- `related_to` `surface-architecture-open-questions`, which tracks the unresolved questions a
  first real surface must close.

## Notes

The classes were proposed in the 2026-05-31 surface-architecture-refinement sprint and tested
against the CRM and SMM old-repo systems, both of which decomposed cleanly into S1 to S5 plus an
embedded S4 chat with no sixth class needed. Promote to canon only after a built surface
confirms the taxonomy.
