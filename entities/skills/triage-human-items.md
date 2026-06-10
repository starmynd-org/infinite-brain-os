---
id: "skill-triage-human-items"
aliases: ["skill-triage-human-items", "triage-human-items"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Apply the surfacing policy to a set of human-bound items: route each to auto-handle, surface-now, batch, or escalate-urgent, conservative by default, with the external and canon-touching hard flags always surfacing. At L1, learning is OFF: everything batches or escalates-urgent, nothing auto-handles."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when the chief-of-staff membrane has human-bound items to route. It applies the surfacing policy and returns the routing decision and rationale per item. At L1 it never auto-handles."
edges:
  - target: "[[rule-surfacing-policy]]"
    relation: "applies"
    confidence: 0.9
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-03"
---

# Skill: Triage Human Items

Apply `[[rule-surfacing-policy]]` to human-bound items and return one routing action per item.

## Steps

1. Confirm each item carries the nine signals (`[[rule-signal-vocabulary]]`) and the item class.
2. Check the hard flags first: `external` or `canon-touching` route to surface-now or batch, never
   auto-handle. Low `confidence` always surfaces.
3. Apply the stakes-by-reversibility matrix for the rest.
4. At L1 (learning OFF): route everything to `batch`, except high-or-critical stakes with a deadline or
   decay, which route to `escalate-urgent`. Never `auto-handle`.
5. Emit the routing decision per item with a one-line rationale, and assemble the batch for the next
   daily review.

## Output

A routing decision per item (auto-handle, surface-now, batch, escalate-urgent) with rationale, plus the
assembled batch. Every decision is logged for the audit trail and the (future) learning loop.

## Guardrails

Conservative by default: when unsure, surface. The raw unfiltered queue stays accessible to the operator. The
mis-surface rate is the safety metric. At L1 the skill cannot auto-handle, by policy.
