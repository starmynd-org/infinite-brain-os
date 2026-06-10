---
id: "knowledge-example-concept"
aliases: ["knowledge-example-concept"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Example concept node explaining attribution-window semantics for analytics work."
confidence: 0.85
retrieval_class: "domain"
export_class: "department"
edges:
  - target: "[[knowledge-about-this-company]]"
    relation: "grounded_in"
    confidence: 0.9
created: "2026-05-20"
---

# Concept: Attribution Window

An attribution window is the time period after an advertising impression or click
during which a resulting conversion is credited to that ad.

## Why it matters

Attribution windows directly affect the revenue numbers we report to clients. A 7-day
click window and a 1-day click window on the same campaign can produce radically different
ROAS figures. Choosing the wrong window makes campaigns look better or worse than they
are, which leads to bad budget decisions.

## How it works

When a shopper sees or clicks an ad and later makes a purchase:
- **View-through attribution**: the impression gets credit if the purchase happens
  within the view window (often 1 day).
- **Click-through attribution**: the click gets credit if the purchase happens within
  the click window (often 7 or 28 days, platform-dependent).

When multiple channels claim the same conversion, the attribution model decides who
gets credit. The main models are:

| Model | Logic |
|-------|-------|
| Last-click | 100% credit to the last touch before purchase |
| First-click | 100% credit to the first touch in the journey |
| Linear | Credit split equally across all touches |
| Data-driven | Platform-modeled split based on historical conversion paths |

## Platform defaults

| Platform | Default click window | Default view window |
|----------|---------------------|---------------------|
| Meta Ads | 7 days | 1 day |
| Google Ads | 30 days | 1 day |
| TikTok Ads | 7 days | 1 day |

We standardize all clients to 7-day click, 1-day view for cross-channel comparison.
This is documented in `[[knowledge-about-this-company]]` as a company standard.

## Common confusion

Clients often compare Meta ROAS (using Meta's default 7-day window) to Google ROAS
(using Google's default 30-day window) and draw the wrong conclusion about which
channel is performing better. Always confirm window settings before presenting numbers.

## How we handle it

Our attribution model applies a consistent window across all channels by querying
conversion events from the Shopify order feed and matching them to ad exposure events
within the defined window. We do not rely on platform-reported conversions as the
canonical figure; we derive our own from the raw event data.

See ``data-example-metric`` for the pointer to the conversion events table.

## Open questions

- We have not validated our model against data-driven attribution on high-volume
  accounts. This is a known gap as of 2026-05-20. Confidence reduced to 0.85 until
  validated.
