---
id: "knowledge-ai-architecture-synthesis-feedback-plane-act-to-orient-loop"
aliases: ["knowledge-ai-architecture-synthesis-feedback-plane-act-to-orient-loop", "feedback-plane-act-to-orient-loop", "feedback-plane", "act-to-orient-feedback-plane"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Spec for the missing half of the brain's OODA web: the Act-to-Orient feedback plane. The architecture has strong feed-forward (intake to orient to decide to act) and almost no feedback, which in Boyd's terms is a loop that cannot stay matched to reality. The single feedback-plane build restores interaction with outcomes, gives novelty a trigger, and completes the Act-to-Orient and Act-to-Observe arrows that make OODA a web rather than a pipeline."
confidence: 0.83
retrieval_class: "domain"
export_class: "public"
edges:
  - target: "[[knowledge-ai-architecture-canon-core-doctrine]]"
    relation: "supports"
    confidence: 0.88
  - target: "[[synthesis-boyd-to-agent-architecture-ooda-map]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "implemented_by"
    confidence: 0.9
created: "2026-06-17"
---

## The claim

The brain has rich feed-forward and almost no feedback. Intake flows to orientation,
orientation to a thin decide, decide to action. What does not flow back is the result:
whether the action worked, whether reality matched expectation, whether the orientation
that produced the action is still matched to the world. In Boyd's terms this is not a
smaller loop, it is a broken one. Boyd's 1995 diagram has more arrows running backward and
sideways than forward, and the two that matter most for staying alive are Act-to-Orient
(results update the mental model, the double loop) and Act-to-Observe (results update what
data you gather). A system missing both cannot detect its own mismatch and therefore cannot
re-orient. It can only drift until an operator corrects it by hand.

This is why the feedback plane is the highest-leverage OODA work in the system, above more
autonomy and more departments. The full reasoning is in the bridge
[[synthesis-boyd-to-agent-architecture-ooda-map]]: building it closes the three weakest
points of Boyd's own diagnostic test at once.

- It restores **interaction with outcomes** (meta-primitive 1, the weakest axis). A system
  cut off from feedback decays; one that interacts adapts.
- It gives **novelty a trigger** (meta-primitive 3). Today correction-to-structure is
  operator-driven; with a mismatch signal the system can flag when its own orientation has
  gone stale.
- It completes the **web** (meta-primitive 2's framing). Feed-forward plus feedback is a
  loop; feed-forward alone is a pipeline.

## What it maps to in the audited gaps

This spec is not new scope invented from Boyd. It is the Boyd reading of gaps the
architecture had already audited in the deployment this starter derives from:

- The analytical plane had no owner, schema, or consumer, so every charter KPI was
  stranded. That stranded plane is exactly the Act-to-Orient arrow with no wire attached.
- Cascade containment and poison-rule quarantine needed a sensor. A feedback plane that
  tracks per-department error, mis-surface, and escalation rates is the sensor a quarantine
  state reads from.
- The standing operating scorecard and weekly review cadence needed a data source. The
  scorecard is the operator-facing projection of the feedback plane.

Boyd's contribution is to say why these are one build and why it is first, not fifth:
without it the loop is not a loop.

## What the feedback plane is

A third truth plane, distinct from git (canon and contracts) and the runtime substrate
(live queues and approvals), per the surface boundary. It is the analytical history:
append-only, owned by your operations lane, living wherever your durable runtime lives,
never a second source of canon. Git holds the contract and the schema; the plane holds the
measured history.

It ingests, from the receipts the system already emits:

- head-loop receipts (what each department head did each cycle)
- launch and closeout receipts (what swarms and sprints produced)
- result-and-escalation envelopes (outcome: success, denied, escalated, halted, no_op)
- review verdicts (what the operator accepted, rejected, or overrode)
- intake dispositions (what was promoted, deferred, rejected, and whether that held up)
- cost records (tokens and spend per actor and action)

It emits one thing the system does not otherwise have: a **mismatch signal**. For any
action with a stated expectation (a scoper's acceptance criteria, a priority model's
predicted unblocking, an intake score's predicted relevance), the plane records expectation
against outcome and surfaces the gap. Mismatch is the raw material of re-orientation. Per
Boyd, mismatch is not failure but fuel: the signal that destruction and creation are due.

## The three consumers that close the arrows

1. **Correction-to-structure trigger (Act-to-Orient).** When mismatch on a given pattern
   crosses a threshold, the plane raises a candidate for the correction-to-structure loop:
   a rule, playbook, decision, or canon revision is due. This turns the operator-driven
   loop into one the system can initiate, while keeping the operator as the approver
   (canon is never self-approved).
2. **Priority and surfacing re-weighting (the learning the L1 posture defers).**
   Mis-surface rate is already named as the safety metric in the surfacing policy. The
   plane is where that rate is measured, so the operator can tune weights and confidence
   thresholds against real data instead of intuition, and so the auto-handle circuit can be
   widened only as measured accuracy earns it.
3. **Fleet health view (Act-to-Observe).** The plane feeds the fleet view and the executive
   brief with per-department liveness, queue age, autonomy level, cost-versus-outcome, and
   review false-pass rate. This is Act-to-Observe: results change what the system and the
   operator look at next.

## The re-orientation trigger (the part that makes it a web)

The single mechanism that distinguishes this from ordinary observability: a standing rule
that when a department's mismatch, escalation, or mis-surface rate crosses a threshold, the
department drops to observe-only (a quarantine state) and raises a re-orientation
candidate. This is the architectural form of Boyd's claim that an orientation generating
persistent mismatch must be broken down and rebuilt, not pushed harder. It also doubles as
the cascade-containment guardrail: a department that has drifted stops acting before it
propagates.

## Implementation: the wager ledger

This spec is implemented by the wager ledger, decided in
[[wager-ledger-and-scientific-loop]] and governed by `_system/wager-ledger-rules.md`. The
mismatch signal this node calls for is the wager's `surprise` field: a pre-registered,
falsifiable prediction tied to a metric, scored later against an exogenous result and
diagnosed. The lifecycle (observation, routing, disposition, wager, verdict, improvement)
makes the brain the bookkeeping layer for AI harnesses and turns the corpus into a lab
notebook of tested hypotheses.

## Scope boundaries

- The plane measures and signals. It does not decide canon and it does not auto-approve.
  Every re-orientation candidate it raises is operator-gated, consistent with the
  result-and-escalation and surfacing contracts.
- Live in-flight state stays in the runtime substrate; the durable measured history is the
  plane; the schema and the thresholds are the contract in git. No plane value is a second
  source of truth for canon.
- This node is a spec, not a running system. Nothing in this starter operates a feedback
  plane; the wager ledger it hands off to is a ratified design with an operative contract,
  built when a deployment activates it.

## Open questions

- The mismatch metric needs a concrete definition per action class (what counts as
  expectation, what counts as outcome, what threshold triggers re-orientation). This is the
  first design task.
- Whether the re-orientation trigger and the cascade-containment quarantine are one
  mechanism with two thresholds or two mechanisms. The spec treats them as one; this should
  be validated against the first real multi-department run.
- How far the auto-initiated correction-to-structure loop may go before an operator sees
  it. The conservative default (it only raises candidates, never lands structure) is
  assumed here.

## Promotion status

This is a `synthesis` node, not canon. The bounded canon edit its reading implies was
promoted separately, operator-gated, in the deployment this starter derives from
(core-doctrine sections 14 and 15.2). Canon is never self-approved.
