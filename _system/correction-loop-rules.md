# Correction Loop Rules

Operative procedure for absorbing a recurring human correction into durable structure
instead of re-paying it in chat every session. This file is the executable rule layer.
The reasoning and the three-question test live in [[correction-loop-absorption]].

Scope: contract Part 11 (correction to structure) and Part 8 (where absorbed structure
lands). This file states the recurrence threshold, the triage procedure, the routing
table, and what is checkable.

## What a correction loop is

A correction loop is the pattern where an agent produces output, a human corrects it, the
agent complies for that turn, and the underlying durable structure stays unchanged, so the
next session reproduces the original error. Each repeat is wasted operator attention and a
signal that some durable surface is missing or wrong.

Absorption converts the recurring correction into a structural change one time. After
absorption, the loading agent reads the corrected structure and produces the right output
without further intervention.

## The third-time test (the recurrence gate)

Rule CORR-1: a correction is absorbed when it has occurred a third time, or when the
operator explicitly predicts it will recur. The first occurrence is a one-off fix. The
second is a coincidence. The third is a pattern, and a pattern is a defect in durable
structure.

Rule CORR-2: the operator may short-circuit the test. If the operator says "make this a
rule" or "this will keep happening," absorb on the first occurrence. Operator prediction
overrides the count.

Rule CORR-3: a correction tied to a single throwaway artifact, a correction the operator
marks as context-specific, or a correction that contradicts settled canon without a
deliberate revision does NOT get absorbed. Absorbing one-offs bloats the durable surface
and trains agents on noise.

## The three questions (triage)

Run all three on every candidate before absorbing. They decide whether to absorb and where
the correction lives. The reasoning behind them is in [[correction-loop-absorption]].

1. What correction recurs. Name the specific, repeated correction in concrete terms. State
   it as the rule the agent keeps breaking, not as the symptom. If it cannot be named
   concretely, it is not yet a loop.
2. What structure absorbs it. Choose the durable home by the kind of correction (see the
   routing table). A constraint on how to write or act becomes a rule. A repeatable
   procedure done wrong becomes or amends a playbook. A relitigated choice becomes a
   decision node. A shift in first-principles understanding becomes a canon revision.
3. Where it lives. Route the structure to the right namespace and folder, then link it so
   the loading agent actually reads it. Absorption that lands in a file no agent loads has
   not closed the loop.

## Routing table: correction kind to durable home

Rule CORR-4: absorb into exactly one of these four homes per correction. Pick the lightest
home that fully closes the loop.

| Correction kind | Durable home | Location |
|-----------------|--------------|----------|
| Standing constraint on voice, format, or behavior across sessions | Rule | `entities/rules/` |
| A recurring procedure executed wrong | Playbook (new or amended) | `knowledge/<ns>/playbooks/` |
| A choice that keeps getting relitigated | Decision node | `knowledge/<ns>/decisions/` |
| A change in compressed first-principles understanding | Canon revision | `knowledge/<ns>/canon/core-doctrine.md` |

Rule CORR-5: a canon revision is the heaviest absorption and follows the canon contract
(contract Part 3). It is operator-approved, provenance-bearing, and recorded in the canon
`## Changelog` with a date and a one-line reason. Do not revise canon to absorb a
correction without operator approval.

## Procedure

1. Detect. A curator agent or the operator flags a correction that has recurred. Apply the
   third-time test (CORR-1) or accept an operator override (CORR-2).
2. Triage. Run the three questions. If the recurrence gate fails or CORR-3 applies, stop
   and leave the correction in chat.
3. Route. Pick the single durable home from the routing table (CORR-4). Prefer the lightest
   home that fully closes the loop: a rule over a playbook, a playbook over a decision, a
   decision over a canon revision, unless the correction genuinely changes doctrine.
4. Write. Create or amend the target file with correct frontmatter and the voice rules.
   State the absorbed correction as a standing instruction, not as a narrative of the
   incident.
5. Link. Add edges so the loading agent reaches the new structure: link from the namespace
   `INDEX.md` load surface or query class where relevant, and add `edges` to and from
   related nodes.
6. Mirror entities. If the home is a rule (or any executable entity), update the `.claude/`
   and `.codex/` adapters (symlink or run `bash sync-adapters.sh`) so both runtimes see it.
7. Verify closure. Confirm the structure is on a path the relevant agent actually loads.
   Run `bash _system/validate.sh` and fix any error.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- a canon revision must keep its `## Changelog` section and `verified_at` / `verified_by`
  frontmatter present (canon checks)
- new entity files must carry valid frontmatter and resolve their `[[wikilinks]]`
- the em and en dash ban applies to the absorbed text

Fuzzy (curator agent, not validate.sh):

- whether a correction has actually recurred and crossed the third-time test
- which of the four homes is correct
- whether the correction genuinely changes doctrine (canon) or is just a constraint (rule)
- whether the absorbed structure is reachable by the agent that needs it

## Anti-patterns

- Absorbing a one-off. The recurrence gate exists to prevent this.
- Re-correcting in chat after the third occurrence. That is the loop the rules close.
- Writing the absorbed correction as a story ("the agent kept doing X") instead of a
  standing instruction ("always do Y").
- Landing the structure in a file no agent loads. Unlinked absorption does not close the
  loop.
- Revising canon to absorb a correction without operator approval and a changelog entry.

## Notes

The why and the three-question test live in [[correction-loop-absorption]]. This file owns
the recurrence threshold, the routing table, and the closure procedure. Curator agents
surface candidates as a fuzzy check; the operator approves any canon revision.
