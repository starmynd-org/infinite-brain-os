# Canon: operating-library-example

This is the canon layer for the operating-library-example scaffold. It is an example, not
production canon. It shows what an Operating Library canon layer looks like: a small set
of compressed, provenance-bearing files that give an agent the first-principles
understanding of how operations are organized before it expands into specific procedures
or diagnostics.

## What canon means in an Operating Library namespace

Canon in an Operating Library namespace compresses the organizing principles: how
procedures are triggered and structured, how diagnostics relate to metric nodes, how
escalation is handled, and what makes a good decision tree. It does not duplicate the
SOPs or diagnostic steps. It synthesizes the reasoning that makes the SOP library
trustworthy and navigable.

## How canon is approved

In a production namespace, canon files require operator review before promotion from
`lifecycle_state: research` to `lifecycle_state: canon`. The `derived_from` edges must
point to the procedure, diagnostic, and decision tree nodes the synthesis draws from.
The `verified_at` and `verified_by` fields must be filled.

In this example scaffold, `core-doctrine.md` carries `lifecycle_state: research` to
show the shape of a real canon node.

## How to update canon

1. Identify which SOP, diagnostic, or decision tree changed in a meaningful way.
2. Determine whether the change affects a core organizing principle in `core-doctrine.md`
   or only a detail node.
3. If core-doctrine changes, revise it, update `verified_at`, and append a line to
   the `## Changelog` section at the bottom of the file.
4. Run `bash _system/validate.sh` to confirm no broken links or missing frontmatter.

## Files in this canon layer

- `README.md` (this file): navigational, not a knowledge node.
- `core-doctrine.md`: the compressed first-principles synthesis. The keystone.
- `agent-load-order.md`: load order by query class. Navigational.
