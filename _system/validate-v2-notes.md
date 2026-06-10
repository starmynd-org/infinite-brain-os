# validate.sh V2 Extension Notes

This file documents the profile-aware checks added to `_system/validate.sh` for the
Namespace Architecture V2 upgrade (contract Part 7.3, guardrail G5). It is an operative
audit reference for the operator: what each new check does, whether it is deterministic
(enforced by `validate.sh`) or fuzzy (left to a curator agent), and how to run them.

The doctrine behind these checks lives in `knowledge/ai-architecture/`. This file states
the operative rules; it does not restate the reasoning. See [[namespace-linting]],
[[canon-layer]], [[required-namespace-surfaces]], `namespace-audit-wave-order`,
[[intake-fabric-namespace]], and [[system-vs-doctrine-boundary]] for the why. The operative
overview of this whole layer is `_system/README.md`.

## How to run

```bash
bash _system/validate.sh
```

Run from anywhere; the script resolves the repo root from its own path. Exit code 0
means all checks pass. Exit code 1 means at least one error. Warnings never change the
exit code. The script is idempotent: it writes nothing to the repo, only to two
temporary files that its own EXIT trap removes. Re-running produces identical output.

## What did not change

All pre-V2 checks are preserved exactly:

- required node frontmatter keys (`id`, `type`, `namespace`, `lifecycle_state`,
  `summary`, `confidence`, `retrieval_class`, `export_class`)
- namespace registry required keys and the lifecycle enum (extended 2026-05-31 to
  `scratch|research|candidate|canon|archive`; see "Lifecycle enum extension" below)
- Obsidian alias compatibility warning (id not in aliases when id differs from filename)
- Project node `state_stored_at` / `analytical_view` suggestion (v3.1)
- n8n JSON validity, JSON-to-companion-MD pairing, SSH-auth and webhook-probe warnings
- `paperclip-mapping.json` validity
- the em dash and en dash ban across all `.md`
- exit-code behavior: 0 pass, 1 on error, warnings do not fail

## New deterministic checks (enforced by validate.sh)

### 1. Required base surfaces (error or warning by v2_status)

