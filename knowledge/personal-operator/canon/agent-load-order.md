# personal-operator load order

Read canon first, then load by query class. This namespace is small and operator-specific; the load
order is correspondingly simple.

## Load first

1. `core-doctrine.md`: the compressed model of what this namespace is and who reads it.

## Query classes

- **Who is the operator as an operator** (deep-work windows, communication style, risk and reversibility
  posture, default item classes): load `pillars/operator-profile.md`.
- **How the chief-of-staff uses this model** (surfacing, prioritization, attention gating): load
  `core-doctrine.md`, then the doctrine in `ai-architecture`:
  `human-interaction-membrane` and `operator-priority-and-surfacing-model`.
- **What the operator's tuning values are** (priority weights, auto-handle cutoffs, shadow threshold,
  rule-edit authority, review cadence): load `operator-tuning-decisions` once built. Until
  then, the values are operator-input-required in `pillars/operator-profile.md`.
- **the operator's goals and alignment** (goals, task-and-time alignment): load `goal-tracking-and-alignment`
  once built, mapped onto Paperclip Goals.
- **Operator reviews and trends** (daily, weekly, monthly, quarterly review notes and their distilled
  trends): load the `operator-review-cadence` PKM graph once built.
- **A prior operator decision** (a tooling fit, the namespace-buildout method): load the
  matching node under `decisions/` or
  `playbooks/namespace-buildout-sprint-pattern.md`.

## Teaching scaffolds (not load-bearing)

The fictional teaching templates moved to `_examples/` on graduation. They demonstrate node anatomy and
are never cited as fact. See `synthesis/template-vs-real-guide.md` for the disambiguation. The canonical
repo-wide doctrine scaffold is `knowledge/_examples/doctrine-example/`.
