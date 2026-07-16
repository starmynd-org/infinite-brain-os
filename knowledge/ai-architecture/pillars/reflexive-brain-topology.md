---
id: "knowledge-ai-architecture-reflexive-brain-topology"
aliases: ["knowledge-ai-architecture-reflexive-brain-topology", "reflexive-brain-topology", "brain-hierarchy"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The enterprise standard for how one company organizes its repos once it runs the Infinite Brain internally: a company-level shared parent, a plural individual brain tier (one repo per person), a department brain tier, and one company brain tier, plus an orthogonal brain-versus-app repo-kind classification for repos that are not knowledge-graph OSes at all."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
edges:
  - target: "[[department-model]]"
    relation: "extends"
    confidence: 0.88
  - target: "[[department-graduates-to-repo-on-trust-boundary]]"
    relation: "supports"
    confidence: 0.9
  - target: "[[graduate-a-department-to-its-own-brain-repo]]"
    relation: "supports"
    confidence: 0.88
  - target: "[[apps-decompose-into-primitives]]"
    relation: "related_to"
    confidence: 0.75
created: "2026-07-13"
---

## Summary

This is the enterprise standard for how one company organizes its repos once it runs the
Infinite Brain internally: not only how the architecture arrives, but the shape it settles
into. The pattern was field-tested first on client releases (a shared parent folder, a
personal repo per builder, and a governed canon layer, with a strict core-versus-overlay
boundary so downstream consumers never fork the standard). This pillar states that same
topology as the standard shape any adopting company runs on its own root, whether it is a
single-operator business or an enterprise with many teams.

## The shared parent folder is a company-level root, not a personal one

A company running this standard has one shared parent folder: a root containing every
sibling repo (personal and department) for that company, with root guidance (`CLAUDE.md`,
`AGENTS.md`, root-level commands) that orients any person or agent that lands in it. The
root should itself be a real (thin) git repo, not loose files: that makes "the brain is
just git, synced through your git host" true at every tier, not only inside the company
brain repo itself. A company adopting the standard should start with a versioned shared
parent, not retrofit one later.

## Four tiers, not three

The client-facing pattern names two governed tiers under the shared parent: personal and
department. Applied as the standard for how a whole company runs the system, a third tier
appears above them, because a real company is simultaneously many operators, a portfolio of
departments, and one standard-setter for its own architecture:

| Tier | Physical home | Governs |
|------|------------------------|---------|
| Shared parent | the company's repos root (a thin, versioned repo) | root orientation, cross-repo routing, repo-kind classification |
| Individual brain | one personal repo per person who works in the system | one person's scratch and research layer |
| Department brain | `departments/<slug>/` folders inside the company brain, or a graduated sibling repo | one business function's operating assembly |
| Company brain | the company's own primary brain repo (what this starter becomes when you adopt it) | architecture doctrine, the shared entity library, the department assembly layer |

The company brain is the upstream role: the authoritative core that downstream layers
consume and never fork. The difference between deployments is only who the downstream
consumer is. For an enterprise, the downstream consumers are each team member's individual
repo and each department's repo. For a solo operation, the downstream consumers are the
operator's individual layer and any department that graduates (see
[[department-graduates-to-repo-on-trust-boundary]]).

## Individual brain: one personal repo per person, by default

At company scale, the individual tier is plural: every person who touches the system, an
employee or a contractor, gets their own personal repo (`individual-<name>/`, one per
roster entry). This is not a speculative extension; it is the same mechanism proven on
client team rollouts, applied to a company's own staff. A company of any real size should
provision one individual-brain repo per person from the start, not wait for a trigger.

The one legitimate collapse is the degenerate case of a single-operator instantiation
before a second person exists: the shared parent and the sole individual layer may live
together as one namespace (`knowledge/personal-operator/`) plus the shared-parent command
layer, without a dedicated personal repo, because there is no second person to isolate from
yet. That collapse is a minimal starting instantiation of the standard, not the standard
itself, and it unwinds the moment a second person is onboarded, using the same mechanism.

## Department brain: stays a folder until a trust boundary demands otherwise

