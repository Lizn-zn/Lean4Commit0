# Pydantic

## Background

Pydantic is Python's most popular data validation library. It uses type annotations to validate data at runtime, coerce values to the correct types, apply constraints, and generate structured error messages. This spec covers the core validation pipeline: validating an entire model from input data, checking individual values against type descriptors, and applying field constraints.

## Task

Complete implementation holes in explicitly editable regions in the `Pydantic/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `ModelDef.validate`

- **Signature**: `def ModelDef.validate (m : ModelDef) (input : Value) : Except ValidationError ModelInstance`
- **Description**: Validate input data (expected to be a `Value.dict`) against a model definition, constructing a `ModelInstance` on success or returning validation errors on failure.
- **Postcondition**: `ModelDef.validate_postcond` requires:
  - On success: `inst.modelDef = m` (model definition is preserved)
  - On success: every field from the input dict that matches a field name in the model has a value in the instance
  - On success: every field in the model has a value in the instance (including defaults)
  - On success: `inst.data.length ≥ m.fields.length`
  - On success: str/int/bool fields with matching input types store the exact input value
  - Required fields (no default, no defaultFactory, not optional) missing from input produce an error
- **Key constraints**: The input is expected to be `Value.dict pairs`. Fields are looked up by name in the pairs. Default values must be applied for missing optional fields.

### 2. `validateType`

- **Signature**: `def validateType (td : TypeDesc) (value : Value) (strict : Bool := false) : Except String Value`
- **Description**: Validate a single value against a type descriptor. Returns the (possibly coerced) value on success, or an error message on failure.
- **Postcondition**: `validateType_postcond` requires (12 clauses):
  - Matching types pass through: str→str, int→int, bool→bool, float→float, null→none_
  - `any` type accepts everything
  - int→float coercion: `Value.int n` validates as `.float` producing `Float.ofInt n`
  - Strict mode: `strict = true` blocks int→str coercion (produces error)
  - Type mismatches produce errors: str value for int type, list value for int type, str value for bool type, null for bool type
- **Key constraints**: Non-strict mode allows int→float coercion but NOT str→int or str→bool. The `strict` flag only affects whether int can be accepted where str is expected.

### 3. `applyConstraints`

- **Signature**: `def applyConstraints (constraints : List Constraint) (value : Value) : Except String Value`
- **Description**: Apply a list of constraints to a value. Returns the value unchanged on success, or an error message if any constraint is violated.
- **Postcondition**: `applyConstraints_postcond` requires (10 clauses):
  - `minLength n` on `str s`: fails if `s.length < n`, passes if `s.length ≥ n`
  - `maxLength n` on `str s`: fails if `s.length > n`, passes if `s.length ≤ n`
  - `gt/ge/lt/le bound` on `float x`: passes/fails based on the comparison
  - `minItems n` on `list vs`: fails if `vs.length < n`, passes if `vs.length ≥ n`
  - `maxItems n` on `list vs`: fails if `vs.length > n`, passes if `vs.length ≤ n`
  - Empty constraints always pass
  - On success, the returned value equals the input value (constraints don't transform)
- **Key constraints**: The postcondition is specified for single-constraint lists (e.g., `constraints = [.minLength n]`). The last clause `result = .ok v → v = value` guarantees constraints are pure checks — they never modify the value.

## Types

- **`Value`** — A JSON-compatible dynamic value: null, bool, int, float, str, list, or dict (key-value pairs)
- **`Constraint`** — A validation constraint: string length bounds, numeric comparisons, list item counts, uniqueness
- **`TypeDesc`** — A type descriptor: primitive types (str, int, float, bool), compound types (optional, list, dict, tuple, union), constrained types, model references
- **`FieldInfo`** — A field definition: name, type descriptor, optional default value, alias, frozen/exclude/deprecated flags
- **`ValidationErrorItem`** — A single error: location path, message, optional input value
- **`ValidationError`** — A collection of errors with the model name
- **`ModelConfig`** — Model-level settings: frozen, extra fields handling, strict mode
- **`ModelDef`** — A model definition: name, fields, config, validators
- **`ModelInstance`** — A validated model instance: model definition + field data + extra data

## Hints

- **`ModelInstance.get`** is infrastructure — implement it as a list lookup on `inst.data`. Its postcondition is a simple found-or-not-found disjunction.
- For `ModelDef.validate`, iterate through `m.fields`, look up each field name in the input dict, validate the value with `validateType`, apply constraints, and use defaults for missing fields. Collect all field values into `inst.data`.
- For `validateType`, match on `(td, value)` pairs. Most cases are straightforward pattern matches. The int→float coercion (`Value.int n` → `Value.float (Float.ofInt n)`) is the main non-trivial case.
- For `applyConstraints`, fold through the constraint list checking each one. Since the postcondition specifies behavior for single-constraint lists, a recursive/folding implementation that checks one constraint at a time is natural.
- The `FieldInfo` structure has a `defaultFactory` field of type `Option (Unit → Value)` — this prevents `FieldInfo` from deriving `BEq`/`DecidableEq`, which may affect proof strategies.

## Edit Boundaries

`Pydantic/*.lean` is divided into labeled sections:

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

- `Pydantic/ApplyConstraints.lean`
- `Pydantic/Get.lean`
- `Pydantic/Types.lean`
- `Pydantic/Validate.lean`
- `Pydantic/ValidateType.lean`

## Published model limits (v3)

Success completeness is required only for the explicit unique-key, correctly typed unconstrained primitive-field domain. Combined constraints and other upstream features are not implied.
