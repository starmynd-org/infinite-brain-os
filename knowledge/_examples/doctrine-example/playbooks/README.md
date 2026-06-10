# Playbooks: doctrine-example

This folder holds repeatable procedures for work in this namespace.

## What goes here

A playbook node describes a step-by-step procedure that an agent or operator follows
to accomplish a repeatable task. Playbooks enact the doctrine from `pillars/` and
`concepts/`; they are the operational layer.

Typical content: how to run a review, how to update a decision node, how to route a new
input to the right place, how to validate the namespace.

## What does not go here

Principles go in `pillars/`. Definitions go in `concepts/`. Decisions go in `decisions/`.
Derived analysis goes in `synthesis/`.

## Relationship to skills and workflows

A playbook is a knowledge node. A skill in `entities/skills/` is the executable
encapsulation of a playbook for an agent. When a playbook is stable enough, it is a
candidate for a corresponding skill.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, add one file per
repeatable procedure. Each file carries full node frontmatter.
