# Fabric

## Background

Fabric is a Python library for streamlining SSH-based deployment and remote execution. It provides task orchestration with dependency resolution, layered configuration management (with precedence levels from defaults to runtime), and shell command composition. This spec models Fabric's core logic as pure data structures without actual I/O or SSH connections.

## Task

Complete implementation holes in explicitly editable regions in `Fabric/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `resolveDependencies`

- **Signature**: `def resolveDependencies (tasks : List TaskDef) (target : TaskId) : Option (List TaskId)`
- **Description**: Given a list of task definitions and a target task, resolve all transitive dependencies and return them in topological execution order, with the target task last. Returns `none` if resolution fails (e.g., circular dependencies or missing target).
- **Postcondition**: `resolveDependencies_postcond` requires:
  - The target task is the last element in the result (`getLast? = some target`)
  - The result has at least 1 element and contains the target
  - Topological ordering: for every task in the result, all of its dependencies that appear in the result come earlier (verified via `listIndexOf`)
  - Dependency completeness: if a task in the result has a dependency that exists in the task list, that dependency is also in the result
- **Key constraints**: The `listIndexOf` helper (already implemented) is used in the postcondition to check ordering. `TaskId` uses `BEq` for comparison. The result must be a valid topological sort — not just any ordering.

### 2. `Config.get`

- **Signature**: `def Config.get (cfg : Config) (key : String) : Option ConfigValue`
- **Description**: Look up a configuration value by key, returning the value from the highest-precedence level if multiple entries exist for the same key.
- **Postcondition**: `Config.get_postcond` requires:
  - Empty config returns `none`
  - If `some v` is returned, there exists an entry with that key and value in the config
  - The returned entry has the maximum `level.precedence` among all entries with the same key
  - If any entry with the key exists, the result is not `none` (completeness)
- **Key constraints**: Precedence is defined by `ConfigLevel.precedence` (defaults=0, system=1, user=2, project=3, runtime=4). When multiple entries share a key, the one with the highest precedence wins.

### 3. `ShellFragment.render`

- **Signature**: `def ShellFragment.render : ShellFragment → String`
- **Description**: Render a shell command fragment AST into an executable shell command string.
- **Postcondition**: `ShellFragment.render_postcond` requires:
  - `.literal cmd` renders to exactly `cmd`
  - `.pipe a b` renders to a non-empty string containing `" | "`
  - `.subshell f` renders to a string starting with `(` and ending with `)`
  - `.env key value f` renders to a non-empty string containing `key=value` (when key and value are non-empty)
  - `.cd dir f` renders to a non-empty string starting with `"cd "` (when dir is non-empty)
  - `.sudo f user` renders to a non-empty string starting with `"sudo"`
  - `.quoted s` renders to a non-empty string starting and ending with `'`
- **Key constraints**: This is a recursive function over the `ShellFragment` inductive type. Each variant has specific formatting rules. The `.andThen`, `.orElse`, and `.redirect` variants have no postcondition constraints — implement them reasonably (e.g., `&&`, `||`, `>` / `>>`).

## Relational Properties

- **`resolveDependencies_closed_rel`**: Every task ID in the result is either the target itself or the ID of a task in the input list. Additionally, the result contains no duplicates.
- **`Config.set_get_roundtrip_rel`**: After setting key `k` to value `v` at any level, `get k` returns `some v`.
- **`Config.higher_level_overrides_rel`**: If you set the same key at a low level then a high level, `get` returns the high-level value.
- **`ShellFragment.literal_render_rel`**: Rendering a `.literal s` fragment returns exactly `s`.

## Types

- **`ShellFragment`**: An AST for shell commands with 10 constructors: `literal`, `quoted`, `pipe`, `andThen`, `orElse`, `subshell`, `redirect`, `env`, `cd`, `sudo`. Supports recursive composition.
- **`TaskId`**: A task identifier with a namespace (list of strings) and a name. Uses `BEq` for equality.
- **`TaskDef`**: A task definition with an `id`, optional `description`, list of `hosts`, list of `dependencies` (as `TaskId`s), and execution `order`.
- **`ConfigLevel`**: Five precedence levels from `defaults` (lowest, 0) to `runtime` (highest, 4).
- **`ConfigValue`**: A sum type for configuration values: `str`, `int`, `bool`, `list`, `dict`, or `none`.
- **`ConfigEntry`**: A triple of `key`, `value`, and `level`.
- **`Config`**: A list of `ConfigEntry` records.

## Hints

- Already implemented helpers (not `sorry`):
  - `ConfigLevel.precedence` — maps each level to a `Nat` (0–4)
  - `listIndexOf` — finds first index of an element in a list (returns list length if not found)
  - `Config.empty` — creates an empty config (`⟨[]⟩`)
  - `String.containsSubstr` — checks substring presence using `splitOn`
- For `Config.set`, replace all existing entries for the key before inserting the new value. Prepending alone can leave a higher-precedence old entry and violate the unconditional set/get roundtrip.
- For `Config.get`, iterate through all entries, filter by key, then select the one with maximum `level.precedence`.
- For `resolveDependencies`, implement a standard topological sort (e.g., DFS-based). Return `none` for cycles. Ensure the target is the last element.
- For `ShellFragment.render`, pattern match on each constructor. For `.quoted s`, wrap in single quotes: `"'" ++ s ++ "'"`. For `.pipe a b`, render both and join with `" | "`. For `.sudo`, prepend `"sudo "` (or `"sudo -u user "` if a user is given).
- The `set_get_roundtrip_rel` proof requires the new entry to be the effective value even when the previous configuration contained a higher-precedence entry for that key.

## Edit Boundaries

`Fabric/*.lean` is divided into labeled sections:

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

- `Fabric/ConfigGet.lean`
- `Fabric/Helpers.lean`
- `Fabric/Relations.lean`
- `Fabric/ResolveDependencies.lean`
- `Fabric/ShellFragmentRender.lean`
- `Fabric/Types.lean`
