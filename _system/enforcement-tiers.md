# Enforcement Tiers

This file is the operative enforcement-tier registry for `infinite-brain-os`. It
assigns exactly one enforcement tier to every numbered rule across the `_system` rule
files, so the gap between the specified harness and the enforced harness is declared
instead of implied. Like the rest of `_system/`, this is contract surface, not a knowledge
node; it carries no node frontmatter.

Built by an internal build sprint (records not shipped) under
`projects/harness-hardening-program/PLAN.md`.

## The four tiers

- `validate`: deterministically checked by `bash _system/validate.sh` today. Each
  validate-tier row cites the concrete check in the script.
- `hook`: checkable at action time by a Claude Code hook registered in
  `.claude/settings.json`. Each hook-tier row names the wrapper in `.claude/hooks/`.
- `audit`: checkable post-hoc by a cadence report script in `_system/checks/`. Each
  audit-tier row names the script and marks it shipped or planned honestly. A planned
  script is a named commitment, not a TODO marker; the rule is enforceable, the script
  has not been written yet.
- `prose`: genuine judgment that no script can make. The rule stays prose and is loaded
  at point of use by the agent or curator doing the work.

Posture: every mechanical check added by the 2026-06-10 sprints is WARN-ONLY. The hook
and audit scripts report findings; they do not block. Promoting any check to blocking (a
nonzero exit consumed as a failure by the validator or a hook) is an operator decision
recorded by editing this registry and the affected script.

A tier declaration is about checkability, not importance. A prose rule can be more
load-bearing than a validate rule. Most rules land in audit or prose; that is the honest
shape of the system, not a deficiency to engineer away.

## Summary counts

| Tier | Count |
|------|-------|
| validate | 5 |
| hook | 2 |
| audit | 16 |
| prose | 50 |
| total numbered rules | 73 |

By series: SESSION 17, LOAD 12, CONTRA 10, FRESH 10, EVAL 10, CORR 5, INTAKE 9.
Lettered sub-rules (SESSION-6A through 6E, SESSION-8A, SESSION-8B, LOAD-7A) count as
distinct rules.

## Script registry

Shipped (in `_system/checks/`, all warn-only):

- `canon-obligation-language.sh` (canon-boundary sprint): obligation phrases in canon
- `node-lint.sh`: per-file frontmatter, required keys, dash ban, placeholder text; the
  one script that exits 2 on findings so the PostToolUse hook can feed them back
- `session-ledger-status.sh`: active-session count and stale-session listing
- `adapter-sync-check.sh`: entities/ versus adapter drift, CLAUDE.md and AGENTS.md
  co-edit warning
- `uncommitted-work-check.sh`: working-tree status one-liner

Planned (named here, not yet written):

- `session-ledger-audit.sh`: closeout completeness over `sessions/closed/` and
  `sessions/reviews/` (record fields, usage receipts, review presence, cross-links)
- `namespace-health-audit.sh`: freshness metadata over registries and canon
  (`freshness_posture` enum, `verified_at` and `verified_by` presence and staleness,
  eval-set presence and size)
- `intake-hygiene-audit.sh`: intake tree hygiene (no live-queue folders, stub id and
  timestamp forms)

## SESSION rules (`_system/session-ledger-rules.md`)

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| SESSION-1 | validate | `check_sessions_base` in validate.sh requires `sessions/README.md` and the five base folders. |
| SESSION-2 | prose | Whether a given piece of state is live runtime state or durable trail is a boundary judgment. |
| SESSION-3 | hook | `.claude/hooks/session-start.sh` (SessionStart) injects the forced-start discipline and the ledger status into session context. It reminds and reports; it cannot verify that registration then happens, so compliance remains behavioral. |
| SESSION-4 | audit | `session-ledger-audit.sh` (planned): each session record declares a transcript path or states the export gap. |
| SESSION-5 | prose | Append-only logging cannot be verified per-file without history forensics; rewrite-versus-redact intent is judgment. |
| SESSION-6 | audit | `session-ledger-status.sh` (shipped) flags stale active sessions; `session-ledger-audit.sh` (planned) checks every closed session has a closeout review. |
| SESSION-6A | audit | `session-ledger-audit.sh` (planned): usage totals or an explicit `usage_capture_status: unavailable` present at closeout. |
| SESSION-6B | audit | `session-ledger-audit.sh` (planned): presence of the preferred machine-readable usage fields. |
| SESSION-6C | prose | Choosing the strongest available capture pattern is a judgment about the surface's capabilities. |
| SESSION-6D | audit | `session-ledger-audit.sh` (planned): a non-direct capture pattern carries `runtime_session_id` or a stated substitute key. |
| SESSION-6E | prose | A boundary statement about where provider detail belongs; not checkable. |
| SESSION-7 | prose | Routing promoted signal to the right durable home is curator judgment. |
| SESSION-8 | prose | Recognizing a repeated correction and converting it to structure is the correction-loop judgment. |
| SESSION-8A | prose | Whether a chat is operating inside a sprint, and dual-writing on purpose, is behavioral. |
| SESSION-8B | audit | `session-ledger-audit.sh` (planned): sprint-linked session records and sprint `SESSION-LINK.md` files cross-link each other. |
| SESSION-9 | prose | Retrieval restraint (logs as archive, not default context) is agent behavior at load time. |
| SESSION-10 | audit | `session-ledger-audit.sh` (planned): session records carry a summary and artifact links. |

