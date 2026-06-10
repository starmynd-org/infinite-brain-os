# component-library-example

This is a reduced-base EXAMPLE scaffold for the **component-library** profile. It is not
a real namespace. It exists to prove the shape of a component-library namespace so that
an agent or operator can copy this structure when starting a real one. All content here
is illustrative: real nodes carry minimum required frontmatter and one representative
body, not deep content.

The key discipline for this profile: **source code stays in the implementation
repository**. This namespace approves components, constrains their usage, and links to
the implementation. It does not duplicate code.

## Profile

Component-library. This profile carries approved reusable implementation patterns plus
deployment and usage rules. The profile adds `components/`, `patterns/`, `examples/`,
`deployment/`, and `references/` to the shared base. See [[namespace-profiles]] for the
operative profile registry.

## Load first

Canon entry points, in order:

1. [[core-doctrine]] in `canon/core-doctrine.md`: the compressed first-principles
   synthesis for this component library. Read before any component or deployment detail.
2. [[agent-load-order]] in `canon/agent-load-order.md`: tells you what to read next by
   query class.
3. `canon/README.md`: what canon means in this namespace.

Top files after canon:

- `components/`: approved components with usage rules and implementation repo links.
- `deployment/`: deployment notes and environment-specific configuration rules.
- `patterns/`: approved composition patterns built from multiple components.

## Query classes

- **Component lookup** (what is the approved component for X, how do I use it): load
  `components/`. Load the specific component node if the query names one.
- **Composition pattern** (how to combine components for a common UI pattern): load
  `patterns/`.
- **Deployment and environment** (how to deploy, configure, or publish the library):
  load `deployment/`.
- **Usage example** (a concrete worked example tying components to a screen or feature):
  load `examples/`.
- **External spec or upstream library** (the third-party library this wraps or extends):
  load `references/`.

## Stable vs stateful

Stable (changes only on breaking API revision): the component approval model, the
link-to-implementation principle, the usage playbook format.

Stateful or evolving: individual component records (update when the component's API
or approval status changes), deployment notes (update on each deployment toolchain
change), pattern records (update when a composition pattern is superseded).

## Open disputes

No disputes in this example scaffold. In a real namespace, contested questions would
live in `synthesis/`.

## What this namespace drives

A real component-library namespace drives:

- agent-driven QA that checks whether a screen uses approved components and follows
  approved patterns
- onboarding paths for engineers joining a project (load canon plus the relevant
  component records)
- the public component docs export (`llms.txt` or a Storybook-companion catalogue)

## Archive and provenance

No archive by default. Use `support/` for migration receipts when components are
renamed, deprecated, or moved between versions. Do not put derived thinking in
`support/`.

## Common misreadings

- Putting source code here. Source code stays in the implementation repository. This
  namespace approves and links; it never duplicates.
- Treating a component record as a copy of the component's Storybook or API docs.
  The namespace records the approval decision, the usage rules, and the link. It does
  not replace the implementation documentation.
- Putting deployment scripts here. Deployment scripts are operational artifacts; they
  live in the implementation repository. This namespace records deployment doctrine and
  configuration rules.

## Map

```text
knowledge/_examples/component-library-example/   # EXAMPLE scaffold only, not a real namespace
  INDEX.md                                        # this retrieval router
  canon/
    README.md                                     # what canon means here (navigational)
    core-doctrine.md                              # compressed component-library synthesis (knowledge node)
    agent-load-order.md                           # load order by query class (navigational)
  components/
    README.md
    data-table-component.md                       # example approved component node
  patterns/
    README.md
  examples/
    README.md
  deployment/
    README.md
    npm-package-publish.md                        # example deployment note
  references/
    README.md
  synthesis/
    README.md
  playbooks/
    README.md
  support/
    README.md
```
