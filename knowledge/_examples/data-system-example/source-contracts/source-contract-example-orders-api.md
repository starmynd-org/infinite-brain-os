---
id: "knowledge-data-system-example-source-contract-example-orders-api"
aliases: ["knowledge-data-system-example-source-contract-example-orders-api", "source-contract-example-orders-api"]
type: "Knowledge"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Source contract for the example Orders API. Stub showing the required fields and structure for a source contract node."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[metric-example-order-count]]"
    relation: "produces"
    confidence: 0.9
  - target: "[[knowledge-data-system-example-canon-core-doctrine]]"
    relation: "grounded_in"
    confidence: 0.8
created: "2026-05-30"
---

The **Orders API** is the upstream source that provides order records for this example
data system. This contract records what the API exposes and how this namespace interprets
it.

## Source details

- System: Example e-commerce orders platform (placeholder; replace with real system name).
- Base URL: `https://api.example.com/v2/orders` (placeholder).
- Auth: bearer token, rotated monthly. Credential reference: `secret/orders-api-token`.
- Pagination: cursor-based, `next_cursor` field in response envelope.

## Fields

| Field | Type | Nullable | Interpretation |
|-------|------|----------|----------------|
| `order_id` | string (UUID) | no | Stable unique identifier for the order. Deduplication key. |
| `created_at` | ISO 8601 timestamp | no | When the order was placed. Used as the event timestamp. |
| `order_status` | string enum | no | Raw status value from the source. Normalized in the transform layer. See Status values below. |
| `customer_id` | string | no | Identifier for the customer account. Not a UUID in all environments. |
| `line_item_count` | integer | yes | Number of line items on the order. Null for draft orders. |
| `currency_code` | string (ISO 4217) | no | Three-letter currency code. |

## Status values (raw enum)

The source emits these raw status strings. The transform normalizes them to the canonical
enum used downstream:

| Raw value | Canonical value | Meaning |
|-----------|----------------|---------|
| `CONFIRMED` | `confirmed` | Order accepted and being processed. |
| `SHIPPED` | `confirmed` | Order dispatched. Still counted as confirmed for the order-count metric. |
| `CANCELLED` | `cancelled` | Order cancelled by customer or system. Excluded from order count. |
| `PENDING` | `pending` | Order placed but not yet confirmed. Excluded from order count. |
| `DRAFT` | `draft` | Incomplete order. Excluded. |

## Known quirks

- The `line_item_count` field is null for orders with `order_status = 'DRAFT'`. Do not
  use it as a nullability signal for order validity.
- `created_at` is in UTC but the source documentation incorrectly states local time.
  This has been verified against production records as of 2026-05-30.

## Versioning

The source uses `v2` in the base URL. Breaking changes appear as a major version bump.
The owner of this contract must update this file when the source API changes its field
list, type, or status enum. Run `bash _system/validate.sh` after any contract update to
check for broken edges.
