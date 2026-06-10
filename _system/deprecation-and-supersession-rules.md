# Deprecation and Supersession Rules

Operative rules for retiring a node without breaking the graph: the `supersedes` field,
tombstone stubs, and the `archive` lifecycle state. This file owns the "what" and "how to
check." The "why" (durable links and a corrosion-resistant graph) lives in the
ai-architecture doctrine: [[namespace-architecture-v2]] and [[namespace-linting]]. This
file does not restate that reasoning.

## Principle: a node is retired, never silently deleted

Deleting a node that other nodes link to breaks the graph. The deterministic link checker
in `validate.sh` will then fail on every inbound `[[wikilink]]` and `edges.target`. The
correct operation is supersession or deprecation, both of which keep links resolving.

Three distinct operations:

| Operation | What changed | Result |
|-----------|--------------|--------|
| Supersession | a newer node replaces an older one | old id stays reachable; pointer to new node |
| Deprecation | a node is no longer current but is not replaced | node kept, marked, links preserved |
| Archival | a node moves to historical storage | `lifecycle_state: archive`; provenance retained |

## The supersedes field

`supersedes` records that this node replaces a prior one. It lives in the frontmatter of
the new (replacement) node and names the id of the node it replaces.

```yaml
supersedes: knowledge-ai-architecture-old-canon-loader
```

Rules:

- the value is a single id or a list of ids, never a path.
- the superseded node is NOT deleted in the same move. It either becomes a tombstone stub
  (below) or is marked `lifecycle_state: archive`, so inbound links keep resolving.
- a registry entry (`_system/namespaces/<ns>.md`) uses the same `supersedes` field; its
  default value is `null` until the namespace is replaced.
- `supersedes` is one-directional. Add a complementary `superseded_by` edge on the old node
  pointing forward, so the relation is navigable both ways.

- Enforced by `validate.sh` (deterministic): if `supersedes` names an id, that id must
  resolve to a file (the superseded node must still exist as a node or tombstone).
- Whether a supersession is the right call versus a deprecation is a curator check (fuzzy).

## Deprecating a node without breaking links

To deprecate a node that is no longer current but has no single replacement:

1. Set `lifecycle_state: archive` (or keep it where it is if it remains a live but
   downgraded reference; mark the body instead).
2. Add a `## Status` section at the top of the body stating it is deprecated, the date, and
   why. Use "Deprecated as of 2026-05-30." style phrasing, not a placeholder.
3. Lower `confidence` to reflect the downgrade.
4. Keep all existing `edges` and `aliases`. Do not strip them. Inbound links must keep
   resolving.
5. If a successor exists, add a `superseded_by` edge to it. If the material is dispersed
   into several new nodes, add `related_to` edges to each.

A deprecated node is not removed from the graph. It stays as a signpost so an agent that
follows an old link lands on a clear "this is no longer current, go here instead" marker.

## Tombstone stubs

A tombstone stub is the minimal node left in place when content moves to a new id or new
file and the old id must keep resolving. Use a tombstone when the content genuinely left
(renamed file, merged into another node) rather than just being downgraded.

A tombstone stub carries:

- the original id (unchanged) so old `[[old-id]]` links resolve.
- `lifecycle_state: archive`.
- `supersedes: null` and a `superseded_by` edge (or `related_to` edges) pointing to where
  the content now lives.
- a one-line body: "This node moved to [[new-node]] on 2026-05-30. Kept as a tombstone so
  prior links resolve."
- no substantive content. The stub is a redirect, not a copy.

Prefer the alias mechanism over a tombstone when only the filename changed and the content
and id are intact: add the old filename to `aliases` per [[stable-id-and-alias-rules]]. Use
a tombstone when the id itself changed or content merged elsewhere.

## The archive lifecycle state

`lifecycle_state: archive` marks a node as historical: kept for provenance and link
integrity, not current truth.

- Allowed lifecycle values: `scratch`, `research`, `candidate`, `canon`, `archive`.
- `archive` is terminal for a node's currency. An archived node is not loaded as current
  doctrine and is not promoted further without a deliberate revival (a new node that
  `supersedes` the archived one in reverse, recorded explicitly).
- Archived knowledge nodes typically live under `knowledge/<ns>/archive/`. An in-place
  archived node (kept in its original folder as a tombstone) is acceptable when moving it
  would break more links than it fixes.

- Enforced by `validate.sh` (deterministic): the lifecycle value must be one of the five
  allowed states.

## Never strip a canon claim silently

Retiring a canon claim is the highest-stakes deprecation. It requires:

- a `## Changelog` entry on `canon/core-doctrine.md` recording the date and the one-line
  reason for the removal or supersession, per [[canon-changelog-rules]].
- operator approval, the same gate that admits a canon claim, per
  [[promotion-path-rules]].
- a `superseded_by` edge or a synthesis note explaining where the reasoning went.

A canon claim does not disappear without a changelog trace. An agent must be able to see
that the claim was deliberately retired, not lost.

## Checklist before retiring a node

- decide the operation: supersession, deprecation, or archival.
- the old id still resolves (kept node, tombstone, or alias).
- all existing `edges` and `aliases` preserved.
- forward pointer added (`superseded_by` edge, or `supersedes` on the replacement).
- `lifecycle_state` set correctly (`archive` for retired nodes).
- a dated `## Status` line or tombstone body explains the change, no placeholder text.
- if canon, a `## Changelog` entry and operator approval are recorded.

## Related operative rules

- [[stable-id-and-alias-rules]]: ids are permanent; alias the old filename on rename.
- [[migration-compatibility-rules]]: never break a link silently; preserve edges on move.
- [[promotion-path-rules]]: the operator gate that also governs retiring canon.
- [[canon-changelog-rules]]: the changelog trace required when canon changes.
