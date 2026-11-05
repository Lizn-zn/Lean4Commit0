# Voluptuous

## Background

Voluptuous is a Python data validation library that validates nested data structures (dictionaries, lists, scalars) against declarative schemas. Schemas are built from composable nodes: type checks, coercions, range/length constraints, list/dict validators, and logical combinators (all/any). This spec covers the core validation engine and demonstrates type validator behavior with the boolean validator.

## Task

Complete implementation holes in explicitly editable regions in `Voluptuous/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `validate`

- **Signature**: `def validate (node : SchemaNode) (value : Value) (path : List String := []) : Except MultipleInvalid Value`
- **Description**: Validate a value against a schema node. Returns the (possibly transformed) value on success, or a list of validation errors on failure.
- **Postcondition**: `validate_postcond` requires (11 clauses):
  - Literal node: ok result equals the expected value
  - Errors always have at least 1 entry
  - Result is always either ok or error (totality)
  - TypeCheck node: ok implies the check function passes and value is preserved
  - TypeCheck node: check failure implies error
  - Range node: non-numeric value (toFloat? = none) implies error
  - Length node: non-measurable value (length? = none) implies error
  - ListOf node: non-list value implies error
  - DictOf node: non-dict value implies error
  - DictOf node: missing required key implies error
  - DictOf with prevent: extra keys in dict implies error
- **Key constraints**: The validation engine must handle all `SchemaNode` variants. The postcondition constrains behavior for literal, typeCheck, range, length, listOf, and dictOf nodes specifically.

### 2. `isBoolean_accepts` (via `validate isBoolean`)

- **Signature**: Uses `validate isBoolean (.bool b)`
- **Description**: The boolean type validator accepts boolean values and returns them unchanged.
- **Postcondition**: `isBoolean_accepts_postcond` requires:
  - `validate isBoolean (.bool b) = .ok (.bool b)`
- **Key constraints**: The result must be exactly `.ok (.bool b)` — both acceptance and value preservation.

### 3. `isBoolean_rejects_int` (via `validate isBoolean`)

- **Signature**: Uses `validate isBoolean (.int n)`
- **Description**: The boolean type validator rejects integer values with an error.
- **Postcondition**: `isBoolean_rejects_int_postcond` requires:
  - Result is `.error e` where `e.errors.length ≥ 1`
- **Key constraints**: Must produce at least one error entry.

## Types

- **`Value`** — JSON-like dynamic value: null, bool, int, float, str, list, dict
- **`Invalid`** — A single validation error with message and path
- **`MultipleInvalid`** — A collection of validation errors
- **`ExtraKeys`** — Policy for extra dictionary keys: prevent (error), allow (pass through), remove (strip)
- **`KeyRequirement`** — Whether a dict key is required or optional (with optional default)
- **`SchemaNode`** — Schema definition: literal match, type check, coercion, all/any combinators, range/length constraints, regex match, list/dict validators, custom validator

## Hints

- `isBoolean` is a schema node (`sorry`) that should be defined as `SchemaNode.typeCheck "bool" Value.isBool` — a type check that uses the `Value.isBool` predicate.
- All `Value` helper functions (`isBool`, `isInt`, `isStr`, `isList`, `isDict`, `toFloat?`, `length?`) are already implemented (not `sorry`) and can be used directly.
- For `validate`, implement each `SchemaNode` variant:
  - `literal v`: check `value == v`, return `value` if match, error otherwise
  - `typeCheck _ check`: if `check value = true` return `.ok value`, else error
  - `range lo hi`: use `toFloat?` to get numeric value, check bounds
  - `length lo hi`: use `length?` to get length, check bounds
  - `listOf elemSchema`: check `isList`, then validate each element
  - `dictOf keys extra`: check `isDict`, verify required keys present, check extra key policy, validate each field
  - `all nodes`: all validators must pass
  - `any nodes`: at least one validator must pass
- The `path` parameter tracks the current location in nested structures for error reporting.
- Errors should always have `errors.length ≥ 1` — never return an empty error list.

## Edit Boundaries

`Voluptuous/*.lean` is divided into labeled sections:

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

- `Voluptuous/Helpers.lean`
- `Voluptuous/Types.lean`
- `Voluptuous/Validate.lean`
