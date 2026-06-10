---
id: "skill-build-tool-contract-namespace"
aliases: ["skill-build-tool-contract-namespace", "build-tool-contract-namespace"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build a production-grade tool-contract namespace from public docs or trusted internal contract material, including canon, operation nodes, examples, and the recommended-calls router."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a tool or API needs a deep namespace that tells an agent exactly what call to make, how to call it, and how to avoid common mistakes."
edges:
  - target: "[[skill-build-namespace]]"
    relation: "paired_with"
    confidence: 0.92
  - target: "[[skill-build-knowledge-node]]"
    relation: "paired_with"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[knowledge-ai-architecture-canon-entity-tools]]"
    relation: "informed_by"
    confidence: 0.82
created: "2026-06-03"
---

# build-tool-contract-namespace

Use this skill when a tool or API needs a serious deep namespace under `knowledge/` whose
job is to help an agent choose the right call and execute it correctly. This skill assumes
the namespace profile is `tool-contract` and applies the architecture recommendation:
subject-first slugging, explicit profile suffix when useful, and `operations/INDEX.md` as
the call router.

## Use when

- a public API, MCP, or repo-native tool has enough operational depth that `tools/` alone
  is not enough
- agents need more than discoverability and ownership; they need call-selection guidance
- the integration has enough sharp edges that auth posture, examples, and error handling
  need a durable home

## Do not use when

- a shallow `tools/<tool>.md` registry entry is enough
- the source material is still unprocessed and belongs in `intake/`
- the work is really a data pipeline or operating-library problem rather than a tool-call
  problem

## Goal

Produce a namespace that makes five things fast to answer:

1. what this tool is for
2. what call I should make
3. what payload or parameters I should send
4. how auth and failure handling work globally
5. which root tool entry and workflows depend on this namespace

And two things complete:

6. what the full documentation surface for the tool looks like
7. what the full meaningful tool-call inventory is, beyond only the recommended shortlist
8. how the tool fits into the wider OS and what it is allowed to own
9. what was actually verified versus only inferred from docs

## Required outputs

1. A `tool-contract` namespace under `knowledge/<slug>/` with the shared base plus
   `operations/`, `concepts/`, `decisions/`, `references/`, and `examples/`
2. `canon/core-contract.md`, `canon/README.md`, and `canon/agent-load-order.md`
3. `operations/INDEX.md` as the recommended-call router
4. One operation node per high-value operation
5. At least one worked payload or response example per operation
6. A linked root `tools/<tool>.md` entry pointing at the namespace, and a reciprocal link
   back from the namespace
7. A full source map in `references/README.md`
8. A compact full call inventory in `operations/INDEX.md`
9. A verification note in `support/` recording which calls were live-tested, dry-run
   tested, or doc-derived only

## Build steps

1. Pick the slug using the naming rule: subject-first, with explicit
   `-tool-contract` suffix when profile visibility helps.
2. Apply [[skill-build-namespace]] for the structural base and registry posture.
3. Write `canon/core-contract.md` with the global auth, safety, rate-limit, and error
   contract plus the tool's system-fit statement: fit class, OS role, ownership boundary,
   and exclusions.
4. Write `operations/INDEX.md` before writing every detailed operation node. The router
   forces a shortlist and prevents the namespace from becoming a bag of unranked endpoints.
5. Add the full operation inventory to `operations/INDEX.md`, grouped by function and marked
   as recommended, supporting, dangerous, or lower-priority as needed.
6. Add the high-value operation nodes and matching examples first; supporting operations may be
   mapped in the inventory before they get full nodes.
7. Add references for volatile upstream details and a source map of the full docs surface.
8. Test every listed high-value operation when feasible. Record the result as:
   `live-tested`, `dry-run-tested`, `doc-derived`, or `known-broken`.
9. Add playbooks for recurring multi-step
   procedures.
10. Add or update the root tool registry entry in `tools/` so discoverability and deep
   contract stay linked.

## Quality checks

- the namespace profile is clearly `tool-contract`
- `operations/INDEX.md` exists and answers "what call should I make"
- `operations/INDEX.md` also exposes the full meaningful call inventory
- every operation has a linked example
- `references/README.md` maps the major upstream documentation sections used
- `canon/core-contract.md` clearly states the tool's fit class and what remains outside
  the tool boundary
- `support/` records verification status for the key operations and any breakages or drift
- the root tool entry points to the namespace
- the namespace points back to the root tool entry
- canon stays compressed and cross-cutting rather than duplicating every endpoint

## Anti-patterns

- putting all call-selection logic only in canon
- documenting operations without examples
- documenting only the shortlist and never mapping the wider tool surface
- listing calls as if they were proven when nobody actually tested them
- discovering a broken call later and leaving the correction only in chat instead of
  updating the namespace
- leaving the root `tools/` entry disconnected from the deep namespace
- using a special slug prefix that makes subject scanning worse
