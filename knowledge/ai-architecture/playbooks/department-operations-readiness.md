---
id: "knowledge-ai-architecture-department-operations-readiness"
aliases: ["knowledge-ai-architecture-department-operations-readiness", "department-operations-readiness", "department-readiness-checklist", "operating-readiness-gate"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The operating-readiness gate for a department: the bar a built department clears before it can run its own clock and its own inbox. It complements the build acceptance gate in build-out-a-department by pinning the operating layer at the contract level: a complete cadence register including the two universal lifecycle rows, the three department-web folders (capture, sops, receipts), and an intake inbox spec the intake fabric routes against. Defines the departments/<slug>/capture/INBOX.md convention."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[build-out-a-department]]"
    relation: "extends"
    confidence: 0.9
  - target: "[[department-web]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[department-assembly-model]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-17"
---

# Department Operations Readiness

## Relationship to the onboarding gate

The canonical acceptance gate for a new department is now [[department-onboarding-guide]] (its alignment
checklist, which is OODA and wager-ledger aware). This playbook is the operating-layer subset that feeds
that gate: it certifies the cadence register, the department-web folders, and the inbox spec. Where the
two overlap, the onboarding gate wins; this playbook adds the cadence and inbox detail the onboarding gate
references but does not spell out. The inbox spec defined here is the department's lane policy
(deterministic versus judgment) that the onboarding gate requires.

## When to use

Use this after a department has been built (it has `INDEX.md`, `CHARTER.md`, a head agent, and its
namespaces) and before you call it ready to operate. `build-out-a-department.md` owns the build and its
acceptance gate (architecture conformance, one real end-to-end item, a Paperclip render, a
built-but-not-working list). This gate is narrower and lives one layer in: it certifies that the
department can run its **clock** (its recurring and lifecycle cadence) and its **inbox** (what intake
deposits and how the department converts it). A department can pass the build acceptance gate and still
fail this one, because a register with no startup or closeout discipline and no declared inbox is a
folder that cannot reliably take input and act.

## The readiness bar

A department is operating-ready when all five are true.

### 1. The cadence register is complete

`departments/<slug>/OPERATIONS.md` follows `entities/rules/trigger-taxonomy.md` and carries, at minimum:

- `scheduled: daily` department update, pointing at `workflows/department-daily-update.md`. The daily
  update is goal-directed: beyond reporting state, it emits a short ranked forward plan to advance the
  department's charter goals, each action naming the mechanism it uses (SOP, automation, agent or
  workflow, project task, or a human-gated step) and an impact estimate grounded in
  `entities/rules/signal-vocabulary.md` and ranked by `entities/rules/priority-model.md`
- `scheduled: weekly` department summary, pointing at `workflows/weekly-review.md`
- `lifecycle: on-startup` session startup (the two universal lifecycle rows below)
- `lifecycle: on-closeout` session closeout
- every domain-specific recurring task the department actually owns (`scheduled: monthly`, `condition:`,
  `on-call:`), each pointing at an existing workflow, playbook, or SOP, never restating its steps

The register is a contract, not live state: no checkboxes, no "done today" markers. Runtime state lives
in the operational substrate per `_system/department-runtime-contract.md`.

### 2. The two universal lifecycle rows are present

Every department carries the same two lifecycle rows, identical except for the slug. They are what make
a department resumable and auditable across sessions.

| Task | Trigger | Implementing workflow or playbook or skill | Owner agent | Output target | Receipt requirement | Hard flags |
|---|---|---|---|---|---|---|
| Department session startup | `lifecycle: on-startup` | `entities/skills/manage-ai-session.md` and `knowledge/ai-architecture/playbooks/open-and-close-ai-session.md` | `<dept>-head` | Session record in `sessions/active/` and an initial-context note; scan `departments/<slug>/capture/` and open blockers before substantive work | Append-only receipt under `departments/<slug>/receipts/` keyed to the session id | `external: false; canon-touching: false` |
| Department session closeout | `lifecycle: on-closeout` | `workflows/session-closeout-review.md` | `<dept>-head` | Closeout review in `sessions/reviews/`; extract memory, PKM, follow-up, and swarm candidates; drain `departments/<slug>/capture/` into routed candidates | Append-only receipt under `departments/<slug>/receipts/` keyed to the closeout id | `external: false; canon-touching: false` |

