# _system: the operative contract layer

`_system/` is the operative layer of the Infinite Brain. It holds the rules a builder,
validator, or maintainer must obey, the namespace registry that declares what each namespace
is, and the validator that enforces the structural rules mechanically. If you need to know
*what* the system requires and *how it is checked*, you are in the right folder. If you need
to know *why* a rule exists, read `knowledge/ai-architecture/` instead.

This split is the single most important thing to understand about the repo, so it is stated
first and bluntly.

## _system versus knowledge/ai-architecture

There are two homes for system knowledge, and they do not duplicate each other.

| | `_system/` | `knowledge/ai-architecture/` |
|---|---|---|
| Holds | operative schema, rules, the namespace registry, the validator | the reasoning, the first-principles doctrine, the "why" |
| Question it answers | what must be true, how it is checked | why it is true, what it is for |
| Read it when | you are building, validating, or upgrading and need the exact contract | you are deciding, designing, or reasoning and need the rationale |
| Form | rule files, schema files, registry entries, a bash validator | knowledge nodes (canon, pillars, concepts, decisions, playbooks, synthesis) |
| Approval | edited as the contract evolves; changes land with the validator | canon is operator-approved and provenance-bearing |
| Source of truth for | structure and enforcement | meaning and intent |

A rule in `_system/` that has a doctrine counterpart links to it; it does not restate the
reasoning. A doctrine node in `ai-architecture` that has an operative counterpart links to
it; it does not restate the rule. The reasoning for this division is the doctrine node
[[system-vs-doctrine-boundary]]; this README is the operative statement of it.

The practical test: if changing the text would change what `validate.sh` accepts or what a
builder must produce, it belongs in `_system/`. If changing the text would change how someone
*thinks* about the architecture but not what passes the validator, it belongs in
`ai-architecture`.

## What lives here

### The namespace registry: `_system/namespaces/`

One file per namespace plus an `INDEX.md`. Each entry is the operative declaration of a
namespace: its `profile` (one of the eight), its `lifecycle_state`, its `v2_status`
(`upgraded` or `queued`), its `canon_posture` (`full`, `thin`, or `none`), its
`freshness_posture`, its `archive_posture`, and its `expected_folders`. The validator reads
these fields to know what each namespace must contain. To add or upgrade a namespace, edit its
registry entry; the validator then enforces the declared shape.

Optional scope overlays may also appear in a namespace registry entry when the namespace is
materially tied to external commercial scope: `party_slugs`, `client_slug`, and `brand_slug`.
These do not change the namespace ontology or validator posture; they make tenancy and relationship
scope explicit without forcing every party to become a namespace.

### The party layer: `parties/`

A root relationship layer for external or business actors. This is where stable client, brand,
vendor, partner, and influencer records live. `parties/` owns relationship identity and scope.
`knowledge/` owns retrieval doctrine. `departments/` owns operating assembly. Use `parties/` when
many parts of the OS need to refer to the same external actor without creating a namespace solely
for classification.

### The schema and rule files

Operative contracts, one concern per file. The schema files define the shape of a thing
(`canon-layer-schema.md`, `namespace-index-schema.md`, `namespace-profiles.md`,
`metric-primitive-schema.md`, `stable-id-and-alias-rules.md`, `secret-reference-schema.md`).
The rule files define a
procedure or policy a maintainer must follow (`namespace-intake-rules.md`,
`promotion-path-rules.md`, `freshness-review-rules.md`, `contradiction-review-rules.md`,
`correction-loop-rules.md`, `migration-compatibility-rules.md`,
`deprecation-and-supersession-rules.md`, `cross-namespace-edge-rules.md`,
`namespace-lint-rules.md`, `profile-lint-rules.md`, `output-linkage-review-rules.md`,
`retrieval-load-order-policy.md`, `retrieval-eval-rules.md`, `public-llm-index-policy.md`,
`canon-changelog-rules.md`, `department-assembly-rules.md`,
`department-runtime-contract.md`, `session-ledger-rules.md`, `tool-registry-rules.md`,
`repo-registry-rules.md`, `secret-registry-rules.md`). Each names the
`ai-architecture` doctrine node that explains why it exists.

