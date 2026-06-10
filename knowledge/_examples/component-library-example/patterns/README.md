# Patterns: component-library-example

This folder holds approved composition patterns for the namespace. A pattern is a named,
approved combination of two or more components for a recurring UI need.

## What goes here

- One node per approved pattern. Examples: `search-results-pattern.md`,
  `settings-page-pattern.md`, `data-entry-wizard-pattern.md`.
- Each node states: what the pattern is for, which components it combines, the approved
  composition rules, and when to use an alternative.

## Patterns vs components

A component is atomic: it renders one thing. A pattern is composed: it combines
components into a larger structure for a recurring purpose. When the query is "how do I
build a search results screen," the answer comes from `patterns/`, not `components/`.

## This is an example namespace

In a real component-library namespace, pattern files would live here. This example
scaffold leaves `patterns/` at the README level.
