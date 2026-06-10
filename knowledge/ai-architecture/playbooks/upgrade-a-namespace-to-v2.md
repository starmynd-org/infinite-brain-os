---
id: "knowledge-ai-architecture-upgrade-a-namespace-to-v2"
aliases: ["knowledge-ai-architecture-upgrade-a-namespace-to-v2", "ai-architecture-upgrade-namespace-v2", "upgrade-a-namespace-to-v2"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Migration procedure for an existing namespace: assign a profile, add canon and synthesis additively, upgrade INDEX.md to the router contract, preserve edges and aliases, validate, author the retrieval eval."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[required-namespace-surfaces]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[migration-compatibility-rules]]"
    relation: "bounded_by"
    confidence: 0.9
  - target: "[[canonize-a-namespace]]"
    relation: "depends_on"
    confidence: 0.88
created: "2026-05-30"
---

# Upgrade A Namespace To V2

## Summary

This is the additive migration path for an existing namespace. It adds the V2 shared
base and the router contract on top of the current folders. It never restructures
`pillars/`, `concepts/`, `decisions/`, `playbooks/`, `support/`, or `archive/`, and it
never drops an edge or an alias. The work is done when `validate.sh` passes and the
namespace retrieval eval resolves correctly.

## When to run

Run this when an existing namespace needs the V2 surfaces: a declared profile, a
`canon/` layer, a `synthesis/` layer, and an `INDEX.md` that acts as a retrieval router
rather than a folder list. Upgrade builders first so new work is V2-aligned by default,
then upgrade namespaces in audit-packet order.

## Procedure

1. Assign the profile. Pick one of the eight profiles from [[namespace-profiles]] and
   record it in the registry entry `_system/namespaces/<ns>.md` via `profile:`. Add the
   companion fields: `canon_posture`, `freshness_posture`, `archive_posture`, and
   `expected_folders`. The profile adds folders to the shared base; it never removes a
   base surface and never forks the ontology. See [[required-namespace-surfaces]] for
   the base set.

2. Add `canon/` additively. Create the canon folder alongside existing folders, never
   in place of them. Build its contents using [[canonize-a-namespace]]. Match the canon
   posture you recorded in step 1.

3. Add `synthesis/` additively. Create the synthesis folder for within-namespace derived
   thinking: contradiction maps, best-current-reading notes, what-changed reviews, and
   canon candidates. Move any derived thinking currently sitting in `support/` into
   `synthesis/`. Leave provenance and migration receipts in `support/`.

4. Upgrade `INDEX.md` to the router contract. Rewrite it to the required section order:
   purpose, `## Profile`, `## Load first`, `## Query classes`, `## Stable vs stateful`,
   `## Open disputes`, `## What this namespace drives`, `## Archive and provenance`,
   `## Common misreadings`, and `## Map` last. `INDEX.md` stays rich markdown without
   node frontmatter.

5. Preserve edges and aliases. Reorganization must not drop any existing `edges` or
   `aliases`. When a file is renamed or moved, add the old id to the new file's
   `aliases` or leave a stub with a `supersedes` pointer. Follow
   [[migration-compatibility-rules]] exactly. Never break a link silently.

6. Land the structural rules in the validator in the same pass. If this upgrade
   introduces a new structural rule for the namespace, ensure `validate.sh` already
   checks it so drift is visible immediately.

7. Run `bash _system/validate.sh`. Fix every error: missing base surface, missing canon
   file for a `full` canon posture, broken relative links, broken `wikilinks`, and
   frontmatter key gaps. Warnings such as orphan detection and unexpected-folder checks
   should be reviewed but do not block.

8. Author the retrieval eval. Write five to ten representative agent queries and the
   expected load set or answer to `support/retrieval-eval.md`. The upgrade is not done
   until these queries resolve correctly against the upgraded structure.

9. Update the registry and close. Set the registry `lifecycle_state` as appropriate,
   confirm `expected_folders` matches the on-disk folders, and record the upgrade in the
   namespace `support/` migration trail.

## Quality checks

- No existing folder was restructured; `canon/` and `synthesis/` were added beside them.
- Every pre-upgrade edge and alias still exists.
- `INDEX.md` follows the router section order and resolves every file it names.
- `validate.sh` exits clean.
- The retrieval eval exists and passes.

## Notes

This playbook is additive on purpose. The whole point of V2 is that an upgrade is safe
to run on a live namespace without breaking the agents already reading it. If a step
would force a destructive restructure, stop and route the question to the audit packet
instead of improvising a rename.
