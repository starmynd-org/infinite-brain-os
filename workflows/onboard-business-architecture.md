---
id: "workflow-onboard-business-architecture"
aliases: ["workflow-onboard-business-architecture", "onboard-business-architecture"]
type: "Workflow"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "End-to-end onboarding pipeline: interview, business map, bounded recommendation set, acceptance, then one scoped project plus one generated launchable swarm sprint per accepted recommendation. Scopes and scaffolds only; the generated sprints do the building."
confidence: 0.8
retrieval_class: "domain"
export_class: "public"
runtime: "agentic"
edges:
  - target: "[[cmd-onboard-business]]"
    relation: "used_by"
    confidence: 0.95
  - target: "[[skill-interview-business]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[skill-recommend-architecture]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[skill-build-project-and-task]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-build-swarm-sprint]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-build-namespace]]"
    relation: "references"
    confidence: 0.8
  - target: "[[skill-build-knowledge-base]]"
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

# Workflow: Onboard Business Architecture

The full loop behind `/onboard-business`: a person sits down, the brain interviews them,
recommends what to build, and turns accepted recommendations into scoped projects with
launchable swarm sprints. This workflow scopes and scaffolds; it never builds the
architecture itself. The generated sprints carry that work, executed by the builder
skills, in new terminals, after a human launches them.

## Trigger

Invoked by [[cmd-onboard-business]], first run or re-run.

## Inputs and preconditions

- a willing interviewee (founder or operator)
- repo with the standard scaffold: `projects/_template/PLAN.md`,
  `departments/_template/`, `knowledge/_examples/`, `_system/swarm-sprint-rules.md`
- on a re-run: the prior business map plus the current architecture inventory

## Pipeline

### Stage 1: Interview

Run [[skill-interview-business]]. Output: the business map at
`intake/processed/<date>-business-map.md`, confirmed phase by phase.

### Stage 2: Recommend

Run [[skill-recommend-architecture]] against the map (and, on a re-run, the architecture
inventory). Output: the bounded recommendation set (max one department, three namespaces,
three workflows, plus Later and Do-not-build-yet lists), every item quoting the
interview, plus the optional tooling note (Obsidian, n8n, Paperclip) only when the map
carries a matching signal; tooling suggestions sit outside the ceiling, are framed as
optional, and point to `docs/local-tooling-setup.md`.

### Stage 3: Accept (human gate)

Present the set. The person accepts a subset, item by item. Record the acceptance
decisions verbatim. Nothing below this line runs for an item that was not explicitly
accepted. Declined items move to the Later list with the person's reason.

### Stage 4: Scope one project per accepted item

For each accepted item, per [[skill-build-project-and-task]] and
`projects/_template/PLAN.md`, create `projects/<slug>/PLAN.md`:

- goal, why-now, scope, and success criteria written from the business map, quoting it
- `## Tasks` with explicit `depends_on` and `blocks` between tasks; research or
  prerequisite tasks first, then one anchor task per generated sprint with
  `mode: swarm`, `status: proposed`, and `anchored_sprint` pointing at the sprint folder
  generated in stage 5
- frontmatter per the template; `owner_department: none` until a department exists to own
  the work, then the new department's slug

Slug convention: `<business-slug>-<item-slug>` (for example `acme-candles-suppliers-namespace`).

### Stage 5: Generate one launchable sprint per accepted item

For each accepted item, per [[skill-build-swarm-sprint]] and
`_system/swarm-sprint-rules.md`, generate `swarms/Sprints/<YYYY-MM-DD>-<slug>/` with the
full required package, structurally identical to a hand-scoped house sprint:

- `README.md` with frontmatter: `sprint_id`, `sprint_status: "ready"`,
  `execution_mode: "swarm"`, `parent_task: "<project-slug>#<anchor-task-id>"`,
  `linked_project`, `owning_department` (the new department's slug when the item is a
  department, otherwise `none`), `approval_receipt` path, additive `cross_refs` to the
  business map and the namespaces or departments the sprint touches
