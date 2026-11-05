# Requests

## Task

Complete implementation holes in explicitly editable regions in the split files under `Requests/` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Layout

- `Requests/Types.lean`: shared `ContentType` type
- `Requests/Helpers.lean`: shared helpers such as `String.containsSubstr`, `isAbsoluteUrl`, and `ContentType` predicates
- `Requests/ParseContentType.lean`: `parseContentType`
- `Requests/UrlJoin.lean`: `urlJoin`
- `Requests/DomainMatch.lean`: `domainMatch`

## Core Functions

- `parseContentType`: parse a content-type header into media type and parameters.
- `urlJoin`: combine a base URL and a relative URL.
- `domainMatch`: check cookie-domain matching.

## Edit Boundaries

The split files under `Requests/` use:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `Requests/DomainMatch.lean`
- `Requests/Helpers.lean`
- `Requests/ParseContentType.lean`
- `Requests/Types.lean`
- `Requests/UrlJoin.lean`
