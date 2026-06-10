# Secret Reference Schema

This file defines the operative shape of a durable secret-reference entry. It covers references
and policy metadata only. Secret values never live in git.

The root registry home is:

```text
secrets/
```

Minimum expected entry shape:

```yaml
secret_ref:
  id: "stable-secret-id"
  status: "planned | live | limited | deprecated"
  owner_department: "devops-platform"
  backend: "1password | gcp-secret-manager | aws-secrets-manager | azure-key-vault | other"
  locator: "provider-specific-pointer"
  exposure_mode: "tool-only | runtime-env | human-copy | delegated-session"
  allowed_runtimes:
    - "local-attended"
    - "cloud-headless"
  allowed_surfaces:
    - "surface-slug"
  allowed_tools:
    - "tool-slug"
  allowed_workflows:
    - "workflow-slug"
  scope_class: "shared-platform | department-local | client-scoped | brand-scoped | personal-operator"
  consumer_departments:
    - "department-slug"
  consumer_systems:
    - "system-slug"
  party_slugs:
    - "stable-party-key"
  client_slug: "stable-client-key or null"
  brand_slug: "stable-brand-key or null"
  client_namespace: "namespace-slug or null"
  brand_namespace: "namespace-slug or null"
  rotation_class: "manual | periodic | event-driven"
  last_rotated: "YYYY-MM-DD or unknown"
  notes: "Short operational note."
```

Required meaning:

- `id`: the stable repo-facing identifier. Never change this casually. Provider migration should
  normally update `backend` or `locator`, not the `id`.
- `status`: whether the secret reference is actively usable by the OS.
- `owner_department`: the department that owns the posture, usually `devops-platform` for shared
  credentials.
- `backend`: the current resolution backend.
- `locator`: the provider-specific pointer, path, or item reference. This may be redacted at the
  operator's discretion if even the locator is too revealing, but the entry should still point to
  the owning system clearly enough for operators.
- `exposure_mode`: how the resolved value may be handed to the executor.
- `allowed_runtimes`, `allowed_surfaces`, `allowed_tools`, `allowed_workflows`: least-privilege
  binding scope.
- `scope_class`: the main blast-radius and ownership posture for the secret reference.
- `consumer_departments`: which departments materially depend on the secret at runtime.
- `consumer_systems`: stable external-system or vendor slugs when no root `tools/` entry exists
  yet.
- `party_slugs`: broad external-party linkage when the secret meaningfully belongs to or is used
  for one or more parties beyond a single client or brand.
- `client_slug`, `brand_slug`: stable scope keys for client or brand affinity even when no
  dedicated namespace exists yet.
- `client_namespace`, `brand_namespace`: optional links to real namespaces once those surfaces
  exist. Do not invent namespaces solely to park a secret.
- `rotation_class`: how rotation is expected to happen.

Recommended body sections:

- what this secret unlocks
- which departments, tools, surfaces, or workflows depend on it
- what must never happen with it
- what audit trail or approval posture applies

What this schema is not:

- not a place for raw values
- not a runtime log
- not the live queue of secret requests, refreshes, or approvals
- not a substitute for a cloud or human-managed secret backend
