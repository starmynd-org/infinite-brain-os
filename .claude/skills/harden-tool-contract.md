---
id: "skill-harden-tool-contract"
aliases: ["skill-harden-tool-contract", "harden-tool-contract"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "scratch"
summary: "Test a tool-contract namespace against the live tool: build a two-tier test plan from the coverage ledger, execute under safety gates, triage discrepancies, and upgrade verification posture with evidence."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a tool-contract namespace needs its documented operations tested against the live tool and its verification postures upgraded or corrected."
edges:
  - target: "[[skill-build-tool-contract-namespace]]"
    relation: "depends_on"
    confidence: 0.9
created: "2026-06-11"
---

# harden-tool-contract

Use this skill to turn an untested contract into a trusted one. Hardening is the posture
upgrade machine: it executes documented operations, compares reality to the contract, and
moves each operation's `verification` field forward with evidence. The operative contract
is `_system/tool-contract-hardening-rules.md`; the full procedure is
`knowledge/ai-architecture/playbooks/harden-a-tool-contract.md`.

## Use when

- a tool-contract namespace exists with operations at `doc-derived`
- upstream changed (version bump, breaking change, observed drift) and postures reset
- a real caller hit a contract mismatch
- the newest hardening ledger is older than the namespace's review cadence

## Do not use when

- the namespace has no coverage ledger yet (run [[skill-build-tool-contract-namespace]] first)
- no runtime exists to test against (record the blocker instead of pretending)

## Build steps

1. Confirm preconditions: coverage ledger exists, runtime reachability checked, secrets
   resolve by `secret_ref`, the tool's test-surface class is declared (local
   self-hosted, own-account external, or client-account external), and the sprint
   approval receipt scopes any mutating tests. Read-only runs carry the operator's
   standing approval; client-account tools never receive test mutations under any
   receipt.
2. Write or refresh `playbooks/hardening-test-plan.md` in the target namespace. Tier 1:
   at least one functional test per documented operation, derived from the coverage
   ledger. Tier 2: scenario tests for the real journeys agents in this OS run end to
   end. Tier 3: the edge matrix (boundaries, pagination, error codes, idempotency,
   rate-limit behavior) plus a harness script in `playbooks/harness/` that executes the
   matrix deterministically; size it dense for local runtimes, rate-limit-bounded for
   external services.
3. Execute under the safety gates: read-only freely; mutations only on `tc-hardening-`
   prefixed throwaway resources with cleanup; irreversible blast radius never live-tested;
   rate limits respected.
4. Triage every discrepancy to exactly one bucket: doc error (fix the node now), tool
   quirk (record in `decisions/` or `concepts/`), broken operation (`known-broken` with
   the failure stated), missing coverage (ledger row plus node when warranted).
5. Write `support/hardening-ledger-YYYY-MM-DD.md`: one row per test with result, posture
   change, and evidence pointer. Update `verification`, `verified_at`, `verified_by` on
   every touched operation node.
6. Close: cleanup confirmed, `bash _system/validate.sh` passes, blocked lanes record
   their blocker honestly in the ledger.

## Quality checks

- every posture upgrade traces to a ledger row with evidence
- no test resource left behind in the live tool
- failures made the contract better (fixed node, recorded quirk, or honest known-broken),
  never silently dropped
