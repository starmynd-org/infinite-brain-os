# Secret Registry Rules

This file is the operative contract for the root secret-reference registry.

Doctrine lives in:

- `knowledge/ai-architecture/playbooks/secret-reference-model.md`
- `knowledge/ai-architecture/concepts/surface-boundary.md`
- `knowledge/ai-architecture/concepts/deterministic-workflow-boundary.md`

## Purpose

Use this rule file to answer:

- where durable secret references live
- what may be stored in git about a secret
- how tools, surfaces, workflows, and namespaces point at credentials safely
- what ownership belongs to `devops-platform` versus domain departments
- how client, brand, and tool scope attach without turning namespaces into secret stores

## Canonical home

Durable secret references live at:

```text
secrets/
```

Minimum root shape:

```text
secrets/
  README.md
  _template.md
  <secret-id>.md
```

This registry is for references and policy metadata only. Secret values, tokens, certificates,
live refresh state, OAuth artifacts, and session copies do not belong here.

## Core rule

The repo stores references, policy, and scope. Trusted runtime binds values at the point of use.

The baseline execution sequence is:

1. a tool, surface, deterministic workflow, or runtime process names one or more `secret_ref.id`
2. runtime checks whether the current identity and execution context are allowed to resolve it
3. runtime retrieves the value from the configured backend
4. executor receives the value through the approved exposure mode
5. the model sees at most the reference id, policy metadata, and redacted results

## Ownership

Shared platform credentials default to `devops-platform` ownership.

A domain department may own a secret reference only when all of the following are true:

- the credential is materially department-local
- the runtime scope is not shared substrate
- ownership would be more misleading if centralized

Even then, the durable entry still lives in the root `secrets/` registry unless a later contract
introduces a better root-layer split.

## Allowed callers

The following durable surfaces may point at `secret_ref.id` values:

- tool registry entries in `tools/`
- surface declarations under `_system/surface-registry/`
- deterministic workflow companion markdown nodes
- department assembly notes
- project or sprint artifacts when approval or execution context requires explicit credential scope

Knowledge namespaces may mention credential dependencies in prose, but they should normally point
at the tool or surface that binds the secret rather than acting as the primary credential record.
This matters especially for future design-system or brand namespaces: a namespace may describe a
protected design library, email-platform account, or asset store, but the credential reference should
resolve through the runtime surface or tool that uses it.

## Scope attachment

Every durable secret reference should carry:

- a required `owner_department`
- at least one concrete consumer anchor through `allowed_tools`, `allowed_surfaces`,
  `allowed_workflows`, or `consumer_departments`

Optional scope overlays may also be used:

- `scope_class` for blast-radius posture
- `party_slugs` for broad party attachment across partner, vendor, client, or brand scope
- `client_slug` and `brand_slug` for stable scope keys
- `client_namespace` and `brand_namespace` only when real namespaces exist
- `consumer_systems` when the external system is known but a root `tools/` entry does not exist yet

Do not create a namespace solely to satisfy secret classification. Use stable party, client, and
brand slug metadata first, then add namespace pointers later if the client or brand becomes a real
retrieval surface.

## Agent guardrails

Future AI agents operating in this repo should follow this default sequence:

1. register or update the durable `secrets/<secret-id>.md` metadata entry first
2. keep raw values out of git, logs, and model-visible context
3. upload or rotate the secret only through an approved backend path
4. write back the resulting backend locator, scope, and policy metadata only

Default ingestion posture:

- metadata registration is expected by default
- backend upload is allowed only through an approved secure path and user intent
- autonomous secret-value harvesting or bulk migration without explicit approval is not allowed
- `.env` files, copied tokens, or pasted credential blobs must not become the secret inventory

## Not allowed in git

- raw secret values
- access tokens
- private keys
- certificate bodies
- copied `.env` content
- live approval or refresh state
- logs containing resolved secret material

## Related contracts

- `_system/secret-reference-schema.md`
- `_system/tool-registry-rules.md`
- `_system/surface-contract-rules.md`
- `departments/devops-platform/delivery-standards.md`
