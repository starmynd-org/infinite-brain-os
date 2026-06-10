---
id: "playbook-ai-architecture-implement-session-usage-capture"
aliases: ["implement-session-usage-capture", "session-usage-capture", "automatic-session-metering"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Implementation playbook for automatic token and cost capture at AI session closeout, with portable patterns for direct receipts, SDK receipts, gateway aggregation, and provider-side lookup."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[session-ledger-root-layer]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[open-and-close-ai-session]]"
    relation: "extends"
    confidence: 0.9
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.88
created: "2026-06-03"
---

# Implement Session Usage Capture

## Summary

Use this playbook when an S4 terminal runtime or surface-embedded chat should write token and cost
data into `sessions/` automatically at closeout. The goal is not one vendor-specific mechanism. The
goal is one durable closeout receipt shape over several allowed collection patterns.

## The target outcome

At session closeout, the session record and closeout review should receive a usage receipt with:

- `usage_capture_status`
- `usage_source`
- `runtime_session_id`
- `captured_at`
- `input_tokens`
- `output_tokens`
- `cached_input_tokens`
- `tool_calls`
- `tool_cost_usd`
- `estimated_cost_usd`
- `usage_notes`

If a field is unknown, leave it blank and explain why in `usage_notes`.

## Architecture rule

Usage data is runtime truth, not canon truth. The durable receipt belongs in `sessions/` only after
it has been captured or looked up. A surface or runtime must never make session cost visible only in
an opaque vendor dashboard if the session itself is otherwise tracked in the OS.

## Collection patterns in order of preference

### Pattern 1: Direct session receipt

Use when the runtime itself exposes a final per-session total.

Examples:

- a terminal harness emits a final JSON event with usage totals
- a local supervisor process accumulates the totals as the session runs

Write the totals into `sessions/` immediately at closeout.

### Pattern 2: SDK-derived receipt

Use when the runtime is served through an SDK that exposes message or step usage.

Behavior:

1. accumulate usage against the runtime session id during the run
2. compute the best final totals at closeout
3. mark `usage_source` as `sdk-derived`
4. note whether the final cost is exact or estimated

### Pattern 3: Gateway-derived receipt

Use when a proxy or gateway can aggregate all model calls for one runtime session.

Behavior:

1. capture the runtime session id at session start
2. make sure the gateway can group calls by that id
3. fetch totals at closeout
4. write the receipt into `sessions/`

This is the preferred pattern for interactive runtimes that do not natively emit final totals but
do propagate a stable session header.

### Pattern 4: Provider-side lookup

Use when the runtime does not expose direct totals but the provider exposes a supported usage or
compliance surface after the fact.

Behavior:

1. capture the runtime session id and closeout timestamp
2. end the tracked session normally
3. query the provider-side usage surface
4. join the provider result back to the session record
5. mark `usage_source` as `provider-lookup`

This is the preferred baseline for Codex-style local terminal sessions when no stronger local hook
exists.

## Runtime-specific recommendations

### Claude Code

Preferred order:

1. SDK-derived receipt when you own the runtime through the Agent SDK
2. gateway-derived receipt when a proxy aggregates by runtime session id
3. provider-side or admin usage lookup only if the first two are unavailable

### Codex

Preferred order:

1. direct local receipt if a wrapper or future harness exposes one
2. provider-side lookup joined by runtime session id
3. explicit unavailable note if neither source exists

Do not wait for the interactive CLI itself to become the architecture. The architecture should stay
portable if the runtime changes but the provider-side audit path remains.

## Implementation procedure

### Step 1: Capture the join key at session start

Record the runtime session id in the session record as soon as the session is registered. If the
runtime does not expose one, create a local supervisor id and note that the join is indirect.

### Step 2: Declare the source class

Record one of:

- `direct`
- `sdk-derived`
- `gateway-derived`
- `provider-lookup`
- `unavailable`

This makes later aggregation deterministic.

### Step 3: Capture or fetch the totals at closeout

Use the strongest available pattern from the list above. Do not hand-edit numbers that could have
been derived mechanically.

### Step 4: Write the receipt into both session surfaces

Update:

- the session record in `sessions/closed/`
- the closeout review in `sessions/reviews/`

The same runtime session id should appear in both places.

### Step 5: Preserve ambiguity honestly

If the numbers are estimated, partial, or delayed, say so plainly. A transparent partial receipt is
better than a false exact one.

## Success test

The implementation is correct when a future agent can answer:

- which runtime produced this spend
- how the totals were captured
- whether the totals are exact or estimated
- which session record and closeout review own the durable receipt

without opening the vendor UI first.
