---
id: "department-template-inbox-spec"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template intake inbox spec: the department-side contract for what this department's capture inbox accepts, what each class needs, where it lands, and which operations-register trigger it fires. Copy to departments/<slug>/capture/INBOX.md."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
created: "2026-06-17"
---

# Department Intake Inbox Spec (Template)

Copy this to `departments/<slug>/capture/INBOX.md` and fill every section. This file is the
department-side half of intake. The routing map (`intake/routing/department-routing-map.md`) decides
which lane owns an item; this spec declares what the lane's inbox accepts and what happens to it. Keep
the two surfaces in agreement and cross-link them.

Derive the accepted classes from this department's "route here when the item is about" criteria in the
routing map. See `knowledge/ai-architecture/playbooks/department-operations-readiness.md` for the
convention and `entities/rules/department-web-capture.md` for how ambient capture deposits stubs.

## Accepted classes

| Class | What it is | Minimum fields on the stub | Conversion destination | Register trigger fired | Review posture |
|---|---|---|---|---|---|
| `<class-slug>` | `<one-line description>` | `<the fields a deposited stub must carry>` | `<knowledge node / SOP / n8n automation / agent architecture / Data pointer>` | `<the OPERATIONS condition: or on-call: row this fires>` | `<auto-first-pass / review-required / human-only>` |

Choose each conversion destination with
`knowledge/ai-architecture/concepts/choosing-the-right-primitive.md`.

## Where deposits land

Typed stubs land in `departments/<slug>/capture/` as one file per candidate, per
`entities/rules/department-web-capture.md`. When the owning department is genuinely unclear, deposit to
the root `intake/` fabric instead and let routing assign the lane.

## What does not belong here

Mirror the routing map's "does not own" column so a misroute is caught at the inbox and re-routed rather
than converted in the wrong lane.

- `<item type that looks close but belongs elsewhere>` route to `<correct lane>`

## Safety posture

Capture is ambient and safe; conversion and promotion are gated. Anything `external` or
`canon-touching` is captured but never auto-converted; it escalates per
`entities/rules/result-and-escalation-contract.md` and `entities/rules/surfacing-policy.md`.

## Cross-links

- routing map row: `intake/routing/department-routing-map.md`
- namespace selection inside the lane: `intake/routing/namespace-routing-map.md`
