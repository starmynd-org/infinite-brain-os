---
id: "knowledge-personal-operator-operator-review-cadence"
aliases: ["knowledge-personal-operator-operator-review-cadence", "operator-review-cadence"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "The operator review cadence: daily, weekly, monthly, and quarterly review interviews conducted with the operator and captured as raw notes (a PKM graph of Output nodes), then distilled into trends over time. Defines what each cadence covers, where raw notes and trends live, and how reviews read the time fact table and the goal-alignment check."
confidence: 0.55
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[personal-operator-core-doctrine]]"
    relation: "part_of"
    confidence: 0.85
created: "2026-06-03"
---

# Operator Review Cadence

Four nested review cadences, each conducted as an interview with the operator and captured as raw notes, then
distilled into trends. This is the reflection face of the chief-of-staff. The reviews read the time fact
table and the goal-alignment check, so reflection is grounded in what actually happened, not memory.

## The four cadences

- **Daily** (morning and evening): the queue, the day's proposed and confirmed time allocation, and
  tomorrow's plan. Short. Feeds the time fact table confirm loop.
- **Weekly**: time-versus-goal alignment (``skill-check-goal-alignment``), the surfacing-rule and
  auto-handle audit, the week's wins and drift, the next week's focus.
- **Monthly**: operator leverage and the KPI set (queue size and age, decision latency, auto-handle and
  mis-surface rates, protected deep-work time), the operator-profile and tuning review.
- **Quarterly**: goals review and reset, the big-picture trend across the quarter, structural changes to
  the operating model.

## Where raw notes and trends live

- **Raw notes (the PKM graph)**: each review produces an Output node under `outputs/operator-reviews/`
  with lineage to the conduct-operator-review workflow and the cadence. These are the durable raw
  reflection record. They are not canon and not live state.
- **Trends (distilled)**: periodically, the raw notes plus the time fact table are distilled into a
  trends reading in `knowledge/personal-operator/synthesis/` (interpretive, derived), and quantitative
  trends reference the time fact table Data node. Distillation follows the promotion path: raw notes to
  synthesis, never raw notes straight into canon.

## Boundary

The reviews are conducted with the operator (they are interviews, not autoreports); the actual runs are an
operator activity, deferred to the chief-of-staff activation project. The structure, the workflow, and
the homes are built here so a review can run the moment the operator sits down for one. Goals and operator
values are operator-input; reviews surface and reflect, they do not set them.
