---
id: "cmd-build-knowledge-base"
aliases: ["cmd-build-knowledge-base", "build-knowledge-base"]
type: "Command"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Command that launches a plain-English build or migration of a real Infinite Brain knowledge namespace."
confidence: 0.92
retrieval_class: "identity"
export_class: "internal"
description: "Use when an operator wants to create a new real knowledge namespace or migrate an existing corpus into Infinite Brain V2 shape, using normal English instead of rigid flags."
edges:
  - target: "[[skill-build-knowledge-base]]"
    relation: "delegates_to"
    confidence: 0.97
  - target: "[[skill-build-namespace]]"
    relation: "delegates_to"
    confidence: 0.95
  - target: "[[skill-migrate-legacy-knowledge-to-v2]]"
    relation: "delegates_to"
    confidence: 0.93
  - target: "[[skill-canonize-namespace]]"
    relation: "delegates_to"
    confidence: 0.9
  - target: "[[skill-refine-namespace-index]]"
    relation: "delegates_to"
    confidence: 0.9
  - target: "[[workflow-legacy-knowledge-migration]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[workflow-build-knowledge-base]]"
    relation: "uses"
    confidence: 0.94
  - target: "[[workflow-namespace-lint-review]]"
    relation: "uses"
    confidence: 0.86
created: "2026-05-31"
---

# /build-knowledge-base

Launch a real namespace build or migration in plain English.

This command is for cases where an operator wants to say something like:

> Build a new namespace called `personal-health` from `<legacy-root>\legacy-notes\Health`, do not migrate the legacy database, and refactor the rest into Infinite Brain style.

The command does not require rigid `mode=` or `exclude=` flags. The operator describes the source, the target namespace, and any constraints in normal language. The command then routes that request through the V2 namespace machinery.

## When to use this

- Building a brand-new real knowledge namespace under `knowledge/`
- Migrating an existing corpus, folder, or PKM subtree into Infinite Brain V2
- Testing whether the current skills, agents, workflows, validator, and doctrine are good enough to convert a real source corpus
- Refactoring semi-structured notes into canon, synthesis, support, and profile-aware structure

## When NOT to use this

- You only need a lightweight namespace registry stub. Use `/create-namespace`.
- The inbound material is still raw intake and should go to root `intake/` first.
- The work is mostly runtime state, secrets, operational queue data, or databases that do not belong in a knowledge namespace.
- The request is to add or revise one node inside an existing namespace rather than create or migrate the namespace itself.

## Operator input style

The operator may describe the job in natural language. The command should extract, from the request, as much of the following as is available:

- source location or source set
- target namespace slug
- target repo
- what to exclude
- what canon expectations matter
- what the namespace should be used for
- any known constraints, sensitivities, or live-truth risks

Do not force the operator into a fixed flag schema when plain-English instructions are sufficient.

## What this command does

1. Reads the operator request and determines whether this is:
   - a born-V2 namespace build, or
   - a migration of an existing knowledge corpus into a new namespace.
2. Reads the V2 doctrine and operative contract:
   - `AGENTS.md`
   - `CLAUDE.md`
   - `_system/README.md`
   - `_system/namespace-profiles.md`
   - `knowledge/ai-architecture/INDEX.md`
   - `knowledge/ai-architecture/canon/core-doctrine.md`
   - `knowledge/ai-architecture/canon/problem-to-architecture.md`
3. Chooses the namespace profile from first principles using `[[skill-build-namespace]]`.
4. Creates or updates the registry entry under `_system/namespaces/`.
5. Scaffolds the namespace with the shared base and profile-additive folders.
6. Routes the actual build through `[[skill-build-knowledge-base]]` and
   `[[workflow-build-knowledge-base]]`, which in turn sequence the lower-level V2
   machinery:
   - `[[skill-build-namespace]]` for new namespace scaffolding
   - `[[skill-migrate-legacy-knowledge-to-v2]]` or `[[workflow-legacy-knowledge-migration]]` for corpus refactoring
   - `[[skill-canonize-namespace]]` for compressed canon
   - `[[skill-refine-namespace-index]]` for the retrieval router
7. Atomizes broad source material into digestible nodes before building higher-order
   summaries, so future agents can ingest the graph selectively rather than only reading
   a few large notes.
8. Preserves provenance in `support/`, puts derived interpretation in `synthesis/`, and
   keeps canon compressed and agent-usable as the main-ideas layer future agents should
   ingest first.
9. Reviews related namespaces for additive node, synthesis, canon, or router updates
   triggered by the new build.
10. Runs `bash _system/validate.sh` plus `[[workflow-namespace-lint-review]]` before closing.
11. Produces a short build or migration report describing:
   - chosen profile
   - sources used
   - major atomization decisions
   - canon surfaces created
   - synthesis surfaces created
   - cross-namespace changes made or deferred
   - support receipts created
   - validator/lint results
   - any open questions or human approval gates

## Expected defaults

- Assume the target repo is:
  `<legacy-root>\infinite-brain-os`
  unless the operator clearly says otherwise.
- Assume the target location is:
  `knowledge/<namespace>/`
  unless the best profile is `intake-fabric`, which belongs at root `intake/`.
- Assume a serious namespace should be born V2-compliant unless the operator explicitly wants a reduced-base starter.
- Treat databases and app-runtime stores as out of scope for knowledge migration unless the operator explicitly asks for a contract namespace that documents them.
- For `data-system` requests, default to a thin starter implementation unless the operator
  explicitly asks for full custom lineage engineering. Thin means real metrics and source
  contracts, explicit implementation posture, and an in-house or client-owned adapter path.

## Required command behavior

- Prefer reasoned extraction from the operator's English request over asking for flags.
- If one detail is missing but can be inferred safely, infer it and document the assumption.
- If a missing detail would materially change the resulting architecture, stop and ask for that one detail clearly.
- Do not bypass the V2 system with ad hoc copying.
- Do not flatten a source corpus into vague summaries.
- Do atomize broad material into digestible nodes before relying on synthesis or canon.
- Distinguish:
  - `canon/` for compressed first-principles reasoning
  - `synthesis/` for derived interpretation
  - `support/` for migration and provenance
  - `archive/` for preserved raw source, only when profile and corpus justify it
- Review whether related namespaces need additive node, synthesis, canon, or `INDEX.md`
  updates because of the new namespace.

## Example operator prompts

- `/build-knowledge-base Build a namespace called personal-health from <legacy-root>\legacy-notes\Health. Do not migrate the legacy database. Refactor the rest into Infinite Brain style for future health planning and longitudinal reasoning.`
- `/build-knowledge-base Take the Meta Ads ETL docs and code notes in example-orchestrator and build a real data-system namespace that future agents can use.`
- `/build-knowledge-base Build a tool-contract namespace for Google Docs API usage from our existing docs and working examples.`

## Edge cases

- **The source corpus belongs in an existing namespace**: refuse a new namespace and explain which existing namespace should absorb it.
- **The best fit is `intake-fabric`**: route to root `intake/` scaffold logic instead of creating `knowledge/<namespace>/`.
- **The source corpus is too raw or too broad**: create a build report that recommends intake or staged migration rather than pretending the namespace is ready.
- **The operator names exclusions in prose**: honor them as constraints without requiring formal flags.
- **The canon expectations are unusually specific**: record them in the build report and satisfy them through canon targets, not only through general summaries.

## Notes

- This command is intentionally operator-friendly and input-flexible, but execution is strict. The natural-language front door should lead into the existing V2 skills, workflows, and validator, not around them.
- Keep `/create-namespace` as the lightweight registry stub. `/build-knowledge-base` is the heavier path for real knowledge architecture work.
