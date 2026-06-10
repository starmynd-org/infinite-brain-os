# Canon: ai-architecture

This folder is the canon layer for the `ai-architecture` namespace. Canon is the
compressed, operator-approved, first-principles reasoning a future agent should load
and think from before it expands into the deeper graph. It is not a folder list and
not a loader. It is synthesized doctrine.

This README is navigational. It carries no knowledge-node frontmatter and is exempt
from node-frontmatter checks in `validate.sh`. The substantive node in this folder is
[[core-doctrine]], which does carry full frontmatter.

## What canon means here

Per the V2 architecture contract Part 3, canon in this namespace is:

- **Compressed synthesis.** It states the best current first-principles understanding
  of the Infinite Brain architecture in tight form. It does not paraphrase every pillar,
  concept, and decision node by node. It compresses them and links out.
- **Operator-approved and provenance-bearing.** The keystone node cites, via
  `derived_from` edges, the pillars, concepts, and decisions it compresses, and carries
  `verified_at` and `verified_by` frontmatter.
- **Small relative to the graph it sits over.** Canon is a thin top layer, not a
  duplicate corpus. The graph below it holds the detail.
- **The first thing an agent loads.** For any architecture question, an agent reads
  [[core-doctrine]] first, then expands into the specific pillar, concept, or decision
  the question needs. The reading order itself is governed by [[agent-load-order]].

## What canon is not

- Not a copy of `pillars/`. Canon synthesizes and compresses across the graph; the
  pillar, concept, and decision nodes remain the detailed homes.
- Not a parking lot for open questions. Unresolved or contested material lives in
  `synthesis/`, not in canon. Canon states settled doctrine. If a question is live,
  the doctrine node names it and points to `synthesis/`, but the dispute itself does
  not sit in canon.
- Not runtime state, not raw archive, not a public export. Live queue state stays in
  the operational app layer. Provenance and migration receipts stay in `support/`. The
  public `llms.txt` surface is generated from canon but is a separate export artifact.

## How this canon was approved

The V2 canon synthesis was authored on 2026-05-30 during the
`ai-architecture-namespace-v2-upgrade` sprint. It compresses the doctrine already
present in this namespace (the control-model pillar, the planning ladder, the surface
boundary, the namespace-first topology decision, the PM-agent posture, and the swarm
launch governance playbook) plus the cross-cutting doctrine the sprint canonized
(retrieval over raw memory, correction to structure, harness and memory portability,
output linkage, the metric primitive). The keystone node carries `verified_by:
operator-pending` until the operator signs off, then it moves to operator-approved with
a changelog entry.

## How to update canon

Do not edit canon casually. Canon changes follow the promotion path and changelog
discipline:

- Use the [[canonize-a-namespace]] playbook to promote synthesized material into canon.
  New first-principles understanding enters as a `synthesis/` canon-candidate, gets
  operator review, and only then lands here.
- Follow [[canon-changelog-rules]] for every revision: append a dated one-line reason to
  the `## Changelog` section in [[core-doctrine]], and update `verified_at` and
  `verified_by`.
- When a node this canon derives from changes materially, revisit the `derived_from`
  edges and the synthesis, do not let canon silently drift from the graph below it.

## Canon files in this namespace

- `core-doctrine.md` ([[core-doctrine]]): the keystone. The compressed first-principles
  synthesis of the Infinite Brain architecture. A full knowledge node.
- `agent-load-order.md` ([[agent-load-order]]): the load-order controller. What to load
  first for this namespace and why, by query class. Navigational.
- `README.md` (this file): what canon means here, how it was approved, how to update it.
  Navigational.

This namespace has `canon_posture: full`, so all three canon files are required. There
is no `current-truth.md` here because `ai-architecture` carries durable doctrine, not
live-but-canonical facts. Stateful namespaces such as `example-marketing` carry
`current-truth.md`; this one does not.
