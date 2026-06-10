# Retrieval Load Order Policy

Operative policy for what an agent loads, in what order, when retrieving from a namespace.
This file is the executable rule layer. The reasoning, including why retrieval is the
operating layer and why the right small fragments beat a large context, lives in
[[retrieval-over-raw-memory]].

Scope: contract Part 11 (name the consumer, retrieval over raw memory) and Part 4 of the
guardrails (G7, name the retrieval consumer). This policy is what the namespace `INDEX.md`
load surface and `canon/agent-load-order.md` implement.

## Name the consumer (G7, locked)

Rule LOAD-1: surfaces are designed for the reader that actually retrieves today. The
consumer is named, not assumed.

- Today: Claude Code and Codex file-reading agents. They retrieve by `Glob`, `Grep`, and
  `Read` over the working tree. There is no embedding index and no vector store in the
  baseline. The retrieval surface is the filesystem: folder names, frontmatter, `INDEX.md`,
  and `[[wikilinks]]`.
- Later: an MCP server or a RAG retriever may sit in front of the same tree as an optional
  adapter. It is not in the baseline. If one is planned, this policy is updated to name it
  so surfaces account for it.

Because the reader today greps and reads files, the load order is expressed as a sequence
of files to read, not as a query to an index. Every rule below assumes a file-reading
agent.

## Canon-first load order (locked)

Rule LOAD-2: the standard load order for a serious namespace is:

1. The namespace `INDEX.md`. It is the router and operating brief: profile, load-first
   list, query classes, stable-vs-stateful split, open disputes, what the namespace
   drives, common misreadings, and the folder map. The agent reads this first to orient.
2. `canon/agent-load-order.md`. It states what to load first for this namespace and why.
   It is navigational, not a knowledge node.
3. `canon/core-doctrine.md`. The compressed first-principles synthesis the agent should
   think from before expanding into the deeper graph. For a Tool Contract namespace this
   is `canon/core-contract.md`. For a stateful namespace, also load
   `canon/current-truth.md` for the live-but-canonical facts.
4. The query-class files. The `INDEX.md` query classes name the specific nodes to load for
   the task at hand. The agent loads only the class that matches.
5. On demand: the long tail (concepts, decisions, playbooks, archive, support) reached by
   edge or by the router, one hop away, only when the task needs it.

Rule LOAD-3: canon is the first content loaded, the `INDEX.md` is the first navigation
read. Both come before the long tail. An agent that dumps a whole namespace into context
instead of following this order is retrieving wrong, not retrieving thoroughly.

Rule LOAD-4: a namespace with `canon_posture: none` (for example `personal-operator`) has
no canon step. The agent loads `INDEX.md`, then the relevant files directly. The `INDEX.md`
of such a namespace says it carries a reduced base.

## Right fragments for the task (locked)

Rule LOAD-5: load the minimal sufficient set, not the maximal available set. The goal is
the few fragments that let the agent reason correctly, in a sensible order, with the rest
one hop away. Filling a context window with loosely relevant material dilutes attention,
raises cost, and buries the load-bearing fact among near-duplicates.

Rule LOAD-6: the query class drives the fragment selection. The `INDEX.md` `Query classes`
section maps a common query type to the specific files that answer it. The agent matches
the task to a query class, loads that class, and stops. It does not pre-load every class.

Rule LOAD-7: deep archives and full provenance are reached on demand. They live in
`archive/` and `support/` and are loaded only when the task needs the raw source or the
migration trail, never as part of the default canon-first load.

Rule LOAD-7A: session transcripts under `sessions/logs/` are also on-demand provenance, not
default context. An agent should load the session record or closeout review first and open
the raw log only for audit, debugging, handoff recovery, or exact-history questions.

## How INDEX.md and canon/agent-load-order drive loading

Rule LOAD-8: the namespace `INDEX.md` is the operative load surface. Its `Load first`
section names canon entry points and the top three to five files for the namespace, each
with a one-line reason. Its `Query classes` section maps query types to files. These two
sections are what an agent reads to decide what to load. The `INDEX.md` schema is governed
by `_system/namespace-index-schema.md`.

Rule LOAD-9: `canon/agent-load-order.md` is the canon-internal load guide. It states the
order to read canon files for the namespace and why. It is navigational and exempt from
node-frontmatter checks. `INDEX.md` points to it; the agent uses both: `INDEX.md` to
orient across the whole namespace, `agent-load-order.md` to sequence the canon read.

Rule LOAD-10: when the load order in `INDEX.md` and `canon/agent-load-order.md` disagree,
`INDEX.md` is the namespace operating brief and wins for cross-namespace orientation;
`agent-load-order.md` wins for the canon-internal sequence. They should not disagree; if
they do, the curator reconciles them in the next health review.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- a serious namespace has an `INDEX.md` and a `canon/` directory (required base surface)
- a `canon_posture: full` namespace has `canon/README.md`, `canon/core-doctrine.md`, and
  `canon/agent-load-order.md`
- links named in the load surface resolve (broken relative links and `[[wikilinks]]` are
  errors)

Fuzzy (curator agent, not validate.sh):

- whether the `Load first` list actually contains the highest-signal files
- whether the query classes map to the right fragments for real tasks
- whether the load order in `INDEX.md` and `agent-load-order.md` agree in spirit
- whether canon is small enough relative to the graph to be loaded first cheaply

## Relationship to the public export

Rule LOAD-11: this policy governs internal retrieval by trusted file-reading agents. It
does not govern the public export surface. `INDEX.md` is the rich internal router;
`llms.txt` is a thin public summary generated from canon for external discovery. The two
are different artifacts (contract Part 10) governed by the public LLM index policy.

## Notes

The why lives in [[retrieval-over-raw-memory]]: memory is raw material, retrieval is the
operating layer, the right fragments beat a big context. This file owns the load sequence,
the minimal-sufficient-set rule, and the named consumer. When an MCP or RAG retriever is
introduced, update Rule LOAD-1 to name it and re-derive the load order for that reader.
