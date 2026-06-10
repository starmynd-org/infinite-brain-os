# Playbook: Process a Repo Item

How to take one captured GitHub repository from capture through to a processed receipt. This
is the procedure for the `repos` source family.

This playbook aligns with the `ingest-repo` skill, which uses the `gh` CLI to pull repo
metadata, README, and file tree, writes a repo capture, and extracts atomic notes on
architecture and patterns. That skill is the extraction engine. This playbook frames that work
inside the intake fabric: capture as an intake record, route the signal, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After you find a repository worth understanding and want its patterns captured durably.
- When `ingest-repo` has produced a repo capture and atoms you want to route.

## Boundary

The `gh` CLI calls and any credential for private repos are connector and runtime work. This
playbook starts at a captured repo analysis and ends at a durable receipt. Source code stays in
its own repository; the intake fabric captures the analysis and approves patterns, it does not
copy the codebase in.

## Procedure

### Step 1: Capture the repo as an intake record

Write one intake record to `../sources/repos/`, shaped by `../schemas/intake-record.md`.

- `source` is `repo`. `creator` is the repo owner or org. `original_ref` is the repo URL.
- `received_at` is the capture timestamp, ISO 8601.
- Save the repo analysis (metadata, README, file tree, key-file notes) under
  `../sources/repos/raw/` and point `raw_capture` at it.
- `summary` is what the project does in one line. `why_it_matters` names the pattern worth
  stealing or the architecture worth understanding.
- Filename and `id`: `intake-repo-<date>-<slug>`, where the slug includes `org-repo`.

### Step 2: Extract the signal

Run the `ingest-repo` extraction shape: read the analysis and pull each distinct concept,
pattern, or technique as a separate claim. A claim qualifies if it is a novel architectural
pattern, a reusable technique, an interesting API design decision, a scaling or performance
strategy, a developer-experience pattern, or an agent pattern (memory, tool interface,
orchestration). Standard boilerplate and framework defaults do not qualify. Aim for five to
fifteen real claims depending on complexity; for large repos, focus on the architecturally
interesting parts, not every file.

Record the load-bearing patterns in the `## Extracted summary` section of the intake record,
with enough implementation detail to reproduce the pattern.

### Step 3: Route the item

Apply `../routing/scoring-model.md` to decide route or reject. If it clears, apply
`../routing/destination-rules.md` decision order to pick one of the five destinations. For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. Repo
items route to `ai-architecture` for agent and orchestration patterns, to a component-library
or data-system namespace when one exists, or to a project when the repo is a direct candidate
to adopt or integrate.

Write one routing decision to `../sources/repos/`, shaped by `../schemas/routing-decision.md`.

### Step 4: Do the work and write the receipt

Do the routed work, then write one processed receipt to `../processed/repos/`, shaped by
`../schemas/processed-receipt.md`. Record what came in, why it mattered, what was done, the
single `layer_changed` value, `files_touched`, what is unresolved, and links back to the source
record and routing decision. Add a pointer under `../namespaces/<ns>/processed/` when the
destination was a knowledge namespace.

## Quality checks

- The repo analysis lives in `raw_capture`; source code is referenced by link, not copied in.
- One intake record, one routing decision, one receipt, sharing the `repo-<date>-<slug>` stem.
- The receipt's links resolve and `layer_changed` matches reality.
- No live queue status in git. No em dashes, no en dashes.

## Anti-patterns

- Capturing a repo without naming the specific pattern worth keeping, leaving a description
  with no signal.
- Copying source files into the brain instead of linking to the upstream repo.
- Routing a whole repo to one namespace when its patterns belong to two (note the split in the
  receipt or write a second routing decision).