## LOAD rules (`_system/retrieval-load-order-policy.md`)

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| LOAD-1 | prose | Naming the retrieval consumer is a design declaration kept current by hand. |
| LOAD-2 | prose | The canon-first load sequence is agent behavior at retrieval time. |
| LOAD-3 | prose | Canon-before-long-tail is agent behavior; no script observes what an agent loaded. |
| LOAD-4 | prose | Skipping the canon step for `canon_posture: none` namespaces is load-time behavior. |
| LOAD-5 | prose | Minimal sufficient set versus maximal available set is the core retrieval judgment. |
| LOAD-6 | prose | Matching a task to a query class is judgment. |
| LOAD-7 | prose | On-demand-only loading of archive and support is load-time behavior. |
| LOAD-7A | prose | On-demand-only loading of session transcripts is load-time behavior. |
| LOAD-8 | validate | `check_base_surfaces` requires every serious namespace to carry `INDEX.md`, and the link checks confirm its references resolve. Whether the Load first and Query classes sections carry the right content stays curator judgment. |
| LOAD-9 | validate | `check_full_canon` requires `canon/agent-load-order.md` for `canon_posture: full` namespaces, and the plumbing exemption in `is_plumbing` encodes its frontmatter-exempt status. |
| LOAD-10 | prose | Reconciling a disagreement between INDEX.md and agent-load-order.md is curator judgment at health review. |
| LOAD-11 | prose | The internal-versus-public-export boundary is a policy statement, governed operationally by the public LLM index policy. |

## CONTRA rules (`_system/contradiction-review-rules.md`)

Contradiction review is fuzzy by its own first rule; the whole series stays prose. The
structural side it leans on (frontmatter on synthesis nodes, resolvable wikilinks,
no-broken-link supersession) is already validate-tier via the main frontmatter scan and
link checks, and is not re-declared per row.

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| CONTRA-1 | prose | The rule itself declares contradiction detection out of validate.sh; meaning checks stay with the curator. |
| CONTRA-2 | prose | Deciding whether two statements actually conflict is the whole judgment. |
| CONTRA-3 | prose | Detecting duplicate `metric_id` definitions is mechanizable later, but judging divergence is not; stays prose until a metric audit exists. |
| CONTRA-4 | prose | Surfacing during health review is a deliberate curator read. |
| CONTRA-5 | prose | Within-namespace versus cross-namespace homing is a scoping judgment. |
| CONTRA-6 | prose | Recording a map instead of silently resolving is behavioral; the map's frontmatter is covered by the main scan. |
| CONTRA-7 | prose | Correct location requires recognizing a file as a contradiction map, which is semantic. |
| CONTRA-8 | prose | Choosing the resolution move is judgment. |
| CONTRA-9 | prose | Recognizing canon-touching conflicts and escalating is judgment plus the operator gate. |
| CONTRA-10 | prose | Recording unresolved status and escalating is curator behavior. |

## FRESH rules (`_system/freshness-review-rules.md`)

Honesty note: freshness-review-rules.md lists the `freshness_posture` enum and the
`verified_at` and `verified_by` presence checks as deterministic validate.sh territory,
but the current validate.sh contains neither check. They are declared audit-tier
(planned) here and are the strongest candidates for promotion into validate.sh.

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| FRESH-1 | prose | Scoping review by posture is review-procedure behavior. |
| FRESH-2 | audit | `namespace-health-audit.sh` (planned): registry `freshness_posture` is one of the three values. Promotion candidate for validate.sh. |
| FRESH-3 | prose | Whether content is stable doctrine, and therefore review-on-edit, is judgment. |
| FRESH-4 | audit | `namespace-health-audit.sh` (planned): registry postures compared against the locked baseline table; deviations reported for curator review. |
| FRESH-5 | prose | Posture guidance for future profile types; judgment at namespace creation. |
| FRESH-6 | audit | `namespace-health-audit.sh` (planned): `verified_at` and `verified_by` present on `core-doctrine.md` and `current-truth.md`. The rule file claims validate.sh enforces this today; it does not. Promotion candidate. |
| FRESH-7 | prose | Whether a confirmation actually happened, versus a formatting edit, is human or curator knowledge. |
| FRESH-8 | audit | `namespace-health-audit.sh` (planned): the date comparison (`verified_at` versus latest material edits, cadence-window staleness) is mechanical; whether the content is still true stays prose. |
| FRESH-9 | prose | Exempting detail nodes from `verified_at` is a scoping statement. |
| FRESH-10 | hook | `.claude/hooks/post-write-lint.sh` (PostToolUse on Write|Edit) runs the per-edit deterministic slice (node-lint.sh) on every markdown write. Running the full validator before a wave closes stays session discipline. |

