---
id: "knowledge-ai-architecture-points-orientation-currency"
aliases: ["knowledge-ai-architecture-points-orientation-currency", "points-orientation-currency"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Why the brain keeps a points and orientation currency: a value-weighted, actor- and department-attributed completion award that rewards throughput and orients attention toward the highest-value work, complementary to the wager ledger's exogenous value verdict and kept honest by it. Holds the orientation-currency theory, the Goodhart reasoning, the per-department improvement loop, and the dormant department-orientation read model. Operative contract: _system/points-orientation-rules.md."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-25"
verified_by: "operator-pending"
edges:
  - target: "[[rule-priority-model]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "complements"
    confidence: 0.9
  - target: "[[metric-effectiveness-points]]"
    relation: "explains"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "constrained_by"
    confidence: 0.85
  - target: "[[planning-to-execution-ladder]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[department-operating-guide]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-06-25"
---

# Points and Orientation Currency

## What this concept is

The reasoning behind the points and orientation primitive. The operative, checkable contract is
`_system/points-orientation-rules.md`; this node says why the primitive exists and how it stays honest.
A points award is a value-weighted, actor- and department-attributed record that a piece of prioritized
work was completed. The currency does two jobs at once: it rewards throughput, and because each award is
weighted by the item's value, the accrued total orients attention toward where the highest-value work is
and how much of it is actually getting done.

## Why a currency and not just a scoreboard

A raw completion count measures activity, not progress. The brain already scores value once, in the
nine-signal vocabulary ([[rule-signal-vocabulary]]) and the priority model ([[rule-priority-model]]). The
points currency reuses that scoring as its weight, so the same judgment that orders the backlog also sizes
the reward. That is what turns a scoreboard into an orientation signal: a thousand trivial completions do
not outscore one high-stakes, dependency-unblocking, charter-aligned completion. Points point the same
direction value does, by construction.

The currency is designed to orient two consumers. Today it orients the operator: finish the highest-value
next thing and the reward tracks the value, not the effort. Later it orients the self-serving AI
departments: a department reads its own accrued, value-weighted points as a focus signal (the read model
below).

## Complementary to the wager ledger, kept honest by it

The wager ledger ([[wager-ledger-and-scientific-loop]]) is the org's value truth: a pre-registered,
falsifiable prediction of business value scored against an exogenous metric at a horizon. Points are not a
second value system. The division is clean:

- the **wager verdict** is the lagging, exogenous outcome signal: did the bet create value.
- the **points award** is the leading, throughput signal: is high-value work moving, and which actor moved
  it.

They meet on the same action (joined by `wager_ref`), so they are reconcilable. This is what keeps points
honest. Because points reward throughput, they are gameable: Goodhart's law says that once the count
becomes the target, parties inflate it (split work, complete low-value items, re-close entities, claim AI
for human work) and the measure stops measuring. The wager ledger is the check. A slice that piles up
effectiveness-points while its wagers keep missing is doing busywork, not creating value, and is flagged.
When points and value diverge, value wins and the weighting is re-tuned. Effectiveness-points is therefore
a leading, diagnostic signal of AI leverage and momentum, never an optimization target. The full guardrail
is rule POINTS-7 in the contract.

## Actor attribution: the AI-leverage question

Every award carries `actor_type` (`human`, `ai`, `hybrid`) and `owning_department_id`. This is what lets
the brain ask the question the operator cares about: how much of the high-value work is the AI actually
accomplishing, and where. Attribution is evidence-based, inferred from who performed the completing work,
never self-declared by the party that benefits from the count, and `hybrid` is the honest default when
both contributed. Misattribution (claiming `ai` for human work) is the named failure mode the contract
guards against.

## The per-department improvement loop

The aggregate, effectiveness-points by actor by department, is defined once as a metric
([[metric-effectiveness-points]]). A department can run a real loop on it: pre-register a wager that a
specific change (a new skill, an automation, a rule) will raise its AI-accomplished effectiveness-points on
a slice, ship the change, then score the wager honestly against the ledger. The loop targets AI leverage
but is value-checked, so it cannot degenerate into points-farming. This is the orientation currency doing
its second job: steering a self-serving department toward the highest-leverage next investment.

## The department-orientation read model (dormant)

A department reads its own slice of the points board, filtered by `owning_department_id`, the same way it
reads its wager-ledger slice ([[department-operating-guide]]). It sees where its high-value points
concentrate, how much it is accomplishing via `ai` versus `human` versus `hybrid` (human-heavy high-value
slices are automation candidates), and which prioritized high-weight work is not moving (the next best
action). It uses this to choose focus, and it acts through the improvement loop above. The read model is
defined and dormant: it requires both the points runtime store and the wager-ledger runtime to be live
before a department can read a real tally. Until then it is design, not capability.

## What this drives and where to go next

This concept drives the points contract (`_system/points-orientation-rules.md`), the
effectiveness-points metric ([[metric-effectiveness-points]]), and a future coach surface that
ranks the backlog and books the award on completion (design only; nothing books points yet). It is the throughput-and-orientation complement
of the wager ledger's value truth; read `_system/wager-ledger-rules.md` and
[[wager-ledger-and-scientific-loop]] for the value side.
