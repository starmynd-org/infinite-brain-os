# Audience and Export Schema (Operative)

This file is the operative contract for the audience axis: which node may be seen by whom, and what
has to be true before a node crosses from one audience to a wider one. Like the rest of `_system/`,
it is contract surface, not a knowledge node; it carries no node frontmatter.

Added under packet B01 of the 2026-09-06 Multiverse sprint. It exists because separating reusable
doctrine from private capture needs a marker the machine can check, and the marker that was there
could not be checked.

## The problem this fixes

`export_class` is one of the eight frontmatter keys `validate.sh` requires. The validator checks that
the key is **present**. It has never checked that the value means anything.

The consequence is measurable in this tree. `retrieval_class` is governed the same way, and it has
already drifted: alongside its documented `identity | domain | ephemeral` it carries `normal` on ten
nodes and `explicit` on six, accepted silently for as long as they have existed. Nobody chose that.
It happened because nothing said no.

An audience boundary built on an unchecked field inherits exactly that failure, and inherits it in
the worst possible place. A privacy marker that admits any spelling reads as a guarantee while
providing none: the node whose author typed `confidential` because it was the obvious word is not
protected, and no one is told. That failure is silent, and it is discovered by disclosure.

So the enforcement lands before the marker: `_system/checks/frontmatter-enum-check.sh`.

## The export_class enum

| Value | Meaning | May leave the authoring brain |
|---|---|---|
| `private` | Personal or raw capture. Belongs to the person who wrote it. | Never, by any profile |
| `internal` | The operation's own working material | Only into a brain the same operation owns |
| `department` | Scoped to a department's trust boundary | Only into that department's brain |
| `public` | Cleared for a published surface | Yes, subject to the export profile's own ship list |

`private` is new. Before this change the taxonomy in use was `internal` (331 nodes), `public` (42) and
`department` (7), with no value at all for the thing the reflexive-brain topology most needs to name.
The only privacy signal that existed was `default_visibility: private` on two namespace registry
entries, which is namespace-grain rather than node-grain, and which nothing read.

`private` is deliberately the strongest value and the simplest one. It is not a scope, it is a stop.
No profile may ship it, no promotion may widen it in place, and no allowlist entry overrides it.

## What this schema does not do, and must not be described as doing

**A marker is not a control.** The export pipeline's actual control is `SHIP_LIST`, the per-profile
allowlist that decides what is copied at all. The leak scan downstream of it is a pattern grep over
the result: a finder, not a checker. Its own base-pattern file records that before the 2026-07-28
audit it carried no credential shape whatsoever, so a pasted token would have passed every automated
stage while the phrase "leak scan clean" read as an assurance the scanner was never built to give.

This schema adds a fourth value and a check that the value is spelled correctly. It does not make an
export safe, and marking a node `private` does not remove it from a history that already carries it.
Removing a file from the present tree does not remove it from the past, which is why the launch
reconciliation keeps the legacy Brain private rather than cleaning it up for sharing.

The independent agent-run sweep in each consumer's release checklist remains the checker. The finder
must never be presented as having replaced it.

## Promotion across the audience axis

Promotion up the lifecycle (`_system/promotion-path-rules.md`) and promotion across audiences are
different acts and only one of them is a matter of confidence.

- Moving `scratch` to `research` to `canon` is a statement about how settled the content is.
- Moving `private` to `internal` to `public` is a statement about who is permitted to see it.

A node can be canon and private forever. That is the normal state of a mature personal brain, and
treating a lifecycle promotion as implying an audience promotion is the mechanism by which a private
brain leaks into a shared one one confident node at a time.

Therefore: **an audience widening is never implied.** It is recorded, on the node, as an explicit
grant naming who granted it and when. A node whose `export_class` widened without a grant is a
finding, not a merge conflict to resolve in favour of the newer value.

## Enforcement tier

`frontmatter-enum-check.sh` ships **warn-only against an enumerated baseline**, matching the posture
`_system/enforcement-tiers.md` sets: promoting a check to blocking is an operator decision, recorded
there.

Warn-only is the honest tier today for one reason: thirteen nodes in this tree already carry
out-of-enum `retrieval_class` values, so shipping the check as blocking would fail the starter
against its own validator on inherited debt the user did not create. What the check does instead is
enumerate that debt in `_system/known-enum-drift.txt` and fail on anything **new**. Inherited drift
is visible and countable; new drift cannot be added silently.

`export_class` itself has **zero** drift today: every one of the 380 nodes carrying it uses a value
the enum defines. So for the audience axis specifically, the check is effectively already strict, and
`--strict` passes for that field the day it is asked to.

The promotion to blocking becomes available when `known-enum-drift.txt` is empty. That is the work,
and shrinking that file is how it gets done.

## Related contracts

- `_system/promotion-path-rules.md`: movement up the lifecycle, which this file deliberately keeps
  separate from movement across audiences.
- `_system/public-llm-index-policy.md`: what a public surface may index.
- `_system/enforcement-tiers.md`: where the tier of this check is recorded and where its promotion
  would be decided.
- `_system/namespace-profiles.md`: `default_visibility` at namespace grain, which this schema
  refines to node grain rather than replacing.
- `tools/brain-export/` in the authoring brain: the engine, its mandatory guard set, and the ship
  list that is the actual control.
