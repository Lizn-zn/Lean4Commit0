# TinyDB

## Background

TinyDB is a lightweight, pure-Python document-oriented database. It stores JSON-like documents in tables, supports a rich query language for searching/filtering, and provides CRUD operations. This spec covers the core pipeline: the query evaluation engine, document insertion, and document search.

## Task

Complete implementation holes in explicitly editable regions in `TinyDB/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Query.eval`

- **Signature**: `def Query.eval (q : Query) (doc : Value) : Bool`
- **Description**: Evaluate a query expression against a document value, returning whether the document matches.
- **Postcondition**: `Query.eval_postcond` requires (10 clauses):
  - `Query.all` → true; `Query.none` → false
  - `Query.and q1 q2` → logical AND of sub-evaluations
  - `Query.or q1 q2` → logical OR of sub-evaluations
  - `Query.not q'` → negation of sub-evaluation
  - `Query.exists f` → field exists in document
  - `Query.eq f v` → field value equals v
  - `Query.ne f v` → field exists and value ≠ v
  - `Query.search f sub` → field is a string containing substring
  - `Query.oneOf f vals` → field value is in the list
- **Key constraints**: The `ne` query returns false if the field doesn't exist (not just "not equal"). The `search` query only works on string fields. Three additional algebraic theorems must hold: double negation, and-all identity, or-none identity.

### 2. `Table.insert`

- **Signature**: `def Table.insert (t : Table) (data : Value) : Table × Nat`
- **Description**: Insert a document into the table. Returns the updated table and the assigned document ID.
- **Postcondition**: `Table.insert_postcond` requires (5 clauses):
  - Result table has exactly one more document
  - Returned ID equals `t.nextId`
  - Result table's `nextId` is incremented by 1
  - Table name is preserved
  - The document `{ docId := id, data := data }` is in the result's documents
- **Key constraints**: IDs are assigned sequentially from `nextId`. The table name must not change.

### 3. `Table.search`

- **Signature**: `def Table.search (t : Table) (q : Query) : List Document`
- **Description**: Return all documents in the table whose data matches the query.
- **Postcondition**: `Table.search_postcond` requires (4 clauses):
  - `Query.all` → returns all documents (= t.documents)
  - `Query.none` → returns empty list
  - Every result document is in the table and matches the query (soundness)
  - Every matching document in the table is in the result (completeness)
- **Key constraints**: The result must be both sound and complete — it's exactly the set of matching documents.

## Relational Properties

- **`Table.get_after_insert`**: After `t.insert data`, calling `get` with the returned ID returns `some { docId := id, data := data }`.
- **`Table.insert_search`**: After `t.insert data`, if `Query.eval q data = true`, then `{ docId := id, data := data } ∈ t'.search q`.

## Types

- **`Value`** — JSON-like document value: null, bool, int, float, str, list, dict (key-value pairs)
- **`Document`** — A value with an assigned document ID
- **`Query`** — Query expression: field existence, equality/inequality comparisons, string search, membership test, logical combinators (and/or/not), nested path queries, all/none constants
- **`Table`** — A named collection of documents with an auto-incrementing ID counter

## Hints

- `Value.getField` is an infrastructure function (marked `sorry`) that must be implemented. It should look up a field by name in a `Value.dict`, returning `none` for non-dict values or missing fields.
- `Table.get` is also infrastructure (marked `sorry`). It should find a document by its `docId`.
- For `Query.eval`, implement each query variant according to the postcondition. The recursive cases (`and`, `or`, `not`) call `Query.eval` recursively. Use `Value.getField` for field access.
- For `Table.insert`, append a new `Document` with `docId := t.nextId` and increment `nextId`.
- For `Table.search`, filter `t.documents` by `Query.eval q d.data`. The postcondition requires exact correspondence (filter semantics).
- The algebraic theorems (`eval_not_not`, `eval_and_all`, `eval_or_none`) follow directly from the definitions of `not`, `and`, `or`, `all`, and `none`.

## Edit Boundaries

`TinyDB/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `TinyDB/Eval.lean`
- `TinyDB/Helpers.lean`
- `TinyDB/Insert.lean`
- `TinyDB/Search.lean`
- `TinyDB/Types.lean`
