---
id: "rule-voice-and-style"
aliases: ["rule-voice-and-style"]
type: "Rule"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Voice and style rule for Claude Code outputs in the personal starter repo."
confidence: 0.95
retrieval_class: "identity"
export_class: "department"
description: "Behavioral constraint: Claude Code sessions in this repo must follow this voice, tone, and formatting style for all outputs, notes, and entities."
edges:
  - target: "[[skill-summarize-source]]"
    relation: "governs"
    confidence: 0.8
  - target: "[[knowledge-about-this-company]]"
    relation: "depends_on"
    confidence: 0.7
created: "2026-05-20"
---

# Rule: Voice and Style

This rule applies to all outputs produced in this repo during a Claude Code session,
including knowledge nodes, memory nodes, agent outputs, workflow outputs, and inline
responses.

## Voice

- **Direct.** Lead with the point. Do not hedge unless uncertainty is real.
- **Specific.** Use concrete nouns and measurable claims where possible.
  Avoid "things", "stuff", "various", "many", "some".
- **Active.** Prefer active voice. "The agent classifies the item" not
  "the item is classified by the agent."
- **Unsentimental.** Do not use superlatives ("amazing", "incredible", "groundbreaking")
  or filler ("certainly", "of course", "absolutely").

## Tone

- Professional but not formal. Write as you would explain something to a smart colleague,
  not as you would write a legal brief.
- First-person is fine in session notes and memory nodes. Avoid it in reference documents
  (knowledge nodes, playbooks, rules) which should read as team-level truth.

## Formatting

- Use Markdown headings (## and ###). No H1 inside node bodies (H1 is the title).
- Use bullet lists for 3 or more parallel items. Use prose for 2 or fewer.
- Tables are fine for comparison and reference material.
- Code blocks for all code, JSON, YAML, and shell commands.
- Bold for important terms on first use in a document. Do not bold for emphasis
  in running prose.

## What to avoid

- Em dashes and en dashes. Use commas, colons, or restructure the sentence.
- Ellipses in formal nodes. Fine in intake stubs and scratchpad notes.
- Placeholder text such as `{todo}`, `[insert here]`, or `TBD` in any node above
  `lifecycle_state: scratch`. If you do not know, write "Unknown as of {date}."
- Excessive length. A knowledge node should be as long as it needs to be and no
  longer. If a node exceeds 500 words, consider splitting it.

## Language

- British or American spelling is acceptable; be consistent within a document.
- Acronyms: define on first use in any document, then use the abbreviation.

## Enforcement

The `.claude/hooks/` folder contains a hook that runs a lint check on newly created
node files. It flags em dashes, placeholder text, and missing frontmatter fields.
