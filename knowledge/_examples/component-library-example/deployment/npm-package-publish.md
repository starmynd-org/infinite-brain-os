---
id: "knowledge-component-library-example-npm-package-publish"
aliases: ["knowledge-component-library-example-npm-package-publish", "component-library-example-npm-publish"]
type: "Knowledge"
namespace: "component-library-example"
lifecycle_state: "research"
summary: "Deployment doctrine for publishing the component library as an npm package, including versioning rules and peer-dependency policy."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-component-library-example-canon-core-doctrine]]"
    relation: "implements"
    confidence: 0.85
created: "2026-05-30"
---

This node documents the deployment doctrine for publishing the example component library
as an npm package. Source code and the CI workflow live in the implementation repository.
This node records the constraints and decisions that govern the publish process.

## Package scope and naming

The package publishes under the organization scope: `@example-org/ui`. This is the
canonical install path for all consumers. Do not publish under an unscoped name or
under a personal scope.

## Versioning rules

Versioning follows semantic versioning (semver):

- Major version: a breaking change to a component's API (removed prop, renamed prop,
  changed behavior that requires a consumer code change).
- Minor version: a new component added, or a new prop added to an existing component
  in a backward-compatible way.
- Patch version: a bug fix, accessibility fix, or documentation update that does not
  change the component API.

Do not release a major version for a visual-only change (token value update, spacing
adjustment) unless the change breaks an existing layout.

## Peer dependency policy

The library declares its framework dependencies as peer dependencies, not direct
dependencies. The consuming application owns the framework version. Peer dependencies:

- React and ReactDOM: `>=18.0.0`
- The design-system token package (if separate): `>=1.0.0`

Do not pin peer dependencies to exact versions. Pinning breaks consumers who are on
a compatible but newer patch.

## Pre-publish checklist (summary, not a full script)

Before publishing:

1. Confirm the version bump follows the rules above.
2. Run the component library's test suite and confirm all tests pass.
3. Confirm the Storybook build succeeds (this is the visual smoke test).
4. Confirm the package's `exports` field in `package.json` is correct and includes
   all new components added in this release.
5. Tag the release in git before running the publish command.

The CI script in the implementation repository runs steps 1 to 4 automatically. Step 5
is a manual operator action before triggering the publish workflow.

## What this namespace does not own

The `package.json` file, the CI workflow YAML, and the build configuration live in the
implementation repository. Changes to those files do not require a canon update here
unless they affect the versioning rules or the peer dependency policy documented above.

## Changelog

- 2026-05-30: Created as illustrative example for the V2 component-library profile
  scaffold. Values and constraints are representative; replace with real content when
  building a real namespace.
