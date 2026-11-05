# FilesystemSpec

## Background

fsspec (filesystem_spec) is Python's standard abstract filesystem interface, providing a unified API for accessing different storage backends (local filesystem, S3, GCS, HDFS, etc.). This spec models the core path manipulation utilities and an in-memory filesystem implementation as pure data structures. The three core functions cover path joining, path normalization, and filesystem write operations.

## Task

Complete implementation holes in explicitly editable regions in `FilesystemSpec/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `pathJoin`

- **Signature**: `def pathJoin (base : String) (child : String) : String`
- **Description**: Join two path components with a `/` separator, following POSIX path semantics.
- **Postcondition**: `pathJoin_postcond` requires:
  - If `child` starts with `/` (absolute), result is just `child` (absolute child overrides base)
  - If `base` is empty, result is `child`
  - If `base` is non-empty and `child` is empty, result is `base`
  - If both non-empty and `child` is relative: if `base` ends with `/`, concatenate directly; otherwise insert `/` between them
- **Key constraints**: Use `String.front` and `String.back` to check first/last characters. The absolute-child-overrides rule takes priority.

### 2. `pathNormalize`

- **Signature**: `def pathNormalize (path : String) : String`
- **Description**: Normalize a path by removing redundant separators, `.` components, and resolving `..` components where possible.
- **Postcondition**: `pathNormalize_postcond` requires:
  - **Idempotent**: `pathNormalize result = result`
  - No double slashes (`//`) in result
  - No `/./` sequences in result
  - Result longer than 1 char does not end with `/`
  - Preserves absoluteness: if input starts with `/`, output does too
  - Empty input produces `"."` or `""`
  - Result doesn't end with `.` (unless it's `".."` or ends with `/..`)
  - **Identity for clean paths**: if the input has none of `//`, `/./`, `/../`, trailing `/`, trailing `/.`, trailing `/..`, leading `./`, and isn't `.`, `..`, or empty, then `result = path`
- **Key constraints**: This is the hardest function to implement and prove. The idempotency requirement (`pathNormalize result = result`) means you must get normalization exactly right — applying it twice must be a no-op. The identity-for-clean-paths clause is also important: don't over-normalize paths that are already clean.

### 3. `MemFS.put`

- **Signature**: `def MemFS.put (fs : MemFS) (path : String) (content : ByteArray) : FSResult MemFS`
- **Description**: Write a file with the given content to the in-memory filesystem, creating it if it doesn't exist or overwriting if it does.
- **Postcondition**: `MemFS.put_postcond` requires:
  - On success, the file exists in the resulting filesystem (`fs'.exists_ path = true`)
  - On success, reading the file back returns the exact content (`fs'.cat path = Except.ok content`)
- **Key constraints**: The postcondition references `MemFS.exists_` and `MemFS.cat`, which are also `sorry` — you must implement all three consistently. The `MemFS` stores files in a tree structure (`List (String × MemNode)`) rooted at `root`. You need to navigate/create the tree based on path components.

## Relational Properties

- **`pathJoin_pathSplit_roundtrip_rel`**: For non-empty `dir` and `base` where `base` contains no `/`, splitting `pathJoin dir base` returns `(dir, base)`. This ensures join and split are inverse operations.

## Types

- **`MemFile`**: An in-memory file with `content : ByteArray`, `modified : Nat`, `created : Nat`.
- **`MemNode`**: Either a `file` (wrapping `MemFile`) or a `dir` (containing child entries as `List (String × MemNode)` plus a modified timestamp).
- **`MemFS`**: The filesystem state: `root : List (String × MemNode)` and `currentTime : Nat`.
- **`FSError`**: Error type with variants: `fileNotFound`, `isADirectory`, `notADirectory`, `alreadyExists`, `permissionDenied`, `invalidPath`.
- **`FSResult α`**: Alias for `Except FSError α`.

## Hints

- `String.containsSubstr` is already implemented (not `sorry`) — it checks substring presence by scanning with `List.any`.
- For `pathJoin`, a simple if-else chain handles the 4 cases in the postcondition directly.
- For `pathNormalize`, a common approach is: split on `/`, process the component list (remove empty strings for `//`, remove `.` entries, handle `..` by popping the previous component), then rejoin. Be careful to preserve a leading `/` for absolute paths and handle edge cases like `"."` and `".."`.
- For `MemFS`, you'll need to implement `exists_`, `cat`, and `put` consistently. A natural approach:
  - Parse the path into components (split on `/`, filter empty)
  - Navigate the tree for `exists_` and `cat`
  - For `put`, create intermediate directories as needed, then insert/update the file node
- `pathSplit` and `isAbsolute` are also `sorry` — implement them to support the relational spec proof. `isAbsolute` just checks if the path starts with `/`. `pathSplit` splits at the last `/`.
- The `pathJoin_pathSplit_roundtrip` proof requires `pathJoin` and `pathSplit` to be consistent — if `pathJoin` inserts exactly one `/` between dir and base, then `pathSplit` must find that `/` and split there.

## Edit Boundaries

`FilesystemSpec/*.lean` is divided into labeled sections:

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

- `FilesystemSpec/Helpers.lean`
- `FilesystemSpec/MemFSPut.lean`
- `FilesystemSpec/PathJoin.lean`
- `FilesystemSpec/PathNormalize.lean`
- `FilesystemSpec/Relations.lean`
- `FilesystemSpec/Types.lean`
