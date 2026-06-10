# personal-operator

This is the durable model of the operator as an operator: how he works, how he decides, what he wants, and
how the system should treat his attention and time. The chief-of-staff department owns this namespace
and reads it to order work, gate attention, schedule the day, and track time against goals. It is a
serious retrieval target with a full canon layer.

It graduated from a reduced-base sandbox to a serious namespace on 2026-06-03 (an internal buildout). The fictional teaching templates it used to carry moved
off the load-bearing path into `_examples/`.

## Profile

Doctrine profile, serious base. `canon_posture: full`, `archive_posture: none`,
`freshness_posture: review-on-edit`. Carries the full serious base (`INDEX.md`, `canon/`, `playbooks/`,
`support/`, `synthesis/`) plus the doctrine-profile folders (`pillars/`, `concepts/`, `decisions/`). The
profile model is explained in [[namespace-profiles]] and [[profile-aware-knowledge-graph-design]]. The
operative registry entry is `_system/namespaces/personal-operator.md`.

## Load first

1. [[personal-operator-core-doctrine]]: the compressed model of what this namespace is, who reads it,
   and the skeleton-now posture. Read it whole before expanding.
2. [[agent-load-order]]: the load-order controller, by query class.

## What is here

Real operator doctrine (trust and maintain):

- [[operator-profile]]: the load-bearing pillar. Deep-work windows, communication style, risk and
  reversibility posture, and the default approve/want/ignore item classes the surfacing policy reads.
  A skeleton as of 2026-06-03: the structure is fixed, the operator-specific values are
  operator-input-required.
- your own surface-fit and tooling decisions land in `decisions/` as you make them.
- [[namespace-buildout-sprint-pattern]]: a real, reusable namespace buildout and migration
  methodology.

Operator model and reviews (planned; build them as you activate the operator model):

- [[operator-tuning-decisions]]: the five operator-set values that tune the priority model and the
  surfacing policy. Structure fixed; values operator-input-required (filled in the activation project).
- [[goal-tracking-and-alignment]]: how the operator's goals are tracked (mapped onto Paperclip Goals) and how
  his tasks and time stay aligned with them.
- [[operator-review-cadence]]: the daily, weekly, monthly, and quarterly review interviews captured as a
  PKM graph and distilled into trends.

Teaching scaffolds (fictional, not load-bearing, in `_examples/`):

- [[about-this-company]]: a pillar template (fictional "Acme Analytics"). Copy the shape, never the
  content.
- [[example-concept]]: a concept template (fictional attribution-window example), with intentional
  fill-me-in links.

See [[template-vs-real-guide]] for the disambiguation between the real doctrine and the teaching
scaffolds.

## What this namespace drives

- the chief-of-staff surfacing policy (what reaches the operator versus what batches or auto-handles)
- the per-head prioritization weights that order work
- the deep-work category boundary in the operator time fact table
- the schedule the chief-of-staff proposes and the operator owns
- the alignment check between the operator's tasks, time, and goals

## What does not live here

Per [[surface-boundary]]: live queue state, in-flight approvals, and the learned-rules live registry
stay in the runtime substrate (Paperclip). Raw time data and the time fact table values stay in the
Example Co data layer (BigQuery); git holds only the Data-node pointer. Secrets stay in the root
`secrets/` registry as references; raw values bind at runtime.

## Common misreadings

- Citing a teaching scaffold as fact. The `_examples/` nodes are fictional. Never quote their numbers
  or claims.
- Inventing the operator's operator values. The operator profile's structure is canonical; its values are set
  by the operator as logged decisions, never guessed by an agent.
- Expecting canon to hold the operator's goals or live state. Canon holds the durable model and routes; goals
  and reviews are their own nodes, and live state is runtime.

## Map

```text
knowledge/personal-operator/
  INDEX.md                       # this router
  canon/
    README.md                    # what canon means here (navigational)
    core-doctrine.md             # the keystone (knowledge node)
    agent-load-order.md          # load order by query class (navigational)
  pillars/
    operator-profile.md          # the load-bearing operator model (skeleton)
  concepts/                      # operator concepts (grow as needed)
  decisions/
  playbooks/
    namespace-buildout-sprint-pattern.md    # real doctrine
  support/
    README.md                    # provenance and the graduation receipt
  synthesis/
    README.md                    # navigational
    template-vs-real-guide.md    # template-vs-real disambiguation
  _examples/
    about-this-company.md        # teaching template (fictional)
    example-concept.md           # teaching template (fictional)
```
