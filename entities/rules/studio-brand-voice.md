---
id: "rule-studio-brand-voice"
aliases: ["rule-studio-brand-voice", "studio-brand-voice"]
type: "Rule"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Emberline's brand voice rule: warm but plain, sensory specifics over adjectives, honest materials, plain prices."
confidence: 0.9
retrieval_class: "identity"
export_class: "public"
name: "studio-brand-voice"
description: "Behavioral constraint: every customer-facing word from Emberline Candle Studio, listings, emails, and collection pages, follows this voice."
edges:
  - target: "[[knowledge-emberline-studio-brand-essentials]]"
    relation: "derived_from"
    confidence: 0.85
created: "2026-06-11"
---

# Rule: Studio Brand Voice

Applies to every customer-facing word: product listings, email replies, collection
pages, and packaging copy. Agents drafting in this namespace load this rule first.

## The voice

- **Warm but plain.** Write like a maker talking across the workbench, not a
  luxury brand talking down from a billboard.
- **Sensory specifics over adjectives.** Name what the nose finds. "Cedar and
  clove" beats "rich and inviting" every time.
- **Honest materials.** Name the wax, the wick, and the fragrance source as they
  are. If a candle uses synthetic fragrance oil, say so.
- **Plain prices and availability.** State the price as a number and the stock as
  a fact. "Back in stock March 3" beats "returning soon".

## No scent cliches

These words are banned in scent copy: luxurious, indulgent, intoxicating,
heavenly, divine, signature blend, premium, evocative.

## Dos

- Do open with the strongest scent note: "Smoked cedar first, then chestnut."
- Do state numbers plainly: "Burns about 45 hours. 28 dollars."
- Do admit limits honestly: "This batch is 40 candles; when it sells out, it is gone."

## Don'ts

- Don't stack adjectives: "a rich, warm, cozy, inviting glow."
- Don't hide materials behind vagueness: "our proprietary luxury wax blend."
- Don't dodge availability: "selling fast!" with no date or count.

## Source

Derived from `[[knowledge-emberline-studio-brand-essentials]]`. When the brand
essentials change, review this rule in the same session.
