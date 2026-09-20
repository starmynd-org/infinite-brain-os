---
id: "skill-store-kyn-files"
aliases: ["skill-store-kyn-files", "store-kyn-files"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Prepare, seal and check this OS's kyn/ folder (the kyn-files/v1 prepared-facts contract that Infinity Reporting reads), with the folder validator as the gate and a synthetic worked example."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
name: "store-kyn-files"
description: "Use this skill when Infinity Reporting (Dashboards and Reports) needs prepared metric facts and dimension registries from this OS, or when an existing kyn/ folder must be corrected. It writes a catalog, member files and fact files, seals them with byte descriptors, and runs the folder validator. Not for raw event archives, database administration, or fetching sources."
edges:
  - target: "[[knowledge-ai-architecture-metric-primitive]]"
    relation: "related_to"
    confidence: 0.8
  - target: "[[knowledge-ai-architecture-canon-doctrine-card]]"
    relation: "governed_by"
    confidence: 0.85
  - target: "[[skill-manage-ai-session]]"
    relation: "paired_with"
    confidence: 0.8
created: "2026-09-20"
---

# store-kyn-files

A repeatable technique for turning numbers you already hold into a `kyn/` folder that
Infinity Reporting can read: one catalog, one member file per dimension, one or more fact
files, every file sealed with its byte length, row count and SHA-256, and the whole folder
checked by the engine's validator before it replaces the live one. The contract is
`kyn-files/v1`. This file is meant to be enough on its own: a reader who saw only it produced a
valid folder on the first try (CMD-P7-REPORTS control, 2026-09-20); after any edit to this file, run
that control again before trusting the claim.

## Use when

- a dashboard or report in Infinity Reporting needs daily metric facts from this OS
- an existing `kyn/` folder needs a corrected cell, a new metric, or a new date range
- you want to rehearse the format on invented numbers before touching real ones

## Do not use when

- the material is raw events or an export you have not attributed to business dates yet
  (prepare it first; this folder holds prepared cells, one value each)
- the task is fetching new sources, installing software into this OS, or publishing
  outside it (this skill prepares files and runs a check, nothing more)
- the numbers need currency conversion, arbitrary formulas, calendar comparisons or
  historical joins (v1 refuses these; prepare a separately defined metric upstream, or say
  the capability is unsupported)

## Where it lives

- `<os>/kyn/` at the root of this repo is the live home. Infinity Reporting's Dashboards
  read it directly. A report copies the whole folder into `reports/<id>/kyn/` on the
  reporting host and freezes it there; report copies are never edited.
- In this OS's terms the folder is a prepared reporting surface, not a system of record.
  `CLAUDE.md` says this OS is "Not a system of record for numbers" and that `data/` holds
  pointers; `kyn/` keeps that true because it is a prepared copy, and the record of every
  number stays upstream in the source the catalog names. `data/` still holds only pointers: write one Data node under `data/` whose
  `state_stored_at` names the folder path, so agents cite the pointer and the numbers stay
  in the sealed files. The shipped example pointer is `data/kyn-synthetic-example.md`; copy
  its shape for your live folder.
- Work in a sibling staging folder, `kyn-staging/`, and keep the current `kyn/` untouched
  until the staged revision passes the validator.
- The root `.gitattributes` carries `/kyn/** -text`, so git never rewrites the bytes that
  the descriptors hash. If you store a folder anywhere else in this repo, add the same
  `-text` rule for that path before you compute descriptors.

## Prepare the meaning before the rows

1. Fix the `workspaceId`: the key the reporting host uses for this OS. If nobody has told
   you one, use this repo's own slug and say in your summary that the host must be given
   the same id; the validator's `--workspace` argument is that id.
2. Fix the business timezone (an IANA name such as `UTC` or `Europe/London`). It is the
   business's own zone, named by the person: ask once and record it; never write `UTC`
   silently because nobody said.
3. Fix the recognition rule per metric: one sentence naming the business date rule (for
   example "order paid, Europe/London business day"), the native unit and currency per
   metric, a real as-of instant per source, and the revision's own as-of instant. All
   as-of values are UTC in `YYYY-MM-DDTHH:mm:ssZ`; a source as-of can not be later than the
   catalog as-of. If you do not know when a source was last read, find out; never write the
   time the script ran. When the numbers were dictated in chat or typed by hand, the as-of
   is the moment the person gave them, in UTC, and the source name says so, for example
   "Typed by the owner on 2026-03-04".
4. Choose the `revision`: any stable nonempty string; `<date>-r<n>` (the date you prepared
   it, then a run number) is the recommended shape.
5. Choose one finest grain per dataset: the list of dimension ids every fact in it carries.
   Include every axis the business reports per row (if sales come per product and per
   channel, the grain is both). Flows (revenue, units) go in an `aggregate` dataset; levels
   (stock on hand) go in a `snapshot` dataset. A primitive metric belongs to exactly one
   dataset. A ratio is declared in the catalog, never stored as rows, and it is optional:
   add average price only when a report will ask for it.
6. One `sourceId` per dataset, and every metric in it carries that same source. When two
   exports (a till and a web export, say) feed the same metric, either declare one source
   whose name names both honestly ("Till and web export, read together") or split them
   into two datasets with separately named metrics. Recommended: one source named
   honestly, unless the two exports have different as-of times, in which case two datasets.
7. Give every dimension member a stable id and a separate label. The id is the identifier
   the source itself uses (a SKU is right); the label carries the name. When a fact's member
   is unknown, write `null` for that axis; it will show as `(Unmapped)`, never as a total. A
   tuple may be null on one axis and known on another. Each child member has exactly one
   parent in this revision; renaming or reparenting restates the whole revision.
8. Sum every raw contribution that lands in the same cell (same date, metric and member
   tuple) upstream into one row. Never drop rows because their keys look alike. A retry
   replaces the cell; it never appends a second copy.
9. Decide coverage per dataset and date. `complete` asserts that every primitive metric and
   every member at that date was exhaustively observed. Under that assertion an omitted
   cell on a complete flow date means zero, so a wrong `complete` changes the numbers.
   `incomplete` (or a missing coverage record) makes every aggregate touching that date
   unknown, never zero. Write a value you do not know as `null`. A null stays unknown even
   on a complete date: every total that includes that cell comes back null with a reason,
   while the other metrics in the same rows stay numbers.
10. Zero versus omitted, in one sentence: on a complete day, omit the cell of a channel that
   was closed or had nothing to sell (zero by contract), and write an explicit `"0"` only
   when the channel was open and observed to sell nothing.
11. A member the person did not mention on a day they call complete is never zero: either
    the day is not complete (mark it `incomplete`) or the cell is `null` (unknown). Ask
    once; when the answer is not known, mark the day incomplete.
12. A coverage record for a date with no rows is allowed and means something:
    `incomplete` with no rows is an honest gap; `complete` with no rows asserts zero for
    every cell that day.

## The contract in short

Catalog, `catalog.json`, one JSON object with exactly these keys and no others:
`format` (`"kyn-files/v1"`), `workspaceId`, `name` (put the word Synthetic in the name of
any invented set), `revision` (a stable nonempty identity for this publication, not a
counter to sum), `asOf`, `timezone`, `writeDiscipline` (`"replace-folder"`), `sources`,
`dimensions`, `metrics`, `datasets`.

- Every id matches `[a-z][a-z0-9_\-]{0,63}` and is unique in its registry. `date` is
  reserved for the date axis.
- Source: `{"id","name","asOf"}`.
- Dimension: `{"id","name","parentId","history","file"}`. `parentId` is another dimension
  id or `null`; `history` is the literal `"restated-snapshot"`; `file` is a descriptor.
- Metric: `{"id","name","kind","unit","currency","scale","sign","recognition","sourceId"}`.
  `kind` is `flow`, `level` or `ratio`; `unit` and `recognition` are nonempty text;
  `currency` is `null` or one uppercase three-letter code; `scale` is an integer 0 to 6;
  `sign` is `nonnegative` or `signed`. A ratio adds `numerator` and `denominator`, two flow
  metric ids in the same dataset, meaning numerator sum divided by denominator sum. The
  ratio's currency equals its numerator's; its denominator is nonmonetary; its unit
  explains the quotient (`USD/unit`).
- Dataset: `{"id","name","kind","sourceId","grain","metricIds","files","coverage"}`. `kind`
  is `aggregate` (flows and ratios) or `snapshot` (levels only). `grain` lists dimension
  ids, never `date`. The dataset's `sourceId` equals every listed metric's `sourceId`.
  `files` is a list of descriptors. `coverage` is a list of `{"date","status"}`, one per
  date, `status` `complete` or `incomplete`; every fact date needs one.
- Descriptor: `{"path","bytes","rows","sha256"}`. `path` is exactly
  `dimensions/<id>.jsonl` or `facts/<name>.jsonl` (the name follows the id rule above and
  need not equal the dataset id), unique across the catalog; `bytes` is the
  file's byte length; `rows` is its count of nonempty lines; `sha256` is 64 lowercase hex
  characters over the exact bytes, newlines included.

Member line, one per nonempty line of `dimensions/<id>.jsonl`, exactly these fields:
`{"id":"web","label":"Web shop","parent":null}`. `id` is a nonempty string of at most 128
characters; `parent` is a member id of the parent dimension or `null`. `(All)` and
`(Unmapped)` are forbidden as ids or labels.

Fact line, one per nonempty line of `facts/<name>.jsonl`, exactly these fields:

```text
{"workspaceId":"pebble-press","date":"2026-03-01","metricId":"revenue","sourceId":"till","value":"30.00","currency":"USD","dimensions":{"channel":"web"}}
```

- `date` is a real `YYYY-MM-DD` already attributed to the business day.
- `value` is `null` or a decimal string: optional minus sign, digits, an optional point
  with at most `scale` digits after it, no exponent, no leading zeros except a lone `0`,
  at most 15 digits in all. JSON numbers are rejected. One value per row.
- `currency` equals the metric's currency, including `null`.
- `dimensions` carries every grain axis of the dataset and no other. A `null` axis is an
  unknown member and is part of the row's identity.
- Rows are unique on (dataset, date, metricId, full dimension tuple) across all of the
  dataset's files. `workspaceId` and `sourceId` must equal the catalog's on every row.

Files are UTF-8 without BOM, one JSON object per nonempty line, LF line endings (the format also accepts CRLF; this
OS's `.gitattributes` writes LF, so write LF), an
optional final newline, no blank interior lines, no arrays, no extra fields. Sort rows the
same way every time (date, then each grain axis with `null` last, then metric id) so
diffs stay readable.

Snapshots: a level is read at one date, or grouped by date, or with `latest`, which means
the globally latest complete snapshot date; a range over several snapshot dates is refused
(check M02). Levels add across members at one date and never across dates; a stock of 10
on Monday and 8 on Wednesday is 8 today, not 18.

Reading back: a grouped query lists only the groups that have rows. A cell you omitted on
a complete day is zero when you ask for it directly (a filter on that member), but it does
not appear as a row of its own in a grouped result.

Budgets (design limits, not measured capacity): the catalog stays under 1 MiB and each listed
file under 8 MiB, with everything together under 32 MiB; no more than 128 listed files,
100,000 fact rows or 20,000 members; no line over 16 KiB; no dataset spanning more than
3,660 days of coverage. Larger sets are split
into separate folders; never truncate silently.

## Write, seal and check

1. Write the member files and fact files into `kyn-staging/dimensions/` and
   `kyn-staging/facts/`.
2. Compute each file's descriptor from the actual bytes. From inside `kyn-staging/`:

   ```bash
   for f in dimensions/*.jsonl facts/*.jsonl; do
     printf '%s bytes=%s rows=%s sha256=%s\n' "$f" "$(wc -c < "$f")" "$(grep -c . "$f")" "$(sha256sum "$f" | cut -d' ' -f1)"
   done
   ```

   On macOS use `shasum -a 256` in place of `sha256sum`. Copy the numbers into the
   catalog's descriptors. Recompute after any edit to any listed file.
3. Write `catalog.json` last.
4. Run the validator. It lives in the engine repository, `starmynd-org/starmynd-reporting`
   (private; use your own access), at commit `a5bc54a39faaeb86563c6e3e49a231fbab4ffb0c`.
   In a checkout of that commit run `pnpm install` and then
   `pnpm --filter ./packages/data build` (the package `packages/data` is named
   `@starmynd-org/reporting-data`; its `build` script is `tsup`; the root `package.json`
   pins `"node": "22.23.2"` and `pnpm@9.15.0`). Then, from anywhere:

   ```bash
   node <engine checkout>/scripts/validate-kyn.mjs <kyn folder> --workspace <workspaceId>
   ```

   Pass means exit code 0 and `"valid": true` in the printed JSON, with `"issues": []`.
   A failure exits 1 and lists issues, each with a check id, a location and a reason, for
   example:

   ```text
   {"checkId": "J01", "location": "facts/sales.jsonl", "message": "J01 facts/sales.jsonl: SHA-256 mismatch: mixed or damaged revision"}
   ```

   Fix the file or the interpretation, recompute the affected descriptors, rerun. Never
   convert a null to zero, delete a hash, or loosen a budget to get to green.
5. Hand-check at least one total, one grouped reconciliation (the groups add up to the
   total), one null versus zero case and any ratio or level, with exact decimal
   arithmetic (Python's `decimal`, never floats). Keep the workings and the validator
   output as a file under `outputs/`, never inside `kyn/`; the folder holds only the
   catalog and its listed files. That file is a node: the standard frontmatter with
   `type: "Output"` and a `produced_by` edge to this skill, in the shape of the shipped
   `outputs/2026-06-05-spring-collection-brief.md`, per `_system/outputs-placement-rules.md`.

The validator certifies structure and arithmetic: fields, references, uniqueness, hashes,
budgets, and that supported queries reproduce the sums. It never certifies that the source
was read correctly or that a `complete` claim is true. Its `NOT CHECKED` lines (T02, C01,
C02) name capabilities outside the file profile, not failures.

## Worked example: Pebble Press (Synthetic)

An invented card seller with two channels, a web shop and a market stall, and a till
export as its only source. Three days: March 1 and 2 fully observed, March 3 still being
extracted. On March 2 the web shop sold nothing (an observed zero) and one sale could not
be tied to a channel (an unknown member). On March 3 the stall's revenue is not yet known
(a null value) though its units are. The folder ships at
`knowledge/_examples/kyn-folder-example/kyn/` with its pointer node
`data/kyn-synthetic-example.md`; copy it to rehearse.

`dimensions/channel.jsonl`:

```text
{"id":"web","label":"Web shop","parent":null}
{"id":"stall","label":"Market stall","parent":null}
```

`facts/sales.jsonl` (14 rows; revenue is USD at scale 2, units at scale 0):

```text
{"workspaceId":"pebble-press","date":"2026-03-01","metricId":"revenue","sourceId":"till","value":"30.00","currency":"USD","dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-01","metricId":"units","sourceId":"till","value":"2","currency":null,"dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-01","metricId":"revenue","sourceId":"till","value":"45.00","currency":"USD","dimensions":{"channel":"stall"}}
{"workspaceId":"pebble-press","date":"2026-03-01","metricId":"units","sourceId":"till","value":"3","currency":null,"dimensions":{"channel":"stall"}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"revenue","sourceId":"till","value":"0.00","currency":"USD","dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"units","sourceId":"till","value":"0","currency":null,"dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"revenue","sourceId":"till","value":"60.00","currency":"USD","dimensions":{"channel":"stall"}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"units","sourceId":"till","value":"4","currency":null,"dimensions":{"channel":"stall"}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"revenue","sourceId":"till","value":"15.00","currency":"USD","dimensions":{"channel":null}}
{"workspaceId":"pebble-press","date":"2026-03-02","metricId":"units","sourceId":"till","value":"1","currency":null,"dimensions":{"channel":null}}
{"workspaceId":"pebble-press","date":"2026-03-03","metricId":"revenue","sourceId":"till","value":"20.00","currency":"USD","dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-03","metricId":"units","sourceId":"till","value":"1","currency":null,"dimensions":{"channel":"web"}}
{"workspaceId":"pebble-press","date":"2026-03-03","metricId":"revenue","sourceId":"till","value":null,"currency":"USD","dimensions":{"channel":"stall"}}
{"workspaceId":"pebble-press","date":"2026-03-03","metricId":"units","sourceId":"till","value":"2","currency":null,"dimensions":{"channel":"stall"}}
```

`catalog.json`, with the descriptors the recipe above produced for those exact bytes:

```json
{
  "format": "kyn-files/v1",
  "workspaceId": "pebble-press",
  "name": "Pebble Press (Synthetic)",
  "revision": "2026-03-04-r1",
  "asOf": "2026-03-04T08:00:00Z",
  "timezone": "UTC",
  "writeDiscipline": "replace-folder",
  "sources": [
    {"id": "till", "name": "Invented till export (Synthetic)", "asOf": "2026-03-04T07:30:00Z"}
  ],
  "dimensions": [
    {
      "id": "channel",
      "name": "Sales channel",
      "parentId": null,
      "history": "restated-snapshot",
      "file": {"path": "dimensions/channel.jsonl", "bytes": 98, "rows": 2, "sha256": "02c2ab7c76d85411142db5a360532def094cb989b481e8dd56d6105a102510ca"}
    }
  ],
  "metrics": [
    {"id": "revenue", "name": "Revenue", "kind": "flow", "unit": "USD", "currency": "USD", "scale": 2, "sign": "nonnegative", "recognition": "Order paid, UTC business day", "sourceId": "till"},
    {"id": "units", "name": "Units sold", "kind": "flow", "unit": "unit", "currency": null, "scale": 0, "sign": "nonnegative", "recognition": "Order paid, UTC business day", "sourceId": "till"},
    {"id": "average_price", "name": "Average unit price", "kind": "ratio", "unit": "USD/unit", "currency": "USD", "scale": 2, "sign": "nonnegative", "recognition": "Revenue over units for the same rows", "sourceId": "till", "numerator": "revenue", "denominator": "units"}
  ],
  "datasets": [
    {
      "id": "daily-sales",
      "name": "Daily sales by channel",
      "kind": "aggregate",
      "sourceId": "till",
      "grain": ["channel"],
      "metricIds": ["revenue", "units", "average_price"],
      "files": [
        {"path": "facts/sales.jsonl", "bytes": 2113, "rows": 14, "sha256": "5ebf0a093bd1bec991205b3395c26676862ff4071c51b8768f3ae2fd623e6da9"}
      ],
      "coverage": [
        {"date": "2026-03-01", "status": "complete"},
        {"date": "2026-03-02", "status": "complete"},
        {"date": "2026-03-03", "status": "incomplete"}
      ]
    }
  ]
}
```

The check: `node <engine checkout>/scripts/validate-kyn.mjs knowledge/_examples/kyn-folder-example/kyn --workspace pebble-press`
exits 0 with `"valid": true` and twelve required checks at `PASS`.

Hand answers, which the engine reproduces:

- March 1 to 2 total: revenue 150.00, units 10, average price 15.00.
- March 1 to 2 by channel: web 30.00 and 2; stall 105.00 and 7; `(Unmapped)` 15.00 and 1.
  The three rows add to the total.
- Web shop on March 2: revenue 0.00, units 0, average price null (zero denominator, with a
  reason). A zero is a number; it is not unknown.
- Any range that includes March 3: every metric null, reason "missing or incomplete
  coverage". Neither the 20.00 nor the null on that day leaks into a sum.

## Make the revision available

1. With the staged folder green, replace the live one in one move from the repo root:
   `mv kyn kyn-previous && mv kyn-staging kyn`, rerun the validator on `kyn/`, then delete
   `kyn-previous`. When there is no live `kyn/` yet (the first revision), the move is just
   `mv kyn-staging kyn`. Never copy single files into a live folder; a mix of revisions
   fails its hashes, and the fix is a whole folder, not a removed hash.
2. Update the Data pointer node under `data/` (revision, as-of, read date). Preparing and
   checking do not commit or publish anything; commit the folder and the node together,
   with a plain message, only when the person asks for the revision to be committed. If
   this OS's `CLAUDE.md` asks for a session ledger entry, write it as for any other session
   (`[[skill-manage-ai-session]]`); the skill adds no extra record of its own.
3. A running dashboard reads the new revision after `adapter.reload()` or a fresh adapter;
   a report keeps pointing at its own frozen copy. Both are the reporting host's concern,
   not files in this OS.
4. If validation fails, stop here: leave `kyn-staging/` and the validator output for
   review, and say plainly which check failed and why.

## Quality checks

- Every fact date has a coverage record; `complete` is written only where you can defend
  exhaustive observation.
- Every descriptor was recomputed after the last edit to its file.
- The validator printed `"valid": true` on the exact folder that is now live.
- One total and one grouped reconciliation were checked by hand with exact decimals.
- The catalog name of any invented set contains the word Synthetic.

## Anti-patterns

- Turning null into `"0"` to make a query return a number.
- Marking a day `complete` because the extraction finished, rather than because everything
  was observed.
- Storing a subtotal, an `(All)` row, or a computed ratio as a fact row.
- Editing a file in the live `kyn/` in place, or editing a report's frozen copy.
- Hand-editing descriptors to match a guess instead of recomputing them.
