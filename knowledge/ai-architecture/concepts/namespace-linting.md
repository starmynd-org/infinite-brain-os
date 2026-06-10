---
id: "knowledge-ai-architecture-namespace-linting"
aliases: ["knowledge-ai-architecture-namespace-linting", "ai-architecture-namespace-linting"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Graph health is kept by splitting deterministic checks (orphans, broken links, missing surfaces) into validate.sh and fuzzy checks (contradiction surfacing, canon candidates) into curator agents. Lint expectations vary by profile."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[namespace-lint-rules]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[profile-lint-rules]]"
    relation: "implements"
    confidence: 0.88
  - target: "[[detect-contradictions]]"
    relation: "uses"
    confidence: 0.85
created: "2026-05-30"
---

# Namespace Linting

## Summary

A knowledge graph rots without maintenance: orphans accumulate, links break, claims go
stale, content duplicates, and nodes contradict each other (contract Part 11, X research
lesson 5). Linting is the discipline that surfaces this rot. The load-bearing rule is the
split: deterministic checks belong in `validate.sh`, and only genuinely fuzzy checks
belong to curator agents (guardrail G5).

## Content

Namespace linting covers five health categories.

- Orphans: a node with no inbound and no outbound edges. It cannot be reached by graph
  traversal and is likely either dead or unlinked.
- Broken links: a relative link or a `wikilink` whose target file does not resolve. A
  broken link silently drops a path an agent expected to follow.
- Stale claims: a node whose content has decayed because the world moved and the node did
  not. Most acute in stateful namespaces and stateful sections.
- Duplicates: two nodes that own the same content, which splits authority and lets the
  copies drift apart.
- Contradictions: two nodes or sources that assert incompatible things without a recorded
  resolution.

## The deterministic versus fuzzy split

The split is the core doctrine of namespace linting, and it is what keeps maintenance
cheap and trustworthy.

Deterministic checks have a single correct answer that a script can compute. They belong
in `validate.sh` so they run fast, run the same way every time, and gate the graph in CI.
The V2 `validate.sh` checks include: missing required base surface (`INDEX.md`, `canon/`,
`playbooks/`, `support/`, `synthesis/`) for serious namespaces; missing required canon
files for `canon_posture: full` namespaces; broken relative links and broken wikilinks;
orphan detection as a warning; the profile folder check as a warning; intake completeness
as an error; plus the existing frontmatter, dash-ban, n8n pairing, JSON validity,
lifecycle enum, and alias checks.

Fuzzy checks require judgment a script cannot make: deciding whether two claims actually
contradict, whether a synthesis is ready to be a canon candidate, and whether a claim has
gone stale. These belong to curator agents and workflows, not to `validate.sh`. Putting a
fuzzy check in the validator produces false gates; leaving a deterministic check to an
agent produces unreliable enforcement. The split avoids both.

## Profile-aware lint expectations

Lint expectations are not uniform. A profile changes which structural facts are required
and therefore what the linter checks, captured in [[profile-lint-rules]].

- Tool Contract: payload examples present, endpoints fresh, parameter names consistent.
- Data System: a metric has source lineage, a model has refresh logic, a pipeline maps to
  a transform.
- Design System: asset examples present, component usage maps to a token.
- Component Library: a component has a usage playbook, deployment notes present.
- Operating Library: an SOP has a trigger, a diagnostic has a next action, a procedure has
  an escalation condition.

Starter and example namespaces carry a reduced base and declare it in their `INDEX.md`, so
the profile folder check does not flag their missing surfaces as defects. The expected
surface set comes from the registry `expected_folders` field; a folder outside that set
is a warning, not an error, because additive growth is allowed.

## Edges

- `implements` the namespace-lint rules, which carry the general operative check list.
- `implements` the profile-lint rules, which carry the per-profile structural expectations.
- `uses` the contradiction-detection skill for the fuzzy contradiction-surfacing pass that
  sits outside `validate.sh`.

## Notes

Operative rules live in [[namespace-lint-rules]] and [[profile-lint-rules]]. This node
owns the why and the deterministic-versus-fuzzy split; the rules files own the executable
checks. The split with validate.sh is non-negotiable: deterministic in, fuzzy out.
