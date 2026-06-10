# parties

`parties/` is the root relationship layer for external or business actors the OS needs to
reference repeatedly. It is where stable client, brand, vendor, partner, influencer, and related
party identities live.

This layer exists so relationship scope does not get overloaded into namespaces, departments,
tools, or runtime CRM systems.

## What belongs here

- one durable record per external party
- stable slugs and relationship metadata
- parent and child links such as client -> brand
- pointers to related namespaces, departments, tools, repos, and surfaces

## What does not belong here

- live CRM pipeline state
- mutable approvals or task queues
- copied secrets or credentials
- full doctrine that should live in `knowledge/<namespace>/`
- runtime system configuration

## Relationship to the rest of the OS

- `parties/` owns stable relationship identity and scope
- `knowledge/` owns retrieval and doctrine
- `departments/` owns operating assembly
- runtime CRM tools consume party records but do not own the ontology

## Current shape

```text
parties/
  README.md
  _template.md
  clients/
  brands/
  vendors/
  influencers/
  partners/
```

The current scaffold is intentionally light. It establishes the layer and the stable record shape
before a full validator and rule contract are added.
