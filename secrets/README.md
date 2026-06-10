# Secret Registry

`secrets/` is the root operating registry for secret references.

Use this folder to answer:

- what stable secret ids exist in the OS
- which surfaces, tools, or workflows may resolve each secret
- which backend currently stores the real value
- what rotation and exposure policy applies

This folder does not store secret values.

## Core rule

The repo stores references and policy metadata. A trusted runtime resolves the value at
execution time, from wherever the value actually lives (a cloud secret manager, an OS
keychain, a password manager). The model should see ids and redacted outcomes, never raw
credentials.

## When to use `secrets/`

Use `secrets/` for:

- provider-neutral secret reference ids
- backend pointer metadata (which secret manager, which entry name)
- least-privilege binding scope (who may resolve the secret)
- ownership and rotation posture

Do not use `secrets/` for:

- `.env` snapshots
- copied API keys or tokens
- OAuth refresh state
- live request queues or approval flows
- vendor-specific secret-manager tutorials that belong in an ops runbook

## How to add a reference

Copy `_template.md` to a new file named after the secret id, fill in the reference fields,
and link it to the tools and workflows that consume it. Pick a stable kebab-case id that
describes the credential, not the value.

## Fictional example

A reference for an example application's API key, held in a cloud secret manager:

```yaml
secret_ref:
  id: "example-app-api-key"
  status: "active"
  backend: "cloud-secret-manager"
  locator: "projects/<your-project>/secrets/example-app-api-key"
  exposure_mode: "tool-only"
  allowed_runtimes: ["local-attended"]
  allowed_tools: ["example-app-client"]
  allowed_workflows: []
  scope_class: "shared-platform"
  rotation_class: "manual"
  last_rotated: "unknown"
```

The entry says where the key lives and who may bind it. The key itself never appears in
this repo, in a node body, or in a session log.

## Scope model

Use the reference fields to attach each secret to the rest of the system without storing
values:

- `allowed_tools`, `allowed_runtimes`, `allowed_workflows`: who may bind it
- `scope_class`: whether the secret is shared platform infrastructure, scoped to one
  project or client, or personal to the operator
- `rotation_class` and `last_rotated`: the rotation posture

Keep references minimal at first. Add scope fields when a real consumer exists, not
speculatively.
