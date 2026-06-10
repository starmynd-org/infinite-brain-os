# Assets: design-system-example

This folder holds asset catalogue nodes for the namespace. Each node describes an
approved visual asset: its name, format, intended use, and a link to where it lives in
the implementation repository or asset store.

## What goes here

- One node per asset category, or one record per named asset when the catalogue is small.
  Examples: `logo-assets.md`, `icon-set.md`, `illustration-library.md`.
- Each node states: asset name, approved formats (SVG, PNG, WebP), intended use context,
  restrictions (where it must not be used), and the canonical source location.
- The source location is a link, not a copy of the file. Assets live in the
  implementation repository or asset store, not in the knowledge namespace.

## What does not go here

Do not store binary asset files here. This namespace catalogues and approves assets;
it does not duplicate them. Do not put usage examples here; those live in `examples/`.

## Freshness

Asset records need freshness review when a new brand revision is released. Mark the
source location with the version or release date when adding a record.

## This is an example namespace

In a real design-system namespace, asset records would live here. This example scaffold
leaves `assets/` at the README level so the shape is clear.
