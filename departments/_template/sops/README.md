---
id: "department-template-sops-readme"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template SOP library README: the templated, repeatable procedures a department can run on demand, distinct from one-off workflows. One file per procedure."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
created: "2026-06-17"
---

# SOP Library (Template)

This folder holds the department's standard operating procedures: templated, repeatable procedures a
human or an agent can run on demand. An SOP is distinct from a one-off workflow and from a `condition:`
trigger. The operations register may name an SOP as a row's implementing procedure, but the steps live
here, never inlined in the register.

One file per procedure, named `<verb-noun>.md` (for example `triage-a-captured-request.md`). Each SOP
states: when to run it, inputs, the numbered steps, the output and its receipt, and the human-review
gate if any.

See `knowledge/ai-architecture/canon/department-web.md` for where SOPs sit in the capture-to-build web
and `knowledge/ai-architecture/concepts/choosing-the-right-primitive.md` for when a captured item should
become an SOP versus an automation or agent architecture.

## SOPs in this library

State the gap honestly until the first SOP exists:

- Unknown as of the department build date. No SOP authored yet.
