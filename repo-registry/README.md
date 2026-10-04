---
id: "repo-registry-readme"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Root registry for repos outside and around this brain: what each repo is for, who owns it, which surfaces depend on it, and what its posture is. Pointer nodes only, never raw secrets or live state."
confidence: 0.88
retrieval_class: "identity"
export_class: "internal"
created: "2026-05-31"
---

# Client workspace

This folder is the root registry for repos that matter to this brain. The brain becomes a
multi-repo system as soon as it coordinates work in even one sibling repo, and
this registry is how agents know what exists beyond the brain itself.

Use it to answer:

- what repos exist across your repos root
- what each repo's job is
- who owns each repo and where the ownership boundary sits
- whether a repo is a primary repo, a supporting runtime repo, a source-migration repo,
  or a digestion candidate

## What belongs here

- one registry entry per relevant repo
- repo identity and path (relative to your repos root, never a machine-specific path)
- primary job and current registry status
- ownership and the boundary of what this brain may touch in it
- related namespaces, projects, and runtime systems or tools
- open decisions and risks

## What does not belong here

- raw secrets, tokens, or credentials of any kind (those are secret references in
  `secrets/`, and the values live outside git entirely)
- deep doctrine about a repo's domain (that belongs in `knowledge/`)
- full project plans that belong in the repo itself
- live runtime state

## How to register a repo

Copy `_template.md` to a new file named after the repo slug, fill in the identity, path,
job, ownership, and posture sections, and link the entry to the namespaces and tools that
depend on it. Keep every entry on the same section schema so agents can scan the registry
uniformly.

## Repo kind and brain tier

Every entry classifies what the repo is, independent of who owns it: `repo_kind` is
`brain`, `app`, or `mixed`, and `brain_tier` (for brains) is `individual`, `department`,
or `company`. The field definitions are in `_system/repo-registry-rules.md`; the reasoning
is the topology pillar `knowledge/ai-architecture/pillars/reflexive-brain-topology.md`.

## Fictional examples

Two entries a typical adopter might add:

- `company-canon.md`: the shared company library at `<your-repos-root>/company-canon`.
  Job: brand, rules, and cross-team knowledge promoted from working repos. Ownership: the
  team lead owns merges; this brain proposes via pull request and never edits canon
  directly.
- `example-product-app.md`: the product codebase at
  `<your-repos-root>/example-product-app`. Job: the shipped application. Ownership: the
  engineering team owns it; this brain reads it for context and files issues, but deploys
  only through the team's own pipeline.

## Related surfaces

- `_system/repo-registry-rules.md`
- `knowledge/ai-architecture/`
- `secrets/` for credential references a registered repo needs

Start from `_template.md` when adding a new repo.
