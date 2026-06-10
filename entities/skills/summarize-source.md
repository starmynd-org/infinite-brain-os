---
id: "skill-summarize-source"
aliases: ["skill-summarize-source"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Skill for compressing sources into citable knowledge-ready summaries."
confidence: 0.9
retrieval_class: "domain"
export_class: "department"
description: "Summarize any source (web page, document, knowledge node, or transcript) into a compact, citable entry suitable for inclusion in a knowledge node or research digest."
edges:
  - target: "[[agent-research-assistant]]"
    relation: "used_by"
    confidence: 0.9
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
  - target: "[[namespace-intake-rules]]"
    relation: "references"
    confidence: 0.85
  - target: "[[promotion-path-rules]]"
    relation: "references"
    confidence: 0.85
created: "2026-05-20"
---

# summarize-source

A reusable technique for compressing any information source into a compact, citable
summary. Apply this skill any time you need to distill a source before adding it to
the knowledge graph.

## When to apply

- You found a web article, PDF, or transcript relevant to work in progress.
- You are synthesizing multiple knowledge nodes into a research digest.
- You are building a Memory node from an experience and need to compress what happened.
- An Agent like `[[agent-research-assistant]]` needs to reduce a source before combining.

## Technique

### Step 1: Identify source type

Classify the source:
- **Document or article**: read in full, then summarize.
- **Long transcript or video**: chunk into segments of roughly 1,500 words, summarize
  each chunk, then synthesize the chunk summaries.
- **Knowledge node**: read the frontmatter (confidence, type) and body, then produce a
  one-sentence summary plus the node id for wikilink.
- **Data table or report**: identify the key metric, its direction, and the time period.
  Do not reproduce numbers; reference the Data pointer node.

### Step 2: Extract the core claim

Every useful source has one core claim. Write it in one sentence, in plain language,
with no jargon unless the jargon is domain-essential. If you cannot state the core claim
in one sentence, the source is not yet understood; re-read.

### Step 3: Identify supporting points

Extract 2-5 supporting points. Each is one sentence. Prefer concrete evidence over
assertions. Flag if a point is an assertion without evidence.

### Step 4: Assign confidence

- `1.0`: primary source, peer-reviewed or first-party data, directly verifiable.
- `0.85`: reputable secondary source, no obvious conflict of interest.
- `0.7`: plausible but not verified; blog post, analyst opinion, single source.
- `0.5`: uncertain; contradicts other sources or lacks supporting evidence.
- `0.3`: treat as a signal, not a fact.

### Step 5: Format the output

```
**Source:** {title or description}
**URL / Location:** {url or file path}
**Core claim:** {one sentence}
**Supporting points:**
- {point 1}
- {point 2}
- {point 3}
**Confidence:** {0.0-1.0}
**Relevance note:** {why this matters to the current task}
```

### Step 6: Route the output (V2)

A finished summary is not done until it lands in the right place. The destination depends
on what the summary is, not on what it summarizes. There are three distinct homes, and
choosing wrong corrupts the boundary between provenance, derived thinking, and receipts.

- **Provenance goes to `support/`.** When the summary records where a source came from,
  what it asserted, and its citation, so a later reader can trace and trust the lineage,
  it is provenance. It goes to `knowledge/<namespace>/support/`. Support is mechanical
  and historical: source-priority tables, citation records, "this claim came from that
  source." Do not put interpretation here.
- **Derived reading goes to `synthesis/`.** When the summary is your synthesized current
  understanding (a best-current-reading note, a contradiction map across several sources,
  a what-changed review, or a canon-candidate package), it is derived intellectual work.
  It goes to `knowledge/<namespace>/synthesis/`. Synthesis is interpretive and current.
  Do not file derived reading under `support/`.
- **A receipt goes to `intake/processed/`.** When the summary is the record of an inbound
  item being processed (what came in, why it mattered, what was done with it, whether it
  changed support, synthesis, or canon, and which files were touched), it is a processed
  receipt. It goes to `intake/processed/<source>/` with a link back to the source record.
  The receipt never owns the durable truth; it points at where the truth landed.

These three are not interchangeable. The same source can produce all three: a provenance
record in `support/`, a derived reading in `synthesis/`, and a processed receipt in
`intake/processed/`. Keep them separate. The boundary rules are governed by
[[namespace-intake-rules]] (how a namespace consumes intake) and [[promotion-path-rules]]
(how a source moves from raw to support to synthesis to canon).

## Quality checks

- The core claim must be falsifiable. "AI is transforming business" is not falsifiable.
  "AI adoption reduced ticket resolution time by 34% at Intercom in 2024" is.
- If confidence is below 0.6, say so explicitly in the relevance note.
- Never pad summaries. Shorter is better. If the source has nothing concrete to add,
  say "Source reviewed: no actionable content found."
- The summary must land in exactly one of the three homes for its purpose: provenance in
  `support/`, derived reading in `synthesis/`, a processing record in `intake/processed/`.
  If you cannot say which one it is, you have not decided what the summary is for.

## Governed by

This skill follows the tone and style rules in `[[rule-voice-and-style]]`.