Same discipline. A `departments/<slug>/` folder graduates to its own sibling repo only when
a real access or trust boundary requires it, never on a fixed schedule and never for
symmetry with other departments. The trigger and the rejected alternatives are in
[[department-graduates-to-repo-on-trust-boundary]]. The step-by-step mechanics are in
[[graduate-a-department-to-its-own-brain-repo]].

## Brain versus app: an orthogonal repo-kind axis

Not every repo under the shared parent is a brain at all. Product codebases, client sites,
and service repos are read and modified as software, not retrieved as a knowledge graph.
Forcing a full `entities/` plus namespace apparatus onto a repo that will never carry
doctrine is the same mistake as forcing every namespace into one schema, rejected in
[[infinite-brain-namespace-architecture-v2]] for namespaces and rejected here for repos.

A repo's `repo_kind` (`brain`, `app`, or `mixed`) is independent of its `brain_tier`
(`individual`, `department`, `company`, applicable only when `repo_kind` includes brain)
and independent of the internal-versus-external ownership axis in
`_system/repo-registry-rules.md`. The three axes compose: a product codebase is
`internal` + `app` + no tier; the company brain is `internal` + `brain` + `company`; a
graduated department repo is `internal` or `external` + `brain` + `department`. The
operative field definitions are in `_system/repo-registry-rules.md`.

An app repo does not need `entities/`, `knowledge/`, or the namespace ontology. It needs
whatever product-development commands and skills fit its own work. It may still want a
thin, curated slice of shared operator-level commands (a morning review, an evening review)
so the daily rhythm survives switching into an app repo. That slice is vendored in, per the
mechanism below, not rebuilt locally.

## One export mechanism, several consumers, not one script per consumer

Every arrow that carries content downward in this topology is the same shape: an upstream
core, a manifest of what ships, a scrub or strip pass, and a way to detect drift. A public
starter release, a client department release, and an internal department or individual
graduation are three consumers of one mechanism, not three bespoke scripts. Building a
separate exporter per consumer is the divergence-over-reuse mistake the core-versus-overlay
boundary exists to prevent. The target state is one manifest-driven export mechanism with a
profile per consumer; this pillar states the target, and building the generalized exporter
is implementation work tracked separately, not performed by adding doctrine.

## Entities and adapters per brain-tier repo

The existing canonical/adapter pattern in `entities/README.md` (canonical files in
`entities/`, `.claude/` and `.codex/` as shims) already works per repo and needs no
redesign. What is new is the discipline for a repo that vendors entities it does not
author:

- A vendored entity file (copied in from the company brain, not authored locally) carries
  provenance in its frontmatter: where it came from and when it was last synced. It is
  read-only from the downstream repo's point of view. Edit the upstream original and
  re-sync; never hand-edit the downstream copy.
- A locally-authored entity in a department or individual repo has no such provenance
  field and follows the ordinary `scratch` to `research` to `candidate` to `canon`
  lifecycle, with `candidate` proposing it back upstream when it deserves to become shared.
- An app repo's `.claude/commands/` may hold vendored copies of specific shared commands
  with the same provenance discipline, without ever growing an `entities/` folder, because
  an app repo does not participate in the brain ontology at all.

## What this does not mean

- It does not mean renaming or splitting your brain repo on day one. A standalone brain
  already plays the company-brain role; this pillar names that role so the graduation
  trigger and the brain-versus-app classification have somewhere to point.
- It does not mean every department gets a repo regardless of company size. A department
  stays a folder until its specific trust-boundary trigger fires, per
  [[department-graduates-to-repo-on-trust-boundary]], whether the company is a solo
  operation or an enterprise. Individual brains are the one tier that is plural by default
  at company scale; the single-repo collapse is the pre-team special case, not the general
  rule.
- It does not create a new entity type. Tiers and repo kinds classify existing repos and
  departments; they are not a twelfth entity alongside the set in [[system-overview]].

## Relationship

Derived from the field-tested client-release topology (shared parent, personal repo per
builder, governed canon layer) of the deployment this starter derives from. This pillar is
the reflexive, internal-facing generalization: it applies that topology one level up, to
the adopting company itself. `extends` [[department-model]] section 9 (cross-repo
ownership). The operative repo-registry fields this pillar assumes are in
`_system/repo-registry-rules.md`.
