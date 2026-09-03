---
id: "secret-ref-stable-secret-id"
aliases: ["secret-ref-stable-secret-id", "stable-secret-id"]
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Stable secret reference entry for a runtime-bound credential used by this OS."
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
created: "YYYY-MM-DD"
secret_ref:
  id: "stable-secret-id"
  status: "planned"
  owner_department: "devops-platform"
  backend: "cloud-secret-manager"
  locator: "projects/<your-project>/secrets/<secret-name>"
  exposure_mode: "tool-only"
  allowed_runtimes:
    - "local-attended"
  allowed_surfaces: []
  allowed_tools: []
  allowed_workflows: []
  scope_class: "shared-platform"
  consumer_departments: []
  consumer_systems: []
  client_slug: null
  brand_slug: null
  client_namespace: null
  brand_namespace: null
  rotation_class: "manual"
  last_rotated: "unknown"
---

# Secret Reference: <stable-secret-id>

## What this unlocks

Short description of the system, account, or capability this reference unlocks. Name the
capability, not the credential, so the entry still reads correctly after a rotation.

## Provisioning status

`status: planned` means the reference exists and the value does not. Say what has to happen
before it becomes `active`, and who has to do it. Flip the status in the same change that
creates the value.

## Allowed consumers

Fill these in when a real consumer exists, not speculatively. An empty list is an honest
answer and a guessed one is not.

- Surfaces:
- Tools:
- Workflows:
- Departments:
- Client scope:
- Brand scope:
- Consumer systems:

## Guardrails

- Never place the raw value in git, logs, or namespace canon. Only the reference and the
  policy live here.
- Resolve only inside the approved runtime path. The model sees the reference id and
  redacted results, never the credential material.
- Keep least privilege explicit. Widening `allowed_tools` is a decision, not a default.

## Related

- `tools/<tool>.md`
- `_system/surface-registry/<surface>.md`
- `departments/devops-platform/INDEX.md`
