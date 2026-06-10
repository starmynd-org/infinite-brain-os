---
id: "skill-review-output-linkage"
aliases: ["skill-review-output-linkage", "review-output-linkage"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Verify each namespace's canon actually drives real outputs by checking the What this namespace drives surface against the outputs and decisions it claims to improve."
confidence: 0.88
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to test whether a namespace's canon is load-bearing: confirm the outputs, projects, or decisions it claims to drive really consume it, and flag canon that drives nothing."
edges:
  - target: "[[output-linkage-review-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[retrieval-eval-rules]]"
    relation: "depends_on"
    confidence: 0.8
  - target: "[[canon-layer-schema]]"
    relation: "informed_by"
    confidence: 0.78
  - target: "[[skill-apply-correction-loop]]"
    relation: "related_to"
    confidence: 0.6
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# review-output-linkage

Test whether a namespace earns its keep. Output is first-class (contract Part 11): every
namespace must answer what outputs its canon drives, and that claim must be true, not
aspirational. This skill verifies the `## What this namespace drives` surface in
`INDEX.md` against reality, following [[output-linkage-review-rules]]. Canon that drives
nothing is either premature or rot.

## Use when

- a namespace upgrade is being closed and you need to confirm the canon is load-bearing
- a periodic review (weekly or monthly) checks whether namespaces still drive real work
- a namespace has grown but no recent output or decision cites it
- you suspect a namespace is accumulating canon faster than it changes any output

## Do not use when

- the namespace is a deliberate starter or example scaffold that declares it drives
  nothing yet (for example `personal-operator` or a `knowledge/_examples/*` namespace)
- the namespace is brand new and has not yet had a chance to drive an output (give it a
  review window first)
- you are checking structural validity rather than output linkage (that is
  `validate.sh` plus the lint skill)

## Goal

Confirm, for one namespace, that the outputs, projects, and decisions its `INDEX.md`
claims to drive actually consume its canon, and surface every claimed driver that does not
and every real consumer that the `INDEX.md` failed to list.

## Required outputs

1. A linkage report for the namespace listing each claimed driver from
   `## What this namespace drives` with a verdict: confirmed consumer, stale claim (the
   output no longer cites the canon), or missing (a real consumer not listed in INDEX.md).
2. A proposed edit to the namespace `INDEX.md` `## What this namespace drives` section
   that makes the claim match reality.
3. A flag for any canon node that no confirmed driver consumes, routed for review (prune,
   demote, or accept with a stated reason).

## Build steps

1. Read the namespace `INDEX.md` `## What this namespace drives` section
   ([[namespace-index-schema]]). List each claimed output, project, or decision.
2. For each claimed driver, find the consuming artifact by grep and read across
   `outputs/`, `projects/`, `decisions/`, and any cited workflow or agent. Confirm it
   actually references the namespace canon (by wikilink, by path, or by clear content
   dependence).
3. Run the reverse check. Grep for files that cite this namespace's canon but are not
   listed in `## What this namespace drives`. These are missing claims.
4. Cross-check against the namespace retrieval eval set if one exists
   ([[retrieval-eval-rules]]): the eval queries name what the namespace is supposed to
   answer, which is a second view of what it should drive.
5. Flag canon with no consumer. A `canon/core-doctrine.md` that nothing reads is either
   too new, mis-scoped, or rot. Route it per [[output-linkage-review-rules]]: prune,
   demote to `synthesis/`, or accept with a stated near-term consumer.
6. Produce the linkage report and the proposed `INDEX.md` edit. Apply the edit only with
   operator confirmation if it removes a claimed driver.

## Quality checks

- every claimed driver in `INDEX.md` has a verdict backed by a found (or not found)
  consumer, not an assumption
- the reverse check ran: real consumers missing from `INDEX.md` are surfaced
- canon nodes with zero confirmed consumers are flagged, not silently passed
- example and starter namespaces that declare they drive nothing are exempted, not failed
- the proposed `INDEX.md` edit makes the drives-claim match observed reality
- run `bash _system/validate.sh` if the `INDEX.md` edit is applied

## Anti-patterns

- accepting the `## What this namespace drives` claim at face value without finding the
  consumer
- skipping the reverse check, so real but unlisted consumers stay invisible
- treating canon that drives nothing as fine because it reads well
- failing an example namespace for declaring it drives nothing yet
- editing the INDEX drives-claim to remove a driver without operator confirmation
