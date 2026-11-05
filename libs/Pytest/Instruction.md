# Pytest

## Background

Pytest is the most widely-used Python testing framework. It provides powerful features including parametrized tests (generating multiple test cases from data), fixtures (dependency injection for test setup/teardown with automatic dependency resolution), and comprehensive test reporting. This spec covers the three pillars: parametrize expansion, fixture dependency resolution, and test report summarization.

## Task

Complete implementation holes in explicitly editable regions in the `Pytest/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `expandParametrize`

- **Signature**: `def expandParametrize (item : TestItem) : List TestItem`
- **Description**: Expand a test item that has `@pytest.mark.parametrize` markers into multiple test items, one per parameter combination.
- **Postcondition**: `expandParametrize_postcond` requires:
  - If the item has no parametrize markers (`markers.filter (kind == .parametrize) = []`), return `[item]` unchanged
  - Result is never empty
  - All expanded items preserve the original `filePath` and `lineNo`
- **Key constraints**: Filter markers by `kind == .parametrize` to detect parametrization. Non-parametrized tests pass through as a singleton list. Each expanded item should have the same source location as the original.

### 2. `resolveFixtures`

- **Signature**: `def resolveFixtures (fixtures : List FixtureDef) (requested : List String) : Option (List FixtureDef)`
- **Description**: Resolve fixture dependencies using topological sort. Returns the fixtures in dependency order (dependencies before dependents), or `none` if resolution fails.
- **Postcondition**: `resolveFixtures_postcond` requires (5 clauses):
  - Empty request → `some []`
  - Circular dependencies (f1 depends on f2 AND f2 depends on f1) → `none`
  - On success: topological ordering — if `a` depends on `b`, then `b` appears before `a` in the list
  - On success: every requested fixture name has a corresponding `FixtureDef` in the result
  - On failure (none) with non-empty request: either a requested name is missing from available fixtures, or there's a circular dependency
- **Key constraints**: The topological ordering clause requires that for any `a, b` in the result where `b.name ∈ a.depNames`, there exist sublists `l1 ++ [b] ++ l2 ++ [a] ++ l3 = resolved`. This is the formal way to say "b comes before a."

### 3. `summarizeReports`

- **Signature**: `def summarizeReports (reports : List TestReport) : TestSummary`
- **Description**: Compute aggregate test outcome counts from a list of individual test reports.
- **Postcondition**: `summarizeReports_postcond` requires (8 clauses):
  - Empty reports → all zeros (`⟨0, 0, 0, 0, 0, 0, 0, 0.0⟩`)
  - `total = passed + failed + skipped + xfailed + xpassed + errors`
  - `total = reports.length`
  - `passed` = count of reports with `.passed` outcome
  - `failed` = count of reports with `.failed _` outcome
  - `skipped` = count of reports with `.skipped _` outcome
  - `xpassed` = count of reports with `.xpassed` outcome
  - `errors` = count of reports with `.error _` outcome
- **Key constraints**: Note that `xfailed` count is implied by the total equation but not explicitly specified as a filter. The counts must exactly match the filtered list lengths.

## Types

- **`MarkerKind`** — Marker types: skip, skipIf, xfail, parametrize, usefixtures, filterwarnings, custom
- **`Marker`** — A test marker: name, kind, positional args, keyword args
- **`TestOutcome`** — Test result: passed, failed (with message), skipped, xfailed, xpassed, error
- **`TestItem`** — A test to run: node ID, name, file path, line number, markers, parameters, parent IDs
- **`ParamSet`** — One parameter combination: argument names, values, optional ID, marks
- **`FixtureScope`** — Fixture lifetime: function, class, module, package, session (narrowest to broadest)
- **`FixtureDef`** — A fixture definition: name, scope, params, autouse flag, dependency names, module path
- **`ReportWhen`** — Report phase: setup, call, teardown
- **`TestReport`** — Report for one test phase: node ID, phase, outcome, optional traceback, captured sections, duration
- **`TestSummary`** — Aggregate counts: total, passed, failed, skipped, xfailed, xpassed, errors, total duration

## Hints

- For `expandParametrize`, filter the item's markers for `kind == .parametrize`. If none found, return `[item]`. Otherwise, parse the parametrize markers' args to generate parameter combinations, creating a new `TestItem` for each combination with the same `filePath` and `lineNo`.
- For `resolveFixtures`, implement a topological sort. Start with the requested names, look them up in `fixtures`, recursively resolve their `depNames`, and detect cycles. A standard approach: maintain visited/in-progress sets, DFS from each requested name.
- For `summarizeReports`, iterate through reports, match on each `outcome`, and count. The `xfailed` count can be computed as `total - passed - failed - skipped - xpassed - errors` to satisfy the total equation, or counted directly with a filter for `.xfailed _`.
- `TestOutcome` uses parameterized constructors (`.failed msg`, `.skipped reason`), so pattern matching in filters needs to handle the argument (e.g., `match r.outcome with | .failed _ => true | _ => false`).

## Edit Boundaries

`Pytest/*.lean` is divided into labeled sections:

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

- `Pytest/ExpandParametrize.lean`
- `Pytest/ResolveFixtures.lean`
- `Pytest/SummarizeReports.lean`
- `Pytest/Types.lean`

## Published model limits (v3)

Fixture resolution uses the explicit pair-cycle predicate and output-order/request coverage clauses. It does not establish general dependency-graph completeness or require every returned fixture to be an input record.
