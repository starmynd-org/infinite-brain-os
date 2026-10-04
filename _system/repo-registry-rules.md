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

The active set lives under one active root (`<your-repos-root>`), with the brain and the
internal active repos under `internal/` and external repos under `external/`. A legacy root,
where one exists, is retained only for legacy, dead, or source-material repos. The
repo-root `CLAUDE.md` and `AGENTS.md` are the source of truth for the lean active set; the registry maps
both roots but must keep the active set accurate against that source. Active entries point at the
active root; legacy entries legitimately still point at the old root because those repos were left behind.

A worked active set looks like: `infinite-brain-os` (the brain itself),
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
10. `repo_kind`, one of the enum below
11. `brain_tier`, when `repo_kind` includes brain

### Repo kind and brain tier

Two fields classify what a repo *is*, independent of who owns it (the internal-versus-external
axis above) and independent of its operating status (the canonical status vocabulary below).

- `repo_kind`: `brain | app | mixed`. `brain` is a repo organized as a knowledge graph (it
  carries or vendors `entities/`, participates in the namespace ontology, and is retrieved
  rather than only read as code). `app` is a product or client codebase with no brain
  ontology: a thin `.claude/` for product-development commands and skills is normal, an
  `entities/` folder is not expected. `mixed` is a repo that carries a real `entities/`
  adapter set alongside substantial non-brain application code; use it rather than forcing a
  false binary.
- `brain_tier`: `individual | department | company`. Applies only when `repo_kind` is `brain`
  or `mixed`. `individual` is one operator's scratch-and-research layer. `department` is one
  business function's operating assembly that has graduated out of a company brain's
  `departments/` folder. `company` is the upstream core that individual and department
  tiers vendor shared entities and doctrine from.

The reasoning for the tier model and the graduation trigger between a department folder and
a department repo lives in `knowledge/ai-architecture/pillars/reflexive-brain-topology.md`
and `knowledge/ai-architecture/decisions/department-graduates-to-repo-on-trust-boundary.md`.
This file states the operative fields only.

### Canonical status vocabulary

The status field uses one of these canonical values. Per-entry normalization to this set is a
registry-refinement task, not a silent rename.

- `primary`: the brain itself, the single source of truth.
- `owned`: an active repo the brain owns and builds in (the internal active set).
- `active`: an actively used runtime repo (for example the orchestrator) that the brain depends on.
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
- the repo holds important runtime systems or integrations used by the brain
- the repo is part of the active expansion plan

## First implementation guidance

The first pass does not need every repo under either root.

Start with:

- repos that already feed active departments
- repos that are explicit migration or digestion targets
- repos that the expansion program already names

Then expand as the department map gets broader.