### The validator: `_system/validate.sh`

The deterministic enforcer. It checks node frontmatter keys, the namespace lifecycle enum,
the required base surfaces and full-canon files (profile-aware, by `v2_status`), broken
wikilinks and relative links, orphan nodes, intake processed-receipt completeness, the
`sessions/` base scaffold, n8n JSON pairing and validity, and the em and en dash ban. Run
it from anywhere:

```bash
bash _system/validate.sh
```

Exit 0 means all checks pass. Exit 1 means at least one error. Warnings never change the exit
code. The script writes nothing to the repo. What each V2 check does, and which checks are
deterministic here versus left to a curator agent, is documented in
`_system/validate-v2-notes.md`.

### The deterministic versus fuzzy boundary

`_system/validate.sh` owns only what is mechanically decidable from file structure and
frontmatter: surface presence, canon file presence, link resolution, orphan topology, receipt
field presence, dash bans. Judgment calls (is this synthesis ready for canon, do these two
nodes contradict, is this fact stale) stay with curator agents and the `workflows/` review
pipelines. New structural rules land in `validate.sh` in the same change that makes them
doctrine, so the validator and the rules never drift.

## How to use this folder

- Building a new namespace: read `namespace-profiles.md` to pick a profile, copy a registry
  entry from `_system/namespaces/`, declare the V2 fields, then create the base surfaces. Run
  the validator.
- Building or revising a department assembly: read `department-assembly-rules.md` and, if
  runtime mapping matters, `department-runtime-contract.md`. Use a shared platform department
  for cross-cutting DevOps or delivery capabilities rather than making every department own a
  separate GitHub or CI/CD posture. The reusable creation path is `entities/skills/build-department.md`
  plus `workflows/build-department.md`.
- Building or revising a department charter: read `department-charter-rules.md`. Serious
  departments should have both `INDEX.md` and `CHARTER.md`.
- Building or revising the cross-repo map: read `repo-registry-rules.md`. If a department
  materially depends on another repo under `<legacy-root>`, create or
  update a `repo-registry/` entry and link it from the department `INDEX.md`.
- Building or revising the shared secret posture: read `secret-registry-rules.md`, keep durable
  references in the root `secrets/` registry, and keep raw values in the external secret backend
  and runtime layer.
- Upgrading a queued namespace to V2: read its audit packet, follow
  `migration-compatibility-rules.md` (additive moves, preserve edges and aliases), author
  canon per `canon-layer-schema.md`, flip `v2_status` to `upgraded`, run the validator.
- Authoring or revising canon: `canon-layer-schema.md` and `canon-changelog-rules.md` are the
  operative contract; [[canon-layer]] is the reasoning. Canon is operator-approved; an agent
  drafts at `verified_by: operator-pending` and the operator signs off.
- Processing intake: `namespace-intake-rules.md` plus the schemas under `intake/schemas/`.
- Checking structural health: run the validator, then the `namespace-lint-review` workflow to
  triage its output.

## What this folder is not

- Not the reasoning layer. The "why" lives in `knowledge/ai-architecture/`. Do not write
  doctrine here; link to it.
- Not live runtime state. No live queues, no in-flight approvals, no secrets. Those stay in
  the operational substrate per [[surface-boundary]]. Secret references and policy metadata may
  live in the root `secrets/` registry, but raw values never enter `_system/` or git canon. The
  durable `sessions/` ledger is
  allowed in git because it is a settled audit trail, not a mutable queue.
- Not a knowledge namespace. `_system/` files are exempt from node-frontmatter checks (they
  are operative scaffolding, not graph nodes), though they still obey the voice and dash
  rules.
