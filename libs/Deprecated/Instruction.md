# Deprecated

## Background

The `deprecated` library (Python) provides a mechanism for marking functions and types as deprecated, with configurable warning messages, version tracking, and removal policies. This spec models the core deprecation registry (register/lookup) and version-based removal checking, capturing the library's essential workflow: register a deprecation with metadata, query it by name, and determine whether a deprecated item should be treated as removed based on the current version.

## Task

Complete implementation holes in explicitly editable regions in the `Deprecated/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `DeprecationRegistry.register`

- **Signature**: `def DeprecationRegistry.register (reg : DeprecationRegistry) (name : String) (info : DeprecationInfo) : DeprecationRegistry`
- **Description**: Adds a deprecation entry (name + info) to the registry, preserving all existing entries.
- **Postcondition**: `register_postcond` requires:
  - The new `(name, info)` pair is a member of `result.entries`
  - All entries from the original registry are preserved in the result
- **Key constraints**: This is purely additive — existing entries must not be removed or modified.

### 2. `DeprecationRegistry.lookup`

- **Signature**: `def DeprecationRegistry.lookup (reg : DeprecationRegistry) (name : String) : Option DeprecationInfo`
- **Description**: Looks up deprecation info for a declaration by name, returning `some info` if found or `none` if not.
- **Postcondition**: `lookup_postcond` requires:
  - Empty registry always returns `none`
  - If `some info` is returned, then `(name, info)` must be in `entries`
  - If no entry with `name` exists, returns `none`
  - If any entry with `name` exists, returns `some`
- **Key constraints**: Must find entries by the `String` name (first component of the pair). If multiple entries exist for the same name, returning any one of them satisfies the spec.

### 3. `isRemoved`

- **Signature**: `def isRemoved (info : DeprecationInfo) (currentVersion : VersionInfo) : Bool`
- **Description**: Checks whether a deprecated item should be treated as fully removed, based on comparing the current version against the `removedIn` version in the deprecation info.
- **Postcondition**: `isRemoved_postcond` requires:
  - If `removedIn` is `none`, return `false` (no removal version set)
  - If `removedIn` is `some rv` and `currentVersion < rv`, return `false` (not yet removed)
  - If `removedIn` is `some rv` and `currentVersion ≥ rv` (i.e., compare is not `.lt`), return `true`
- **Key constraints**: Uses `VersionInfo.compare` which is already implemented as `Ord.compare`. The comparison is: `currentVersion ≥ removedIn` means removed.

## Relational Properties

- **`register_lookup_rel`**: After registering `(name, info)` into a registry, looking up `name` returns `some info`. This verifies that register and lookup are consistent.

## Types

- **`DeprecatedAction`**: Either `.warning` (allow use with warning) or `.error` (disallow use). Used in `DeprecationInfo.action`.
- **`VersionInfo`**: Semantic version with `major`, `minor`, `patch` fields. Has `BEq`, `Ord`, and `ToString` instances. `VersionInfo.compare` is already implemented via the derived `Ord` instance.
- **`DeprecationInfo`**: Metadata for a deprecation — `reason` (string), `since` (optional version), `removedIn` (optional version), `replacement` (optional string), `action` (warning or error).
- **`DeprecationRegistry`**: A list of `(String × DeprecationInfo)` pairs mapping declaration names to their deprecation info.

## Hints

- `VersionInfo.compare` is already fully implemented (not `sorry`) as `Ord.compare v1 v2` — use it directly in `isRemoved`.
- For `register`, prepending or appending the new entry to `entries` both work. Prepending (`(name, info) :: reg.entries`) makes the membership proof simpler.
- For `lookup`, a simple `List.find?` or recursive search on `entries` matching the name component works. If you prepend in `register`, `lookup` will naturally find the most recently registered entry first, which satisfies `register_lookup_rel`.
- The `register_lookup_rel` proof requires `register` and `lookup` to be consistent — if `register` prepends and `lookup` scans from the front, the proof is straightforward.

## Edit Boundaries

The editable module files under `Deprecated/` are divided into labeled sections:

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

- `Deprecated/Helpers.lean`
- `Deprecated/IsRemoved.lean`
- `Deprecated/Lookup.lean`
- `Deprecated/Register.lean`
- `Deprecated/Relations.lean`
- `Deprecated/Types.lean`
