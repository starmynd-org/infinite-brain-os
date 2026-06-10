---
id: "skill-recommend-architecture"
aliases: ["skill-recommend-architecture", "recommend-architecture"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Map a business map onto the OS ontology and produce a bounded, prioritized recommendation set: knowledge namespaces to research, departments to create, workflows to build, each justified by the person's own words, plus an explicit do-not-build-yet list."
confidence: 0.8
retrieval_class: "domain"
export_class: "public"
description: "Use this skill after interview-business has produced a business map: translate the business onto namespaces, departments, and workflows with rationale, effort, and priority, under the bounded ceiling. Invoked by /onboard-business; feeds the onboarding workflow."
edges:
  - target: "[[skill-interview-business]]"
    relation: "paired_with"
    confidence: 0.95
  - target: "[[cmd-onboard-business]]"
    relation: "used_by"
    confidence: 0.9
  - target: "[[workflow-onboard-business-architecture]]"
    relation: "used_by"
    confidence: 0.9
  - target: "[[skill-shape-ai-work]]"
    relation: "references"
    confidence: 0.85
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[skill-build-namespace]]"
    relation: "references"
    confidence: 0.8
  - target: "[[skill-build-department]]"
    relation: "references"
    confidence: 0.8
  - target: "[[skill-build-workflow]]"
    relation: "references"
    confidence: 0.8
created: "2026-06-10"
---

# recommend-architecture

Use this skill to turn a confirmed business map into an architecture recommendation set.
This is the judgment layer of onboarding: it decides what the OS should hold for this
business, in what order, and, just as deliberately, what it should not build yet.

## Use when

- a business map exists (fresh from [[skill-interview-business]] or current from a prior
  run) and the person needs to know what to build
- a re-run: the business evolved and the recommendation set should cover only the delta

## Do not use when

- no business map exists; interview first
- the person has already decided exactly what to build; route to the matching builder
  skill directly

## Input

The business map at `intake/processed/<date>-business-map.md`. On a re-run, also load the
current architecture inventory: `_system/namespaces/INDEX.md`, the `departments/` folder,
and `workflows/`. Recommend only what the existing architecture does not already cover,
and say which existing pieces already serve which needs.

## The three recommendation shapes

Every recommendation is exactly one of these. Each carries: **why** (the interview facts
that triggered it, quoting the person's own words), a **value statement** (what gets
better and for whom), an **effort class** (small, medium, large), and a **priority rank**
across the whole set.

1. **KNOWLEDGE NAMESPACE to research and add.** For a domain the business reasons about
   repeatedly: products, customers, suppliers, a craft, a market. Include the 5 to 10
   research questions that would fill it, and which `knowledge/_examples/` profile it
   should follow (doctrine, tool-contract, data-system, design-system, component-library,
   content-strategy, or operating-library; intake-fabric is a root layer, never a
   recommendation).
2. **DEPARTMENT to create.** For a whole business function that should run AI-first with
   the person as the thin human layer. Built from `departments/_template/`. Include its
   owned namespaces, the head agent shape (what it routes, what it escalates), and the
   first three OPERATIONS register tasks with triggers per
   `entities/rules/trigger-taxonomy.md`.
3. **WORKFLOW to build.** For one recurring loop with stable steps. Include the loop it
   automates, its trigger, and its output target.

## Judgment rules

- **Anchor every item in the map.** A recommendation that cannot quote the interview does
  not ship. The trigger facts are the rationale, not decoration.
- **Apply the [[skill-shape-ai-work]] ladder.** Durable understanding wants a namespace;
  a repeated loop wants a workflow; a whole function with intake, knowledge, and recurring
  execution wants a department. The smallest valid shape wins.
- **Departments are earned, not default.** Recommend a department only when the map shows
  a real function with recurring intake, its own knowledge needs, and work the person
  wants off their plate. A function that is too small or too vague gets a namespace or a
  workflow now and a department later. Fit test per [[skill-build-department]].
