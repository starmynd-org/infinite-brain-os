# Department Head Operating Contract

This file is the operative contract for how a department head agent operates. Where
`department-assembly-rules.md` says what a department's durable surfaces must contain, and
`department-runtime-contract.md` maps those surfaces to runtime, this file says what the head agent that
runs the department must do: the work it classifies, the cadence it runs, the daily update it emits, and
when it escalates. It is the conformance bar every `entities/agents/<slug>-head.md` is measured against.

The reasoning behind the always-on head design (why the head is a stateless-per-cycle
loop, the reusable governance stack, and the Paperclip mapping) lives in the upstream
deployment's synthesis layer. This file is the operative "what must be true," not the "why."

How a head runs its loop with the wager ledger (the two intake lanes, the
observation-to-disposition-to-wager-to-verdict lifecycle, what the department owns via
`owning_department_id`, and how the rollup is its slice aggregated) is the operating guide
`knowledge/ai-architecture/playbooks/department-operating-guide.md`; the operative ledger contract is
`_system/wager-ledger-rules.md`.

## 1. What a head is

One department has exactly one head-of-department agent. It owns first-pass triage, orchestration across
specialist agents and workflows, the department's daily update and rollup, and escalation to the human
layer. It is a router and an operator, not a re-implementer: it loads the durable model, decides what
kind of work an item is, and delegates depth to skills, workflows, and SOPs.

The head is a stateless-per-cycle loop, not a long-lived mind. It holds no durable state in context.
Each cycle it re-hydrates from canonical files, acts, writes state back, emits receipts, and drops
context. Its working memory is an externalized state ledger that must be reconcilable from canonical repo
state (backlog, intake receipts, OPERATIONS rows, sprint statuses), never a second source of truth.
Dispatch is one authority with one level of nesting: the head spawns a scoper or workers; they return
artifacts and die; they do not spawn more agents except inside a bounded swarm run. See
`department-head-runtime.md` sections 1 and 2.

## 2. Work sources, the lane gate, and the judgment lifecycle

Every head classifies each unit of work into exactly one work source. The work sources are the operative
pairing of the trigger taxonomy (`entities/rules/trigger-taxonomy.md`) with the head's three inputs
(intake, backlog, recurring) from `department-head-runtime.md` section 6. "Work source" is the axis of
where work originates. It is distinct from the wager ledger's two intake lanes (section 2a), which
classify how an inbound item is handled. The word "lane" is reserved for that deterministic-versus-judgment
sense, per the disambiguation precedent in `_system/wager-ledger-rules.md`.

| Work source | Triggered by | What the head does | Implementing surface |
|---|---|---|---|
| intake / capture | a routed intake item, or a capture stub in `departments/<slug>/capture/` | pass the lane gate (2a); for a judgment-lane item run the lifecycle (2b), classify per the inbox spec, convert or escalate | `capture/INBOX.md` (the lane policy) plus the department triage SOP and `knowledge/ai-architecture/concepts/choosing-the-right-primitive.md` |
| recurring | a `scheduled:` or `lifecycle:` OPERATIONS row (daily, weekly, monthly, on-startup, on-closeout) | run the named workflow, playbook, or SOP for that row | the implementing entity named in the OPERATIONS row |
| incident / condition | a `condition:` OPERATIONS row fires (a failure, anomaly, freshness miss, or declared state match) | triage AI-first, remediate what is testable in-org, escalate what the gates reserve | the condition row's procedure plus the escalation gates in section 4 |
| on-call | another agent or department invokes a callable capability | run the requested capability and return a structured result | the `on-call:` row's implementing entity |
| backlog | scoped, prioritized work waiting to run | order by the priority model, dispatch a scoper or worker, reconcile the result | `entities/rules/priority-model.md` and the prioritize-backlog skill |

One unit of work gets exactly one work source. If an item could enter more than one, the head splits it
so each is unambiguous, mirroring the one-trigger-per-row rule in the trigger taxonomy.

### 2a. The lane gate (WAGER-12): deterministic versus judgment

Inbound items in the intake work source pass a cheap deterministic classifier before any scoring, per
`_system/wager-ledger-rules.md` (WAGER-12). An item that matches a known pattern with a deterministic
handler (spam, newsletter, receipt, duplicate, known-sender-known-action) takes the **data-handling
lane**: handled by rule and logged as one thin `intake_event`, with no scoring, no wager, and no
lifecycle. Only the residue (ambiguous, novel, or actionable) takes the **judgment lane**, is scored, and
promotes to an `observation` that enters the lifecycle below. Both lanes write an `intake_event` so
auto-handling stays auditable. A department declares which inbound patterns are deterministic and which
are judgment in its `departments/<slug>/capture/INBOX.md`: that file is the head's lane policy and the
onboarding gate's required lane declaration.

### 2b. The judgment-work lifecycle and wagers

A judgment-lane observation runs the OODA lifecycle
`observation -> routing -> disposition -> (wager?) -> action -> verdict -> improvement`, defined in
`knowledge/ai-architecture/playbooks/department-operating-guide.md` and contracted in
`_system/wager-ledger-rules.md`. The head:

- carries `owning_department_id` on every observation it owns (inherited by its disposition and wager), so
  it sees and manages only its slice of the board;
- records a `disposition` by reference (type task, knowledge, charter, architecture, swarm, or reject)
  that points to the realized entity and never duplicates it; a `swarm` or investigate disposition is
  non-terminal and chains to a child action disposition that carries the wager;
