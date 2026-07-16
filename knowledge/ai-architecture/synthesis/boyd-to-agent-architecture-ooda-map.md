---
id: "synthesis-boyd-to-agent-architecture-ooda-map"
aliases: ["synthesis-boyd-to-agent-architecture-ooda-map", "boyd-to-agent-architecture-ooda-map", "boyd-ooda-agent-map"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Cross-namespace bridge mapping Boyd's real OODA web onto the Infinite Brain's agent architecture. The brain is an externalized-orientation engine, not a four-box pipeline: intake scoring is the Orient-to-Observe arrow, the knowledge graph plus canon plus fat skills are the standing Orient, the priority model is a deliberately thin Decide, workflows and learned auto-handle rules are the Orient-to-Act implicit-guidance pathway, and the planning ladder is the explicit novelty circuit. Run through Boyd's three-meta-primitive diagnostic test the architecture passes orientation-dominance, is weak on interaction-isolation (the unowned feedback plane), and is partial on novelty (correction-to-structure is operator-driven)."
confidence: 0.86
retrieval_class: "domain"
export_class: "public"
edges:
  - target: "[[knowledge-ai-architecture-canon-core-doctrine]]"
    relation: "supports"
    confidence: 0.9
  - target: "[[infinite-brain-control-model]]"
    relation: "supports"
    confidence: 0.88
  - target: "[[retrieval-over-raw-memory]]"
    relation: "supports"
    confidence: 0.87
  - target: "[[planning-to-execution-ladder]]"
    relation: "supports"
    confidence: 0.86
  - target: "[[feedback-plane-act-to-orient-loop]]"
    relation: "supports"
    confidence: 0.88
created: "2026-06-17"
---

## What this bridge is

This is the cross-namespace bridge that owns "how Boyd's OODA maps onto thin-harness,
fat-skills agent architecture" in this repo. It reconciles John Boyd's OODA doctrine with
the brain's control model. It is a synthesis node, not canon: it maps and reconciles, it
does not replace settled doctrine, and canon is never self-approved. The Boyd corpus itself
is not shipped in this starter; the bridge summarizes the load-bearing claims it uses, and
any serious deployment should read Boyd (the 1995 "The Essence of Winning and Losing"
sketch in particular) directly.

## The thesis: the brain is an externalized-orientation engine

The most Boyd-faithful fact about the Infinite Brain is structural, not procedural. In
Boyd's mature doctrine, orientation is the generative center that sets the quality of
everything downstream, and the whole point of strategy is to build better orientation, not
to cycle faster. The brain's defining investments are all orientation infrastructure:
[[retrieval-over-raw-memory]], the namespace knowledge graph, the canon and synthesis
layers, the doctrine card, and durable fat skills. The system's leverage is the quality of
the model an agent reasons from before it decides or acts.

The corollary is the common failure to avoid. The four-box clockwise cycle (observe, then
orient, then decide, then act, win by going faster) is the single most damaging misread of
Boyd. Describing the brain as "intake equals Observe, departments equal Observe-Decide,
backlog equals Act, executed in order" is exactly that cartoon, and it inverts the system's
own strength by demoting the box that should dominate. The architecture is more faithful
than the linear description of it. The corrected mapping below restores the web.

## Component-to-concept map (the real web, not the cartoon)

| Brain component | OODA web element | Note |
|---|---|---|
| Intake capture (X, YouTube, web, email, Slack) | Observe (raw environmental intake) | Boyd's three input streams: unfolding circumstances, outside information, unfolding interaction. The brain has the first two; the third (the outside world's moves) is barely modeled. |
| Intake scoring (relevance, novelty, source-trust, actionability) | Orient-to-Observe arrow, externalized | The score filters reality against the existing model. This is already orientation shaping perception, not pure Observe. |
| Department charter, INDEX, knowledge namespace, prior tasks, state ledger | Orient (the five sub-elements) | Cultural tradition equals canon and rules; previous experience equals prior tasks and memory; new information equals intake; analysis-and-synthesis equals the head's reasoning; the genetic substrate equals the harness and runtime. |
| Priority model (the weighted signal score) | Decide, deliberately thin | Correct Boyd: the D is the least important letter, so making Decide a deterministic, explainable function is the right design, not a shortcut. |
| Workflows, fat skills, learned auto-handle rules | Orient-to-Act, implicit guidance | The primary pathway and the most important arrow. Present in the architecture, deliberately throttled off at the L1 posture (learning off, nothing auto-handles). |
| Swarm-ai, sprint, project ladder | Explicit Orient-Decide-Act circuit for novelty | The destruction-and-creation circuit for work the existing repertoire cannot handle. |
| Analytical plane, correction-to-structure | Act-to-Orient feedback (double loop) | Mostly unbuilt. The missing half of the web. See [[feedback-plane-act-to-orient-loop]]. |

