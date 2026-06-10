---
id: "knowledge-component-library-example-data-table-component"
aliases: ["knowledge-component-library-example-data-table-component", "component-library-example-data-table"]
type: "Knowledge"
namespace: "component-library-example"
lifecycle_state: "research"
summary: "Approved component record for the DataTable component: usage rules, constraints, implementation link, and usage playbook pointer."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-component-library-example-canon-core-doctrine]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

The **DataTable** component renders tabular data with sorting, filtering, and pagination.
It is the approved component for all read-only data grid use cases in the product.

Approval status: **approved**.

## When to use DataTable

Use DataTable when:

- The data has three or more columns and the user needs to compare rows.
- The data set exceeds ten rows and the user needs pagination or filtering.
- The user needs to sort by at least one column.

Do not use DataTable when:

- The data has one or two columns and a simple list or key-value layout is clearer.
- The data is form input (editable fields). Use a form component instead.
- The data is a timeline or sequence. Use a timeline component instead.

## Usage constraints

- Column definitions must declare a `type` (`string`, `number`, `date`, `boolean`).
  The type drives sort behavior and display format. Omitting the type disables sorting
  for that column and produces inconsistent display.
- Pagination is required when the row count may exceed 50. Do not disable pagination for
  large datasets.
- The `aria-label` prop is required. DataTable has no visual heading of its own; the
  `aria-label` is the accessible name for screen readers.
- Do not override the row height via inline styles. Use the `density` prop
  (`compact`, `normal`, `comfortable`) to control row spacing.

## Implementation link

Source: `packages/ui/src/components/DataTable/` in the implementation repository.
See the Storybook entry at `storybook.example-app.internal/components/DataTable` for
live prop documentation and interactive examples.

Note: the URL above is illustrative for this example scaffold. In a real namespace,
replace with the actual repository path and Storybook URL.

## Usage playbook pointer

For step-by-step guidance on adding DataTable to a new screen, see
`playbooks/add-data-table-to-screen.md` in this namespace. (This file does not exist
in the example scaffold; create it in a real namespace.)

## Known constraints and open issues

- The column pinning feature (freeze a column on scroll) is under review. Do not use
  it in production screens until approval status changes to `approved` for that feature.
  Track in `synthesis/`.
- DataTable does not support virtualized rendering for sets over 10,000 rows. If the
  query may return more than 10,000 rows, add a server-side pagination guard before
  passing data to the component.

## Changelog

- 2026-05-30: Created as illustrative example for the V2 component-library profile
  scaffold. Approval status and constraints are representative; replace with real
  content when building a real namespace.
