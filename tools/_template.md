---
id: "tool-template"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template for adding a tool to the Infinite Brain OS tool registry."
confidence: 0.86
retrieval_class: "identity"
export_class: "internal"
tool_type: "api"
tool_status: "planned"
departments: []
related_namespaces: []
party_slugs: []
client_slug: null
brand_slug: null
created: "2026-05-31"
---

# Tool Registry Template

Use this when adding a new tool under `tools/`.

## Frontmatter guidance

Prefer fields like:

```yaml
id: "tool-<slug>"
aliases: ["tool-<slug>", "<slug>"]
type: "Tool"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "<what this tool is for>"
confidence: 0.8
retrieval_class: "identity"
export_class: "internal"
tool_type: "api"
tool_status: "planned"
system_fit: "department-local-tool"
departments: ["personal-health"]
related_namespaces: ["personal-health"]
party_slugs: []
client_slug: null
brand_slug: null
created: "2026-05-31"
```

Add these when they materially matter:

```yaml
tools: []
secret_refs: []
```

If the tool materially belongs to external commercial scope, use:

```yaml
party_slugs: [acme, drift]
client_slug: "acme-crm"
brand_slug: "drift"
```

## Body sections

- what the tool does
- why it matters in this OS
- system fit class and boundary
- deep namespace link
- who owns it
- what external parties, client, or brand it serves when relevant
- what workflows and agents use it
- runtime/source location
- auth or credential boundary
- risks or limitations
- next integration step

## Deep namespace linkage

If the tool needs serious API, payload, schema, or call-selection documentation, point at
its deep namespace under `knowledge/`. The root tool entry stays shallow:

- `tools/<tool>.md` answers discoverability, ownership, and runtime posture
- `knowledge/<namespace>/` answers how to call the tool correctly

Suggested body line:

```markdown
Deep contract namespace: `knowledge/<subject>-tool-contract/`
```

If the namespace uses a subject-only doctrine-style slug or another justified shape, state
the actual path explicitly.

Suggested system-fit line:

```markdown
System fit class: `os-operational-tool`
```

Then answer in prose:

- what part of the OS this tool serves
- what it is allowed to own
- what remains outside its boundary
- whether it should roll into `_system/` and `knowledge/ai-architecture/`
