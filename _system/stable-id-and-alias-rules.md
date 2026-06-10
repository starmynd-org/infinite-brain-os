# Stable ID and Alias Rules

Operative rules for node and entity identifiers in the Infinite Brain. This file owns the
"what" and "how to check." The "why" (identifiers as durable graph anchors that survive
moves) lives in the ai-architecture doctrine, primarily [[profile-aware-knowledge-graph-design]]
and the migration doctrine in [[namespace-architecture-v2]]. This file does not restate
that reasoning.

## Rule 1: every node and entity has an id

Every node-bearing file carries an `id` in frontmatter. The id is the stable handle for
the file. Links, edges, and registry references point at the id, not at the path. The id
does not change when the file moves.

- Enforced by `validate.sh` (deterministic): the `id` key must be present on every
  node-bearing file outside the exemption list.

## Rule 2: ids are kebab-case, ASCII, lowercase, type-prefixed

An id is lowercase ASCII kebab-case with a leading type prefix. No spaces, no underscores,
no uppercase, no non-ASCII characters.

Allowed type prefixes (the id prefix table):

| Entity or node type | id prefix | Example |
|---------------------|-----------|---------|
| Knowledge | `knowledge-` | `knowledge-ai-architecture-canon-layer` |
| Memory | `memory-` | `memory-2026-05-30-swarm-launch-lesson` |
| Data | `data-` | `data-ga4-events-table` |
| Output | `output-` | `output-2026-05-30-weekly-review` |
| Project | `project-` | `project-namespace-v2-upgrade` |
| Metric | `metric-` | `metric-roas` |
| Skill | `skill-` | `skill-canonize-namespace` |
| Agent | `agent-` | `agent-namespace-curator` |
| Workflow | `workflow-` | `workflow-monthly-canon-review` |
| Command | `command-` | `command-triage-intake` |
| Rule | `rule-` | `rule-voice-and-style` |
| Namespace registry entry | `namespace-` | `namespace-ai-architecture` |
| Intake record | `intake-<source>-<date>-<slug>` | `intake-x-2026-05-30-thread-on-retrieval` |

- Enforced by `validate.sh` (deterministic): id casing and ASCII kebab-case.
- The correct type prefix for a file's actual type is a curator check (fuzzy): the
  validator cannot always infer intended type, so a misprefixed id is surfaced by the
  namespace linter and reviewed.

## Rule 3: knowledge node id pattern is namespace-scoped

A knowledge node id is `knowledge-<namespace>-<slug>`. The slug is the descriptive tail in
kebab-case. The namespace segment keeps ids unique across namespaces and makes the owning
namespace legible from the id alone.

- Canon core-doctrine: `knowledge-<namespace>-canon-core-doctrine`.
- Canon current-truth: `knowledge-<namespace>-canon-current-truth`.
- Metric node: `metric-<slug>` (metrics are cross-namespace by design and are not namespace-scoped in the id).

## Rule 4: filename is the id without the type prefix

The filename is kebab-case `.md`, normally the id with the type prefix stripped.

- `id: knowledge-ai-architecture-canon-layer` lives in `canon-layer.md`.
- `id: skill-canonize-namespace` lives in `canonize-namespace.md`.
- `id: namespace-ai-architecture` lives in `_system/namespaces/ai-architecture.md`.

The filename is a convenience for humans and Obsidian. The id is the contract. When the
two diverge, Rule 5 applies.

## Rule 5: alias discipline when id differs from filename

When the id does not equal the filename (with prefix stripped), the file MUST carry an
`aliases` array that includes both the full id and the filename-without-extension. This
keeps `[[wikilinks]]` resolvable in Obsidian and keeps the validator's link checker honest.

The standard `aliases` shape for a knowledge node:

```yaml
aliases: ["knowledge-<namespace>-<slug>", "<namespace>-<short>"]
```

When a doctrine node is commonly linked by a short human name (for example
`upgrade-a-namespace-to-v2`), add that short name to `aliases` too so `[[short-name]]`
resolves:

```yaml
aliases:
  - "knowledge-ai-architecture-upgrade-a-namespace-to-v2"
  - "ai-architecture-upgrade-namespace-v2"
  - "upgrade-a-namespace-to-v2"
```

- Enforced by `validate.sh` (deterministic): Obsidian alias compatibility (the link
  resolver must be able to reach the file by every name used in `[[...]]`).
- Whether the alias set is the most useful one for human linking is a curator check (fuzzy).

## Rule 6: stable ids survive moves

An id is permanent for the life of the node. Moving a file between folders
(`research` -> `candidate`), or within a namespace reorganization, MUST NOT change the id.
Inbound `[[id]]` links and `edges.target` references keep resolving because they target the
id, not the path.

When a file moves and the filename changes as a side effect:

- Keep the original id unchanged.
- Add the prior filename-without-extension to `aliases` so old `[[old-filename]]` links
  still resolve.
- Never silently rename the id. A genuine id change is a supersession, governed by
  [[deprecation-and-supersession-rules]], not a rename.

This is the link-preservation half of the migration contract; the full path-change and
rename doctrine lives in [[migration-compatibility-rules]].

## Rule 7: ids are unique repo-wide

No two files share an id. The namespace segment in `knowledge-<namespace>-<slug>` is the
primary uniqueness mechanism. A slug that collides with an id of another type in the same
namespace (for example a decision id matching a campaign-type id) is renamed at authoring
time.

- Enforced by `validate.sh` (deterministic): duplicate-id detection across the repo.
- Predicting a future collision before it happens is a curator check (fuzzy).

## Checklist before committing a new node

- id present, lowercase ASCII kebab-case, correct type prefix.
- Knowledge node id is `knowledge-<namespace>-<slug>`.
- Filename equals id with prefix stripped, or `aliases` carries both names.
- If linked by a short human name, that name is in `aliases`.
- id is unique repo-wide.
- If this file replaces an older one, the move follows Rule 6 (alias the old name) and a
  true id change follows [[deprecation-and-supersession-rules]].

## Related operative rules

- [[migration-compatibility-rules]]: never break a link silently; alias on rename.
- [[deprecation-and-supersession-rules]]: when an id is genuinely retired or replaced.
- [[canon-changelog-rules]]: id and provenance stability for canon core-doctrine.