- pre-registers a **wager** before any consequential action: a falsifiable, business-grounded prediction
  stating `expected_revenue_impact` and `expected_contribution_profit_impact` (a cost-only action sets
  revenue to 0 and books the saving as profit; a department whose value is indirect estimates the
  downstream economic value its work will create elsewhere, with an explicit basis and lower confidence),
  plus scope, comp scenario, dataset, and date range, so the verdict compiles to a BI query and scores
  against an exogenous metric. A knowledge-update disposition records a truth, not a bet, and carries no
  wager;
- books lifecycle receipts mechanically at the three moments (disposition-created, wager-registered,
  result-produced); the heartbeat reconciles the board from canonical state and flags any unbooked
  consequential action, and booking coverage is a tracked safety metric.

The board (`item_lifecycle`, `component_health`, `calibration`) is a computed projection in the analytical
plane, reconciled from these receipts. The head never hand-maintains it and keeps no second backlog.

## 3. The daily update and rollup

Every head emits the daily department update via `workflows/department-daily-update.md`. The update is
goal-directed, not status-only: beyond what came in, was processed, changed, is blocked, and needs human
review, it emits a ranked forward plan to advance the department's charter goals, each action naming its
mechanism (an SOP, an automation, an agent or workflow, or a project task) with an impact estimate
grounded in `entities/rules/signal-vocabulary.md` and ordered by `entities/rules/priority-model.md`.

The update rolls up to `fleet-coordinator` in the envelope defined by the department-head reporting
contract (`.claude/rules/department-head-reporting-contract.md`). Human-bound items in the rollup are
referenced by id only; they travel through the chief-of-staff membrane, not in the rollup body and not
direct to the operator. The weekly summary uses the same envelope at a coarser cadence. Every
consequential cycle writes an append-only receipt under `departments/<slug>/receipts/`.

The rollup is the department's slice of the wager-ledger board, not a second source: its intake,
processed, changed, blocked, next, and health are projections of the department's `item_lifecycle` and
wager outcomes filtered by `owning_department_id`, and it reconciles from the board per the reporting
contract (WAGER-16c). Consequential forward-plan items in the daily update graduate into pre-registered
wagers per `workflows/department-daily-update.md` (the impact estimate becomes expected revenue and
contribution-profit, the assumption becomes the predicted metric).

## 4. The escalation taxonomy

A head decides complete-in-org versus escalate by the result-and-escalation contract
(`.claude/rules/result-and-escalation-contract.md`) over the shared signal vocabulary
(`.claude/rules/signal-vocabulary.md`), and routes escalations by the surfacing policy
(`.claude/rules/surfacing-policy.md`). The standing gates that always escalate, regardless of other
signals:

- `external`: the work sends, publishes, deploys, spends, or modifies an external runtime
- `canon-touching`: the work proposes or performs a canon change
- low confidence below the operator-set threshold
- high or critical stakes that are costly or irreversible, with no matching pre-approval

A head resolves and verifies in-org what is testable by automated CLI, query, or browser checks. It
escalates as a structured result through the chief-of-staff membrane; it never messages the operator
directly and never self-approves canon or its own work product. At L1 the posture is conservative:
nothing auto-handles, everything human-bound batches or escalates-urgent.

## 5. Autonomous launch, where enabled

A head may launch a well-scoped swarm autonomously only through the machine-checkable launch-readiness
gate in `department-head-runtime.md` section 3 (brief well-formed, work reversible and isolated, cost
within cap, scoper confidence clears threshold). It records a file-backed launch receipt. At L1 this gate
stays conservative and human-gated per `knowledge/ai-architecture/playbooks/swarm-launch-governance.md`;
autonomous launch is enabled per department only after its review panel and reversibility are proven.

## 6. Conformance checklist for a head agent file

A `entities/agents/<slug>-head.md` conforms to this contract when it states, concretely and not
generically:

```
[ ] boundary and ownership: what the department owns and explicitly does NOT own
[ ] load-orientation step: the namespace canon + INDEX + CHARTER + OPERATIONS it reads first
[ ] the section 2 work sources made concrete: the department's real items per source
[ ] a named implementing entity (workflow, playbook, SOP, or skill) for each source it uses, not inline steps
[ ] the lane policy (deterministic vs judgment) is declared in capture/INBOX.md; observations carry owning_department_id
[ ] consequential actions pre-register a wager (section 2b, _system/wager-ledger-rules.md); knowledge updates do not
[ ] the daily update + rollup emission to fleet-coordinator (goal-directed, rollup is the department board slice, per section 3)
[ ] the section 4 escalation gates plus the department's standing human gates
[ ] constraints: no live state in git, secrets by reference only, no self-approval of canon, reports via the chief-of-staff membrane
[ ] reports_to: fleet-coordinator (chief-of-staff is the protected-peer exception)
```

Your first conforming head agent becomes the reference implementation. A head below this bar is
upgraded to it; a department with no head gets one built to it. The agent file is where the lane routing
physically lives: the contract is the standard, the agent is the department-specific realization.

## 7. Boundaries

- git is the source of truth; the runtime substrate (Paperclip, n8n) owns live state, reconcilable from
  git per `department-runtime-contract.md` and the Paperclip boundary.
- the head loads the shared rules and the department's owned entities and applies them; it does not
  improvise governance.
- the head reports to `fleet-coordinator` for cross-department coordination; the chief-of-staff is the
  protected peer that reports to the operator and syncs with the fleet coordinator rather than into it.

## Relationship

This contract ties together the rules a head reads: the trigger taxonomy (work-source vocabulary), the priority
model (backlog ordering), the signal vocabulary (the nine signals and hard flags), the result-and-escalation
and surfacing-policy rules (the escalation path), and the department-head reporting contract (the rollup
envelope). It is the operative companion to `department-head-runtime.md` (the design reasoning) and is
checked against the assembly and runtime contracts for the surfaces it consumes.
