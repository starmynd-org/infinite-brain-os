---
id: "decision-ai-architecture-public-llm-index-export-posture"
aliases: ["decision-ai-architecture-public-llm-index-export-posture", "public-llm-index-export-posture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Treat llms.txt as an export surface generated from canon, not internal architecture; only profiles meant for external discovery expose it, and the generator reads canon and never bypasses it or publishes internal-only material."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[internal-index-vs-public-llm-index]]"
    relation: "explains"
    confidence: 0.9
  - target: "[[public-llm-index-policy]]"
    relation: "implements"
    confidence: 0.88
  - target: "[[canon-layer]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "part_of"
    confidence: 0.85
created: "2026-05-30"
---

# Public LLM Index Export Posture

## Summary

`llms.txt` and similar public discovery files are an export layer generated from
`canon/`, not part of the internal architecture. A namespace exposes a public index only
when it is meant for external discovery. The generator reads canon and produces the
public surface; it never bypasses canon or publishes internal-only material.

## Decision

Two artifacts, two jobs, kept distinct:

- `INDEX.md` is the rich internal retrieval router for trusted Claude Code and Codex
  agents. It carries query classes, load order, open disputes, and output linkage.
- `llms.txt` is a thin public summary generated from `canon/`. It is a derived artifact,
  regenerated when canon changes, never hand-authored as a separate truth.

These are different artifacts with different audiences. See
[[internal-index-vs-public-llm-index]] for the boundary in full.

Which profiles expose a public index:

- **Most relevant**: Tool Contract, Data System, Design System, Component Library, and
  Content Strategy. These describe contracts, data, visual canon, components, and
  positions that an external reader or partner agent may legitimately discover.
- **Least relevant**: private thinker canon such as `ooda-john-boyd` and `david-deutsch`.
  These are internal reasoning corpora with no external-discovery job, so they expose no
  public index by default.

A namespace that is not meant for external discovery exposes no `llms.txt`. Exposure is
opt-in by profile relevance and operator decision, not a default.

Generation rules:

- The generator reads `canon/` (primarily `canon/core-doctrine.md`, and
  `canon/current-truth.md` for stateful namespaces) and emits the public surface from it.
- It never reads raw `pillars/`, `concepts/`, `support/`, `synthesis/`, or `intake/`
  directly into the public file. If a fact is not in canon, it does not reach the public
  index.
- It respects `export_class`. A node marked `internal` or `department` never appears in a
  `public` export, even if it sits in canon.
- The public file is regenerated, not edited. Drift between canon and `llms.txt` is a
  signal to regenerate, not to patch the public file by hand.

## Why this is the right call

- Canon is already the operator-approved, provenance-bearing compression of the
  namespace. Generating the public surface from canon means the public claim and the
  internal trusted claim share one source, so they cannot silently diverge.
- Routing the public surface through canon makes the `export_class` gate the single place
  that decides what is publishable. Internal-only material cannot leak through a
  hand-written public file.
- Treating `llms.txt` as export, not architecture, keeps it out of the retrieval path.
  Agents load `INDEX.md` and canon; the public file is a downstream output, so it never
  competes with the internal router.

## Rejected alternative

Author `llms.txt` by hand as a public-facing companion to `INDEX.md`. Rejected because a
hand-written public file becomes a second source of truth that drifts from canon, and
because it removes the `export_class` gate, making internal-only leakage a manual-review
problem instead of a generation-rule guarantee.

## Status

Locked for the V2 sprint. The operative generation and exposure rules live in
`_system/public-llm-index-policy.md`, surfaced as [[public-llm-index-policy]]. The initial build
defines the posture and policy; per-namespace public-index generation is queued, not run.

## Notes

This decision sets the posture: export from canon, opt-in by profile, gated by
`export_class`. The internal-versus-public boundary is explained in
[[internal-index-vs-public-llm-index]]; the operative rules are in
[[public-llm-index-policy]].
