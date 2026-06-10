---
id: "decision-knowledge-graph-namespace-first-topology"
aliases: ["decision-knowledge-graph-namespace-first-topology", "knowledge-graph-namespace-first-topology"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The Infinite Brain knowledge graph should use a namespace-first physical layout with typed subfolders inside each namespace and full archive retention colocated with that namespace."
confidence: 0.97
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "extends"
    confidence: 0.78
  - target: "[[knowledge-ai-architecture-infinite-brain-control-model]]"
    relation: "implements"
    confidence: 0.85
created: "2026-05-30"
---

# Knowledge Graph Namespace-First Topology

## Summary

The long-term Infinite Brain knowledge graph should be organized physically by
namespace first, not by node type first.

## Decision

Adopt this target shape for durable knowledge:

- `knowledge/<namespace>/INDEX.md`
- `knowledge/<namespace>/pillars/`
- `knowledge/<namespace>/concepts/`
- `knowledge/<namespace>/decisions/`
- `knowledge/<namespace>/playbooks/`
- `knowledge/<namespace>/support/` when migration or provenance notes belong with the namespace
- `knowledge/<namespace>/archive/legacy-pkm-corpus/`
- `knowledge/<namespace>/archive/manifest.tsv`
- `knowledge/<namespace>/archive/README.md`

Keep the global registry in:

- `_system/namespaces/INDEX.md`
- `_system/namespaces/<namespace>.md`

Cross-namespace links remain allowed and expected. Namespace-first storage is for
browsability, portability, auditability, and selective sharing, not for isolation.

## Why this is the right system

- it matches how human operators browse real knowledge graphs
- it makes partial sharing and future repo-splitting straightforward
- it keeps full PKM possible because a namespace can hold both doctrine and full raw archive
- it preserves typed semantics inside each namespace instead of collapsing everything into one flat folder
- it makes migration audits easier because each namespace has one physical home

## Rejected alternative

Do not use the current type-first layout as the long-term topology:

- `knowledge/pillars/`
- `knowledge/concepts/`
- `knowledge/decisions/`
- `knowledge/playbooks/`

That layout is workable for small examples but becomes harder to browse, export,
and audit once the graph contains many namespaces and full-source migrations.

## Migration rule

This is not a summary-only doctrine. Full PKM remains the goal.

For migrated corpora:

- keep the full source corpus
- colocate the archive with the namespace
- add native doctrine, concept, decision, and playbook nodes above the preserved archive
- do not force operators to search multiple unrelated root folders to understand one namespace

## Notes

The current repo is transitional. Existing namespaces may still be stored in the
older type-first layout until the reorganization sprint completes.
