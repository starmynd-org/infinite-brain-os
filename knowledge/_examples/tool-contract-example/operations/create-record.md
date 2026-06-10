---
id: "knowledge-tool-contract-example-create-record"
aliases: ["knowledge-tool-contract-example-create-record", "tool-contract-example-create-record", "create-record"]
type: "Knowledge"
namespace: "tool-contract-example"
lifecycle_state: "research"
summary: "Operation contract for POST /records on the example-api. Shows the payload shape, required fields, auth note, and error patterns for a create operation."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-tool-contract-example-canon-core-contract]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

This node is an example. In a real Tool Contract namespace, one operation node covers
one endpoint or method in full. Read `canon/core-contract.md` before this node: it
defines the auth mechanism and the global error contract that this operation inherits.

## Endpoint

```
POST https://api.example.com/v1/records
```

## Request headers

```
Authorization: Bearer <token>
Content-Type: application/json
```

## Request payload

```json
{
  "external_id": "string",   // required, unique per tenant, max 128 chars
  "name": "string",          // required, max 256 chars
  "category": "string",      // required, one of: "alpha" | "beta" | "gamma"
  "metadata": {              // optional, arbitrary key-value pairs
    "key": "value"
  },
  "created_at": "string"     // optional, ISO 8601 UTC; defaults to server time if omitted
}
```

Required fields: `external_id`, `name`, `category`.

## Response on success (201 Created)

```json
{
  "id": "string",            // internal UUID assigned by the API
  "external_id": "string",
  "name": "string",
  "category": "string",
  "metadata": {},
  "created_at": "string",
  "updated_at": "string"
}
```

## Operation-specific errors

Beyond the global error contract in `core-contract.md`:

- `409 CONFLICT`: a record with the same `external_id` already exists for this tenant.
  The response body includes `"error_code": "DUPLICATE_EXTERNAL_ID"`. Do not retry
  without first checking whether the existing record is the one you intended to create.

## Idempotency note

This endpoint is not idempotent. Calling it twice with the same `external_id` produces
a `409 CONFLICT` on the second call, not a silent no-op. If you need idempotent create,
use `PUT /records/{external_id}` instead (not shown in this example scaffold).

## Worked example payload

See `examples/create-record-payload.json` for a valid sample request payload.

## Operation note

This operation node is part of an example scaffold. Replace the endpoint, fields, and
error cases with the real contract for your API.
