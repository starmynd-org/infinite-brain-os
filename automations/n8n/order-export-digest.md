---
id: "automation-order-export-digest"
aliases: ["automation-order-export-digest", "order-export-digest"]
type: "Workflow"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Companion note for the deterministic weekly order-export digest n8n flow for Emberline Candle Studio."
confidence: 0.9
retrieval_class: "domain"
export_class: "public"
runtime: "deterministic"
definition_file: "automations/n8n/order-export-digest.json"
edges:
  - target: "[[tool-order-ledger]]"
    relation: "feeds"
    confidence: 0.9
  - target: "[[data-orders-ledger]]"
    relation: "refreshes"
    confidence: 0.85
created: "2026-06-11"
---

# Workflow: Order Export Digest (Deterministic)

A weekly n8n flow for Emberline Candle Studio. It pulls the shop platform's order
export, counts units by SKU, and emails the digest. Runs every Monday at 07:00.

## What it does

1. Triggers on a cron schedule (Monday 07:00, configurable).
2. Pulls the past 7 days of orders from the shop platform's order-export API, the
   interface described by [[tool-order-ledger]].
3. A code node sums unit counts by SKU and formats a Markdown digest.
4. An email node sends the digest to the studio inbox.

No reasoning is required. The same orders always produce the same digest, so this
belongs in n8n, not in an agentic workflow. The digest also refreshes the snapshot
that [[data-orders-ledger]] points at.

## What runs where

- The JSON in this repo is the definition and the source of truth.
- The n8n engine runs the flow and owns execution state and run history.
- This `.md` file is the brain record: what the flow does and how it connects to the
  rest of the graph.

## Configuration

Set these environment variables in n8n before activating:

| Variable | Description |
|----------|-------------|
| `SHOP_API_BASE_URL` | Base URL of the shop platform API |
| `DIGEST_FROM_EMAIL` | Sender address for the digest |
| `DIGEST_TO_EMAIL` | Studio inbox that receives the digest |

Set these credentials in n8n:

| Credential | Type | Description |
|------------|------|-------------|
| `shop-platform-api-key` | HTTP Header Auth | API key for the order-export endpoint |
| `studio-smtp` | SMTP | Mailbox credentials for sending the digest |

Credentials live in the n8n engine, never in git. The JSON references credentials by
name only; the repo holds no secret values.

## How to deploy and update

1. Import `order-export-digest.json` into n8n via the workflow import UI.
2. Set the environment variables and credentials above, then activate.
3. To change the flow, edit the JSON in this repo first, then re-import. Never edit
   n8n directly and treat it as authoritative; git is the source of truth.
