# Client workspace Rules

The Infinite Brain can reason about and orchestrate work that spans more than one git repo.
That means repo ownership, repo purpose, and repo-to-department mapping must be explicit.

This file is the operative contract for the root `repo-registry/` layer.

The doctrine that explains why this layer exists lives in:

- `knowledge/ai-architecture/canon/system-overview.md`
- `knowledge/ai-architecture/canon/core-doctrine.md`
- `knowledge/ai-architecture/canon/department-model.md`

## Purpose

Use `repo-registry/` to answer:

- what repos exist across the active root `<your-repos-root>` and the legacy root
  `<legacy-root>`
- what each repo's job is
- which department or departments own or depend on it
- which namespace or architecture surfaces explain it
- whether the repo is active, owned, supporting, legacy, or a future digestion candidate

## The active root and the active set

The 2026-06-04 repo-root migration moved the active set to `<your-repos-root>`, with the OS and the
internal active repos under `internal/` and external repos under `external/`. The legacy root
`<legacy-root>` is retained only for legacy, dead, or source-material repos. The
repo-root `CLAUDE.md` and `AGENTS.md` are the source of truth for the lean active set; the registry maps
both roots but must keep the active set accurate against that source. Active entries already point at the
new root; legacy entries legitimately still point at the old root because those repos were left behind.

As of the 2026-06-09 platform-layer integration review the active set is: `infinite-brain-os`,
`company-canon`, `example-app`, and `example-orchestrator`. A newly
active repo earns its entry through the human-in-the-loop registry pass, since ownership and posture are
operator-gated decisions, not silent additions.

This layer exists because repos are not the same thing as:

- departments
- tools
- namespaces
- projects

A repo is a code and artifact container. It may host several namespaces, several tools, one
department's runtime, or a digestion candidate that Infinite Brain plans to absorb later.

## Required shape

The root registry lives at:

```text
repo-registry/README.md
repo-registry/_template.md
repo-registry/<repo-slug>.md
```

Each repo entry should define:

1. repo name
2. repo path
3. primary job of the repo
4. current status, one of the canonical set below
5. owning department or departments
6. related namespaces
7. related tools or runtime systems
8. digestion or migration posture, if relevant
9. open risks or ambiguities

### Canonical status vocabulary

The status field uses one of these canonical values. The set was widened on 2026-06-09 to match the
values entries already carry; per-entry normalization to this set is a devops-platform registry-refinement
task, not a silent rename.

- `primary`: the OS itself, the single source of truth.
- `owned`: an active repo the OS owns and builds in (the internal active set).
- `active`: an actively used runtime repo (for example the orchestrator) that the OS depends on.
- `supporting`: a related repo that supports a department without being primary or owned.
- `imported-self-contained`: a repo whose corpus was imported, retained self-contained afterward.
- `legacy-source` or `legacy`: retained only as prior art or migration source-material.
- `planned-digestion`: a future absorption target.
- `reference`: a read-only reference repo.

## Department linkage

If a real department materially depends on a repo outside `infinite-brain-os`, that
dependency should be listed in the department `INDEX.md` under a `Related Repos` section.

The department index is the source of truth for:

- why that repo matters to the department
- whether it is core, supporting, or future migration input

The repo-registry entry is the source of truth for:

- what that repo is
- where it lives
- which departments touch it

## Scope boundary

Do not use `repo-registry/` as a second source of truth for:

- the repo's internal knowledge graph
- detailed tool contracts
- live runtime state
- project plans that belong in the repo itself

The registry points at those surfaces. It does not replace them.

## When a repo deserves an entry

Create or update a repo-registry entry when any of the following are true:

- a department depends on the repo operationally
- the repo is a future digestion target
- the repo contains source material for a namespace migration
- the repo holds important runtime systems or integrations used by the OS
- the repo is part of the active expansion plan

## First implementation guidance

The first pass does not need every repo under either root.

Start with:

- repos that already feed active departments
- repos that are explicit migration or digestion targets
- repos that the expansion program already names

Then expand as the department map gets broader.
