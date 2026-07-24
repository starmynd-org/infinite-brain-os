# validate.sh Reference Notes

This file is the operative audit reference for `_system/validate.sh`: what it checks, which
checks block and which only warn, and where the exemption boundaries sit. It exists so the
operator can audit the validator without reading 1400 lines of shell.

`_system/validate.sh` is the source of truth for its own mechanics. This file describes the
contract the script implements and deliberately does not mirror it line by line: the previous
version of these notes drifted into describing temp files, an EXIT trap, and a migration
grandfather that no longer existed, which is the failure mode a code-mirroring document invites.
When the two disagree, the script wins and this file is wrong.

The doctrine behind these checks lives in `knowledge/ai-architecture/`. This file states the
operative behavior; it does not restate the reasoning. See [[namespace-linting]], [[canon-layer]],
[[required-namespace-surfaces]], [[intake-fabric-namespace]], and [[system-vs-doctrine-boundary]]
for the why. The operative overview of this layer is `_system/README.md`. The enforcement tier of
every numbered rule, and which checks block, is `_system/enforcement-tiers.md`.

## How to run

```bash
bash _system/validate.sh
```

Run from anywhere; the script resolves the repo root from its own path. Exit code 0 means every
blocking check passed. Exit code 1 means at least one error. Warnings never change the exit code.
The script is idempotent and writes nothing to the repo.

## The passes

In run order, the script announces each pass:

1. node frontmatter across the repo markdown walk (required keys, dash ban)
2. namespace registry files in `_system/namespaces/` (required keys, lifecycle enum)
3. runtime adapter files (`entities/` versus `.claude/` and `.codex/` copies)
4. V2 base surfaces and canon posture
5. links (wikilinks and relative markdown links)
6. orphan nodes
7. intake processed-receipt completeness
8. em dashes and en dashes
9. warn-only shared checks in `_system/checks/`
10. the warn-only canon field check
11. the enforced tool three-layer standard check

## Blocking checks (exit 1)

- **Required node frontmatter.** Every node-bearing file carries `id`, `type`, `namespace`,
  `lifecycle_state`, `summary`, `confidence`, `retrieval_class`, `export_class`. Exemptions are in
  `is_plumbing` (see below).
- **Namespace registry keys and lifecycle enum.** `NAMESPACE_ALLOWED_LIFECYCLE` is
  `scratch|research|candidate|canon|archive`. The `research` value was added 2026-05-31 so a
  namespace can declare itself validated-but-not-yet-candidate, matching the node-level lifecycle.
- **Required base surfaces.** Every serious namespace under `knowledge/` carries `BASE_SURFACES`:
  `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`. Function: `check_base_surfaces`.
  Exempt: `knowledge/_examples`, any `_examples/*` namespace, and any namespace whose registry entry
  declares `reduced_base: true`. The exemption is registry-driven, so graduating a namespace to the
  serious base is a registry edit, not a validator change.
- **Full canon files.** A namespace declaring `canon_posture: full` carries `canon/README.md`,
  `canon/core-doctrine.md`, and `canon/agent-load-order.md`. On the `tool-contract` profile,
  `canon/core-contract.md` satisfies the core-doctrine requirement. `canon_posture` is read from the
  registry via `registry_field`; a namespace with no such field is skipped. Function:
  `check_full_canon`.
- **Intake processed-receipt completeness.** A file under `intake/processed/**` or
  `intake/destinations/*/processed/**` declaring `type: "processed-receipt"` must carry a
  `routing_decision` wikilink and a `destination` block. `intake/schemas/processed-receipt.md` has no
  frontmatter and is never treated as a receipt.
- **The em dash and en dash ban** across all `.md`.
- **The tool three-layer standard.** `_system/checks/tool-three-layer-standard-check.sh`, enforced as
  an error since 2026-06-17: every root tool pointer links a `*-tool-contract` namespace or declares
  `contract_status: pointer-only` with a reason, and every `*-tool-contract` namespace has a root
  pointer.

## Warn-only checks (never change the exit code)

- **Broken wikilinks.** For each `[[name]]`, warn when no `name.md` exists in the vault and no node
  declares `name` as its `id` or alias. The resolver index is `LINK_INDEX_DIRS`: `knowledge/`,
  `_system/`, `entities/`, `workflows/`, `intake/`. `normalize_wikilink_target` resolves alias pipes,
  anchors, and path prefixes. Archive subtrees are skipped.
  Note: doctrine prose that needs to show wikilink syntax should write it in backticks without double
  brackets, because the extractor treats any bracket pair as a link even inside a code span.
