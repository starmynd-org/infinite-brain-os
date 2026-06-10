# references/

This folder holds reference and evidence nodes: data points, research findings, customer
interview summaries, and external sources that ground the angles in this namespace.

## What belongs here

- A node per significant evidence source: a study, a data point, a concrete customer
  observation, a competitor post that reveals something about the audience.
- Each node records what the source says, why it is relevant, and which angle or concept
  it supports.

## What does not belong here

- Raw intake items. Raw items land in `intake/` for routing. A reference node is the
  distilled, routed output: it has been evaluated and linked to a specific angle.
- Full copies of external documents. A reference node is a pointer with a summary, not
  a mirror.

## Node frontmatter convention

A references/ node carries `type: "Knowledge"`, `retrieval_class: "domain"`, and edges
with `relation: "supports"` pointing at the angle or concept node it grounds. Include
the source URL or citation in the body so the evidence is auditable.

## Cross-namespace references

References that also apply to a Data System or thinker namespace should be cross-linked
with a wikilink to the relevant node in that namespace. Do not duplicate the content.
Link to it.