- `00-sprint-charter.md`: mission, deliverables, quality bar, boundaries; the mission
  quotes the interview facts that justified the item so the executing agent knows why it
  exists
- `01-master-plan.md`: waves. Wave 1 is always the repo's forced startup plus reading the
  business map and this item's rationale. The build waves instruct the executing agent to
  run the matching builder skill, never restating its internals:
  - namespace item: [[skill-build-knowledge-base]] (or [[skill-build-namespace]] for a
    registry-first scaffold), seeded with the recommendation's 5 to 10 research questions
    and its declared `knowledge/_examples/` profile
  - department item: [[skill-build-department]], including the head agent, charter, and
    the three recommended OPERATIONS register tasks; the buildout-versus-activation
    project split happens inside that skill, anchored to the initial build's parent project
  - workflow item: [[skill-build-workflow]] for the recommended loop, trigger, and output
    target
  - every plan ends with a validation wave: `bash _system/validate.sh` clean,
    `bash sync-adapters.sh` when executable entities were created, receipts in `waves/`
- `02-launch-sheet.md`: the terminal launch block (cd to the repo root, written as a
  placeholder since the generator cannot know the adopter's absolute path, then start the
  agent) and a paste-prompt that names the sprint path, the wave order, the
  session-ledger duty, and the deliverables, in the same form as a house launch sheet
- `03-acceptance-gates.md`: gates derived from the item's success criteria plus the
  standing gates (entities validate clean, receipts landed, no doctrine modified)
- `APPROVAL-RECEIPT.md` in the approval-by-launch form: launching the sprint's terminal
  prompt constitutes the human launch decision; name the approver and the scope
- `SESSION-LINK.md` placeholder for the executing session to fill
- `waves/README.md` naming the expected receipts, and `waves/BLOCKERS-AND-DECISIONS.md`
  seeded empty

The workflow sets `sprint_status: "ready"` and stops. It never sets `active`, never
launches a sprint, and never runs a builder skill itself.

### Stage 6: Hand over

Tell the person, in plain language: what was created, where, and how to launch each
sprint in a new terminal (quote each launch sheet). Recommend a launch order from the
recommendation priorities and the `depends_on` chain. If the recommendation set carried
an optional tooling note, close the hand-over with one sentence pointing at
`docs/local-tooling-setup.md`; if it did not, say nothing about tooling.

### Stage 7: Run record

Leave `outputs/onboard-business-<business-slug>-<date>.md` recording: the map path, the
full recommendation set, the acceptance decisions, the projects and sprints created, and
anything parked. Like every `outputs/` artifact, the run record (and any kept interview
transcript) carries full Output frontmatter: `id`, `type: "Output"`, `namespace`,
`lifecycle_state`, `summary`, `retrieval_class: "ephemeral"`, `produced_by` lineage to
this workflow, `created`.

## Test mode (dryrun)

When this workflow runs as a test or demonstration, every generated slug carries the
`dryrun-` prefix (projects, sprints, outputs, and the business map), every generated
README carries `test_artifact: true` in frontmatter plus a first-line banner naming it an
example that must not be launched as real work, and generated sprints stay at
`sprint_status: "scoped"`.

## Completion criteria

- business map landed and confirmed
- recommendation set bounded, quoted, with a non-empty do-not-build-yet list
- one project plus one generated sprint per accepted item, none for declined items
- every generated sprint passes the launch gate shape: resolvable singular `parent_task`
  with `mode: swarm`, file-backed approval receipt, full required file set
- `bash _system/validate.sh` clean after generation
- run record in `outputs/`

## Human approvals in this workflow

Two, both explicit: stage 3 acceptance (nothing scoped without it) and the per-sprint
launch (the approval-by-launch receipt; the workflow never launches). Everything else is
scaffolding with no external effect.
