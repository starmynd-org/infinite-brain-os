---
id: "knowledge-design-system-example-color-type-space-tokens"
aliases: ["knowledge-design-system-example-color-type-space-tokens", "design-system-example-tokens"]
type: "Knowledge"
namespace: "design-system-example"
lifecycle_state: "research"
summary: "Approved color, typography, and space tokens with semantic intent for the example design system."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-design-system-example-canon-core-doctrine]]"
    relation: "derived_from"
    confidence: 0.9
created: "2026-05-30"
---

This node is the token reference for the example design system. It lists approved tokens
in three categories: color, typography, and space. Each entry states the token name, the
approved value, and the semantic intent. Semantic intent is what allows an agent or
implementer to judge whether a new or overriding value is correct.

## Color tokens

| Token name | Value | Semantic intent |
|---|---|---|
| `color-background-primary` | `#090E18` | The primary page background. Dark, near-black. |
| `color-background-card` | `rgba(8, 16, 36, 0.32)` | Card and surface backgrounds with glass effect. |
| `color-accent-blue` | `#3B82F6` | Primary interactive accent. Actions, links, highlights. |
| `color-accent-green` | `#10B981` | Success and positive states. |
| `color-accent-amber` | `#F59E0B` | Warning and caution states. |
| `color-accent-red` | `#EF4444` | Error and destructive action states. |
| `color-text-primary` | `#F9FAFB` | Primary body and heading text on dark backgrounds. |
| `color-text-secondary` | `rgba(249, 250, 251, 0.6)` | Secondary and supporting text. |

Semantic notes: accent colors are not interchangeable. Do not use `color-accent-red` for
anything other than error or destructive actions, even if the visual result looks
similar. The semantic layer is what makes QA checks meaningful.

## Typography tokens

| Token name | Value | Semantic intent |
|---|---|---|
| `font-family-sans` | `Plus Jakarta Sans, sans-serif` | All UI text and headings. |
| `font-family-mono` | `JetBrains Mono, monospace` | Code, data values, technical labels. |
| `font-size-xs` | `12px` | Labels, captions, metadata. |
| `font-size-sm` | `14px` | Secondary body text, table rows. |
| `font-size-base` | `16px` | Primary body text. |
| `font-size-lg` | `18px` | Lead paragraphs, callouts. |
| `font-size-xl` | `24px` | Section headings. |
| `font-size-2xl` | `32px` | Page headings. |
| `font-weight-regular` | `400` | Body text. |
| `font-weight-medium` | `500` | Labels, navigation items. |
| `font-weight-semibold` | `600` | Subheadings, important labels. |
| `font-weight-bold` | `700` | Primary headings. |
| `line-height-tight` | `1.2` | Headings. |
| `line-height-normal` | `1.5` | Body text. |
| `line-height-relaxed` | `1.75` | Long-form content. |

## Space tokens

| Token name | Value | Semantic intent |
|---|---|---|
| `space-1` | `4px` | Tight intra-element gaps (icon to label). |
| `space-2` | `8px` | Compact element padding. |
| `space-3` | `12px` | Standard inner padding for small components. |
| `space-4` | `16px` | Base unit. Standard inner padding. |
| `space-6` | `24px` | Component-to-component spacing within a section. |
| `space-8` | `32px` | Section inner padding. |
| `space-12` | `48px` | Section-to-section gap. |
| `space-16` | `64px` | Major layout gap, above-the-fold splits. |

Space tokens follow a base-4 scale. Do not introduce arbitrary pixel values outside
this scale without a canon update. The scale is the constraint.

## Changelog

- 2026-05-30: Created as illustrative example for the V2 design-system profile scaffold.
  Values are representative; replace with real token set when building a real namespace.
