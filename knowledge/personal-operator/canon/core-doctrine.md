---
id: "knowledge-personal-operator-canon-core-doctrine"
aliases: ["knowledge-personal-operator-canon-core-doctrine", "personal-operator-core-doctrine", "personal-operator-canon"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Compressed first-principles of the personal-operator namespace: the durable model of the operator as an operator, owned by the chief-of-staff department. It holds the operator profile, the operator-tuning decisions, the goals knowledge, and the operator-review PKM graph. It is the operator's identity layer the surfacing and prioritization policies read; it never holds live queue state, raw time data, or secrets."
confidence: 0.6
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-06-03"
verified_by: "operator-pending"
edges:
  - target: "[[knowledge-personal-operator-operator-profile]]"
    relation: "anchors"
    confidence: 0.9
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.85
created: "2026-06-03"
---

## Read this first

This is the canon of the `personal-operator` namespace. It is the compressed model a future agent
reasons from before expanding into the namespace. Read it whole, then load the specific pillar,
decision, or playbook the question needs via [[agent-load-order]].

This namespace graduated from a reduced-base sandbox to a serious namespace on 2026-06-03 (an internal buildout). The fictional teaching templates it used to carry moved
to `_examples/` and are no longer on the load-bearing path. See `support/README.md` for the
graduation provenance.

## 1. What this namespace is

`personal-operator` is the durable model of the operator as an operator: how he works, how he decides, what
he wants, and how the system should treat his attention and time. It is the operator's identity layer.
The chief-of-staff department owns it and reads it to do its job: order work, gate attention, schedule
the day, and track time against goals.

It answers, durably and in git: what are the operator's deep-work windows, how should the system communicate
with him, what is his risk and reversibility posture, which item classes does he always approve, always
want, or never need, what are his goals, and what do his reviews surface over time.

## 2. Who consumes it

The named consumer is the chief-of-staff department and, through it, every department head and the fleet coordinator.
The `human-interaction-membrane` reads this namespace to decide what reaches the operator; the
`operator-priority-and-surfacing-model` reads it for the prioritization weights and the surfacing
cutoffs. The model is built so the system can need the operator less over time without ever hiding what
matters from him.

## 3. What lives here, and what does not

In this namespace (durable, in git):

- the [[knowledge-personal-operator-operator-profile]] pillar: deep-work windows, communication style,
  risk and reversibility posture, and the default approve/want/ignore item classes
- the operator-tuning decisions (the five operator-set values: priority weights, stakes-by-reversibility
  cutoffs, shadow-mode threshold N, rule-edit authority, daily-review cadence), built as you activate the operator model
- the goals knowledge node, mapped onto Paperclip Goals, built as you activate the operator model
- the operator-review PKM graph (daily, weekly, monthly, quarterly review notes distilled into trends),
  built as you activate the operator model

Not here, per [[surface-boundary]]:

- live queue state, in-flight approvals, and the learned-rules live registry (runtime substrate,
  Paperclip)
- raw time data and the time fact table values (the Example Co data layer, BigQuery; git holds only the
  Data-node pointer)
- secrets and credentials (the root `secrets/` registry holds references; raw values bind at runtime)

## 4. The skeleton-now posture

As of 2026-06-03 the operator profile is a skeleton: the structure is fixed and load-bearing, but the
operator-specific values are operator-input-required. This is safe because the chief-of-staff runs at
L1 with surfacing learning OFF: everything batches to the operator, nothing auto-handles, so no operator
value is needed to run safely. The values are filled as logged operator decisions, and each change is a
correction that tunes the surfacing rules per `operator-priority-and-surfacing-model`.

## 5. What this namespace drives

- the chief-of-staff surfacing policy and the per-head prioritization weights
- the deep-work category boundary in the operator time fact table
- the schedule the chief-of-staff proposes and the operator owns
- the alignment check between the operator's tasks, time, and goals

## Changelog

- 2026-06-03: initial canon on graduation from reduced-base sandbox to serious namespace (sprint
  an internal buildout). Authored at verified_by operator-pending; the operator
  signs off.
