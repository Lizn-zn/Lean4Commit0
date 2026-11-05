# FastApi

## Background

FastAPI is a modern Python web framework for building APIs. It features automatic request routing with URL pattern matching and parameter extraction, Pydantic-style request body validation with type checking, and automatic OpenAPI (Swagger) documentation generation. This core spec focuses on the three pillars of FastAPI: URL matching, model validation, and OpenAPI spec generation — all modeled as pure functions over data structures with no IO.

## Task

Complete implementation holes in explicitly editable regions in `FastApi/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `matchURL`

- **Signature**: `def matchURL (pattern : URLPattern) (path : String) : Option (List (String × JsonValue))`
- **Description**: Matches a request path (e.g., `"/items/42"`) against a URL pattern (e.g., segments `[literal "items", parameter "item_id"]`), extracting path parameters as `JsonValue.str` values.
- **Postcondition**:
  - Empty pattern with path `"/"` → returns `some []`
  - On success, every `parameter` segment in the pattern has a corresponding `(name, JsonValue.str s)` entry in the result
  - The result list length equals the number of `parameter` segments in the pattern
- **Key constraints**: Literal segments must match exactly. Parameter segments capture the corresponding path segment as a string. Return `none` if the path doesn't match the pattern structure.

### 2. `validateModel`

- **Signature**: `def validateModel (modelDef : ModelDef) (data : List (String × JsonValue)) : List String`
- **Description**: Validates a JSON-like key-value data set against a model definition (like Pydantic validation). Returns a list of error messages — empty means valid.
- **Postcondition**:
  - If a required field is present but has the wrong type (e.g., `string` field has `int` value) → errors non-empty
  - If a required field is missing entirely → errors non-empty
  - If all required fields are present with correct types → errors is `[]`
- **Key constraints**: Type checking uses `ParamType`: `.string` expects `JsonValue.str`, `.integer` expects `JsonValue.int`, `.float` expects `JsonValue.float`, `.boolean` expects `JsonValue.bool`. Non-required fields are ignored if missing.

### 3. `generateOpenAPISpec`

- **Signature**: `def generateOpenAPISpec (router : Router) (title : String) (version : String) (description : String := "") : OpenAPISpec`
- **Description**: Generates an OpenAPI specification from a router's route definitions. Each route becomes a path item with operations.
- **Postcondition**:
  - `result.title = title`, `result.version = version`, `result.description = description`
  - `result.paths.length = router.routes.length`
  - For every route in the router, there exists a path item in the result containing an operation whose `operationId` matches the route's `endpoint`
- **Key constraints**: Must produce exactly one path item per route. Each path item must contain at least one operation with the correct `operationId`.

## Relational Properties

None included in the core spec.

## Types

- **`HttpMethod`**: HTTP verb enum (GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS).
- **`JsonValue`**: Dynamically-typed JSON value (null, bool, int, float, str, array, object).
- **`ParamType`**: Parameter type enum (string, integer, float, boolean) — used for type checking.
- **`PatternSegment`**: A URL pattern segment — either a `literal` string or a `parameter` name.
- **`URLPattern`**: A list of `PatternSegment`s representing a URL pattern like `/items/{item_id}`.
- **`PathParam`/`QueryParam`**: Parameter definitions with name, type, and (for query) default/required.
- **`Route`**: A route definition with URL pattern, HTTP methods, endpoint name, parameters, and metadata.
- **`Router`**: A collection of routes with a URL prefix and tags.
- **`FieldDef`**: A model field with name, type, required flag, and optional default.
- **`ModelDef`**: A model definition (like Pydantic) with a name and list of fields.
- **`OpenAPISpec`/`OpenAPIPathItem`/`OpenAPIOperation`/`OpenAPIParam`/`SchemaType`**: OpenAPI document structure types.

## Hints

- For `matchURL`, split the path on `"/"` (dropping the leading empty string from the leading slash), then zip with the pattern segments. For each `literal` segment, check exact match; for each `parameter` segment, capture the path segment as `JsonValue.str`. Return `none` if lengths don't match or a literal doesn't match.
- For `validateModel`, iterate over `modelDef.fields`. For each required field, check if it exists in `data` and whether its `JsonValue` constructor matches the expected `ParamType`. Collect error messages for failures. Return `[]` if all required fields pass.
- For `generateOpenAPISpec`, map each route to an `OpenAPIPathItem`. For each route, create an `OpenAPIOperation` with `operationId = route.endpoint`. The `paramTypeToSchema` helper (not included but trivial) maps `ParamType` to `SchemaType`.
- The postcondition for `validateModel` uses a pattern where "wrong type" means no constructor of the expected form matches — e.g., for `.string`, the condition `∀ s, v ≠ .str s` means the value is not a string. This is how the spec encodes type mismatch.

## Edit Boundaries

`FastApi/*.lean` is divided into labeled sections:

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

- `FastApi/GenerateOpenAPISpec.lean`
- `FastApi/Helpers.lean`
- `FastApi/MatchURL.lean`
- `FastApi/Types.lean`
- `FastApi/ValidateModel.lean`
