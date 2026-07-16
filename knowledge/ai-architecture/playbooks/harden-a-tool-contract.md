---
id: "knowledge-ai-architecture-playbook-harden-a-tool-contract"
aliases: ["knowledge-ai-architecture-playbook-harden-a-tool-contract", "harden-a-tool-contract"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "scratch"
summary: "Repeatable sprint-shaped procedure for testing a tool-contract namespace against the live tool: two-tier test plan, gated execution, discrepancy triage, and verification posture upgrades with evidence."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-11"
verified_by: "operator-pending"
edges:
  - target: "[[knowledge-ai-architecture-playbook-document-a-tool-contract]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[knowledge-ai-architecture-review-namespace-health]]"
    relation: "supports"
    confidence: 0.85
created: "2026-06-11"
---

## Purpose

A documented contract is a hypothesis. Hardening is the experiment: execute the
documented operations against the live tool, compare reality to the contract, and move
each operation's `verification` posture forward with evidence, or correct the contract
where reality disagrees. The operative contract (posture enum, ledger shapes, safety
gates) is `_system/tool-contract-hardening-rules.md`; the executable technique is
`entities/skills/harden-tool-contract.md`. The sprint-package shape for the
swarm form is in `_system/swarm-sprint-rules.md`.

## Why posture lives in the contract

The naive shape is a test report beside the docs. Reports rot: nobody reads last month's
test run before trusting a payload example. Binding the result into each operation node's
`verification` field means the trust state travels with the knowledge an agent actually
loads. An agent reading `verification: doc-derived` knows to be careful; reading
`live-tested` with a dated evidence pointer, it can proceed; reading `known-broken`, it
takes the stated fallback.

## The wave shape

1. **Test plan.** Derive `playbooks/hardening-test-plan.md` in the target namespace from
   the coverage ledger. Tier 1, functional: at least one test per documented operation,
   asserting the documented payload, response shape, and error behavior. Tier 2,
   scenario: end-to-end journeys reflecting how agents in this OS actually use the tool
   (the ideal-use cases), which catch cross-operation contract gaps Tier 1 misses.
   Tier 3, edge matrix: parameter boundaries, pagination edges, empty results, size and
   unicode extremes, every documented error code, idempotency retries, and rate-limit
   behavior, authored as a case matrix plus a harness script in `playbooks/harness/`.
   The harness executes the matrix volume deterministically; agents author it once and
   triage its failures. Agent terminals never execute matrix volume one case at a time:
   that is the deterministic-versus-agentic split applied to testing. Matrix sizing
   scales with blast radius: dense (hundreds to thousands of cases) for local
   self-hosted runtimes, rate-limit-bounded representative families for external
   services, never volume that resembles abuse.
2. **Gated execution.** Check runtime reachability first; a lane with no runtime records
   the blocker and stops, it never pretends. Read-only tests run freely and carry the
   operator's standing approval. Mutating tests run only inside the approval receipt's
   stated scope, only against `tc-hardening-` prefixed throwaway resources, with cleanup
   inside the run. Irreversible blast radius (sends, deploys, billing, deletion beyond
   the test resource) is never live-tested. The tool's test-surface class (local
   self-hosted, own-account external, client-account external, per
   `_system/tool-contract-hardening-rules.md`) is declared in the sprint charter and
   sets the ceiling: client-account tools never receive test mutations under any
   receipt; their hardening is read-only plus dry-run, with the limitation stated on
   every affected operation node.
3. **Triage.** Every discrepancy lands in exactly one bucket: doc error (fix the
   operation node in this run), tool quirk worth keeping (record in `decisions/` or
   `concepts/`), broken operation (`verification: known-broken`, failure and fallback
   stated on the node), missing coverage (coverage-ledger row, plus a node when
   warranted). A dropped discrepancy is a process failure.
4. **Posture writeback and gate.** Write `support/hardening-ledger-YYYY-MM-DD.md` with
   one row per test (result, posture change, evidence pointer). Update `verification`,
   `verified_at`, `verified_by` on touched nodes. Confirm cleanup, run
   `bash _system/validate.sh`, close out per sprint rules.

## Sprint shape

Hardening sprints are per-tool: one tool, one receipt, one test-surface class, lanes by
API area plus a harness lane. Documentation batches into multi-tool sprints; hardening
does not, because mutation scopes and runtime realities differ per tool and a shared
receipt blurs the blast-radius conversation.

## Re-hardening

Hardening is periodic, not one-shot. The contract re-enters the queue on upstream version
or breaking changes, on a real caller hitting a mismatch, or when the newest hardening
ledger ages past the namespace's review cadence. Re-hardening re-executes the durable
test plan; it does not improvise a new one.

## Success test

The run is good when every executed test traces to a ledger row, every posture upgrade
has evidence, every failure made the contract better, no test resource survives in the
live tool, and an agent loading the namespace afterward can tell exactly how much to
trust each operation.
