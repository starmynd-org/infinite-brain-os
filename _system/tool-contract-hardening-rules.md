# Tool Contract Hardening Rules

This file is the operative contract for how tool-contract namespaces record coverage,
verification posture, and hardening evidence inside `infinite-brain-os`.

Doctrine lives in:

- `knowledge/ai-architecture/playbooks/document-a-tool-contract.md`
- `knowledge/ai-architecture/playbooks/harden-a-tool-contract.md`
- `_system/tool-registry-rules.md` (the shallow `tools/` registry side)
- `_system/namespace-profiles.md` (the tool-contract profile shape)

## Purpose

Use this rule file to answer:

- how a tool-contract namespace proves it reviewed the full tool surface
- what verification posture an operation node must carry and what each value means
- what a hardening run must produce and where the evidence lives
- what safety gates bound live testing
- when a contract re-enters the hardening queue

## Verification posture

Every node in a tool-contract namespace's `operations/` folder carries a `verification`
frontmatter field with exactly one of these values:

- `doc-derived`: written from documentation only; never executed by this OS
- `dry-run-tested`: exercised without side effects (validate-only flags, list or describe
  calls standing in for the real mutation, schema-level checks)
- `live-tested`: executed for real against the tool, with the evidence reference recorded
- `known-broken`: executed and failed in a way that contradicts the documented contract;
  the node must state the failure and the safe fallback

Posture moves forward only with evidence from a hardening run. A new or edited operation
node defaults to `doc-derived`. Any upstream change to the tool (API version, breaking
changelog entry, observed contract drift) resets affected operations to `doc-derived`
until re-tested.

When posture changes, also update the node's `verified_at` and `verified_by` fields. A
`live-tested` posture must point at evidence: the hardening ledger entry, a receipt under
`support/`, or both.

## Coverage ledger

Every tool-contract namespace carries `support/coverage-ledger.md`: one row per operation,
endpoint, command, or option group in the tool's full surface, whether or not the OS
documents it. Allowed coverage statuses:

- `documented`: an operation node exists (the row names it)
- `out-of-scope`: deliberately not documented; the row states why in a few words
- `blocked`: cannot be documented yet; the row names the blocker
- `undocumented`: surface known but not yet triaged (allowed only while a documentation
  sprint is open against the namespace)

The ledger makes "we reviewed the full API" auditable: an agent or operator can diff the
ledger against the upstream surface instead of trusting a claim. The ledger records its
source set (which docs, schema dumps, or live introspection produced the surface list)
and the sweep date.

## Hardening ledger

Every hardening run writes `support/hardening-ledger-YYYY-MM-DD.md` in the target
namespace: one row per executed or skipped test with test id, operation node, tier
(functional or scenario), result (pass, fail, blocked, skipped), posture change, and an
evidence pointer. Discrepancies found during hardening are triaged to exactly one of:

- doc error: fix the operation node in the same run
- tool quirk worth keeping: record in the namespace's `decisions/` or `concepts/`
- broken operation: set `verification: known-broken` on the node with the failure stated
- missing coverage: add the coverage-ledger row and, when warranted, a new operation node

Test plans are durable: `playbooks/hardening-test-plan.md` in the target namespace, with
three tiers. Tier 1 is functional, at least one test per documented operation, derived
from the coverage ledger. Tier 2 is scenario, end-to-end journeys reflecting how agents
in this OS actually use the tool. Tier 3 is the deterministic edge matrix: parameter
boundaries, pagination edges, empty results, unicode and size extremes, every documented
error code, idempotency retries, and rate-limit behavior, expressed as a case matrix.
Re-hardening after upstream changes re-executes the plan, not a fresh improvisation.

## Tier 3: the edge-matrix harness

Tier 3 volume is deterministic work and runs where determinism is cheap, per core
doctrine. Agents author the matrix and a harness script once; the harness executes the
cases; agents triage the failures. Agent terminals are never the executor for matrix
volume.

- The harness lives in the target namespace at `playbooks/harness/` (script plus a
  companion markdown note describing inputs, scope guards, and how to re-run). It is a
  durable artifact: re-hardening replays the matrix for near-zero cost.
- The harness embeds the same safety gates as the rest of the run: receipt scope,
  `tc-hardening-` resource prefix, rate-limit ceilings, and the test-surface class rules
  below. A harness that cannot enforce its scope guards does not run.