## EVAL rules (`_system/retrieval-eval-rules.md`)

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| EVAL-1 | prose | Falsifiability framing; the rationale for the series. |
| EVAL-2 | audit | `namespace-health-audit.sh` (planned): `support/retrieval-eval.md` exists for every serious namespace. |
| EVAL-3 | audit | `namespace-health-audit.sh` (planned): query count in the eval file is between five and ten. |
| EVAL-4 | prose | Whether each query carries a real task, the right load set, and a usable pass criterion is content judgment. |
| EVAL-5 | prose | Coverage of the namespace's query classes is judged against INDEX.md content. |
| EVAL-6 | audit | `namespace-health-audit.sh` (planned): the eval file lives at `knowledge/<ns>/support/retrieval-eval.md`. |
| EVAL-7 | prose | When a sprint-level eval home is appropriate is a scoping judgment. |
| EVAL-8 | prose | No-eval-no-merge is an operator and curator gate at upgrade close. |
| EVAL-9 | prose | Running the gate (loading expected files, confirming the load-bearing fact) is a reader's job. |
| EVAL-10 | prose | Sprint-scoped seeding note; historical scope, not checkable. |

## CORR rules (`_system/correction-loop-rules.md`)

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| CORR-1 | prose | Counting recurrences of a correction across sessions is judgment over conversational history. |
| CORR-2 | prose | An operator override is a human statement. |
| CORR-3 | prose | Recognizing a one-off or context-specific correction is judgment. |
| CORR-4 | prose | Choosing the lightest durable home that closes the loop is the routing judgment. |
| CORR-5 | prose | Operator approval for canon revisions is a human gate; the changelog and verified-fields structure it relies on is covered under FRESH-6 (audit, planned). |

## INTAKE rules (`_system/namespace-intake-rules.md`)

| Rule | Tier | Mechanism and notes |
|------|------|---------------------|
| INTAKE-1 | prose | Matching every processed item to a receipt requires the runtime's view of what was processed. |
| INTAKE-2 | audit | `intake-hygiene-audit.sh` (planned): no `unprocessed`, `in-review`, or `blocked` folders tracked under `intake/`. The rule file itself notes validate.sh does not scan for these. |
| INTAKE-3 | prose | Promotion-path discipline (raw to support to synthesis to canon) is routing behavior. |
| INTAKE-4 | prose | Destination-owns-truth is a boundary judgment at routing time. |
| INTAKE-5 | prose | What a thin intake namespace may hold is a content judgment. |
| INTAKE-6 | validate | The intake processed-receipt completeness block in validate.sh checks `routing_decision` and `destination` on every `type: processed-receipt` file. Partial: the other receipt fields stay with the curator. |
| INTAKE-7 | validate | Same validate.sh block: a receipt missing a routing decision or destination link is an ERROR. |
| INTAKE-8 | audit | `intake-hygiene-audit.sh` (planned): stub id form `intake-<source>-<date>-<slug>` and ISO `received_at` timestamps are regex-checkable. |
| INTAKE-9 | prose | Migration posture for a past sprint; historical scope. |

## Unnumbered repo-wide contracts

The write-time hook layer mostly enforces contracts that carry no rule number. They are
declared here so the hook layer's actual coverage is visible:

| Contract | Tier | Mechanism |
|----------|------|-----------|
| Node frontmatter present with the eight required keys | validate + hook | Main markdown scan in validate.sh; `node-lint.sh` via `post-write-lint.sh` at write time. |
| Em and en dash ban | validate + hook | Dash check in validate.sh; `node-lint.sh` at write time (mirrored path exemptions). |
| Placeholder text ban above scratch | hook | `node-lint.sh` at write time; validate.sh does not check this today. |
| Canon describes the running system (no obligation language) | audit (shipped) | `canon-obligation-language.sh`. |
| entities/ and adapter copies stay in sync; CLAUDE.md and AGENTS.md edited together | audit (shipped) + hook | `adapter-sync-check.sh`, run by `stop-check.sh` at Stop and by the validate.sh warn-only block. |
| Working tree reviewed before ending a session | hook | `uncommitted-work-check.sh` via `stop-check.sh` at Stop. |
| Sprint package scaffold (swarm-sprint-rules) | prose | The swarm-sprint rule file marks scaffold presence as a candidate deterministic check; not implemented today. |

## Promotion path

To promote a check from warn-only to blocking:

1. The operator approves the promotion for a named check and rule set.
2. The check script's exit behavior is changed (or its caller stops discarding the exit
   code), and the change is noted in the script header.
3. This registry is updated: the affected rows note the blocking posture and date.
4. `bash _system/validate.sh` and the hook layer are re-tested before the change lands.