### 3. The department-web folders exist

Per `knowledge/ai-architecture/canon/department-web.md`, the capture-to-build web needs physical homes:

- `departments/<slug>/capture/` with an `INBOX.md` (the intake inbox spec, below)
- `departments/<slug>/sops/` with at least one real SOP and a `README.md`
- `departments/<slug>/receipts/` (the audit home every register row already points at)

An empty SOP library is allowed at first, but the README must state the gap honestly rather than imply
coverage that does not exist.

### 4. The intake inbox spec is declared and wired

`departments/<slug>/capture/INBOX.md` is the department-side half of intake. The routing map
(`intake/routing/department-routing-map.md`) says which lane owns an item; the inbox spec says what that
lane's inbox accepts, what each accepted class needs, where it lands, and which register trigger it
fires. Without it the `condition:` rows in the register reference criteria that live nowhere. The spec
must be cross-linked from the routing-map row so the two surfaces agree.

### 5. The INDEX registry is filled

The `INDEX.md` maintained-builds, SOP-library, and capture-inbox sections name and link real assets, and
the relevant Open Gap is closed or restated. The INDEX is the legible map of what the web has built; it
must not lag the folders.

## The intake inbox spec convention

`departments/<slug>/capture/INBOX.md` declares, as a contract:

- **Accepted classes.** The typed kinds of item this inbox takes, derived from the department's
  "route here when" criteria in the routing map. One row per class.
- **Per class:** what it is, the minimum fields a deposited stub must carry, the conversion destination
  (a `knowledge/` node, an SOP, an n8n automation, agent architecture, or a Data pointer per
  `knowledge/ai-architecture/concepts/choosing-the-right-primitive.md`), the register trigger it fires,
  and the human-review posture.
- **Where deposits land.** Typed stubs in `departments/<slug>/capture/`, per the ambient-capture
  behavioral contract `entities/rules/department-web-capture.md`. When the owning department is unclear,
  capture routes to the root `intake/` fabric instead.
- **What does not belong here.** The mirror of the routing map's "does not own" column, so misroutes are
  caught at the inbox.

The spec is conservative by default: anything `external` or `canon-touching` is captured but never
auto-converted, and conversion or promotion escalates per `[[result-and-escalation-contract]]` and
`[[surfacing-policy]]`. Capture is cheap and safe; build is gated.

## What this gate does not cover

- It does not fire the clock. Whether a `scheduled: daily` row actually runs without a human is the
  runtime's job (the Chief-of-Staff heartbeat, n8n schedules, or Paperclip routines), staged separately.
- It does not approve canon or author the head agent. Those are operator-gated and owned by the build
  path.

## Readiness checklist

Copyable per department:

```
[ ] OPERATIONS.md has daily + weekly + both lifecycle rows + all real domain rows
[ ] the daily update emits a ranked forward plan with impact estimates, not status only
[ ] every register row points at an existing workflow, playbook, or SOP (no inline steps)
[ ] capture/ exists with INBOX.md
[ ] sops/ exists with a README and >= 1 real SOP (or an honest empty-state note)
[ ] receipts/ exists
[ ] capture/INBOX.md declares accepted classes, fields, destinations, triggers, review posture
[ ] INBOX.md is cross-linked from intake/routing/department-routing-map.md
[ ] INDEX maintained-builds + SOP-library + capture-inbox sections are filled, Open Gap restated
[ ] bash _system/validate.sh shows no new errors from these files
```

## Edges

- `extends` `[[build-out-a-department]]`: that playbook builds the department and gates its function;
  this gate certifies the operating layer once built.
- `depends_on` `[[department-web]]`: the capture-to-build model whose folders this gate requires.
- `depends_on` `[[department-assembly-model]]`: the required-shape contract this operationalizes.