- Sizing scales with blast radius, not ambition. Local self-hosted runtimes may absorb
  dense matrices (hundreds to thousands of cases). External services are bounded by
  their documented rate limits and tested by representative parameter families, never
  exhaustive values; test volume against an external service must never resemble abuse.

## Test-surface classes and approval posture

Every hardening sprint classifies its tool into exactly one test-surface class in its
charter, and the class sets both the approval posture and the mutation ceiling:

1. **Local self-hosted** (runs on operator hardware: Paperclip, n8n, Obsidian test
   vault, repo-native services). Standing operator approval covers read-only and
   `tc-hardening-` mutation testing; the sprint receipt cites this rule and states the
   mutation set. Dense tier 3 matrices allowed.
2. **Own-account external** (operator- or company-owned accounts: own Google Workspace,
   own Slack workspace, Example Co QBO, own bot tokens). Read-only tests carry standing
   approval; mutations require an explicit per-sprint receipt scope, run only against
   `tc-hardening-` throwaway resources or a vendor sandbox, and anything user-visible or
   irreversible stays out permanently.
3. **Client-account external** (any tool authenticated against a client's account or
   tenant: client SaaS seats, client ad or email platforms, client commerce backends).
   **Mutations are never live-tested, regardless of receipts.** No test campaign, no
   test record, no test send, nothing created or removed in a client account, ever. The
   ceiling is permanent and survives credential changes. Hardening for this class is
   read-only live tests plus dry-run posture at best, and the limitation is stated on
   every affected operation node. Example: adding and removing campaigns in a client's
   live email-marketing account during testing is categorically out, even with a receipt.

Standing approval, granted by the operator on 2026-06-12: documentation sprints
(read-only by construction) and read-only hardening lanes are approved by default. The
sprint still records a receipt file for the audit trail, but it cites this standing rule
instead of requiring a fresh operator conversation. Any receipt that includes mutations
is still an explicit, per-sprint operator decision naming the mutation set.

## Live-test safety gates

- Read-only operations may run freely against the live tool.
- Mutating operations run only against test-prefixed throwaway resources (prefix
  `tc-hardening-`), created and destroyed inside the run, never against production data,
  and never in a client-account tool (class 3 above) under any receipt.
- Mutating live tests require the hardening sprint's approval receipt to scope them
  explicitly. No receipt scope, no mutation.
- Destructive operations with irreversible blast radius beyond the test resource
  (account deletion, billing changes, sends, deploys) are never live-tested; they stay
  `dry-run-tested` at best, with the limitation stated on the node.
- Secrets resolve by `secret_ref` at runtime per `_system/secret-registry-rules.md`; no
  raw credential enters the ledger, the test plan, or any node.
- Rate limits stated in the contract bound the test run; a hardening run never degrades
  the live tool for real consumers.

## Re-hardening trigger

Tool-contract namespaces keep `freshness_posture: periodic`. A contract re-enters the
hardening queue when any of these hold:

- the upstream tool announces a version or breaking change touching documented operations
- a real caller hits a contract mismatch (this also files the discrepancy immediately)
- the namespace's newest hardening ledger is older than the review cadence the registry
  entry states

## Deterministic versus curator split

`bash _system/validate.sh` may enforce deterministic checks such as:

- presence of `support/coverage-ledger.md` in tool-contract namespaces
- presence and enum validity of `verification` on operation nodes

The validator does not own fuzzy judgments such as whether coverage rows are honestly
scoped, whether a test plan is adequate, or whether a posture upgrade's evidence is
substantive. Those stay with hardening review and the operator gate.

## Sprint shape

Documentation sprints batch well: multiple tools may run as lanes in one sprint because
the work is read-only and source-bound. Hardening sprints are per-tool: one tool, one
receipt, one test-surface class, one blast-radius conversation, with lanes split by API
area plus a harness lane. A cohort-wide hardening receipt covering unrelated blast radii
is a scoping error.

## Changelog

- 2026-06-11: initial contract, created with the tool-contract meta system buildout
  (operator-approved pilot on Paperclip, n8n, Google Secret Manager).
- 2026-06-12: added tier 3 edge-matrix harness, test-surface classes with the
  client-account mutation ceiling, the standing approval for read-only sprints, and the
  per-tool hardening sprint shape. Operator-granted in the 2026-06-12 working session.
