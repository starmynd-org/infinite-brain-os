# Contradiction Review Rules

Operative rules for surfacing, recording, and resolving contradictions across the
knowledge graph. Contradiction review is a fuzzy check owned by a curator agent, not by
`validate.sh`. The review procedure that runs it lives in [[review-namespace-health]];
the freshness side of the same review is governed by the freshness rules.

Scope: guardrail G5 (reserve agent linting for genuinely fuzzy checks), guardrail G10
(profile-scoped review), and contract Part 4 (synthesis owns contradiction maps). A
contradiction is two statements in the graph that cannot both be true as written.

## Why this is fuzzy, not deterministic

Rule CONTRA-1: contradiction detection is NOT in `validate.sh`. Deciding whether two true
statements actually conflict, whether they conflict only in appearance, or whether one
supersedes the other is a judgment a script cannot make. `validate.sh` checks structure
(links resolve, frontmatter present, dashes banned); a curator agent checks meaning.

A script can flag two nodes that share a topic. It cannot tell that "canon is loaded first"
and "the INDEX.md is read first" are compatible (canon is the first content; the router is
the first navigation) versus genuinely opposed. That distinction is the whole job, and it
stays with the agent.

## What counts as a contradiction

Rule CONTRA-2: a contradiction is two graph statements that cannot both hold as written.
Distinguish from the cases that are not contradictions:

- Not a contradiction: a node and its `archive/` source where the node deliberately
  refines or compresses the source. That is synthesis, not conflict.
- Not a contradiction: two nodes at different altitudes (a pillar and a detail node) that
  agree but differ in scope.
- Not a contradiction: a superseded node correctly marked with `supersedes` or
  `deprecated`. The supersession resolved it.
- Is a contradiction: two live nodes that an agent could load together and that give
  opposed instructions, claims, or definitions, with no recorded resolution.

Rule CONTRA-3: a same-`metric_id` definition that differs between its Data System lineage
node and its Operating Library diagnosis node is a contradiction. The metric primitive
(contract Part 9) requires one definition cross-linked, not two divergent ones.

## How contradictions are surfaced

Rule CONTRA-4: contradictions are surfaced by a curator agent during health review (see
[[review-namespace-health]] step 3) and during cross-namespace synthesis. The agent reads
the namespace (or the bridged namespaces) for nodes or sources that disagree. The
surfacing is a deliberate read, not a passive scan.

Rule CONTRA-5: contradictions can be within a namespace or across namespaces.
Within-namespace contradictions are surfaced and recorded inside that namespace's
`synthesis/`. Cross-namespace contradictions (two thinkers, or a thinker and an
architecture decision) are recorded in the repo-root `synthesis/`, because no single
namespace owns the conflict.

## How contradictions are recorded: the synthesis contradiction map

Rule CONTRA-6: a surfaced contradiction is recorded as a contradiction map in `synthesis/`,
never silently resolved inside `canon/`. A contradiction map is a substantive synthesis
node with full node frontmatter (it is not a navigational file).

Required content of a contradiction map:

- the two (or more) statements in conflict, quoted or precisely paraphrased, each with its
  source node id or file path
- the nature of the conflict (definition, instruction, claim, scope)
- the current best resolution, or an explicit "unresolved" with the open question
- edges to both conflicting nodes (`contradicts` or `qualifies` as appropriate)
- if resolved, the action taken (which node was corrected, deprecated, or superseded)

Rule CONTRA-7: a contradiction map lives in `knowledge/<ns>/synthesis/` for within-namespace
conflicts and in repo-root `synthesis/` for cross-namespace conflicts. It never lives in
`support/` (support is provenance and migration only, G11) and never inside `canon/`.

## How contradictions are resolved or escalated

Rule CONTRA-8: a contradiction is resolved by one of these moves, recorded in the map:

- correct one node to match the truth, and link the correction
- deprecate or supersede the losing node per the deprecation and supersession rules
  (add the old id to the winner's `aliases`, or leave a stub with a `supersedes` pointer,
  so no link breaks silently, contract Part 12)
- qualify both nodes so each states its scope and they no longer collide
- write a best-current-reading synthesis node that states the operator's resolved position
  and links both originals

Rule CONTRA-9: a contradiction that touches canon is escalated to the operator. The curator
agent does not silently pick a winner inside canon. The resolution, if it changes canon, is
an operator-approved canon revision recorded in the canon `## Changelog` (canon contract,
Part 3).

Rule CONTRA-10: a contradiction the curator cannot resolve is recorded as unresolved in the
contradiction map with the open question stated, and escalated to the operator. Unresolved
contradictions do not live in `canon/`; they live in `synthesis/` until resolved.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- nodes referenced by a contradiction map resolve as valid `[[wikilinks]]`
- a superseded node leaves no broken link (alias-on-rename or supersedes-stub present)
- the contradiction map node carries valid node frontmatter (it is a substantive synthesis
  node, not exempt)

Fuzzy (curator or corpus-synthesizer agent, not validate.sh):

- whether two statements actually contradict
- which resolution move is correct
- whether a contradiction touches canon and must be escalated
- the wording of the best-current-reading resolution

## Anti-patterns

- Resolving a contradiction silently inside `canon/` by editing one side. Canon edits that
  resolve conflicts go through operator approval and the changelog.
- Recording a contradiction map in `support/`. Support is mechanical provenance; a
  contradiction map is derived intellectual work and belongs in `synthesis/`.
- Treating a deliberate compression of a source as a contradiction with that source.
- Leaving an unresolved contradiction in canon instead of in a synthesis map.

## Notes

The review procedure that surfaces contradictions step by step lives in
[[review-namespace-health]]. The synthesis homes (per-namespace and repo-root) are defined
in contract Part 4. This file owns the definition of a contradiction, the contradiction-map
contract, and the resolve-or-escalate rule. The judgment stays fuzzy and stays with a
curator agent and the operator; only the structural side is deterministic.
