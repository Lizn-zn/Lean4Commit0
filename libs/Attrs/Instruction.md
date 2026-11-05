# Attrs

## Background

Attrs is a Python library for defining structured data types (classes) with automatic generation of common operations like validation, equality, comparison, and representation. In this Lean formalization, attrs is modeled as a schema definition system where `ClassDef` describes a structured type with typed fields (attributes), each having optional validators, converters, and default values, and `Instance` holds the actual field values conforming to a class definition.

## Task

Complete implementation holes in explicitly editable regions in the `Attrs/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `ClassDef.create`

- **Signature**: `def ClassDef.create (cls : ClassDef) (values : List (String × Value)) : Except String Instance`
- **Description**: Create an instance of an attrs class from a list of (field name, value) pairs, applying validation and filling in defaults.
- **Postcondition**: Six requirements:
  1. Every attribute in the class has a corresponding value in the resulting instance
  2. If any validator on an attribute rejects its value, the result is an error
  3. If all fields are provided (or have defaults) and all validations pass, creation succeeds
  4. The resulting instance's `classDef` equals the input class
  5. Values for fields without converters are preserved as-is in the instance
  6. When no value is provided for a field with a `.value d` default, `d` is stored
- **Key constraints**: Must check all validators on each field. Fields without a provided value must have a default (`.value` or `.factory`), otherwise creation should fail. Converters (if present) transform values before storing.

### 2. `Instance.get`

- **Signature**: `def Instance.get (inst : Instance) (field : String) : Option Value`
- **Description**: Look up a field value by name in an instance.
- **Postcondition**: Either the field exists and the result is `some v` where `(field, v) ∈ inst.values`, or the field doesn't exist and the result is `none`.
- **Key constraints**: Simple lookup in the `values` list. If the field name appears multiple times, returning the first match is sufficient.

### 3. `Instance.evolve`

- **Signature**: `def Instance.evolve (inst : Instance) (changes : List (String × Value)) : Except String Instance`
- **Description**: Create a new instance with some fields changed (functional update), applying validation on the changed values.
- **Postcondition**: Six requirements:
  1. Fields not in `changes` retain their original values (via `get`)
  2. Fields in `changes` take the new value from the changes list
  3. The `classDef` is preserved
  4. Frozen instances always return an error
  5. If any validator rejects a changed value, the result is an error
  6. If not frozen and all validations pass, evolve succeeds
- **Key constraints**: Must validate changed values against the attribute's validators. Only fields mentioned in `changes` are updated; all others are carried over. The instance's class definition must not change.

## Relational Properties

- **`get_after_create_rel`**: If `ClassDef.create` succeeds and a field/value pair was in the input values, then `Instance.get` on that field returns that value (for fields without converters). This ties `create` and `get` together.
- **`evolve_empty_rel`**: Evolving with an empty changes list preserves the instance's values exactly.

## Types

- **`Value`**: A dynamically-typed sum type representing field values — can be `none`, `bool`, `int`, `float`, `str`, `list`, or `dict`. Uses `BEq` for equality.
- **`Validator`**: Has a `name` and a `check` function `Value → Option String`. Returns `none` if valid, `some msg` if invalid.
- **`Converter`**: Has a `name` and a `convert` function `Value → Value` that transforms values before storage.
- **`Default`**: Either `.none` (required field), `.value v` (fixed default), or `.factory f` (computed default via `f ()`).
- **`Attribute`**: A field definition with a name, optional default, list of validators, optional converter, and various boolean flags (repr, eq, order, hash, init).
- **`ClassDef`**: A class schema with a name, list of attributes, and a `frozen` flag (if true, instances cannot be modified).
- **`Instance`**: Holds a reference to its `ClassDef` and a `values : List (String × Value)` storing field data.

## Hints

- `Instance.get` is the simplest function — implement it first as a list lookup, since `evolve` postconditions reference `get`.
- For `ClassDef.create`, iterate over `cls.attributes`: for each attribute, find the value in `values` or use the default. Apply the converter if present, then run all validators. Collect results into a new `Instance`.
- For `Instance.evolve`, check frozen status first. Then for each field in the original instance, check if it appears in `changes` — if so, validate and use the new value; otherwise keep the old value.
- The `values` field is a `List (String × Value)`, so membership proofs use `List.Mem`. Standard list lemmas (`List.mem_map`, `List.mem_filter`, etc.) will be useful for the proofs.
- `Default.factory` takes a `Unit → Value` function — call it with `()` to get the default value.

## Edit Boundaries

`Attrs/*.lean` is divided into labeled sections:

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

- `Attrs/Create.lean`
- `Attrs/Evolve.lean`
- `Attrs/Get.lean`
- `Attrs/Types.lean`
