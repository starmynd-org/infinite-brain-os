# Intake: The Root OS Intake Fabric

This folder is the root OS intake fabric. It is a root-level operating layer, not an
ordinary knowledge namespace. In the architecture it carries Profile H (Intake Fabric).
Its job is to receive inbound items from many sources, preserve source context, record
how each item was triaged and routed, and move high-signal items into a durable home in
`knowledge/`.

Intake is the convergence point for X, bookmarks, YouTube, web pages, repos, email,
Slack, ideas, and AI-guided deep research. It is where capture meets routing. It does
not own truth. The destination namespace owns the durable canon. Intake owns the trail:
what came in, why it mattered, where it went.

---

## The three-layer split

Intake spans three layers. Only the middle layer lives in this folder, in git.

1. **Connector and runtime layer (external, not in git).** OAuth, polling, token
   refresh, and live queue state. This is the operational app, for example a small
   FastAPI connector service. Connectors, secrets, and tokens never live here.
   Live queue state (unprocessed, in-review, blocked) is runtime state owned by the app,
   not tracked git files.

2. **Durable intake layer (in git, this folder).** Captured source records, processed
   receipts, routing decisions, routing doctrine, and processing playbooks. This is the
   durable history of what the intake fabric received and what it decided. It is the
   layer you can read, diff, and audit later.

3. **Knowledge layer (in git, under `knowledge/`).** The distilled doctrine, decisions,
   playbooks, and receipts produced from intake. When an item earns a permanent home, it
   is promoted into a knowledge namespace. The namespace owns it from then on. Intake
   keeps only a processed receipt and a per-destination trail pointer.

The boundary that matters most: **live queues are not in git.** This folder holds the
durable record, not the working queue. There is no `unprocessed/`, `in-review/`, or
`blocked/` folder tracked here. Those are runtime state in the operational app.

---

## Folder map

```text
intake/
  README.md                  # this file
  intake-stub-example.md     # a worked low-confidence stub (manual Tier 1 capture)
  sources/                   # source-aware capture, one folder per source family
    x/ youtube/ web/ repos/ email/ slack/ ideas/ ai-research/
  processed/                 # processed receipts, mirror of the source families
    x/ youtube/ web/ repos/ email/ slack/ ideas/ ai-research/
  routing/                   # routing doctrine (canonical, small)
    destination-rules.md           # how to decide where an item goes (the decision order)
    scoring-model.md               # the triage scoring model and thresholds
    department-routing-map.md      # the owning department lane for a worth-routing item
    namespace-routing-map.md       # source and content signals to likely namespaces
    ambiguity-and-overlap-rules.md # tie-breaks when two department lanes both fit
    residue-and-review-posture.md  # residue classes, the review loop, and when a route closes
  playbooks/                 # how to process each source family
  destinations/              # per-destination processed trails (keyed by namespace slug)
    <namespace>/processed/
    infinite-brain-ops/
      opportunities/         # PKM-opportunity handoff artifacts
      processed/             # pointer trail for PKM dispositions
  schemas/                   # the record contracts
    intake-record.md           # one captured item
    routing-decision.md        # the routing call for an item
    processed-receipt.md       # what was done and what changed
    pkm-opportunity.md         # handoff from intake-operations to infinite-brain-ops
```

---

## How an item flows

An item moves through five steps. The first happens in the runtime app or by hand. The
rest happen in git, in this folder, then into a namespace.

1. **Capture.** The item lands as a captured record under `sources/<family>/`, shaped by
   `schemas/intake-record.md`. It records the source platform, the creator or sender, the
   original URL or message id, the ingest timestamp, where the raw capture lives, an
   extracted summary, and why it matters.

2. **Route.** Triage scores the item using `routing/scoring-model.md`, picks candidate
   destinations using `routing/namespace-routing-map.md`, and applies the decision
   criteria in `routing/destination-rules.md`. The call is recorded as a routing decision
   shaped by `schemas/routing-decision.md`.

3. **Work it.** The chosen destination receives the distilled content: a new or updated
   knowledge node, a project task, a workflow input, or an action. Raw archives stay
   archived. Intake never owns the durable truth that results.

4. **Receipt.** A processed receipt is written under `processed/<family>/`, shaped by
   `schemas/processed-receipt.md`. It records what came in, why it mattered, what was
   done, whether it changed archive, support, synthesis, canon, or nothing, which files
   were created or updated, what remains unresolved, and a link back to the source record.

5. **Promote.** When the item earns a durable home, it is promoted into a knowledge
   namespace. A pointer is added to that namespace's `destinations/<ns>/processed/` trail so
   the per-destination history is auditable from inside intake.

For structurally important items, there may be an extra stewardship hop:

```text
source record -> processed receipt -> PKM opportunity -> disposition -> files changed or task created
```

That handoff belongs to `intake-operations` and `infinite-brain-ops`, not to the destination
namespace alone.

Promotion path across the wider system: raw source (archive or intake) to support
(provenance recorded) to synthesis (derived reading) to canon-candidate to canon
(operator-approved). Intake feeds the first hop. See `_system/promotion-path-rules.md`.

---

## Schemas and playbooks

- **Record contracts** live in `schemas/`: `intake-record.md` (one captured item),
  `routing-decision.md` (the routing call), `processed-receipt.md` (what was done), and
  `pkm-opportunity.md` (what intake-operations recommends to infinite-brain-ops). These are
  the operative contracts. `_system/namespace-intake-rules.md` governs how namespaces
  consume them.
- **Processing playbooks** live in `playbooks/`: one per source family, covering how to
  extract, summarize, score, and route an item of that kind.
- **Routing doctrine** lives in `routing/`: the small, canonical set of rules for deciding
  where an item goes. Start with `routing/destination-rules.md`.

Why intake is a root layer, rather than a knowledge namespace, is explained in
`knowledge/ai-architecture/concepts/intake-fabric-namespace.md`.

---

## What this folder is not

- Not a live queue. Unprocessed, in-review, and blocked items are runtime state in the
  operational app, not tracked git files here.
- Not a connector store. OAuth, polling, token refresh, and secrets stay in the app layer.
- Not a knowledge store. Durable knowledge lives in `knowledge/` namespaces. Intake holds
  capture records, routing decisions, and processed receipts, then points at the namespace
  that took ownership.
- Not a source of truth for numbers. Metrics and live data live in the data layer. Use a
  Data pointer node in the destination namespace.

This is a navigational document. It carries no node frontmatter.
