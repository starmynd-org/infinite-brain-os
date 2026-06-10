# Playbooks: tool-contract-example

This folder holds repeatable procedures for working with this tool or API.

## What goes here

Playbook nodes describe step-by-step procedures that agents or operators follow when
working with this integration. Typical content: how to refresh auth tokens in sequence,
how to migrate records in bulk, how to handle a rate-limit backoff cycle, how to
validate the contract when the upstream API changes.

## What does not go here

Operation descriptions go in `operations/`. Contract decisions go in `decisions/`.
Sample payloads go in `examples/`.

## This example scaffold

This example scaffold includes:

- `build-tool-contract-from-public-docs.md`: a worked procedure for turning public docs
  into a real Tool Contract namespace

In a real namespace, add a playbook for any recurring multi-step procedure that recurs
often enough to warrant documentation.
