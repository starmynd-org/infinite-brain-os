# Surface Declaration: <surface name>

surface_id: "<surface-slug>"
class: "<S1 | S2 | S3 | S4 | S5, or a composite list>"
department: "<owning department slug, linked from its INDEX.md>"
status: "<planned | live | deprecated>"

Governed by `_system/surface-contract-rules.md`. Fill in all nine items. The validator checks
that every item header below is present in a live declaration.

## 1. Truth sources read

Which repos, namespaces, and canon files this surface reads, and whether each read is read-only
or for proposal. Default read-only.

## 2. Owned runtime state

The explicit runtime-plane state this surface owns. Operational substrate only, never git canon.

## 3. Disallowed ownership

What this surface must never become the only home of. Always includes approved knowledge and
canonical semantics.

## 4. Write paths

Each write typed: read-only projection, runtime-state write, draft write, or promotion event.

## 5. Promotion and approval gates

Which writes need a visible promotion event, which need a human gate, and which approval receipt
applies.

## 6. Identity and auth boundary

Which identity the surface and its embedded agent runtime act under, scoped to least privilege.
Credentials by reference per the secret-reference model.

## 7. Agent runtime binding

Which harness serves the chat and write path (Claude Code, Codex, or Agent SDK), plus a
portability statement.

## 8. Observability and metering

How this surface exposes session identifiers, usage data, cost data, and failure telemetry; what
the source of truth is for usage capture; and how the receipt lands in `sessions/` closeout.

## 9. Self-host posture

Where the surface runs, what it depends on, and whether the operator can run it standalone from a
clone of the repo, a render app, and an agent process.
