---
id: "knowledge-ai-architecture-deterministic-workflow-boundary"
aliases: ["knowledge-ai-architecture-deterministic-workflow-boundary", "ai-architecture-workflow-boundary"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Boundary for deciding when a workflow belongs in Markdown, when it belongs in n8n JSON, and how to split hybrid flows."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[playbook-ai-architecture-secret-reference-model]]"
    relation: "supports"
    confidence: 0.82
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "extends"
    confidence: 0.85
created: "2026-05-29"
---

# AI Architecture Deterministic Workflow Boundary

## Summary

The Infinite Brain treats deterministic automation as a separate runtime class from
agentic or judgment-heavy workflows, and that distinction determines where the
workflow should live.

## Content

Use Markdown workflows when the work:

- depends on open-ended reasoning
- requires review loops or synthesis
- is better expressed as a governed procedure than a runtime graph

Use n8n JSON when the work:

- has an explicit trigger
- accepts structured inputs
- can be imported, activated, run, and re-exported without hand editing
- has testable success and failure behavior

Hybrid rule:

- keep orchestration and review logic in Markdown
- extract deterministic subflows into `automations/n8n/*.json`
- pair each production JSON file with a companion Markdown node

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `supports` the secret-reference playbook because deterministic runtimes need safe
  binding rules.
- `extends` the surface boundary by applying the general adapter rule to workflows.

## Confirming evidence

An independent operator's narrow-domain CRM reached this same conclusion, captured as the
asserting-script lesson (a prompt is not a guarantee; a correctness invariant must live in a
script that refuses to exit success when violated). See
`external-crm-surface-boundary-confirmation`.

## Notes

The n8n sources remain partially draft, so this node should be reviewed again if a
later completed swarm revises the deterministic gate materially.
