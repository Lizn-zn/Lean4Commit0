# Jedi

## Background

Jedi is Python's most popular code analysis and autocompletion library, powering IDE features like code completion, goto definition, find references, signature help, and rename refactoring. It works by building a scope tree from the Python AST, extracting name definitions, and resolving names using Python's LEGB (Local, Enclosing, Global, Builtin) scoping rules. This spec models three core analysis operations: building the scope tree, extracting name definitions, and resolving active parameters in function signatures.

## Task

Complete implementation holes in explicitly editable regions in `Jedi/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `buildScopes`

- **Signature**: `def buildScopes (mod : Module) : List Scope`
- **Description**: Build a list of scopes from a Python module's AST. Each scope represents a lexical scope (module, function, class, lambda, comprehension) with its position range and parent link.
- **Postcondition**: `buildScopes_postcond` requires:
  - At least 1 scope in the result (the module scope)
  - The first scope has kind `module_`, no parent (`parentIdx = none`), and its name matches `mod.name`
  - Every scope's `startPos` line is ≥ 1 or 0
  - Every `parentIdx` is either `none` or a valid index into the result list
  - Every scope has a non-empty name (unless it's a comprehension scope)
  - Every scope satisfies `Position.le startPos endPos` (start ≤ end)
  - Every non-module scope has a parent (`parentIdx ≠ none`)
- **Key constraints**: The module scope must always be the first element. Parent indices form a tree rooted at the module scope (index 0). Walk the AST to discover function definitions, class definitions, lambdas, and comprehensions as nested scopes.

### 2. `activeParameter`

- **Signature**: `def activeParameter (sig : SignatureInfo) (argIdx : Nat) : Option ParamInfo`
- **Description**: Given a function signature and the index of the argument being typed, determine which parameter is "active" (should be highlighted in the signature help display).
- **Postcondition**: `activeParameter_postcond` requires:
  - Empty parameter list → `none`
  - `argIdx = 0` → returns the first parameter (`some (params.head)`)
  - `argIdx ≥ params.length` AND no `varPositional` param exists → `none`
  - If result is `some p`, then `p ∈ sig.params`
  - `argIdx < params.length` → result is not `none`
- **Key constraints**: When `argIdx` is within bounds, return the parameter at that index. When `argIdx` exceeds bounds, check for a `*args` parameter (kind = `varPositional`) — if one exists, it should be returned as the active parameter for all overflow arguments. Otherwise return `none`.

### 3. `extractNameDefs`

- **Signature**: `def extractNameDefs (mod : Module) : List NameDef`
- **Description**: Extract all name definitions from a module's AST, including variables, functions, classes, parameters, imports, for-loop variables, with-statement variables, and except-clause variables.
- **Postcondition**: `extractNameDefs_postcond` requires:
  - Empty module body → empty result
  - Every definition's `modulePath` matches `mod.filePath`
  - Every definition's name is non-empty (length ≥ 1)
  - Every definition's position has line ≥ 1
  - Every definition's `scopeIdx` is bounded by `result.length + mod.body.length + 1`
  - The count of `function_` kind definitions ≥ `countFuncDefs mod.body` (top-level function defs)
  - The count of `class_` kind definitions ≥ `countClassDefs mod.body` (top-level class defs)
- **Key constraints**: The last two constraints ensure you find at least as many function/class definitions as there are top-level `functionDef`/`classDef` statements. You may find more if nested definitions are also extracted. The `scopeIdx` should reference a valid scope from `buildScopes`.

## Types

- **`Position`**: A source code location with `line` and `column` (both `Nat`). Has `Position.le` for comparison (already implemented).
- **`Module`**: A Python module with `name`, `filePath`, and `body : List Stmt`.
- **`Stmt`**: A Python statement AST node — `functionDef`, `classDef`, `assign`, `import_`, `importFrom`, `forStmt`, `withStmt`, `tryStmt`, etc. Each carries a `Position`.
- **`Expr`**: A Python expression AST node — `name`, `call`, `attribute`, literals, operators, etc.
- **`Scope`**: A lexical scope with `kind` (module/function/class/lambda/comprehension), `name`, position range (`startPos`/`endPos`), and `parentIdx` (index into the scope list, or `none` for the root).
- **`ScopeKind`**: The type of scope — `builtin`, `module_`, `class_`, `function_`, `lambda_`, `comprehension`.
- **`NameDef`**: A name definition with `name`, `kind`, `pos`, `scopeIdx`, `modulePath`, optional `annotation` and `docstring`.
- **`NameDefKind`**: The kind of definition — `variable`, `function_`, `class_`, `parameter`, `importDef`, `importFrom`, `withVar`, `forVar`, `exceptVar`.
- **`SignatureInfo`**: Function signature with `name`, `params : List ParamInfo`, optional `returnType`, `docstring`, `modulePath`.
- **`ParamInfo`**: A parameter with `name`, `kind` (positionalOnly/positionalOrKw/varPositional/keywordOnly/varKeyword), optional `annotation`, `defaultVal`, `description`.
- **`FuncArgs`**: Function argument specification with `args`, optional `vararg`, `kwonlyargs`, optional `kwarg`.

## Hints

- Already implemented helpers (not `sorry`):
  - `Position.le` — compares two positions (line then column)
  - `countFuncDefs` — counts top-level `functionDef` statements in a list
  - `countClassDefs` — counts top-level `classDef` statements in a list
- For `buildScopes`: start with a module scope at index 0. Walk `mod.body` recursively. For each `functionDef`, `classDef`, `lambda`, create a new scope with `parentIdx` pointing to the enclosing scope's index. Comprehensions (list/dict/set/generator) also create scopes.
- For `activeParameter`: if `argIdx < params.length`, return `params[argIdx]?`. If `argIdx ≥ params.length`, scan for a `varPositional` param and return it. Otherwise `none`.
- For `extractNameDefs`: walk the AST recursively. Each `functionDef` name → `NameDefKind.function_`, each `classDef` name → `class_`, assignment targets → `variable`, function parameters → `parameter`, import names → `importDef`/`importFrom`, for-loop targets → `forVar`, with-statement targets → `withVar`, except clause names → `exceptVar`.

## Edit Boundaries

`Jedi/*.lean` is divided into labeled sections:

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

- `Jedi/ActiveParameter.lean`
- `Jedi/BuildScopes.lean`
- `Jedi/ExtractNameDefs.lean`
- `Jedi/Helpers.lean`
- `Jedi/Types.lean`
