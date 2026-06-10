---
id: "workflow-legacy-knowledge-migration"
aliases: ["workflow-legacy-knowledge-migration"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Run a single namespace's V2 upgrade end to end from its audit packet: migrate, canonize, and refine the index."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-migrate-legacy-knowledge-to-v2]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[skill-canonize-namespace]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-refine-namespace-index]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[upgrade-a-namespace-to-v2]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[canonize-a-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[migration-compatibility-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Legacy Knowledge Migration

A reasoning pipeline that takes one namespace from its V2 audit packet to a finished V2
upgrade. It sequences the three skills in the order the migration doctrine requires:
migrate the structure additively, canonize the compressed doctrine, then refine the
INDEX.md router. It runs one namespace at a time so a failed upgrade never half-migrates
several namespaces. The rollout order across namespaces lives in the audit packets, not
here.

Migration is additive by rule: add `canon/` and `synthesis/` alongside existing folders,
preserve every existing edge and alias, and never break a link silently. The
deterministic guards (link resolution, frontmatter, dash ban) run via
`_system/validate.sh` at the end of each phase. The interpretive work, deciding what
compresses into canon and how the router should route, is the work of the three skills.

## When to run

- When a namespace is scheduled for its V2 upgrade and its audit packet exists under the
  sprint's `Namespace_Audits/` folder.
- One namespace per run. To upgrade several, run this once per namespace in the rollout
  order the audit packets specify.
- Do not run this on a namespace with no audit packet. Author the packet first using the
  packet template; the packet is the required input.

## Inputs

- The target namespace's audit packet at
  your namespace audit packet.
  The packet declares the current file inventory, the chosen profile, the canon posture,
  the expected folder set, the migration moves, and the retrieval eval queries.
- The target namespace's current tree under `knowledge/<namespace>/`.
- The namespace registry entry at `_system/namespaces/<namespace>.md`, for the posture
  fields (`profile`, `canon_posture`, `freshness_posture`, `expected_folders`).
- The migration doctrine: operative rules in [[migration-compatibility-rules]], the
  procedure in [[upgrade-a-namespace-to-v2]], the canon procedure in
  [[canonize-a-namespace]], and the index contract in [[namespace-index-schema]].
- `_system/validate.sh` for the per-phase deterministic gate.

## Pipeline

### Step 1: Read the audit packet and confirm scope

Read the packet end to end. Confirm the namespace, the chosen profile, the canon posture
(full, thin, or none), the `expected_folders` set, and the listed migration moves.
Confirm the registry entry matches the packet. If they disagree, stop and surface the
conflict to the operator; the packet and registry must agree before any move.

### Step 2: Migrate the structure additively

Apply [[skill-migrate-legacy-knowledge-to-v2]] using the packet's migration moves. The
skill adds `canon/` and `synthesis/` alongside the existing folders, classifies existing
material into support (provenance) versus synthesis (derived reading), and preserves
every existing edge and alias. On any rename or move, it adds the old id to the new
file's `aliases` or leaves a stub with a `supersedes` pointer, per
[[migration-compatibility-rules]]. Run `bash _system/validate.sh` and fix any error
before continuing.

### Step 3: Canonize the compressed doctrine

Apply [[skill-canonize-namespace]] to author or revise the `canon/core-doctrine.md` for
the namespace at the posture the packet specifies. For `canon_posture: full`, produce
`canon/README.md`, `canon/core-doctrine.md`, and `canon/agent-load-order.md`; for
`thin`, produce a short core-doctrine plus the two navigational files; for `none`, skip
canon and record why in `INDEX.md`. Canon synthesizes and compresses the pillars,
concepts, and decisions; it does not paraphrase them node by node. The core-doctrine
carries `derived_from` edges, `verified_at`, `verified_by`, and a `## Changelog`. Canon
content is operator-approved before it is written. Run `bash _system/validate.sh` again.

### Step 4: Refine the INDEX.md router

Apply [[skill-refine-namespace-index]] to rewrite the namespace `INDEX.md` to the full
contract in [[namespace-index-schema]]: profile, load-first, query classes, stable versus
stateful, open disputes, what this namespace drives, archive and provenance, common
misreadings, and the folder map. The router points at the new canon as the first load.

### Step 5: Verify against the eval queries

Run the packet's retrieval eval queries against the upgraded structure. For each query,
confirm the expected load set resolves and answers correctly. The upgrade is not done
until every eval query passes. Record any query that fails and the structural gap it
exposed.

### Step 6: Produce the migration Output

Save to `outputs/legacy-knowledge-migration-{namespace}-{date}.md` with the moves made,
the canon authored, the INDEX.md changes, the eval results, and any unresolved item
carried back to the audit packet.

Output frontmatter:
```yaml
---
id: "output-legacy-knowledge-migration-{namespace}-{date}"
type: "Output"
namespace: "personal-operator"
lifecycle_state: "scratch"
produced_by: "[[workflow-legacy-knowledge-migration]]"
created: "{date}"
---
```

## Output format

A single Output node at `outputs/legacy-knowledge-migration-{namespace}-{date}.md`. Body
sections, in order: migration moves (with before and after paths), canon authored, index
changes, eval-query results table, and carry-back items for the audit packet.

## Notes

- Operator approval is required before canon is written (Step 3). Canon is
  operator-approved by definition.
- The workflow runs `validate.sh` after Steps 2 and 3 and refuses to proceed past an
  error. A migration that breaks a link or drops an edge is a failed migration, not a
  finished one.
- The workflow does not invent the rollout order or the profile choice. Both come from
  the audit packet. If the packet is wrong, fix the packet, then rerun.
- Raw legacy source trees under `knowledge/<namespace>/archive/` stay archived and are
  not retrofitted with full node frontmatter. They are provenance, not canonical nodes.
