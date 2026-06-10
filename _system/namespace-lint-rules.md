# Namespace Lint Rules

This file is the operative check list for keeping a namespace structurally healthy. It
states exactly which checks `validate.sh` runs deterministically and which checks a
curator agent runs as fuzzy judgment. The "why" behind the deterministic-versus-fuzzy
split lives in [[namespace-linting]]; this file owns the executable rules and does not
restate the doctrine.

The load-bearing rule is the split (guardrail G5): a check with a single correct answer a
script can compute belongs in `validate.sh`; a check that needs judgment belongs to an
agent. Every rule below is tagged DETERMINISTIC (validate.sh enforces it) or FUZZY (a
curator agent enforces it).

## Scope

These rules apply to every serious namespace under `knowledge/<namespace>/`. A serious
namespace is one meant for real agent retrieval. Starter and example namespaces
(`personal-operator`, `knowledge/_examples/*`) carry a reduced base and declare the
reduction in their `INDEX.md`; the structural checks below do not flag a declared
reduction as a defect. Per-profile structural emphasis lives in [[profile-lint-rules]].

## Deterministic checks (validate.sh enforces)

These run on `bash _system/validate.sh`. Each has a single correct answer. The severity
column states whether a failure is an error (exit 1, blocks the wave) or a warning (does
not fail the run).

### Required base surfaces (error)

Every serious namespace must contain all five base surfaces:

- `INDEX.md`
- `canon/`
- `playbooks/`
- `support/`
- `synthesis/`

A serious namespace missing any one of these is an error. The base set is fixed by
[[required-namespace-surfaces]]. The check reads the namespace `expected_folders` field in
its `_system/namespaces/<ns>.md` registry entry to confirm the base is present. A namespace
whose registry declares a reduced base (a starter or example) is exempt; the reduction must
be declared in both the registry and the namespace `INDEX.md`.

### Required canon files for full-canon namespaces (error)

A namespace whose registry sets `canon_posture: full` must contain:

- `canon/README.md`
- `canon/core-doctrine.md`
- `canon/agent-load-order.md`

A full-canon namespace missing any of these three is an error. A namespace with
`canon_posture: thin` must contain `canon/README.md`, `canon/agent-load-order.md`, and a
short `canon/core-doctrine.md`; missing any is an error. A namespace with
`canon_posture: none` is not checked for canon files. Tool Contract namespaces use
`canon/core-contract.md` as the canon file of record in place of or alongside
`core-doctrine.md`; the check accepts either filename for that profile. Canon contents and
provenance rules live in `_system/canon-layer-schema.md`.

### Broken links (error)

A relative markdown link or a `[[wikilink]]` whose target file does not resolve is an
error. Resolution rules:

- A `[[wikilink]]` resolves if a file named `<target>.md` exists anywhere in the repo, or
  if any node declares `<target>` in its `aliases` list (Obsidian alias compatibility).
- A relative link (for example `../concepts/foo.md`) resolves if the path exists relative
  to the linking file.
- A link to an external URL (`http://`, `https://`) is not checked.

A broken link silently drops a path an agent expected to follow, so it fails the run.

### Orphan detection (warning)

A node with no inbound and no outbound `edges` is an orphan. It cannot be reached by graph
traversal. This is a warning, not an error, because a freshly created node may not be
linked yet. The curator surfaces persistent orphans for triage.

### Profile folder check (warning)

A folder present in `knowledge/<namespace>/` that is not in that namespace
`expected_folders` set is a warning, not an error. Additive growth is allowed: a namespace
may add a folder before its registry catches up. The warning prompts the operator to
either add the folder to `expected_folders` or remove it. The `expected_folders` set is the
base plus the profile-additive folders; the per-profile additive sets are defined in
`_system/namespace-profiles.md`.

### Intake completeness (error)

Inside `intake/`, a processed receipt missing a routing decision, or a routed item missing
a destination link, is an error. This is the one intake structural check `validate.sh`
runs; the full per-profile intake emphasis lives in [[profile-lint-rules]] and the receipt
schema lives in `intake/schemas/processed-receipt.md`. See also
`_system/namespace-intake-rules.md` for how namespaces consume intake.

