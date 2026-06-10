---
id: "workflow-completion-review"
aliases: ["workflow-completion-review", "completion-review"]
type: "Workflow"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Wrap the existing review capabilities (code-review, review, and the review agents) into one workflow that produces a structured result in the result-and-escalation-contract shape, so completed work reaches the operator as a clean review packet through the membrane rather than as raw chatter."
confidence: 0.72
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[rule-result-and-escalation-contract]]"
    relation: "produces_for"
    confidence: 0.88
  - target: "[[workflow-render-review-page]]"
    relation: "feeds"
    confidence: 0.8
created: "2026-06-03"
---

# Workflow: Completion Review

Turn a completed unit of work into a structured review packet the membrane can route. It wraps the
existing review capabilities (the `code-review` and `review` commands and the review agents) and emits a
result in the `[[rule-result-and-escalation-contract]]` shape, so a head never dumps raw work at the
operator.

## Steps

1. Run the appropriate review capability on the work product (code review for code, content review for
   copy, the relevant review agents for the domain).
2. Synthesize the findings into the result envelope: `work_product` link, `outcome`, the nine signals,
   and, when it escalates, the `escalation` block (item_class, recommended_option, counterargument,
   prepared context link).
3. Decide done-vs-escalate by the conservative escalation policy: external, canon-touching, low-
   confidence, or high-stakes results escalate through the membrane.
4. If the result escalates and warrants a review page, hand the packet to
   `[[workflow-render-review-page]]`.
5. Write the receipt (`departments/<slug>/receipts/`) for the action.

## Output

A structured result in the result-and-escalation-contract shape, ready for the membrane to route, plus
the receipt. The work product is the render artifact; this workflow does not self-approve it.

## Boundary

Domain-free and reusable by every head. It produces the packet; the surfacing policy and the operator
human-queue contract route it; the human decides. No self-approval of canon or own work.
