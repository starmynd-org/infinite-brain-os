# Examples: component-library-example

This folder holds usage example nodes for the namespace. Each node is a concrete worked
example tying one or more components to a real feature or screen.

## What goes here

- One node per worked example. Examples: `admin-users-screen-example.md`,
  `reporting-dashboard-example.md`.
- Each node states: which screen or feature it covers, which components and patterns it
  uses, and any screen-specific configuration decisions that are not obvious from the
  component or pattern records alone.

## Examples vs patterns

A pattern is the abstract approved composition. An example is a concrete application
of that pattern to a real screen. If the two conflict, the pattern is authoritative.
The example may reflect a screen-specific override; that override should be documented
in the example node and tracked as a possible canon update if it generalizes.

## This is an example namespace

In a real component-library namespace, usage example files would live here. This example
scaffold leaves `examples/` at the README level.