The load-bearing correction: **departments are where Orient lives, not Observe-Decide.**
Calling them Observe-Decide is the inversion Boyd warns against, because it treats the
dominant box as a pass-through step.

## The two circuits, and the ladder as a novelty selector

In Boyd's implicit-guidance-and-control model, two circuits must run at once: implicit
guidance deploys the existing repertoire fast (Orient-to-Act, bypassing Decide), while the
explicit decide-loop builds new repertoire slowly for genuinely novel situations. The brain
maps this cleanly:

- Implicit circuit: basic task, workflow, fat skill, learned auto-handle rule. Fast,
  repeatable, pattern-based. The earned-trust ramp (a pattern seen enough times at high
  accuracy drops to auto) is the disciplined way to widen it.
- Explicit circuit: scoper to swarm-ai to sprint to project, per
  [[planning-to-execution-ladder]]. Slow, deliberate, novelty-handling.

The improvement this surfaces: the [[planning-to-execution-ladder]] is usually chosen by
size and effort. Boyd's frame says it should be chosen by **novelty** (does the existing
repertoire cover this work, or must new orientation be built). Routing by novelty rather
than size is a small change to the scoper's logic and a more faithful selector.

## The diagnostic test applied to the architecture

Boyd's three meta-primitives give the test for any claimed Boydian application. Run the
brain through it:

1. **Orientation dominates: strong pass in the build, weak in the framing.** The
   orientation infrastructure is the system's core. The risk is design pressure toward
   "more departments, more automation, cycle faster" whenever the loop is described as a
   linear pipeline.
2. **Interaction and isolation across moral, mental, physical: the weakest axis.** The
   system has almost no interaction with its own outcomes (the analytical plane is unowned)
   and no model of the outside world's moves. A system that stops getting feedback from
   reality begins to decay. This is the single most important gap and is specced in
   [[feedback-plane-act-to-orient-loop]].
3. **Novelty and continuous re-orientation: partial.** The correction-to-structure loop is
   a real destruction-and-creation engine, but it is operator-driven: the system absorbs
   novelty handed to it and does not yet detect its own mismatch. Boyd: an orientation that
   stops updating begins dying, and right now updating is exogenous.

## Verdict and what this drives

As a single-department cell the brain is a genuine OODA loop, and an unusually strong one
because Orient is externalized and inspectable. As a full OS with OODA fully incorporated
it is not there yet, for one conceptual reason (the loop is framed and pressured as the
four-box cartoon) and one engineering reason (the feedback half of the web is unbuilt). The
highest-leverage OODA work is not more autonomy or more departments; it is the
Act-to-Orient feedback plane, because that one build closes the three weakest points of the
diagnostic test at once.

This node drives: the orientation-lens framing in `ai-architecture` canon (core-doctrine
sections 14 and 15.2) so Orient is the center rather than step two; the novelty-based
routing refinement to the [[planning-to-execution-ladder]]; the disciplined re-enabling of
the implicit auto-handle circuit; and the feedback-plane build in
[[feedback-plane-act-to-orient-loop]].

## Promotion status

This is a `synthesis` node, not canon. The orientation-lens claims it argues for were
promoted into canon (core-doctrine sections 14 and 15.2, the doctrine card, and
department-model section 11) through an operator-approved canonization in the deployment
this starter derives from. Canon is never self-approved.
