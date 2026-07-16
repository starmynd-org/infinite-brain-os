---
id: "knowledge-ai-architecture-department-graduates-to-repo-on-trust-boundary"
aliases: ["knowledge-ai-architecture-department-graduates-to-repo-on-trust-boundary", "department-graduates-to-repo-on-trust-boundary", "department-repo-graduation-trigger"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Decision: a department stays a folder inside the company brain by default and graduates to its own sibling repo only when a genuine access or trust boundary requires it, not on a fixed schedule and not for symmetry with other departments."
confidence: 0.87
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[reflexive-brain-topology]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[department-model]]"
    relation: "extends"
    confidence: 0.85
  - target: "[[graduate-a-department-to-its-own-brain-repo]]"
    relation: "supports"
    confidence: 0.9
created: "2026-07-13"
---

## The decision

A department (`departments/<slug>/` inside the company brain) graduates to its own sibling
repo only when at least one of these is true:

- a real person other than the operator needs write or read access to that department's
  work, and must not get standing access to the rest of the company brain by the same grant
- the department is client-facing and its knowledge, agents, or runtime must be visible to
  or operated by people outside the company (a client team, a contractor)
- the department's data-handling posture requires isolation the company brain's own access
  model cannot provide (a distinct secret scope, a distinct compliance boundary)

Absent one of these, the department stays a folder. Folder-first is the default; repo is the
earned exception.

## Why not "give every department a repo from day one"

Rejected for the same reason `overlays-over-per-client-forks` rejected per-client
architecture forks: it multiplies maintenance by the department count, strands each
department repo on a version that must be manually kept current with upstream doctrine
changes, and reintroduces the exact surface-area problem the namespace-first, profile-aware
topology in [[infinite-brain-namespace-architecture-v2]] was built to avoid. A repo per
department also fragments retrieval: an agent answering a cross-department question would
have to fan out across many repos instead of reading one graph, the same failure mode
[[knowledge-graph-namespace-first-topology]] already rejected for a type-first folder
layout.

## Why not "never split, keep growing one repo forever"

Also wrong. Some departments genuinely need a distinct trust boundary, and forcing them to
stay inside the company brain to preserve topological purity means either denying a real
person the access they need, or granting them access to everything to give them access to
their one department. Both are worse than a repo split. The discipline is not "never split";
it is "split only when the trigger fires."

## Evidence already in hand

This is not a hypothetical trigger. It has already fired twice:

- A client-engagement cockpit split from the main brain specifically so an outside
  collaborator on that one engagement could get write access without seeing the rest of the
  company brain. The department did not change; only its access boundary did.
- A second client release was built as a fork with shared ancestry and no remotes rather
  than a seat on the shared spine, because isolating that team's cross-pollination in both
  directions was the real requirement, not a desire for a second copy of the architecture.

Both cases confirm the trigger is access and trust, not size, maturity, or department
importance.

## What graduation does not change

A graduated department is still a department in the [[department-model]] sense: it keeps
its charter, its head-of-department agent, its intake, and its rollup obligations under
`_system/department-runtime-contract.md` and the reporting contracts. Graduation changes
where its files live and who can reach them. It does not create a new entity type, does not
change the department's ontology, and does not exempt it from the shared reporting envelope.

## Relationship

`derived_from` [[reflexive-brain-topology]] (the tier model this trigger governs) and
`overlays-over-per-client-forks` (the same reuse-over-divergence reasoning, applied to
repo count instead of architecture forks). `extends` [[department-model]] section 9. The
step-by-step graduation procedure is [[graduate-a-department-to-its-own-brain-repo]]. The
operative `repo_kind` and `brain_tier` registry fields a graduated department must declare
are in `_system/repo-registry-rules.md`.
