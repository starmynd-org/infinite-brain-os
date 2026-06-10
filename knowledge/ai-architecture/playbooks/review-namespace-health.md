---
id: "knowledge-ai-architecture-review-namespace-health"
aliases: ["knowledge-ai-architecture-review-namespace-health", "ai-architecture-review-namespace-health", "review-namespace-health"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Health review procedure for a namespace: run the deterministic validate.sh, then profile-scoped fuzzy review for contradictions, stale canon, and missing output linkage, on a cadence set by freshness posture."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[namespace-linting]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[review-knowledge-freshness]]"
    relation: "depends_on"
    confidence: 0.87
created: "2026-05-30"
---

# Review Namespace Health

## Summary

Namespace health splits into two passes. The deterministic pass is `validate.sh`: it
catches structural and mechanical problems and is the only check that gates. The fuzzy
pass is agent judgment: contradictions, stale canon, and missing output linkage that no
script can decide. Run the deterministic pass first, every time. Run the fuzzy pass on a
cadence set by the namespace freshness posture, scoped by profile so stable doctrine is
not reviewed as often as decaying state.

## When to run

Run the deterministic pass on every edit and before any wave closes. Run the fuzzy pass
on the cadence the registry `freshness_posture` declares: `review-on-edit` namespaces
get fuzzy review whenever canon or a load-bearing node changes, `periodic` namespaces
get it on a scheduled review, and `live` namespaces get it most often because their
state decays fastest.

## Procedure

1. Run the deterministic pass. Execute `bash _system/validate.sh`. It reports missing
   required base surfaces, missing canon files for `full` canon posture, broken relative
   links and `wikilinks`, orphan nodes as warnings, unexpected folders as warnings,
   intake receipt completeness, and the existing frontmatter and dash-ban checks. Fix
   every error before continuing. See [[namespace-linting]] for what is deterministic
   versus fuzzy and why the split matters.

2. Triage warnings. Orphans and unexpected folders do not fail the build but signal rot.
   Decide per warning: link the orphan, remove the stray folder, or record why it stays.

3. Surface contradictions. Read the namespace for nodes or sources that disagree. Where
   two nodes contradict, record the conflict and the current best resolution in
   `synthesis/` as a contradiction map. Do not silently pick a winner inside canon.

4. Check canon freshness. Confirm `canon/core-doctrine.md` still reflects current truth.
   Compare `verified_at` against the latest material edits in the namespace. If canon has
   drifted, queue a refresh through the canonize playbook. Run the freshness judgment per
   [[review-knowledge-freshness]], scoped to where state actually decays.

5. Check output linkage. Read the `INDEX.md` `What this namespace drives` section. Every
   serious namespace must name the outputs, projects, or decisions its canon improves. If
   that surface is empty or stale, the namespace is not earning its keep. Flag it.

6. Apply profile emphasis. Tool Contract checks that payload examples are present and
   endpoints are fresh. Data System checks that each metric has source lineage and each
   model has refresh logic. Design System checks that component usage maps to a token.
   Operating Library checks that each SOP has a trigger and each diagnostic has a next
   action. Doctrine checks that canon still compresses rather than paraphrases.

7. Record the review. Write a dated what-changed note in `synthesis/` summarizing the
   deterministic result, the warnings triaged, the contradictions surfaced, and any
   canon or linkage gaps queued. Link the files touched.

## Cadence by freshness posture

- `review-on-edit`: deterministic pass on every edit; fuzzy pass when canon or a
  load-bearing node changes.
- `periodic`: deterministic pass on every edit; fuzzy pass on the scheduled namespace
  review.
- `live`: deterministic pass on every edit; fuzzy pass most often, because live state
  decays fastest and contradictions appear quickly.

## Quality checks

- `validate.sh` exits clean before any fuzzy work begins.
- Every contradiction found has a recorded resolution location in `synthesis/`.
- Canon freshness was checked against `verified_at`, not assumed.
- The output-linkage surface in `INDEX.md` is current.
- A dated what-changed note exists in `synthesis/` after the review.

## Notes

Keep deterministic and fuzzy work strictly separated. If a check can be expressed as a
rule, it belongs in `validate.sh`, not in this review. The reason to keep a human or
agent in the loop is precisely the judgment a script cannot make: whether two true
statements actually conflict, and whether canon still tells the truth.
