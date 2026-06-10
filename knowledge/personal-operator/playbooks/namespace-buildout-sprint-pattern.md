---
id: "playbook-namespace-buildout-sprint-pattern"
aliases: ["playbook-namespace-buildout-sprint-pattern", "namespace-buildout-sprint-pattern"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Reusable sprint pattern for namespace buildout and migration work derived from a successful namespace buildout in the deployment this starter derives from."
confidence: 0.94
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-build-namespace]]"
    relation: "supports"
    confidence: 0.9
created: "2026-05-29"
---

# Namespace Buildout Sprint Pattern

Derived from the successful `2026-05-29-example-marketing-namespace-buildout` run.

## Recommended artifacts

For namespace buildout or migration sprints, treat these as standard:

1. `waves/wave-0-preflight.md`
2. `waves/lane-a-source-manifest.md`
3. `waves/lane-a-source-priority-table.md` when canon priority matters
4. `waves/lane-b-namespace-boundary.md`
5. `waves/lane-b-canon-selection-rules.md`
6. `waves/lane-c-target-file-map.md`
7. `waves/lane-c-node-briefs.md`

## Why this pattern works

- it forces source clarity before writing nodes
- it forces canon-selection logic before copy work
- it forces target structure before implementation
- it makes later review and audit much easier

## Use when

- building a new namespace from many recent sources
- migrating a corpus into a namespace
- deciding canon versus support material

## Escalation rule

If the corpus requires full inclusion, add explicit raw-source and provenance
planning. Do not rely only on node briefs.

## Full-inclusion standard

For legacy PKM migrations, default to this preservation pattern unless there is a
better namespace-specific reason not to:

- `knowledge/<namespace>/archive/legacy-pkm-corpus/`
- `knowledge/<namespace>/archive/manifest.tsv`
- `knowledge/<namespace>/archive/README.md`

Treat that archive subtree as preserved source material rather than canonical
node inventory. The validator should pass on the repo without requiring copied
legacy markdown files to adopt Infinite Brain frontmatter.
