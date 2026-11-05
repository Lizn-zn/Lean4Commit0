# Pylint

## Background

Pylint is a Python code linting and static analysis framework. It defines checkers that visit AST nodes and emit messages (warnings, errors, conventions), then computes a quality score from 0 to 10. This spec covers the core pipeline: a concrete lint check (line length), the checker execution framework, and the scoring system.

## Task

Complete implementation holes in explicitly editable regions in the `Pylint/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `checkLineLength`

- **Signature**: `def checkLineLength (maxLen : Nat) (source : String) (filePath : String) : List Message`
- **Description**: Check each line of source code and emit a message for every line that exceeds `maxLen` characters.
- **Postcondition**: `checkLineLength_postcond` requires:
  - Empty source → empty result
  - All lines within limit → empty result
  - At least one long line → at least one message
  - Result count equals the number of lines exceeding `maxLen` (exact match with `(source.splitOn "\n").filter (fun l => l.length > maxLen)`)
  - Every message has `filePath` equal to the input `filePath`
  - Every message has `msgId = "C0301"`
- **Key constraints**: Split on `"\n"` to get lines. The count must be *exact* — one message per long line, no more, no less.

### 2. `runChecker`

- **Signature**: `def runChecker (checker : CheckerDef) (mod : Module) : List Message`
- **Description**: Run a checker on a module by applying `checker.visitFn` to each statement in the module's body, collecting all emitted messages.
- **Postcondition**: `runChecker_postcond` requires:
  - Empty module body → empty result
  - Every message in the result has `filePath = mod.filePath`
- **Key constraints**: The checker's `visitFn` takes a `LintContext` and a `Stmt`, returning messages. You need to construct the `LintContext` from the module and visit each statement in `mod.body`.

### 3. `computeScore`

- **Signature**: `def computeScore (stmtCount : Nat) (errors warnings refactors conventions : Nat) : Float`
- **Description**: Compute the Pylint quality score (0 to 10) based on the number of statements and message counts by category.
- **Postcondition**: `computeScore_postcond` requires:
  - `0.0 ≤ result ≤ 10.0`
  - `stmtCount = 0` → `result = 0.0`
  - No issues at all → `result = 10.0`
  - Total issues ≥ statement count → `result = 0.0`
  - Any issues → `result < 10.0`
  - Some issues but fewer than statements → `result > 0.0`
- **Key constraints**: The standard Pylint formula is `max(0, 10 - 10 * total_issues / stmtCount)`. The postcondition doesn't specify the exact formula but constrains the boundary behavior precisely.

## Types

- **`MessageCategory`** — Lint message severity: convention, refactor, warning, error, fatal
- **`MessageDef`** — A lint rule definition: message ID (e.g., "C0301"), symbol, category, description
- **`Message`** — A concrete lint message instance: message ID, symbol, category, line/column, text, file path, module name
- **`Expr`** — Simplified Python expression AST (names, literals, operators, calls, etc.)
- **`Stmt`** — Simplified Python statement AST (function/class defs, assignments, control flow, imports, etc.)
- **`Module`** — A Python module: name, file path, body (list of statements), optional docstring
- **`LintContext`** — Context for lint checks: module name, file path, parent statement
- **`CheckerDef`** — A checker: name, message definitions, and a visit function `LintContext → Stmt → List Message`

## Hints

- For `checkLineLength`, split the source by `"\n"`, enumerate lines with indices, filter for lines exceeding `maxLen`, and create one `Message` per violation. Set `msgId = "C0301"`, `symbol = "line-too-long"`, `category = .convention`, and `line` to the 1-based line number.
- For `runChecker`, create a `LintContext` from the module (`{ moduleName := mod.name, filePath := mod.filePath, parentStmt := none }`), then `flatMap` the checker's `visitFn` over `mod.body`.
- For `computeScore`, compute `total = errors + warnings + refactors + conventions`, then `max 0.0 (10.0 - 10.0 * total.toFloat / stmtCount.toFloat)`. Handle `stmtCount = 0` as a special case returning `0.0`.
- The `CheckerDef` structure has a function field `visitFn` which prevents it from deriving `Repr`/`BEq` — this is intentional.

## Edit Boundaries

`Pylint/*.lean` is divided into labeled sections:

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

- `Pylint/CheckLineLength.lean`
- `Pylint/ComputeScore.lean`
- `Pylint/RunChecker.lean`
- `Pylint/Types.lean`
