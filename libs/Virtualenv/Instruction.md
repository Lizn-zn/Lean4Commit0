# Virtualenv

## Background

Virtualenv is Python's virtual environment and dependency management tool. This spec models the core algorithms: PEP 503 package name normalization, PEP 440 version specifier matching, and dependency resolution. These represent the fundamental operations needed to manage Python package installations — normalizing package names for comparison, filtering compatible versions, and resolving a dependency tree.

## Task

Complete implementation holes in explicitly editable regions in `Virtualenv/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `normalizeName`

- **Signature**: `def normalizeName (name : String) : String`
- **Description**: Normalize a Python package name according to PEP 503 — convert to lowercase, replace dots/underscores/hyphens with single hyphens, collapse consecutive separators.
- **Postcondition**: `normalizeName_postcond` requires (8 clauses):
  - Empty input → empty output; non-empty input → non-empty output
  - Result length ≤ input length
  - Result is all lowercase (`result.toLower = result`)
  - No dots or underscores in result
  - Only alphanumeric characters and hyphens in result
  - Alphanumeric characters from input (lowercased) appear in result in order (filtering out hyphens)
  - No consecutive hyphens (`--`) in result
- **Key constraints**: The 7th clause is the strongest — it requires that filtering out hyphens from the result gives exactly the lowercased alphanumeric characters from the input, in order. This means separators (`.`, `_`, `-`) are replaced with `-` and collapsed, while alphanumeric chars pass through lowercased.

### 2. `VersionSpecSet.filter`

- **Signature**: `def VersionSpecSet.filter (specs : VersionSpecSet) (versions : List Version) : List Version`
- **Description**: Filter a list of versions to only those that satisfy all specifiers in the set.
- **Postcondition**: `VersionSpecSet.filter_postcond` requires (6 clauses):
  - Empty versions → empty result
  - All result versions come from the input list (subset)
  - Result length ≤ input length
  - Empty specs → return all versions unchanged
  - Completeness: every matching version is in the result
  - Correctness: every result version matches the specs
- **Key constraints**: The result must be exactly the set of matching versions — both sound and complete. Uses `VersionSpecSet.matches` to check each version.

### 3. `resolveDependencies`

- **Signature**: `def resolveDependencies (requirements : List Dependency) (available : List PackageInfo) (env : MarkerEnv) : ResolutionResult`
- **Description**: Resolve a list of dependency requirements against available packages, considering environment markers. Returns success with resolved packages, or conflict/missing on failure.
- **Postcondition**: `resolveDependencies_postcond` requires (4 clauses):
  - Empty requirements → `success []`
  - On success, every resolved package exists in the available list (name + version match)
  - On success, every needed requirement has a corresponding resolved package
  - If a needed requirement has no matching package name in available, resolution cannot succeed
- **Key constraints**: Uses `Dependency.isNeeded` to check which requirements apply in the current environment. The 4th clause ensures that missing packages are properly detected.

## Relational Properties

- **`normalizeName_idempotent`**: `normalizeName (normalizeName name) = normalizeName name` — normalizing an already-normalized name produces the same result.

## Types

- **`Version`** — PEP 440 version: epoch, release segments (list of Nat), optional pre-release/post/dev/local
- **`PreRelease`** — Pre-release segment: alpha, beta, or rc with a number
- **`SpecOp`** — Version specifier operators: ==, !=, >=, <=, >, <, ~= (compatible), === (arbitrary)
- **`VersionSpec`** — A single specifier: operator + version string
- **`VersionSpecSet`** — A set of specifiers (all must be satisfied)
- **`MarkerVar/MarkerOp/MarkerExpr`** — PEP 508 environment markers for conditional dependencies
- **`MarkerEnv`** — Environment values (OS, platform, Python version, etc.)
- **`Dependency`** — PEP 508 dependency: name, extras, version spec, marker, URL
- **`PackageInfo`** — A package with name, version, and its own dependencies
- **`ResolvedPackage`** — A resolved package: name + chosen version
- **`ResolutionResult`** — Resolution outcome: success (list of resolved), conflict (message), or missing (message)

## Hints

- `VersionSpec.matches` and `VersionSpecSet.matches` are infrastructure functions (`sorry`) that must be implemented. `VersionSpecSet.matches` should return true iff all individual specs match.
- `MarkerExpr.eval` is infrastructure (`sorry`) — evaluate marker expressions against the environment. Used by `Dependency.isNeeded`.
- `Dependency.isNeeded` is infrastructure (`sorry`) — if no marker, the dependency is always needed; otherwise evaluate the marker.
- For `normalizeName`, the algorithm is: lowercase the input, replace `.`, `_`, and `-` with `-`, then collapse consecutive `-` into one. The postcondition's 7th clause (alphanumeric order preservation) is the key constraint to satisfy.
- For `VersionSpecSet.filter`, simply filter the versions list by `VersionSpecSet.matches`.
- For `resolveDependencies`, iterate through requirements, check `isNeeded`, find matching packages in `available`, and select versions. Return `missing` if no package with the right name exists for a needed requirement.
- The idempotency proof should follow directly from the normalization postcondition — a normalized name already satisfies all the normalization rules.

## Edit Boundaries

`Virtualenv/*.lean` is divided into labeled sections:

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

- `Virtualenv/Filter.lean`
- `Virtualenv/Helpers.lean`
- `Virtualenv/NormalizeName.lean`
- `Virtualenv/ResolveDependencies.lean`
- `Virtualenv/Types.lean`
