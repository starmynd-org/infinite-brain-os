---
id: "knowledge-tool-contract-example-canon-core-contract"
aliases: ["knowledge-tool-contract-example-canon-core-contract", "tool-contract-example-core-contract", "core-contract"]
type: "Knowledge"
namespace: "tool-contract-example"
lifecycle_state: "research"
summary: "Locked operational contract for the example-api. Shows what a Tool Contract profile canon node looks like."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "the-operator"
edges:
  - target: "[[knowledge-tool-contract-example-create-record]]"
    relation: "constrains"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-30"
---

This node is an example. In a real Tool Contract namespace, `core-contract.md` is the
first thing an agent reads before making any call. It states the tool's purpose, its
primary operations, the auth mechanism, the error contract, and the non-obvious
constraints that apply across all operations.

## System fit in the OS (example)

Every real tool-contract namespace should say how the tool fits into the wider OS, not
just how the upstream API works.

- Fit class: `os-operational-tool` in this example
- What it serves: a shared operational API used by agents and workflows
- What it may own: runtime actions and API-side state
- What it may not own: durable planning truth, canon, or secrets copied into docs

If the real tool materially shapes the operating model, use the stronger
`ai-architecture-component` fit class and link back into `_system/` and
`knowledge/ai-architecture/`.

## Verification posture (example)

Real tool-contract namespaces should also record whether the important calls were
actually tested. Good labels are:

- `live-tested`
- `dry-run-tested`
- `doc-derived`
- `known-broken`

If later testing shows a documented call is wrong or has drifted, the namespace should be
updated with that note and the corrected contract rather than leaving the discovery only
in chat or session history.

## Tool summary (example)

**example-api** is a fictional REST API that manages records in an example service.
It is used here only to show the Tool Contract profile shape.

- Base URL: `https://api.example.com/v1`
- Auth: Bearer token in the `Authorization` header. Tokens are short-lived (1 hour).
  Refresh using the `/auth/refresh` endpoint before a token expires.
- Rate limit: 100 requests per minute per token. Retry after the `Retry-After` response
  header on a 429.

## Primary operations (example)

- `POST /records`: create a new record. See `operations/create-record.md`.
- `GET /records/{id}`: retrieve a record by ID.
- `PATCH /records/{id}`: update a record's fields partially.
- `DELETE /records/{id}`: delete a record. Non-reversible.

## Error contract (example)

The API returns standard HTTP status codes. The response body on error carries:

```json
{
  "error_code": "string",
  "message": "string",
  "details": {}
}
```

Key codes:

- `400 BAD_REQUEST`: invalid payload shape or missing required field. Check the request
  before retrying.
- `401 UNAUTHORIZED`: token missing or expired. Refresh and retry once.
- `409 CONFLICT`: a record with this external ID already exists. Check before creating.
- `429 TOO_MANY_REQUESTS`: rate limit exceeded. Wait for `Retry-After` seconds.
- `500 INTERNAL_ERROR`: server fault. Retry with exponential backoff, max three times.

## Cross-cutting constraints (example)

- All timestamps are ISO 8601 UTC.
- `external_id` must be unique across the tenant. Always check before creating.
- Field names use `snake_case`. The API does not tolerate `camelCase` keys.
- Do not call `DELETE` without operator confirmation in an agentic context.

## Changelog

- 2026-05-30: Initial example scaffold created by build agent for the V2 namespace
  architecture sprint.
