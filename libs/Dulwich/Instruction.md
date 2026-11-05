# Dulwich

## Background

Dulwich is a pure Python implementation of the Git version control system's data structures and protocols. It provides functionality for reading and writing Git objects (blobs, trees, commits, tags), managing references (branches, tags), computing diffs, walking commit history, and handling pack files. This core spec focuses on the most fundamental Git operations: serializing and deserializing commit objects (Git's central data structure), and resolving references from names to SHA-1 hashes.

## Task

Complete implementation holes in explicitly editable regions in `Dulwich/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `serializeCommit`

- **Signature**: `def serializeCommit (c : Commit) : ByteArray`
- **Description**: Serializes a `Commit` object into its Git wire format as a `ByteArray`. The Git commit format is: `"commit <size>\0tree <treeSha>\nparent <parentSha>\n...author <identity>\ncommitter <identity>\n\n<message>"`.
- **Postcondition**:
  - Result size > 0
  - Result size ≥ treeSha.length + message.length + 20
  - Result size ≥ 50 (minimum for header + tree + author + committer)
  - Result size ≥ 50 + parents.length * 48 (each parent line is ~48 bytes)
- **Key constraints**: The size must grow proportionally with the number of parent commits. Each parent contributes a `"parent <40-char-sha>\n"` line (48 bytes).

### 2. `deserializeCommit`

- **Signature**: `def deserializeCommit (raw : ByteArray) : Option Commit`
- **Description**: Parses a raw `ByteArray` in Git commit format back into a `Commit` structure. Returns `none` if the input is invalid.
- **Postcondition**:
  - Empty input → returns `none`
  - If successful, the commit's `treeSha` has length 40
  - All parent SHAs have length 40
  - Author and committer names are non-empty
  - Raw data size ≥ 50
- **Key constraints**: Must validate structural integrity of the parsed commit. Must be the inverse of `serializeCommit` (see roundtrip relational spec).

### 3. `resolveRef`

- **Signature**: `def resolveRef (refs : List GitRef) (refName : String) : Option Sha1`
- **Description**: Resolves a Git reference name (e.g., `"refs/heads/main"`) to its target SHA-1 hash by searching a list of references.
- **Postcondition**:
  - Empty refs list → returns `none`
  - If result is `some sha`, then `sha.length = 40`
  - If result is `some sha`, there exists a `GitRef.direct refName sha` in the refs list
  - If a `GitRef.direct refName sha` exists in refs, result must be `some` (completeness)
  - If no matching direct or symbolic ref exists, result is `none`
- **Key constraints**: Must search for `GitRef.direct` refs matching the name. The completeness clause means you can't miss a match that exists.

## Relational Properties

- **`commit_roundtrip`**: `deserializeCommit (serializeCommit c) = some c` — serializing a commit then deserializing it recovers the original commit exactly.

## Types

- **`Sha1`**: Alias for `String` — a 40-character hexadecimal SHA-1 hash.
- **`ObjectType`**: Git object type enum: blob, tree, commit, tag.
- **`Identity`**: Author/committer identity with `name`, `email`, `timestamp` (Unix epoch as `Int`), and `tzOffset` (timezone offset in minutes as `Int`).
- **`Commit`**: A Git commit object with `treeSha`, `parents` (list of parent SHAs), `author`, `committer`, `message`, `sha`, and optional `encoding`/`gpgSig`.
- **`GitRef`**: A Git reference, either `direct` (name → SHA mapping) or `symbolic` (name → target ref name).

## Hints

- For `serializeCommit`, build the commit body first: `"tree <treeSha>\n"` + parent lines + `"author <formatted identity>\n"` + `"committer <formatted identity>\n\n<message>"`. Then prepend `"commit <body-length>\0"`. Convert the full string to `ByteArray` via `String.toUTF8`.
- For `deserializeCommit`, parse the header to extract the body, then parse `tree`, `parent` (zero or more), `author`, `committer` lines, and the message after the blank line. Return `none` for malformed input.
- For the roundtrip proof, the key is ensuring `serializeCommit` and `deserializeCommit` are exact inverses. Design them together so the format is consistent.
- For `resolveRef`, iterate through the refs list and find the first `GitRef.direct` whose name matches `refName`. Return its SHA, or `none` if no match is found.
- The `Identity` type stores timestamps as `Int` (Unix epoch seconds) and timezone offsets as `Int` (minutes). Format them as `"name <email> timestamp tzOffset"` in the Git wire format.

## Edit Boundaries

`Dulwich/*.lean` is divided into labeled sections:

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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Dulwich/DeserializeCommit.lean`
- `Dulwich/Helpers.lean`
- `Dulwich/Relations.lean`
- `Dulwich/ResolveRef.lean`
- `Dulwich/SerializeCommit.lean`
- `Dulwich/Types.lean`
- `Dulwich/Validity.lean`
