# Graphene

## Background

Graphene is Python's leading GraphQL library, providing tools for building GraphQL schemas, parsing and validating queries, executing them against data, and supporting introspection. This spec models the core GraphQL lifecycle as pure data structures: validate a query document against a schema, execute it against a data tree, and introspect the schema's type system. No actual network I/O or resolver functions are involved — resolution is modeled by looking up fields in a `DataTree`.

## Task

Complete implementation holes in explicitly editable regions in `Graphene/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `validateDocument`

- **Signature**: `def validateDocument (schema : Schema) (doc : Document) : List ValidationError`
- **Description**: Validate a GraphQL document against a schema, returning a list of validation errors (empty if valid).
- **Postcondition**: `validateDocument_postcond` requires:
  - When ALL of the following hold, result must be `[]` (no errors):
    1. Schema is well-formed (`schema.validate = []`)
    2. All top-level field selections in operations exist in the query type
    3. All fragment type conditions reference types that exist in the schema
    4. All fragment spreads reference defined fragments
    5. No duplicate operation names (among named operations)
    6. No duplicate fragment names
  - When any operation selects a field not in the schema → `result ≠ []`
  - When any fragment references a non-existent type → `result ≠ []`
  - When there are duplicate operation names → `result ≠ []`
  - When there are duplicate fragment names → `result ≠ []`
- **Key constraints**: The validation checks are specific — you must detect exactly these 4 error conditions. The `collectFragmentSpreads` helper (already implemented) recursively collects fragment spread names from selections. The `hasDuplicates` helper (already implemented) checks for duplicate elements.

### 2. `executeDocument`

- **Signature**: `def executeDocument (ctx : ExecutionContext) : ExecutionResult`
- **Description**: Execute a GraphQL document against a schema and root data tree, returning the query result.
- **Postcondition**: `executeDocument_postcond` requires:
  - When the schema is valid, document validates, operations exist, and rootData is non-null: `result.resultData.isSome = true`
  - Under the same conditions, for every operation and every selected field name that exists as a key in rootData:
    - The field name appears in the result's data tree keys
    - For leaf fields: the resolved value matches the value in rootData exactly
- **Key constraints**: References `validateDocument` in its postcondition — the two must be consistent. Uses `selectionFieldNames` to extract field names, `dataTreeKeys` to get keys from a DataTree node, and `dataTreeLookup` to find values. All three helpers are already implemented.

### 3. `introspection` (introspection_postcond)

- **Signature**: This is a property over `introspectSchema`, `introspectType`, and `typeDefToIntrospection` — all three must be implemented.
- **Description**: For any type definition in the schema, introspection must expose it correctly.
- **Postcondition**: `introspection_postcond` requires that for any `td ∈ schema.types`:
  - An introspection type with `name = some td.name` exists in `(introspectSchema schema).types`
  - `introspectType schema td.name = some (typeDefToIntrospection td)`
  - `(typeDefToIntrospection td).kind` matches the expected kind (scalar→scalar, objectDef→object, etc.)
  - `(typeDefToIntrospection td).name = some td.name`
  - `(typeDefToIntrospection td).fields = td.fields` (preserves field definitions)
  - `(typeDefToIntrospection td).enumValues = td.enumValues` (preserves enum values)
- **Key constraints**: `expectedIntrospectionKind` (already implemented) maps each TypeDef variant to the correct IntrospectionTypeKind. `TypeDef.fields` and `TypeDef.enumValues` (already implemented) extract the relevant data from each variant.

## Types

- **`Schema`**: A GraphQL schema with `types` (list of TypeDef), `queryType` name, optional mutation/subscription types, and directives.
- **`TypeDef`**: A type definition — one of: scalarDef, objectDef (with fields + interfaces), interfaceDef, unionDef, enumDef, inputObjectDef.
- **`Document`**: A parsed GraphQL document with `operations` and `fragments`.
- **`OperationDef`**: An operation with type (query/mutation/subscription), optional name, variables, directives, and selections.
- **`Selection`**: A selection in a query — either a `field` (with name, alias, args, directives, sub-selections), `fragmentSpread`, or `inlineFragment`.
- **`DataTree`**: A tree of resolved values — `null`, `leaf` (wrapping a Value), `node` (named children), or `listNode`.
- **`ExecutionContext`**: Execution input: schema, document, variables, and rootData.
- **`ExecutionResult`**: Execution output: optional resultData (DataTree) and errors.
- **`IntrospectionType`**: The introspection representation of a type — kind, name, fields, enumValues, possibleTypes, ofType.
- **`IntrospectionSchema`**: The full introspection result — types, queryType, mutationType, subscriptionType, directives.
- **`ValidationError`**: An error with message, line, and column.

## Hints

- Already implemented helpers (not `sorry`):
  - `collectFragmentSpreads` — recursively collects fragment spread names from a selection list
  - `hasDuplicates` — checks if a list contains duplicate elements
  - `selectionFieldNames` — extracts field names from selections (ignores fragments)
  - `dataTreeKeys` — extracts key names from a `DataTree.node`
  - `dataTreeLookup` — looks up a key in a `DataTree.node`
  - `expectedIntrospectionKind` — maps TypeDef variants to IntrospectionTypeKind
  - `TypeDef.name`, `TypeDef.fields`, `TypeDef.enumValues` — extract data from TypeDef variants
- For `Schema.validate`, `Schema.lookupType`, `Schema.lookupField` — these are dependencies that need implementation but have no postconds in this core spec. Implement them consistently with how they're used in the postconditions.
- For `validateDocument`: check each of the 4 error conditions independently and collect errors. The postcond's "valid → empty" direction is the conjunction of all 5 preconditions.
- For `executeDocument`: iterate over operations and their selections, look up each selected field in rootData, and build the result DataTree.
- For `typeDefToIntrospection`: pattern match on the TypeDef variant and construct an IntrospectionType with the correct kind, name, fields, and enumValues.

## Edit Boundaries

`Graphene/*.lean` is divided into labeled sections:

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

- `Graphene/ExecuteDocument.lean`
- `Graphene/Helpers.lean`
- `Graphene/Introspection.lean`
- `Graphene/Types.lean`
- `Graphene/ValidateDocument.lean`