- **Workflows need stable loops.** If the steps are still improvised every time, the loop
  is not ready to encode; park it. Fit test per [[skill-build-workflow]].
- **Architecture follows real recurring need.** The doctrine's failure mode is structure
  built ahead of demand. When in doubt, park it.
- **A department absorbs its own knowledge.** A namespace that a recommended department
  would own belongs inside the department item as its owned knowledge, never as a
  separate namespace recommendation. Recommending it twice inflates the set and splits
  the acceptance decision.
- **Name cross-item dependencies.** When one recommended item reads another (a workflow
  reading a namespace's reorder points), say so on the item; the launch order the
  workflow hands over is derived from these plus the priorities.
- **Use the founder's own ranking.** When the interview captured their
  which-moves-the-business-most ranking, the priority order starts from it and departs
  only with a stated reason.

## The bounded ceiling

Per run: at most **one department, three namespaces, three workflows**. Everything else
that surfaced goes to an explicit `## Later` list with one line each on what would promote
it. A brain that recommends everything recommends nothing; the ceiling forces the ranking
to mean something.

## Anti-recommendation discipline

The set must include a non-empty `## Do not build yet` list: things the interview made
tempting that should explicitly not be built now, each with the reason (no recurring need
yet, steps not stable, function too thin, data not owned, person not ready to delegate).
This list is a deliverable, not an afterthought.

## Optional tooling note (outside the ceiling)

The OS has three optional local surfaces: Obsidian (reading and graph browsing), n8n
(deterministic workflow runtime), and Paperclip (runtime cockpit for departments). They
are surfaces, not architecture, so they never count against the ceiling and never appear
as ranked recommendations. Include a short `## Optional tooling` section only when the
business map carries a matching signal, and cap it at the signals found:

- a visual-browsing or see-the-whole-thing signal: suggest Obsidian
- a fully stabilized deterministic loop already running on a clock: suggest n8n,
  explicitly second-stage (agent-run Markdown comes first)
- a recommended department plus live coordination pain across in-flight work: mention
  Paperclip as a later option, month-two-or-after framing

Each suggestion quotes its signal, states plainly that the system works fully without
the tool, and points to `docs/local-tooling-setup.md` for setup. No signal, no section:
omitting it is the correct default, and tooling enthusiasm from the builder is not a
signal.

## Output contract

A recommendation set document with sections in this order:

1. `## What we heard` (a three-to-five-sentence playback of the business in the person's
   own words, so they can see themselves in it)
2. `## Recommended now` (the ranked items, each in its shape with why, value, effort,
   priority)
3. `## Later` (the parked list)
4. `## Do not build yet` (non-empty, with reasons)
5. `## Optional tooling` (only when the map carries a signal; see above)
6. `## What already covers you` (re-runs only: existing architecture already serving
   needs the map surfaced)

The set is presented in-session for acceptance. The onboarding workflow records the
accepted subset and lands the document; this skill only produces it. Plain language stays
the default: introduce each system term (namespace, department, workflow) with a one-line
plain-English gloss the first time it appears.

## Quality checks

- every recommendation quotes the interview verbatim in its why
- value, effort class, and priority rank present on every item
- ceiling respected: max one department, three namespaces, three workflows
- `## Do not build yet` is non-empty and reasoned
- namespace recommendations name a profile and carry 5 to 10 research questions
- department recommendations carry owned namespaces, head agent shape, and three
  OPERATIONS tasks with valid triggers
- workflow recommendations carry loop, trigger, and output target
- a re-run recommends deltas only and credits existing coverage

## Anti-patterns

- recommending the full architecture menu instead of ranking under the ceiling
- rationales that paraphrase the system's preferences instead of quoting the person
- recommending a department because the function sounds important rather than because
  the map shows recurring intake and delegable work
- an empty or token do-not-build-yet list
- jargon without the plain-English gloss on first use
- a tooling section with no interview signal behind it, or tooling framed as required
  rather than optional
