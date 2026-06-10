# design-system-example

This is a reduced-base EXAMPLE scaffold for the **design-system** profile. It is not a
real namespace. It exists to prove the shape of a design-system namespace so that an
agent or operator can copy this structure when starting a real one. All content here
is illustrative: real nodes carry the minimum required frontmatter and one representative
body, not deep content.

## Profile

Design-system. This profile carries approved visual and stylistic canon: design
principles (pillars), token definitions, asset catalogues, usage examples, and external
references. The profile adds `pillars/`, `tokens/`, `assets/`, `examples/`, and
`references/` to the shared base. See [[namespace-profiles]] for the operative profile
registry.

## Load first

Canon entry points, in order:

1. [[core-doctrine]] in `canon/core-doctrine.md`: the compressed first-principles
   synthesis for this design system. Read this before any token or asset detail.
2. [[agent-load-order]] in `canon/agent-load-order.md`: tells you what to read next by
   query class.
3. `canon/README.md`: what canon means in this namespace.

Top files after canon:

- `pillars/`: foundational design principles that all token and asset decisions derive
  from.
- `tokens/color-type-space-tokens.md`: the canonical token reference for color, type,
  and space. Load for any "what value does X use" query.
- `examples/button-usage.md`: an example usage note tying a component back to tokens.

## Query classes

- **Token lookup** (what is the approved value for color, type, or space): load
  `tokens/color-type-space-tokens.md`.
- **Design principles** (why do we make the choices we make): load `pillars/`.
- **Usage and application** (how to apply tokens to a specific pattern or component):
  load `examples/`.
- **Asset inventory** (what approved assets exist, where to find them): load `assets/`.
- **External source or reference** (third-party specs, links out to external systems):
  load `references/`.

## Stable vs stateful

Stable (durable, changes only on design revision): the design principles in `pillars/`,
the semantic token meanings in `tokens/`.

Stateful or evolving: specific token values (may change across releases, needs
freshness review on each design-system release), the asset library (assets are added
and retired), usage examples (updated when a component pattern changes).

## Open disputes

No disputes in this example scaffold. In a real namespace, contested questions would
live in `synthesis/`, not in canon.

## What this namespace drives

A real design-system namespace drives:

- component-library namespaces (they reference approved tokens and principles here)
- brand compliance checks in agent-driven QA workflows
- the public design tokens export (`llms.txt` or token JSON) for external tooling

## Archive and provenance

No archive in a design-system namespace by default. Use `support/` for migration
receipts when token or pillar files are renamed or moved. Do not put derived thinking
in `support/`.

## Common misreadings

- Treating canon as a list of token values. Canon synthesizes the design principles and
  the rationale; the detailed values live in `tokens/`.
- Putting live implementation code here. Source code stays in the implementation repo.
  This namespace approves, constrains, and links; it does not duplicate code.
- Putting open questions in canon. Contested token decisions live in `synthesis/`.

## Map

```text
knowledge/_examples/design-system-example/   # EXAMPLE scaffold only, not a real namespace
  INDEX.md                                    # this retrieval router
  canon/
    README.md                                 # what canon means here (navigational)
    core-doctrine.md                          # compressed design-system synthesis (knowledge node)
    agent-load-order.md                       # load order by query class (navigational)
  pillars/
    README.md
  tokens/
    README.md
    color-type-space-tokens.md                # example token reference node
  assets/
    README.md
  examples/
    README.md
    button-usage.md                           # example usage note
  references/
    README.md
  synthesis/
    README.md
  playbooks/
    README.md
  support/
    README.md
```
