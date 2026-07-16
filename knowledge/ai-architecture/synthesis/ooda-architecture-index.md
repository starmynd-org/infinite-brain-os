---
id: "synthesis-ooda-architecture-index"
aliases: ["synthesis-ooda-architecture-index", "ooda-architecture-index", "ooda-infinite-brain-index"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Navigational index for the OODA-meets-Infinite-Brain body of work shipped in this starter. One entry point that routes an agent by query class across the canonical bridge, the feedback-plane spec, the wager-ledger decision and contract, and the visual explainer."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
edges:
  - target: "[[synthesis-boyd-to-agent-architecture-ooda-map]]"
    relation: "routes_to"
    confidence: 0.9
  - target: "[[knowledge-ai-architecture-synthesis-feedback-plane-act-to-orient-loop]]"
    relation: "routes_to"
    confidence: 0.9
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "routes_to"
    confidence: 0.88
created: "2026-06-18"
---

## What this index is

This is the single retrieval entry point for the work that connects John Boyd's OODA loop
to the Infinite Brain architecture. Load this first when the question is "how does the
brain relate to OODA," "where is the OODA bridge," or "what is the feedback-plane gap." It
is a router, not the content. Each item below names its path, its one-line purpose, and its
node id for grep.

## The thesis in three lines

1. Boyd's real OODA is a feedback web where Orient dominates and action usually flows
   straight from orientation, not the four-box cycle most people teach.
2. The Infinite Brain is, at its core, an externalized-orientation engine, which makes it
   more Boyd-faithful in its build than in how the loop is usually described.
3. The highest-leverage next build is the Act-to-Orient feedback plane: the missing half of
   the web, and the one build that closes all three weak points of Boyd's own diagnostic
   test.

## Query-class routing

- **"Show me the mapping" (the canonical answer):** read
  `knowledge/ai-architecture/synthesis/boyd-to-agent-architecture-ooda-map.md` (id
  `synthesis-boyd-to-agent-architecture-ooda-map`, lifecycle research). The
  component-to-concept table, the two-circuit model, the diagnostic-test score, and the
  corrected framing all live here.
- **"What is the missing half / what do we build next":** read
  `knowledge/ai-architecture/synthesis/feedback-plane-act-to-orient-loop.md` (id
  `knowledge-ai-architecture-synthesis-feedback-plane-act-to-orient-loop`, lifecycle
  research). The Act-to-Orient feedback-plane spec.
- **"How would the feedback loop actually be built":** read the decision
  `knowledge/ai-architecture/decisions/wager-ledger-and-scientific-loop.md` (id
  `decision-ai-architecture-wager-ledger-and-scientific-loop`): the wager ledger, the four
  scientific constraints, and the bookkeeping-layer-for-AI-harnesses thesis. The operative
  contract is `_system/wager-ledger-rules.md`. Both are ratified design, not a running
  system: nothing in this starter books wagers yet.
- **"Show me the picture":** open `docs/ooda-infinite-brain-map.html` from a `file://`
  URL. Two interactive SVG flowcharts (Boyd's real OODA web, then the same topology mapped
  onto the brain's components) plus the diagnostic scorecard and the wager-ledger section.
  The pointer doc is `docs/ooda-infinite-brain-map.md`.
- **"How does a department run inside this loop":** read
  `knowledge/ai-architecture/playbooks/department-operating-guide.md` (the day-to-day
  operating guide) and `knowledge/ai-architecture/playbooks/department-onboarding-guide.md`
  (how a new department wires itself in).
- **"What changed in canon":** the orientation lens is in canon at
  `knowledge/ai-architecture/canon/core-doctrine.md` sections 14 and 15.2, the doctrine
  card, and `department-model.md` section 11. Boyd is a complement on orientation and
  adaptation, not the control model of record.
- **"Give me Boyd himself":** the Boyd corpus is not shipped in this starter. Build your
  own thinker namespace for it (see `entities/skills/build-namespace.md`); the primary
  source is Boyd's 1995 "The Essence of Winning and Losing" sketch and the discourse
  briefings.

## The diagnostic test (use it on any new claim)

From Boyd's three meta-primitives. A claimed Boydian application must pass all three or it
has missed Boyd:

1. **Orientation dominates** (not four equal boxes). Brain score: pass in build, weak in
   framing.
2. **Interaction and isolation** across moral, mental, physical (not one dimension). Brain
   score: weak, the unowned feedback plane and no outside-world model.
3. **Novelty drives survival** (not one correct orientation). Brain score: partial,
   correction-to-structure is operator-driven.

## Provenance and status

Authored 2026-06-18 in the deployment this starter derives from; the orientation lens was
promoted into canon there through an operator-approved canonization on 2026-06-19. The
wager ledger is an operator-ratified decision with an operative contract
(`_system/wager-ledger-rules.md`), decided but not yet built. Canon is never self-approved.
