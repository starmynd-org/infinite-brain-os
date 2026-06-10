---
id: "tool-order-ledger"
aliases: ["tool-order-ledger", "order-ledger"]
type: "Tool"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Pointer node for the shop platform's order-export API: pull orders by date range as CSV or JSON."
confidence: 0.85
retrieval_class: "identity"
export_class: "public"
tool_type: "api"
tool_status: "active"
secret_refs: ["secret://shop-platform-api-key"]
edges:
  - target: "[[data-orders-ledger]]"
    relation: "backs"
    confidence: 0.9
  - target: "[[automation-order-export-digest]]"
    relation: "used_by"
    confidence: 0.9
created: "2026-06-11"
---

# Tool: Order Ledger (Shop Platform Order-Export API)

The bounded capability behind every order question at Emberline Candle Studio: the
shop platform's order-export endpoint. This node is the durable pointer; the
implementation is the shop platform's API, not anything in this repo.

## Interface contract

- `GET {SHOP_API_BASE_URL}/api/v1/orders/export`
- Query: `from` and `to` (ISO dates) or `days` (integer lookback)
- Query: `format=csv` (default) or `format=json`
- Returns one row per order line: order id, date, SKU, quantity, unit price
- Auth: API key in the request header

## Credentials

By reference only. The API key lives in the secret manager under the reference name
`shop-platform-api-key`. The n8n engine holds its own copy as a named credential.
No secret value ever enters git.

## Who may call it

- [[automation-order-export-digest]], the weekly deterministic digest flow
- Agentic sessions running the weekly studio review, via the pointer in
  [[data-orders-ledger]]

This tool is read-only. Nothing in the brain writes orders back to the shop platform.

## Boundary

The tool answers "what sold, when, in what quantity." It does not own pricing
decisions, inventory truth, or customer data beyond the order line. If a deeper call
contract ever becomes necessary, it gets its own namespace under `knowledge/`; this
root entry stays shallow.
