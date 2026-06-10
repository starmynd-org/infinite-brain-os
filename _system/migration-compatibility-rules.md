# Migration and Compatibility Rules

Operative rules for changing the graph without breaking it: link preservation, alias-on-
rename, edge preservation, additive path change, entity-upgrade sequencing, and validator
evolution. This file is the operative home for contract Part 12 (guardrail G8). It owns the
"what" and "how to check." The "why" (a graph that agents already read must stay readable
through an upgrade) lives in the ai-architecture doctrine: [[namespace-architecture-v2]] and
[[namespace-linting]]. The migration procedure for a single namespace is the playbook
[[upgrade-a-namespace-to-v2]]. This file does not restate that reasoning.

## Rule 1: never break a link silently

When a file is renamed or moved, the old name must keep resolving. Two mechanisms, choose by
what changed:

- the id is intact and only the filename changed: add the old filename-without-extension to
  the file's `aliases` array, per [[stable-id-and-alias-rules]].
- the id itself changed or the content merged into another node: leave a tombstone stub at
  the old id with a `superseded_by` edge, per [[deprecation-and-supersession-rules]].

A "silent break" is any rename, move, or deletion that leaves an inbound `[[wikilink]]` or
`edges.target` pointing at nothing. This is forbidden.

- Enforced by `validate.sh` (deterministic): broken relative links and broken `[[wikilinks]]`
  (the target file does not resolve) fail the build. This is the backstop that catches a
  silent break immediately.

## Rule 2: alias on rename

Renaming a file is allowed; losing reachability is not. The rename procedure:

1. keep the `id` unchanged (ids are permanent, per [[stable-id-and-alias-rules]]).
2. add the prior filename-without-extension to `aliases`.
3. confirm every name used in any `[[...]]` link to this file is now in `aliases` or equals
   the id or the new filename.
4. run `bash _system/validate.sh` and confirm the link checker passes.

If the rename is actually an id change (a true replacement), it is a supersession, not a
rename, and follows [[deprecation-and-supersession-rules]] instead.

## Rule 3: preserve existing edges

Reorganization must not drop `edges` or `aliases`. When a node moves folders, is reformatted,
or is upgraded to V2, every pre-existing `edges` entry and every pre-existing `aliases` entry
survives the change. Edges are the graph; dropping one removes a path an agent relies on.

- Curator check (fuzzy): comparing the pre-upgrade and post-upgrade edge set for silent
  drops. The validator catches a broken target but not an edge that was simply deleted, so
  the migration reviewer diffs edge counts.

## Rule 4: prefer additive path change

Structural change is additive by default. Add new folders alongside existing ones rather
than restructuring what agents already read.

- when adding V2 surfaces to an existing namespace, ADD `canon/` and `synthesis/` beside the
  existing folders. Do NOT restructure `pillars/`, `concepts/`, `decisions/`, `playbooks/`,
  `support/`, or `archive/`.
- moving derived thinking out of `support/` into `synthesis/` is allowed and expected
  during upgrade, because it sharpens the support-versus-synthesis boundary; it is a content
  move, not a structural restructure, and it follows Rule 1 on every moved file.
- a destructive restructure (renaming or collapsing a base folder) is not improvised. If an
  upgrade seems to require one, stop and route the question to the namespace audit packet.

This is the path-change half of the additive doctrine; the per-namespace procedure is in
[[upgrade-a-namespace-to-v2]].

## Rule 5: upgrade entities before mass namespace migration

Sequence the work so new content is V2-aligned by default. Upgrade the builder entities
(the `build-namespace`, `build-knowledge-node`, and related skills and agents) before
migrating namespaces in bulk. If builders still emit V1 structure while namespaces are being
migrated, every new node fights the migration and the graph drifts in two directions at once.

Order:

1. upgrade builders and the validator (Rules 5 and 6).
2. upgrade the reference namespace as the proof point.
3. migrate remaining namespaces in audit-packet order, each via [[upgrade-a-namespace-to-v2]].

## Rule 6: the validator evolves with the doctrine

Every new structural rule lands in `validate.sh` in the same wave it becomes doctrine. A
structural rule that is doctrine but unchecked is a rule that drifts invisibly. When a new
required surface, frontmatter key, or link discipline is added to the contract, the
corresponding deterministic check is added to `validate.sh` at the same time, and fuzzy
checks that cannot be made deterministic are assigned to a curator agent or workflow
explicitly.

- Deterministic checks belong in `validate.sh`: required base surfaces, required canon files
  for `canon_posture: full`, broken links and wikilinks, frontmatter key presence, lifecycle
  enum, em and en dash ban, intake completeness.
- Fuzzy checks belong to curator agents and workflows: contradiction surfacing, canon-
  candidate detection, freshness judgment, edge-drop diffing, relation-correctness review.

## Rule 7: a migration is done when it is falsifiable

A namespace migration is not complete until `validate.sh` passes clean and the namespace
retrieval eval resolves correctly against the upgraded structure. "It looks migrated" is not
the bar. The eval set is the falsification test: if the representative agent queries no
longer resolve to the right load set, the migration regressed retrieval and is not done.

## Checklist for any move, rename, or migration

- no inbound link left dangling (Rule 1); `validate.sh` link checker passes.
- renamed files carry the old name in `aliases` (Rule 2).
- every pre-existing edge and alias preserved (Rule 3); edge counts diffed.
- the change is additive; no base folder restructured (Rule 4).
- builders and validator upgraded before mass migration (Rules 5 and 6).
- the new structural rule is checked in `validate.sh` in the same wave (Rule 6).
- the retrieval eval resolves correctly post-migration (Rule 7).

## Related operative rules

- [[stable-id-and-alias-rules]]: ids are permanent; alias the old filename on rename.
- [[deprecation-and-supersession-rules]]: tombstones and `supersedes` for true replacements.
- [[promotion-path-rules]]: moving material up the lifecycle without breaking provenance.
- [[canon-changelog-rules]]: a canon change during migration still needs a changelog entry.
