# Deployment: component-library-example

This folder holds deployment doctrine for the namespace. Each node records how to
package, version, publish, or configure the component library in a specific environment
or toolchain.

## What goes here

- One node per deployment concern. Examples: `npm-package-publish.md`,
  `peer-dependency-policy.md`, `cdn-bundle-deployment.md`.
- Each node states: what the deployment process is, what the version constraints are,
  any environment-specific configuration rules, and what must not be done.
- Deployment notes are doctrine, not scripts. The scripts live in the implementation
  repository. This folder records the decisions and constraints that govern how
  deployment scripts are written and run.

## What does not go here

Deployment scripts, CI configuration files, and package manifests do not go here.
Those are operational artifacts; they live in the implementation repository. This folder
records the doctrine that governs those artifacts.

## This is an example namespace

`npm-package-publish.md` in this folder is the characteristic deployment example node
for the component-library profile. It is illustrative content.
