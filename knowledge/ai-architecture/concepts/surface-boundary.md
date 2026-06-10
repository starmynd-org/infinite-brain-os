---
id: "knowledge-ai-architecture-surface-boundary"
aliases: ["knowledge-ai-architecture-surface-boundary", "ai-architecture-surface-boundary"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Definition of a surface as a thin governed adapter over canon and runtime state, decomposed into three planes (truth, runtime, render) plus an agent-runtime bridge, declaring a nine-item contract and promoting to truth only through visible typed events, never an authority in its own right."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[decision-ai-architecture-paperclip-boundary]]"
    relation: "supports"
    confidence: 0.93
  - target: "[[knowledge-ai-architecture-infinite-brain-control-model]]"
    relation: "supports"
    confidence: 0.9
  - target: "[[surface-classes]]"
    relation: "depends_on"
    confidence: 0.9
created: "2026-05-29"
---

# AI Architecture Surface Boundary

## Summary

A surface is a bounded operating layer that reads the Infinite Brain through approved
adapters and may own draft or operational state, but it may not silently redefine
canon.

## Content

A surface is a thin, bounded operating layer that lets a human or an agent see and act on the
Infinite Brain without owning its truth. It renders projections of the source of truth, lets a
user interact, and routes every durable change back through a visible promotion event. It is an
adapter, never an authority. This concept matters because useful interfaces drift into
second-source-of-truth systems unless the contract is explicit.

### The three planes plus the bridge

A surface is not one thing. It is an assembly of three planes over one truth it does not own,
plus a bridge actor that executes durable change:

- **Truth plane**: the git-backed canon. The single source of truth. Surfaces read it freely
  and write to it only through a visible promotion event. No surface owns it.
- **Runtime plane**: the operational substrate a surface legitimately owns. Session state, UI
  preferences, queue and review state, approvals-in-flight, drafts, run and telemetry state.
  Mutable and fast, authoritative about workflow position, never about meaning. Live queue
  state never enters git. This plane is not a new entity type. It is a state layer. When a
  surface needs a stable, bounded way to read, write, or serve that state, the bridge into the
  runtime plane is usually packaged as a repo-native Tool.
- **Render plane**: the thin UX. It owns nothing durable. It projects the truth and runtime
  planes into a self-hostable interface and captures user intent.
- **The agent-runtime bridge**: a Claude Code, Codex, or Agent SDK process reading the working
  tree, answering in the surface chat, drafting, and performing the gated writes back into the
  truth plane. It is a replaceable harness, not an owner.

Truth flows up into the render plane freely as read-only projection, and down into the truth
plane only through a visible promotion event executed by the agent runtime or a human. A surface
never contains operational logic: it displays, edits, or runs entities (workflows, tools,
agents) defined elsewhere in the repo. "Thin" means thin over truth and over logic; the surface
still owns its runtime state and may be visually rich.

In practice this means a rich surface may depend heavily on a bridge tool without violating the
boundary. The surface owns the interactive behavior and runtime-state intent. The tool owns the
bounded capability that exposes the runtime substrate or deterministic execution path. Dependency
does not collapse the boundary; hidden logic in the surface does.

### The nine-item declaration

A valid surface declares, before it is built or connected:

1. the truth sources it reads, and whether each read is read-only or for proposal
2. the runtime state it owns
3. its disallowed ownership (what it must never become the only home of)
4. its write paths, each typed (read-only projection, runtime-state write, draft write, or
   promotion event)
5. its promotion and approval gates (which writes need a visible event and a human gate)
6. its identity and auth boundary, scoped to least privilege
7. its agent-runtime binding and a portability statement
8. its observability and metering posture
9. its self-host posture

Items 1 to 5 are the original surface declaration; items 6 to 9 close the identity, runtime,
observability, and self-host gaps. The operative form of this declaration is
`_system/surface-contract-rules.md`.

### Allowed and disallowed ownership

Allowed surface ownership (runtime plane): session state, UI preferences, queue or review state
in the runtime substrate, drafts with a clear writeback path.

Allowed implementation pattern: a repo-local runtime substrate plus a bridge Tool that exposes
bounded operations over it to the surface. The substrate is still runtime-plane state, not tool
truth.

Not allowed: becoming the only durable home of approved knowledge, hiding canonical semantics in
a private runtime schema, or mutating canon without a visible promotion event.

### The promotion taxonomy

The only legal bridge from the runtime plane to the truth plane is a visible, typed event
recorded in git, executed by the agent runtime or a human. Six types: read-only (no promotion);
runtime-state write (stays runtime); draft to canon-candidate to canon (operator-gated commit or
PR); run to memory (reviewed lesson); intake capture to node (the intake three-layer path); and
closeout to distilled planning truth (session and swarm closeout). An invisible substrate write
that becomes authoritative meaning is never a promotion; it is a second source of truth.

The surface classes that apply this boundary, and their per-class contracts, are in
[[surface-classes]].

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- `docs/runtime-format-contract.md`

## Edges

- `supports` the Paperclip boundary decision by defining the general surface rule
  first.
- `supports` the control-model pillar because the adapter posture is one of its core
  constraints.
- `depends_on` [[surface-classes]], which carries the five-class taxonomy and the
  per-class read, ownership, writeback, and gate contracts that apply this boundary.

## Notes

This node intentionally treats Paperclip, Obsidian, n8n, and similar tools as
instances of the same class rather than isolated exceptions. The three-plane refinement,
the nine-item declaration, and the promotion taxonomy were added in the
2026-05-31 surface-architecture-refinement sprint and remain research-state pending the
operator approval recorded in that sprint. The surface classes are held provisional in
[[surface-classes]] until a first real surface validates them. The CRM parity-closure sprint added
one clarification to the model: the runtime plane remains a plane, while a runtime bridge is often
best realized as a bounded repo-native Tool rather than buried in a surface or promoted into a new
primitive type.
