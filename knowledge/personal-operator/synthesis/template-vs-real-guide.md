---
id: "knowledge-personal-operator-template-vs-real-guide"
aliases: ["knowledge-personal-operator-template-vs-real-guide", "template-vs-real-guide"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Disambiguates which personal-operator nodes are fictional scaffolding to copy from versus real operator doctrine to trust, so an agent does not mistake a teaching template for a fact or treat real doctrine as a throwaway example."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[about-this-company]]"
    relation: "references"
    confidence: 0.85
  - target: "[[example-concept]]"
    relation: "references"
    confidence: 0.85
  - target: "[[namespace-buildout-sprint-pattern]]"
    relation: "references"
    confidence: 0.85
created: "2026-05-30"
---

## Why this guide exists

`personal-operator` graduated to a serious namespace on 2026-06-03 (an internal buildout). It now carries a full canon layer, so
[[personal-operator-core-doctrine]] is the load-first surface, not this guide. This node remains
because the namespace still holds two fictional teaching templates that look identical in structure to
real doctrine but mean the opposite. An agent that cannot tell them apart will either cite a teaching
example as fact or discard real doctrine as a throwaway. This node is the disambiguator for those
relocated scaffolds.

On graduation the templates moved off the load-bearing path into `_examples/`. The `pillars/`,
`concepts/`, and `decisions/` folders now hold only real operator doctrine. The repo-wide canonical
doctrine scaffold is `knowledge/_examples/doctrine-example/`.

## Template nodes (fictional, copy the shape not the content)

These exist to demonstrate node anatomy and the repo's frontmatter and voice conventions. They live in
`_examples/`, off the load-bearing path. Their content is invented. Copy their structure when you build
a real node; never cite their facts.

- [[about-this-company]]: a pillar template built around a fictional "Acme Analytics"
  business (now in `_examples/`). It demonstrates how a pillar node is shaped (foundational truths about
  a company or domain). The company, its metrics, and its claims are invented.
- [[example-concept]]: a concept template built around a fictional attribution-window example
  (now in `_examples/`).
  It demonstrates concept-node anatomy (a definition, model, or framework). It carries
  intentional fill-me-in wikilinks (to `memory-example-learning` and `data-example-metric`,
  written here without brackets so they are not read as live links) that do not resolve on
  purpose: they mark where a learner would link their own real nodes. Those unresolved links
  are expected, not defects.

## Real nodes (operator doctrine, trust and maintain)

These record the real operator model, decisions, and methods. They are the load-bearing content of the
serious namespace.

- [[operator-profile]]: the load-bearing pillar, the durable model of the operator as an operator (deep-work
  windows, communication style, risk and reversibility posture, default item classes). A skeleton as of
  2026-06-03: the structure is canonical, the operator-specific values are operator-input-required.
- your own decisions: as you record real surface-fit or tooling decisions in `decisions/`,
  they become the load-bearing content this guide contrasts with the templates.
- [[namespace-buildout-sprint-pattern]]: a real, reusable operator methodology for building or
  migrating a namespace, distilled from the prior Example Co buildout. It is the kind of node
  that should graduate into a serious namespace (likely `ai-architecture` or a process
  namespace) once it is stable.

## How to use this namespace

- Building a new node: copy the structure of the matching template, then replace every
  fictional fact with your own. Run `validate.sh` to confirm frontmatter and links.
- Looking for real doctrine: trust only the real nodes above. The templates teach form, not
  fact.
- Promotion: this namespace is now serious doctrine, so new real operator content belongs in its
  `pillars/`, `concepts/`, `decisions/`, or `playbooks/`, not in a sandbox. The `namespace-buildout`
  method may still graduate into `ai-architecture` if it proves broadly reusable. The teaching templates
  stay in `_examples/`; they are permanent teaching artifacts and never load-bearing.
