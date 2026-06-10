# Routing: Department Routing Map

Maps each live operating department to the intake it owns, the namespaces and surfaces it routes
into, and what it explicitly does not own. This is the lane layer of routing. Apply it after
`scoring-model.md` says an item is worth routing and after `destination-rules.md` has picked a
destination type. The lane (which department owns the work) is orthogonal to the destination type
(knowledge, project, workflow, action-queue, rejection): the type says what kind of artifact the
item becomes, the lane says which department owns that artifact and reviews its residue.

The order is: score the item, pick the destination type, pick the owning department here, then pick
the exact namespace inside that department with `namespace-routing-map.md`. When two lanes both
look right, resolve with `ambiguity-and-overlap-rules.md`.

Intake never routes straight into a namespace by reflex. Namespaces are owned by departments, and
routing targets the department set explicitly: the lane that owns the durable outcome answers for
the routed artifact later.

## The department set

The starter ships `departments/_template/` and one example department. The table carries one row
until you assemble your own departments; add a row per department as you stand them up, copying the
column discipline below. Route every worth-routing item to exactly one lane and cross-link the rest
in the routing decision.

| Department | Owns (namespaces and surfaces) | Route here when the item is about | Does not own (route elsewhere) |
|---|---|---|---|
| the example department (see `departments/`) | the namespaces and surfaces its `INDEX.md` declares | items inside the charter its `INDEX.md` states | everything outside that charter; flag a candidate lane instead of force-fitting |

When you add a department: declare its owned namespaces and surfaces in its `INDEX.md`, add a row
here with the three boundary columns filled, and extend `namespace-routing-map.md` for any
namespaces it brings.

## System and stewardship lanes

These lanes are not product departments but are first-class routing and handoff destinations in
every deployment.

| Lane | Role | Route here when the item is | Mechanism |
|---|---|---|---|
| `intake-operations` | owns the intake fabric itself | routing doctrine, receipts, source-family playbooks, scoring or destination-map changes | edit the durable `intake/` trail directly |
| system stewardship | structural stewardship of the OS | a likely canon candidate, a namespace-structure implication, a new tool, workflow, or department implication, or a refined project-task recommendation born from intake | record the opportunity alongside the normal receipt and review it on the operator's cadence |
| the operator | the human decision channel | any human-bound item: a decision, approval, blocker, or assumption needing sign-off | escalate per the surfacing rules; never route human-bound work straight into a namespace |

## Cross-link, never dual-own

A worth-routing item lands in one lane. When it materially touches a second lane, record the second
as a cross-link in the routing decision (`candidate_destinations` with a note), do not write the
node into two namespaces. Genuinely cross-namespace synthesis belongs in the root `synthesis/`
layer, not duplicated. When no lane fits and the item recurs, flag a candidate new namespace or
department in the routing decision rather than force-fitting. Do not stand up a lane from a single
item.
