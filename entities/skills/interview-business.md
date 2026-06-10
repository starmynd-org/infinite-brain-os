---
id: "skill-interview-business"
aliases: ["skill-interview-business", "interview-business"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Interview a founder or operator about their business in plain language, one question at a time, and produce a structured business map document every later recommendation can cite."
confidence: 0.8
retrieval_class: "domain"
export_class: "public"
description: "Use this skill when onboarding a person onto the Infinite Brain: run the phased adaptive business interview and write the business map to intake/processed/. Invoked by /onboard-business; feeds recommend-architecture."
edges:
  - target: "[[skill-recommend-architecture]]"
    relation: "paired_with"
    confidence: 0.95
  - target: "[[cmd-onboard-business]]"
    relation: "used_by"
    confidence: 0.9
  - target: "[[workflow-onboard-business-architecture]]"
    relation: "used_by"
    confidence: 0.9
  - target: "[[intake-fabric-namespace]]"
    relation: "references"
    confidence: 0.8
created: "2026-06-10"
---

# interview-business

Use this skill to interview a person about their business before recommending any
architecture. The interview is a conversation, not a questionnaire. Its product is a
business map: a structured document where every claim is attributed to something the
person actually said.

## Use when

- a person is onboarding onto a fresh Infinite Brain and the system knows nothing about
  their business
- an established operator re-runs onboarding after the business has evolved and the map
  needs refreshing

## Do not use when

- the business map already exists and is current; go straight to
  [[skill-recommend-architecture]]
- the person wants to build one specific thing they can already name; route through the
  matching builder skill instead

## The interviewee

Assume a smart founder or operator who has never seen this system. Plain language only.
No system vocabulary (namespace, canon, entity, swarm, sprint, intake) until the
recommendation stage. If you cannot ask a question without jargon, the question is wrong.
Expect 20 to 40 minutes; depth adapts to the business, not to the phase list.

## The seven phases

Work through these in order, but adaptively: spend time where the business is, skim where
it is not, and record why a skimmed phase was thin.

1. **Business model and offers.** What they sell, to whom, at what price, and how the
   money actually arrives. Get the offer list in their own words.
2. **Customers and channels.** Who buys, how customers find them, which channels produce
   revenue versus noise, what repeat business looks like.
3. **Operations and recurring work.** The work that happens every day, week, and month to
   deliver the offers. Listen for loops: anything they describe doing "every" anything.
4. **Team and roles.** Who does what, including the founder's own jobs. Where judgment
   lives, where handoffs happen, what only one person knows how to do.
5. **Tools, data, and systems of record.** Where orders, customers, money, content, and
   conversations live today. Which numbers they check and where those numbers come from.
   Listen, without pitching anything, for three tooling signals worth recording in the
   map: a wish to see or browse their knowledge visually (a reading-surface signal), a
   stabilized repetitive process they describe in identical steps every time (a
   deterministic-runtime signal), and live coordination pain across several streams of
   in-flight work (a cockpit signal). These feed the optional tooling note at the
   recommendation stage; they are never interview topics in their own right.
6. **Bottlenecks and failure points.** What breaks, what gets dropped, what they redo,
   what they avoid because it is tedious. Listen for the phrase "I keep meaning to."
   Close this phase by asking them to rank: "if one of these disappeared as a problem
   tomorrow, which one moves the business most?" Their ranking, in their words, becomes
   the backbone of the recommendation priorities.
7. **Goals and the 90-day horizon.** What they are trying to make happen this quarter,
   what success looks like, and what they believe is in the way.

## Interview rules

- **One question at a time.** Never stack questions. Wait for the answer before deciding
  the next question.
- **Follow the energy.** When the person lights up or circles back to a topic, go deeper
  there even if it breaks phase order; note the detour in the map.
- **Capture verbatim language.** Record their exact words for offers, customer names,
  pain points, and goals. The recommendation stage must quote them, so the map must keep
  the quotes.
- **Close each phase with a playback.** Summarize what you heard in two to four
  sentences, in their words, and ask whether it is right. Correct the map before moving
  on; never carry an unconfirmed summary forward.
- **Separate fact from inference.** When you infer something they did not say, mark it as
  an inference in the map and confirm it in a playback.
- **Do not solve during the interview.** No recommendations, no tool suggestions, no
  architecture talk until the interview is closed. The interview gathers; the
  recommendation stage maps.
- **Keep the sentence that names the whole problem.** Founders often hand you their own
  diagnosis in one line ("everything recurring and boring gets done late"). Capture it
  verbatim; it anchors the playback the recommendation set opens with.

## Output contract: the business map

Write the map to `intake/processed/<YYYY-MM-DD>-business-map.md` as soon as the interview
closes. Frontmatter:

```yaml
---
id: "business-map-<YYYY-MM-DD>-<business-slug>"
aliases: ["business-map-<YYYY-MM-DD>-<business-slug>"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Business map from the <date> onboarding interview with <person> of <business>."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
interviewee: "<person, role>"
interview_mode: "first-run | re-run"
created: "<YYYY-MM-DD>"
---
```

Body: one section per phase in the order above, each holding the confirmed playback
summary, the load-bearing verbatim quotes, and any marked inferences. Close with two
sections: `## Detours` (where the energy went off-script and what it surfaced) and
`## Thin phases` (which phases were skimmed and why). Every claim in the map must trace to
the interview; nothing imported from assumption.

A re-run interview diffs instead of restarting: load the prior map, confirm what still
holds phase by phase, and interview only what changed. The new map records
`interview_mode: re-run` and names the prior map it supersedes.

## Quality checks

- a founder who has never seen this system could answer every question asked
- no system jargon appears anywhere in the transcript before the recommendation stage
- every phase ends with a confirmed playback
- the map quotes the person verbatim where it matters and marks inferences as inferences
- the map lands at the contracted path with full frontmatter

## Anti-patterns

- running the phase list as a rigid questionnaire and ignoring where the energy is
- stacking three questions into one message
- summarizing in system vocabulary the person never used
- recommending architecture mid-interview
- writing claims into the map that the person never said and never confirmed
