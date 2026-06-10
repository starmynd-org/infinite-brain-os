# Concepts: doctrine-example

This folder holds definitions, models, and frameworks for the namespace.

## What goes here

A concept node defines a term or framework that agents need to understand before they
can apply the namespace's doctrine correctly. Concepts elaborate the pillars; they do
not contradict them.

Typical content: what a term means in this namespace, how a model works, how two related
terms differ, which framework applies to which situation.

## What does not go here

Foundational claims go in `pillars/`. Step-by-step procedures go in `playbooks/`.
Past decisions go in `decisions/`. Disputed readings go in `synthesis/`.

## Frontmatter for concept nodes

Use `retrieval_class: "domain"` for most concept nodes. Use `"identity"` only for
a concept that is as foundational as a pillar.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, add one file per
concept. Each file carries full node frontmatter.
