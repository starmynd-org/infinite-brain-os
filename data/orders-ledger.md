---
id: "data-orders-ledger"
aliases: ["data-orders-ledger", "orders-ledger"]
type: "Data"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Pointer to the studio's orders ledger: the shop platform's daily order export. The repo never stores the numbers, only this pointer."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
state_stored_at: "spreadsheet://emberline-orders/daily-export"
edges:
  - target: "[[tool-order-ledger]]"
    relation: "read_via"
    confidence: 0.9
  - target: "[[automation-order-export-digest]]"
    relation: "refreshed_by"
    confidence: 0.9
created: "2026-06-11"
---

# Data: Orders Ledger

The studio's order history lives in the shop platform and lands in a spreadsheet refreshed
daily by the order-export automation. This node is the pointer agents cite when a decision
rests on order numbers; the numbers themselves never enter git.

## Shape

One row per order line: order id, date, sku, quantity, channel (shop, wholesale, market
stall). The weekly review reads the past week of line items against the four-week trend.

## Discipline

- Quote a number in a knowledge node or output only with its read date.
- If the export breaks, the automation's digest email is the alarm; fix the pipe, never
  hand-edit the sheet.
