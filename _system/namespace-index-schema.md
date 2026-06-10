# Namespace INDEX.md Schema (Operative)

This file is the operative schema for a namespace `INDEX.md`. It is the field-by-field
"what" a builder writes and the linter checks. The "why" the internal index exists and
how it differs from the public export lives in [[internal-index-vs-public-llm-index]]
under `knowledge/ai-architecture/concepts/`.

`INDEX.md` is the agent operating brief and retrieval router for a namespace. It is not a
folder list. It tells a trusted agent how to retrieve correctly inside the namespace:
what to load first, which files answer which query class, what is durable versus
stateful, and where the failure modes are.

This schema file carries no node frontmatter (it lives under `_system/`). The `INDEX.md`
files it governs ALSO carry no node frontmatter: `validate.sh` exempts every
`knowledge/*/INDEX.md` from node-frontmatter checks so the file can stay rich markdown.
An `INDEX.md` is validator-exempt for frontmatter but still subject to the structural
section check below and the universal em-and-en-dash ban.

## Required sections, in order

Every serious-namespace `INDEX.md` carries these ten sections in this order. The H1 title
plus the ten `##` sections are the contract.

### 1. `# <namespace>` title and purpose

The H1 is the namespace name. Immediately below it, one paragraph stating what the
namespace is for and what kind of agent should read it. No frontmatter; the H1 is the
title. This is the only file in `knowledge/` where an H1 in the body is correct, because
it is not a node.

### 2. `## Profile`

State the declared profile slug (one of the eight from [[namespace-profiles]]) and a
one-line why. If the namespace carries a reduced base (a starter or example namespace),
declare the reduction here: name which base surfaces it omits and why. This declaration
is what distinguishes an intentional starter reduction from a defect.

### 3. `## Load first`

The canon entry points plus the top three to five files for this namespace, each with a
one-line reason. Lead with `canon/core-doctrine.md` (or the profile's canon file of
record) and `canon/agent-load-order.md`. This is the load-first discipline: an agent
reads `INDEX.md`, then this section's files, before expanding into the deeper graph.

### 4. `## Query classes`

The common query types this namespace answers, each mapped to the files to load to answer
it. Format each as a query phrased the way an agent would ask it, followed by the load
set. Examples by profile: Data System "trace ROAS to its source and calculation"; Tool
Contract "make the correct create-doc call"; Doctrine "what does Boyd mean by
orientation." Aim for the three to seven query classes that cover the bulk of real
retrieval against this namespace.

### 5. `## Stable vs stateful`

Split the namespace into what is durable doctrine and what changes and needs freshness
review. Name the stateful surfaces explicitly (for example a `canon/current-truth.md`, or
metric values that decay) so an agent knows what to distrust as potentially stale. This
section drives the freshness posture; see [[freshness-review-rules]].

### 6. `## Open disputes`

The current contested questions for this namespace and where each is tracked in
`synthesis/`. This is a pointer section, not the dispute content: the resolution work
lives in `synthesis/`, the index points to it. If there are no open disputes, say so
explicitly rather than omitting the section.

### 7. `## What this namespace drives`

The outputs, projects, or decisions this canon should improve. This is the output-linkage
surface: a namespace must answer what its canon is for. List the concrete downstream
artifacts (a report, a dashboard, a workflow, a decision class) the namespace exists to
make better. See [[output-linkage-review-rules]].

### 8. `## Archive and provenance`

How to use `archive/` and `support/` when present. State whether the namespace is
archive-bearing, what lives in `support/` (provenance, migration receipts, source-priority
tables), and how an agent should treat that material (historical and mechanical, not
current doctrine). If the namespace has no `archive/`, say so.

### 9. `## Common misreadings`

The repeated failure modes for this namespace: claims an agent tends to get wrong,
sources it tends to over-trust, distinctions it tends to collapse. Each entry is the
misreading plus the correction. This section is where hard-won corrections land so the
next agent does not repeat them.

### 10. `## Map`

The folder map, last, as reference. A compact tree or list of the namespace folders with
a one-line note on each. This is the only place a folder list belongs; it comes last
because retrieval guidance, not structure, leads the file.

## Section ordering rule

The order above is fixed. Retrieval guidance (Profile, Load first, Query classes) leads;
state and dispute surfaces follow; the folder Map comes last. An `INDEX.md` that leads
with the folder map has inverted the contract.

## What the validator checks vs what a curator checks

- `validate.sh` (deterministic): confirms `INDEX.md` exists for every serious namespace
  (base-surface check) and that relative links and `[[wikilinks]]` in it resolve. It does
  NOT parse the ten-section structure, because section presence is a content judgment.
- A curator agent (fuzzy): confirms the ten required sections are present and in order,
  that `Query classes` reflect real retrieval needs, that `Common misreadings` is
  populated from actual corrections, and that the reduced-base declaration (section 2) is
  present when the namespace is a starter or example. Run via [[refine-namespace-index]]
  and [[lint-namespace]].

## Relationship to the public index

`INDEX.md` is the rich internal router for trusted agents. It is a different artifact from
`llms.txt`, which is a thin public summary generated from `canon/`. `INDEX.md` may
reference internal-only and department-scoped material; `llms.txt` may carry only
operator-approved canon meant for public export. Never publish `INDEX.md` and never let
`llms.txt` become the router. See [[internal-index-vs-public-llm-index]] and the policy in
[[public-llm-index-policy]].
