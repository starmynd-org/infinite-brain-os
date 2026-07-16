---
id: "knowledge-ai-architecture-playbook-document-a-tool-contract"
aliases: ["knowledge-ai-architecture-playbook-document-a-tool-contract", "document-a-tool-contract"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "scratch"
summary: "Repeatable sprint-shaped procedure for documenting a tool as a tool-contract namespace: full-surface sweep into a coverage ledger, parallel operation authoring at doc-derived posture, and a recommended-calls router."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-11"
verified_by: "operator-pending"
edges:
  - target: "[[knowledge-tool-contract-example-playbook-build-tool-contract-from-public-docs]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[knowledge-ai-architecture-playbook-harden-a-tool-contract]]"
    relation: "supports"
    confidence: 0.9
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-11"
---

## Purpose

When a new tool enters the OS (external API, SaaS, or internal capability), this playbook
produces its tool-contract namespace so any cold-context agent can call the tool
correctly. It extends the example playbook
[[knowledge-tool-contract-example-playbook-build-tool-contract-from-public-docs]] with
the two pieces that make documentation repeatable and auditable at sprint scale: the
coverage ledger and the verification posture. The operative contract is
`_system/tool-contract-hardening-rules.md`; the executable technique is
`entities/skills/build-tool-contract-namespace.md`. The sprint-package shape for the
swarm form is in `_system/swarm-sprint-rules.md`.

## When this is a sprint versus a solo pass

A small tool (a handful of operations, one doc page) is a solo agent pass with the skill.
Use the swarm sprint shape when the surface is large enough to split into lanes (one
swarm per API area or per tool when documenting several), when governance matters
(client-facing or external tools), or when the namespace is being built from zero.
Sprint launch follows `_system/swarm-sprint-rules.md`: parent task with `mode: swarm`
plus a human-granted approval receipt.

## The wave shape

1. **Surface sweep.** Enumerate the complete tool surface from the best available
   sources, in preference order: machine-readable schema (OpenAPI, GraphQL introspection,
   CLI help dumps), official reference docs, live read-only introspection. Write
   `support/coverage-ledger.md` with one row per operation and the source set. Rows start
   `undocumented`; the sweep is done when every row is triaged to `documented`,
   `out-of-scope` (with a stated reason), or `blocked` (with a named blocker).
2. **Operation authoring.** Parallel lanes write one node per in-scope operation in
   `operations/`: endpoint or command, auth, payload shape, response, errors,
   idempotency, plus a worked example in `examples/`. Every node carries
   `verification: doc-derived`. Lanes split by API area; the coverage ledger is the
   work queue and the merge point.
3. **Synthesis.** One lane writes or refreshes `canon/core-contract.md` (system fit
   class, auth boundary, rate limits, error posture, cross-cutting constraints),
   `operations/INDEX.md` as the recommended-calls router (task shape to preferred call,
   the index of suggested tool calls), `canon/agent-load-order.md`, and the namespace
   `INDEX.md` query classes.
4. **Registration and gate.** Registry entry in `_system/namespaces/` (profile
   `tool-contract`, `freshness_posture: periodic`), root `tools/<slug>.md` entry,
   `bash _system/validate.sh` clean, closeout per sprint rules.

## Success test

The namespace is good when a cold-context agent can answer what call to make, how to
authenticate, what payload to send, and what to do on failure, without scanning upstream
docs; and when an auditor can diff the coverage ledger against the upstream surface
instead of trusting the claim of completeness.

## What this playbook does not do

It produces no tested knowledge. Every operation leaves this process at `doc-derived`.
Trust is earned by [[knowledge-ai-architecture-playbook-harden-a-tool-contract]].
