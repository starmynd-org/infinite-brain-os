---
id: "skill-write-product-description"
aliases: ["skill-write-product-description", "write-product-description"]
type: "Skill"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Skill for writing a candle product description: scent notes, burn time, materials, one sensory scene, one care line."
confidence: 0.9
retrieval_class: "domain"
export_class: "public"
name: "write-product-description"
description: "Write an Emberline candle product description: top, heart, and base scent notes, burn time, honest materials, one sensory scene, and one practical care line, in the brand voice."
edges:
  - target: "[[rule-studio-brand-voice]]"
    relation: "applies"
    confidence: 0.9
  - target: "[[knowledge-emberline-studio-brand-essentials]]"
    relation: "reads"
    confidence: 0.85
created: "2026-06-11"
---

# write-product-description

A repeatable technique for describing a candle so a customer can smell it before
they buy it. Apply whenever a listing, reply, or collection page needs copy.

## Technique

1. **Scent notes, in order.** Name top, heart, and base notes as real ingredients,
   not moods. "Bergamot" works; "joy" does not.
2. **Burn time and size.** State hours and weight as plain numbers.
3. **Materials, honestly.** Wax type, wick type, fragrance source. Per
   `[[rule-studio-brand-voice]]`, name them as they are; no vague "premium blend".
4. **One sensory scene.** A single sentence placing the candle in a moment a
   customer recognizes. One scene, not three.
5. **One care line.** A practical instruction: first burn length, wick trimming,
   or draft placement. Exactly one.

Check `[[knowledge-emberline-studio-brand-essentials]]` for the studio's standard
sizes, wax, and wick before writing, so the facts match the catalog.

## Worked example: Hearth No. 3

```text
Smoked cedar over roasted chestnut, settling into amber and a little clove.
Burns about 45 hours. 220 g of rapeseed and coconut wax, single cotton wick.
It smells like the last hour of a long dinner, when nobody wants to leave.
Trim the wick to 5 mm before each burn and give the first burn two full hours.
```

## Quality checks

- Every note is a nameable ingredient.
- Numbers are stated, not implied.
- One scene, one care line, no superlatives.
