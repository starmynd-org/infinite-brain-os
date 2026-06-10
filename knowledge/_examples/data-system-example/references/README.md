# references/

This folder holds external reference nodes. A reference node points to upstream
documentation, API references, vendor data dictionaries, or external standards that
this namespace relies on but does not own.

## What goes here

One `.md` file per external reference. Minimum content:

- Title and URL or location of the external document.
- Why this namespace depends on it.
- The sections or fields that are most relevant.
- A freshness note: when was this last checked against the live document.

## What does not go here

Do not put internal namespace nodes here. References is for external sources only.
Internal reasoning goes in `concepts/` (in a doctrine namespace) or directly in the
node that needs it. Provenance and migration receipts go in `support/`.

## Typical use

You would add a reference node when the source API publishes documentation that defines
field semantics, when an external data dictionary specifies valid enum values, or when
a vendor provides a data model diagram that your source contract node depends on.

In a starter Data System, references may also hold the instrumentation contract for what
`live`, `manual`, and `not-wired` mean so departments do not invent their own statuses.
