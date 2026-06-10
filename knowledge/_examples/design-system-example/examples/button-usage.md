---
id: "knowledge-design-system-example-button-usage"
aliases: ["knowledge-design-system-example-button-usage", "design-system-example-button-usage"]
type: "Knowledge"
namespace: "design-system-example"
lifecycle_state: "research"
summary: "Approved token usage for the primary, secondary, and destructive button variants."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-design-system-example-color-type-space-tokens]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[knowledge-design-system-example-canon-core-doctrine]]"
    relation: "implements"
    confidence: 0.85
created: "2026-05-30"
---

This node documents the approved token usage for button components. It covers three
variants: primary, secondary, and destructive. Load `tokens/color-type-space-tokens.md`
alongside this file when answering a button styling or QA query.

## Primary button

The primary button is the single most prominent action on a surface. Use it for the
action the operator most wants the user to take.

Token assignments:

- Background: `color-accent-blue`
- Text: `color-text-primary`
- Font family: `font-family-sans`
- Font size: `font-size-sm`
- Font weight: `font-weight-semibold`
- Horizontal padding: `space-4`
- Vertical padding: `space-2`

Only one primary button per visible surface. Placing two primary buttons side by side
violates the visual-hierarchy principle.

## Secondary button

The secondary button is a lower-priority alternative action. It sits alongside the
primary button when the user has a clear second option.

Token assignments:

- Background: transparent
- Border: 1px solid `color-accent-blue`
- Text: `color-accent-blue`
- Font family: `font-family-sans`
- Font size: `font-size-sm`
- Font weight: `font-weight-medium`
- Horizontal padding: `space-4`
- Vertical padding: `space-2`

## Destructive button

The destructive button is reserved for irreversible actions (delete, revoke, purge).

Token assignments:

- Background: `color-accent-red`
- Text: `color-text-primary`
- Font family: `font-family-sans`
- Font size: `font-size-sm`
- Font weight: `font-weight-semibold`
- Horizontal padding: `space-4`
- Vertical padding: `space-2`

Never use `color-accent-red` for an action that is reversible. The semantic meaning of
the destructive variant is that it cannot be undone; misapplying it trains users to
ignore the warning signal.

## Deviations

Any usage that differs from the above requires a canon update, not a local override in
the implementation. Accumulating local overrides breaks the semantic contract of the
token system.

## Changelog

- 2026-05-30: Created as illustrative example for the V2 design-system profile scaffold.