Every serious namespace under `knowledge/` must contain the shared base surfaces:
`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.

- The severity depends on the registry field `v2_status` (migration grandfather, see
  below). A namespace marked `v2_status: queued` is scheduled for V2 upgrade but not yet
  upgraded, so a missing base surface is a WARNING (`QUEUED V2 GAP`). A namespace that is
  `v2_status: upgraded`, or that has no `v2_status` field at all (a newly created
  namespace is expected to be born compliant), gets an ERROR.
- Exempt entirely: `knowledge/_examples` and reduced-base namespaces. Reduced-base is the
  slug `personal-operator` plus any `_examples/*` namespace (hardcoded in the
  `REDUCED_BASE_NAMESPACES` array).
- Function: `check_base_surfaces`. Doctrine: [[required-namespace-surfaces]].

### 2. Full canon files (error or warning by v2_status)

A namespace whose registry declares `canon_posture: full` must contain
`canon/README.md`, `canon/core-doctrine.md`, and `canon/agent-load-order.md`.

- Same `v2_status` grandfather as check 1: missing files WARN for `v2_status: queued`
  namespaces and ERROR for upgraded or new ones.
- `canon_posture` is read from `_system/namespaces/<slug>.md` frontmatter via the
  `registry_field` helper. A namespace with no `canon_posture` field is skipped.
- Function: `check_full_canon`. Doctrine: [[canon-layer]], [[canonize-a-namespace]].

### The v2_status migration grandfather

Added during finalization (contract Part 12, migration compatibility: additive and
non-blocking during transition). The registry field `v2_status` takes `upgraded` or
`queued`. Only `ai-architecture` is `upgraded` at the end of the initial build; the other five
namespaces are `queued` because their V2 upgrade is planned in `Namespace_Audits/` but not
yet executed. Checks 1 and 2 route queued-namespace gaps to warnings so `validate.sh`
stays green (exit 0) while the queued upgrades are tracked, and enforce them as errors once
a namespace flips to `upgraded` (or for any new born-V2 namespace, which omits the field).
Helper: `is_v2_queued`. When a namespace is upgraded per its audit packet, set
`v2_status: upgraded` in its registry entry and the validator will then enforce its
surfaces.

### Lifecycle enum extension (2026-05-31)

The namespace registry `lifecycle_state` enum was `scratch|candidate|canon|archive`. It was
extended to `scratch|research|candidate|canon|archive` during the V2 Rollout and Ops
Hardening sprint (`NAMESPACE_ALLOWED_LIFECYCLE` in `validate.sh`). The reason: the
node-level lifecycle already included `research` (a validated state worth refining and
showing to others, per `CLAUDE.md` and the voice-and-style lifecycle), but the namespace
enum did not, so a namespace could not declare itself validated-but-not-yet-candidate. The
`ai-architecture` namespace is exactly that state after V2: it is the proven reference
implementation of the full base, not a throwaway scratch namespace and not yet a promotion
candidate. Moving it to `research` makes the registry honest. The enum extension is additive
and backward compatible: every previously valid value still validates. The other five
namespaces stay at `scratch` until their own upgrade resolves their posture.

### 3. Intake processed-receipt completeness (error)

A processed receipt that is missing a `routing_decision` wikilink or a `destination`
block is an error in `intake/`.

- A real receipt is a file under `intake/processed/**` or
  `intake/destinations/*/processed/**` that has YAML frontmatter declaring
  `type: "processed-receipt"`. The schema doc `intake/schemas/processed-receipt.md` has
  no frontmatter and is not treated as a receipt, so it is never flagged.
- Matched fields come from the processed-receipt schema: `routing_decision`
  (a `[[wikilink]]`) and `destination` (the object whose `target` records where the item
  landed).
- Doctrine: [[process-namespace-intake]], [[intake-fabric-namespace]].

## New warning-only checks (deterministic detection, non-blocking)

These surface curation rot. They are warnings so forward references and not-yet-built
nodes do not block the build. Resolving them is the job of a curator agent
([[review-namespace-health]], [[namespace-linting]]); `validate.sh` only points at them.

### 4. Broken wikilinks (warning)

For each `[[name]]` in a file under `knowledge/`, the check warns when no file
`name.md` exists anywhere in the vault and no node declares `name` as its `id` or alias.
The resolver index spans `knowledge/`, `_system/`, `entities/`, `workflows/`, and
`intake/` (broadened during finalization so that links to skills, agents, and workflows,
which live under `entities/` and `workflows/`, resolve the way Obsidian resolves them
vault-wide). The extractor resolves alias pipes (`[[name|display]]` to `name`), anchors
(`[[name#section]]` to `name`), and path prefixes (`[[canon/README]]` to `README`).
Archive subtrees are skipped to keep noise down.

Note: doctrine prose that needs to show the wikilink syntax should write it in backticks
without double brackets (for example, the word wikilink in code font), because the
extractor treats any `[[...]]` token as a link even inside a code span. Some early nodes
that originally quoted `[[wikilinks]]` illustratively were converted during finalization.
Remaining broken-wikilink warnings point at genuinely absent targets (for example
`personal-operator` starter placeholders) and are warnings, not errors.

### 5. Broken relative markdown links (warning)

For `[text](path.md)` links in `knowledge/` files, the check warns when `path.md` does
not resolve to an existing file. Repo-absolute paths resolve from the repo root;
relative paths resolve from the linking file's directory. Anchors are stripped before
resolution. HTTP, HTTPS, `mailto:`, and pure-anchor links are skipped, and only `.md`
targets are checked.

### 6. Orphan nodes (warning)

A substantive knowledge node with no outbound `edges` and no inbound reference from any
other node is an orphan. The candidate set excludes `archive/`, `support/`, and
`INDEX.md` (those are provenance and routing, not graph nodes). A node counts as
referenced if any wikilink anywhere resolves to its filename or its `id`. Doctrine:
[[curation-against-rot]] (see [[namespace-linting]]).

## Exemption list changes (node frontmatter)

The `is_plumbing` function now also exempts these from node-frontmatter checks, per
contract Part 7.3, because they are navigational or operative scaffolding rather than
knowledge nodes:

- `knowledge/*/canon/README.md`
- `knowledge/*/canon/agent-load-order.md`
- `knowledge/*/synthesis/README.md`
- the entire `intake/` tree

These remain NOT exempt and still require full node frontmatter:

- `knowledge/*/canon/core-doctrine.md`
- `knowledge/*/canon/current-truth.md`
- substantive `knowledge/*/synthesis/*.md` nodes (everything except `synthesis/README.md`)

The intake tree is exempt from frontmatter, but processed receipts inside it are still
checked for completeness by check 3 above, which runs independently of the frontmatter
pass.

## Deterministic vs fuzzy boundary

`validate.sh` owns only checks that are mechanically decidable from file structure and
frontmatter: surface presence, canon file presence, link resolution, orphan topology,
receipt field presence, and the em and en dash ban. Judgment calls stay with curator
agents and workflows: contradiction surfacing, canon-candidate detection, freshness
judgment, and whether a synthesis note is ready for promotion. This split is guardrail
G5. Doctrine: [[namespace-linting]], [[correction-loop-absorption]].

## Where the new code lives

| Concern | Location in validate.sh |
|---------|--------------------------|
| Frontmatter exemptions (canon, synthesis, intake) | `is_plumbing` |
| Registry field reader | `registry_field` |
| Base-surface check | `check_base_surfaces`, `BASE_SURFACES`, `REDUCED_BASE_NAMESPACES`, `is_reduced_base_namespace` |
| Full-canon check | `check_full_canon` |
| v2_status migration grandfather | `is_v2_queued` |
| Wikilink resolver index (vault-wide) | `LINK_INDEX_DIRS` |
| Wikilink target extractor | `extract_wikilink_targets` |
| Broken link and orphan detection | the "Checking links" and "Checking for orphan nodes" blocks |
| Intake receipt completeness | the "Checking intake processed-receipt completeness" block |
