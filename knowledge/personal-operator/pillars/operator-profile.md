---
id: "knowledge-personal-operator-operator-profile"
aliases: ["knowledge-personal-operator-operator-profile", "operator-profile"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "scratch"
summary: "Template operator profile for the adopter to fill in: deep-work windows, communication style, risk and reversibility posture, and the default approve/want/ignore item classes the surfacing policy reads. The structure is fixed and load-bearing; every value is a fill-in prompt until the operator sets it."
confidence: 0.3
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[personal-operator-core-doctrine]]"
    relation: "part_of"
    confidence: 0.9
created: "2026-06-03"
---

# Operator Profile

This pillar is the durable model of you as an operator. The surfacing and prioritization
policies read it to order work, gate attention, and schedule, so it is the load-bearing
pillar of this namespace. It holds stable operating truth about how you work and decide,
not live state and not your goals.

This file ships as a blank template. The sections below are the fixed structure the
surfacing and prioritization policies depend on. Replace each fill-in prompt with your
real values. Until you do, the system runs conservatively: surfacing learning stays OFF
and everything batches to you for review, which is safe without these values.

## 0. Who you are

- One paragraph: your role, what you spend your working time on, and what this brain is
  supposed to take off your plate.
- List the businesses, teams, or projects you operate, and your role in each.

## 1. Deep-work windows

When you do focused work, and the protected blocks the system must defend from
fragmentation and low-value interrupts.

- Primary deep-work window: write the daily time range and which days it applies to.
- Secondary or recovery window: write a second protected block, or state that none exists.
- Timezone: write the IANA timezone your windows are expressed in.
- Protected-block rule: during a deep-work window only urgent escalations interrupt;
  everything else batches to the next review. Adjust this rule only if you mean to.

## 2. Communication style

How the system should write to you and how briefs should be shaped.

- Briefing format: name the brief shape you want (for example: decision requested,
  recommendation, why now, evidence, counterargument, raw links).
- Voice: name the voice rules outputs must follow, or point at [[rule-voice-and-style]].
- Tolerance for length: state whether you want concise tables or fuller prose, and any
  hard length limits.
- Preferred channels and their stakes: list each channel you use, what may arrive on it,
  and where approvals happen. Keep approvals on a single review surface.

## 3. Risk and reversibility posture

How you weigh stakes against reversibility, which is decisive for what the system may
auto-handle versus what must surface.

- Auto-handle posture: state how conservative the system should be. The shipped default
  is: when unsure, surface; auto-handle is the earned exception, never the default.
- Stakes-by-reversibility cutoffs: state which combinations of stakes and reversibility
  count as safe enough to auto-handle once learning is enabled.
- Hard always-surface flags: anything external (send, deploy, spend, publish) and
  anything canon-touching always surfaces. This is fixed, not tunable.
- Reversibility default when unknown: treat as costly-or-irreversible and surface.

## 4. Default item classes (approve / want / ignore)

The starting classification of recurring human-bound item classes, before any learned
rules exist. This seeds the surfacing policy.

- Always-approve classes: list low-stakes reversible item types you reliably approve
  (for example routine doc-only merges, dependency bumps).
- Always-want classes: list item types you always want to see even when low-stakes
  (for example anything client-facing, anything touching money).
- Safe-to-ignore classes: list item types that only need logging, not surfacing
  (for example FYI status with no decision attached).
- Until set: every class defaults to batch (shown in the next daily review). Nothing
  auto-handles. This is the safe default.

## Operator inputs required

Set these before the surfacing policy can earn any auto-handle. Each maps to an
operator-tuning-decision captured in
`knowledge/personal-operator/decisions/operator-tuning-decisions.md`:

1. the primary and secondary deep-work windows (section 1)
2. length tolerance and preferred channels with their stakes (section 2)
3. the stakes-by-reversibility cutoffs that count as safe enough to auto-handle (section 3)
4. the always-approve, always-want, and safe-to-ignore item classes (section 4)
5. the initial prioritization weights and the shadow-mode match threshold N (in
   `operator-priority-and-surfacing-model`)

## What this pillar drives

- the surfacing policy (what reaches you versus what batches or auto-handles)
- the prioritization weights used to order work
- the protected schedule the system proposes and you own

## Notes

This node is operator-pending on its values, not on its structure. Agents must not invent
your windows, cutoffs, or classes. Filling them is a logged operator decision, and each
change is a correction that tunes the surfacing rules per
`operator-priority-and-surfacing-model`.