- **Broken relative markdown links.** For `[text](path.md)` in `knowledge/`, warn when the target does
  not resolve. HTTP, HTTPS, mailto, and pure-anchor links are skipped; only `.md` targets are checked.
- **Orphan nodes.** A substantive knowledge node with no outbound `edges` and no inbound reference is
  an orphan. Excludes `archive/`, `support/`, and `INDEX.md`.
- **Obsidian alias compatibility.** Warn when a node's `id` differs from its filename and `aliases`
  does not include the id.
- **Project node suggestions.** `state_stored_at` and `analytical_view` (v3.1 optional fields).
- **n8n runtime compatibility.** SSH-auth and webhook-probe warnings; JSON validity and
  JSON-to-companion-MD pairing.
- **The shared checks in `_system/checks/`**, including `adapter-sync-check.sh`.
- **The canon field check.** `_system/checks/canon-field-check.sh`, added 2026-07-16: `verified_at`,
  `verified_by`, `derived_from`, and `## Changelog` presence on the canon nodes of record of every
  `canon_posture: full` namespace, plus the `freshness_posture` enum. Warn-only by decision, not by
  oversight: `verified_at` and `verified_by` record operator approval of canon, and no agent may
  self-approve canon, so the tree cannot be brought to green by an agent. Promotion to blocking is an
  operator decision per the promotion path in `_system/enforcement-tiers.md`.

## Frontmatter exemptions (`is_plumbing`)

Exempt, because they are navigational or operative scaffolding rather than knowledge nodes
(contract Part 7.3):

- `knowledge/*/INDEX.md`
- `knowledge/*/canon/README.md`
- `knowledge/*/canon/agent-load-order.md`
- `knowledge/*/synthesis/README.md`
- `knowledge/*/support/*` and `knowledge/*/archive/*`
- the entire `intake/` tree
- the export overlay trees (`tools/starter-export/overlay/`, `tools/client-export/overlay/`), which
  are payload for an exported brain rather than nodes in this one
- the name-based plumbing patterns (`README.md`, `CLAUDE.md`, `AGENTS.md`, `START-HERE.md`, and the
  `_system/`, `swarms/`, `docs/`, `sessions/` trees)

NOT exempt, and still requiring full node frontmatter:

- `knowledge/*/canon/core-doctrine.md` and `knowledge/*/canon/core-contract.md`
- `knowledge/*/canon/current-truth.md`
- substantive `knowledge/*/synthesis/*.md` (everything except `synthesis/README.md`)

The intake tree is exempt from frontmatter, but processed receipts inside it are still checked for
completeness by a pass that runs independently of the frontmatter walk.

An export overlay must be registered in two places to be excluded: `GENERATED_MD_WALK_PRUNES` (the
bash walk) and the `is_plumbing` startswith list (the python walk). Adding an overlay to only one
leaves the other engine scanning it, which is how the client-export overlay came to fail after it
was adapted from starter-export.

## Deterministic versus fuzzy boundary

`validate.sh` owns only what is mechanically decidable from file structure and frontmatter: surface
presence, canon file presence, field presence, link resolution, orphan topology, receipt field
presence, and the dash ban. Judgment stays with curator agents and workflows: contradiction
surfacing, canon-candidate detection, freshness judgment, and whether a synthesis note is ready for
promotion. This split is guardrail G5. Doctrine: [[namespace-linting]],
[[correction-loop-absorption]].

Presence is not truth. The validator can confirm a `verified_by` field exists; it cannot confirm the
operator actually verified anything. Every check here is a lower bound on correctness.

## Changelog

- 2026-05-31: authored as the V2 extension notes for the Namespace Architecture V2 upgrade
  (contract Part 7.3, guardrail G5).
- 2026-07-16: rewritten by sprint `2026-07-16-system-drift-repair` (finding 4). The V2 migration is
  complete (71 upgraded, 1 born-v2, 0 queued), so the migration framing, the `v2_status` grandfather
  narrative, and the `QUEUED V2 GAP` warning path were removed along with the dead code they
  described. Also corrected: the file claimed temp files and an EXIT trap the script no longer has,
  named `extract_wikilink_targets` which no longer exists, and described `personal-operator` as
  reduced-base after its 2026-06-03 graduation. Retitled from "V2 Extension Notes" to reference
  notes, and re-scoped to describe the contract rather than mirror the code, because mirroring is
  what let it drift.