### Existing checks retained (error or warning per current behavior)

The V2 extension keeps every check `validate.sh` already runs:

- frontmatter presence and required keys (`id`, `type`, `namespace`, `lifecycle_state`,
  `summary`, `confidence`, `retrieval_class`, `export_class`) on node-bearing files (error)
- em dash and en dash ban across all `.md` files (error)
- n8n workflow JSON and companion `.md` pairing, plus JSON validity (error), with SSH-auth
  and webhook-probe runtime warnings (warning)
- `paperclip-mapping.json` validity (error)
- namespace registry lifecycle enum (`scratch | candidate | canon | archive`) and required
  registry keys (error)
- Obsidian alias compatibility: when a node `id` differs from its filename and the id is
  not in `aliases`, warn so wikilinks by either form resolve (warning)
- Project node `state_stored_at` and `analytical_view` suggestion (warning)

### Node-frontmatter exemptions (V2 additions)

The following are navigational or operative files and are exempt from node-frontmatter
checks, added to the existing exemption list:

- `knowledge/*/canon/README.md`
- `knowledge/*/canon/agent-load-order.md`
- `knowledge/*/synthesis/README.md`
- the entire `intake/` tree, except the intake completeness check above
- the entire `_system/` tree, except files under `_system/namespaces/` which are registry
  entries and carry registry frontmatter

Files that DO require node frontmatter: `canon/core-doctrine.md`,
`canon/core-contract.md`, `canon/current-truth.md`, and every substantive `synthesis/*.md`
node. Existing exemptions remain: `README.md`, `CLAUDE.md`, `AGENTS.md`, `START-HERE.md`,
`OBSIDIAN-DASHBOARD.md`, `CANONICAL-GATES.md`, `.obsidian/`, `swarms/`, `docs/`,
`data/source-archives/`, `.claude/hooks/`, `entities/README.md`, `knowledge/*/INDEX.md`,
`knowledge/*/support/*`, `knowledge/*/archive/*`.

## Fuzzy checks (curator agent enforces)

These require judgment a script cannot make. They belong to the curator agents
(`namespace-curator`, `namespace-linter`, `corpus-synthesizer`, `freshness-reviewer`) and
the lint and review workflows, not to `validate.sh`. Putting any of these in the validator
would produce false gates.

- Contradiction surfacing: deciding whether two nodes or sources assert incompatible
  things without a recorded resolution. Rules in `_system/contradiction-review-rules.md`;
  surfaced by the `detect-contradictions` skill.
- Canon-candidate detection: deciding whether a `synthesis/` node has matured enough to be
  proposed for promotion into `canon/`. Promotion path in
  `_system/promotion-path-rules.md`.
- Staleness judgment: deciding whether a claim has decayed because the world moved.
  Profile-scoped per `_system/freshness-review-rules.md` (G10); applied where state decays,
  not uniformly to stable doctrine.
- Duplicate consolidation: deciding whether two nodes own the same content and should
  merge, versus legitimately covering distinct facets.
- Output-linkage review: deciding whether a namespace canon actually drives the outputs its
  `INDEX.md` claims. Rules in [[output-linkage-review-rules]].

## How to run

- Deterministic pass: `bash _system/validate.sh` from the repo root. Exit 0 means all
  deterministic checks pass; exit 1 means one or more errors. Fix errors before proceeding
  in a build wave (contract Part 14).
- Fuzzy pass: run the `lint-namespace` skill, which wraps `validate.sh` plus the curator
  fuzzy review, then triages the warnings and fuzzy findings into the
  `namespace-lint-review` workflow.

## Notes

This file is the executable check list. The doctrine and the rationale for the
deterministic-versus-fuzzy split live in [[namespace-linting]]. Per-profile structural
emphasis lives in [[profile-lint-rules]]. When a new deterministic structural rule becomes
doctrine, it lands in `validate.sh` in the same wave per the validator-evolution rule in
`_system/migration-compatibility-rules.md`, and this file is updated to record it.
