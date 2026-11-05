# Click

## Background

Click is a Python library for creating beautiful command-line interfaces. It handles parameter type conversion, argument parsing, option resolution from multiple sources (CLI, environment variables, defaults), help text generation, and command grouping. This core spec focuses on the three most essential operations: converting raw strings to typed values, resolving parameters from multiple sources, and parsing command-line arguments.

## Task

Complete implementation holes in explicitly editable regions in the `Click/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `convertValue`

- **Signature**: `def convertValue (paramType : ParamType) (raw : String) : Except String ParamValue`
- **Description**: Converts a raw CLI string into a typed `ParamValue` based on the given `ParamType`.
- **Postcondition**:
  - STRING → wraps raw string as-is
  - BOOL → "true"/"false" map to `.bool true`/`.bool false`
  - Choice → if raw is in the choices list, returns `.str raw`; otherwise returns an error
  - INT → returns `.int n` for some `n`, or an error
  - FLOAT → returns `.float f` for some `f`, or an error
  - Path/File → passes through as `.str raw`
- **Key constraints**: Choice type must reject values not in the list. INT/FLOAT may fail with an error string.

### 2. `paramValueToString`

- **Signature**: `def paramValueToString (value : ParamValue) : String`
- **Description**: Converts a `ParamValue` back to its string representation (inverse of `convertValue` for simple types).
- **Postcondition**:
  - `.str s` → returns `s`
  - `.int n` → returns `toString n`
  - `.bool true` → "true", `.bool false` → "false"
  - `.none` → ""
- **Key constraints**: Must be consistent with `convertValue` to satisfy the roundtrip relational specs.

### 3. `resolveParam`

- **Signature**: `def resolveParam (name : String) (cliValue : Option String) (envValue : Option String) (defaultVal : Option ParamValue) (paramType : ParamType) : Except String ResolvedParam`
- **Description**: Resolves a parameter's value from multiple sources with priority: CLI argument > environment variable > default value. Returns a `ResolvedParam` with the value and its source.
- **Postcondition**:
  - If CLI value is present → source is `.commandLine`
  - If no CLI but env is present → source is `.environment`
  - If no CLI and no env but default exists → returns the default with source `.defaultValue`
  - If all sources are `none` → returns an error
  - Result always has `name` equal to the input `name`
- **Key constraints**: Must handle all combinations of `none`/`some` for the three sources. When CLI value is provided, it should be converted using `paramType`.

### 4. `parseArgs`

- **Signature**: `def parseArgs (cmd : Command) (args : List String) : Except String (List ResolvedParam)`
- **Description**: Parses a list of command-line argument strings against a `Command` definition, producing resolved parameters.
- **Postcondition**:
  - If a required option (with no default) is missing from args → returns an error
  - If the command has no options and no arguments → returns `Ok` with some parameter list
- **Key constraints**: Must check for required options by looking for `--optionName` prefixes in args.

## Relational Properties

- **`convertValue_string_roundtrip`**: Converting a string with STRING type then calling `paramValueToString` recovers the original string.
- **`convertValue_int_roundtrip`**: Converting `toString n` with INT type then calling `paramValueToString` recovers `toString n`.
- **`convertValue_bool_roundtrip`**: Converting "true" with BOOL type then calling `paramValueToString` recovers "true".

## Types

- **`ParamType`**: Inductive type representing CLI parameter types (STRING, INT, FLOAT, BOOL, Choice, Path, File, IntRange, FloatRange, UUID, Tuple).
- **`ParamValue`**: Inductive type for parsed values (str, int, float, bool, list, tuple, none).
- **`ParameterSource`**: Where a parameter's value came from (environment, defaultValue, prompt, commandLine).
- **`OptionDef`**: Definition of a CLI option with name, type, default, required flag, help text, etc.
- **`ArgumentDef`**: Definition of a positional CLI argument.
- **`ResolvedParam`**: A parameter after resolution — contains name, value, and source.
- **`Command`**: A CLI command with its name, help text, options, and arguments.

## Hints

- For `convertValue`, pattern match on `ParamType` and handle each variant. For INT, use `String.toInt?`; for FLOAT, use `String.toFloat?` (if available) or define a simple parser.
- For `paramValueToString`, pattern match on `ParamValue` — straightforward mapping.
- For `resolveParam`, check `cliValue` first, then `envValue`, then `defaultVal`, using `convertValue` when converting string sources.
- For `parseArgs`, iterate over the command's options and arguments, checking `args` for matches. The postcondition is relatively permissive — focus on the required-option error case and the empty-command success case.
- The roundtrip proofs require `convertValue` and `paramValueToString` to be consistent — implement them together.

## Edit Boundaries

The editable module files under `Click/` are divided into labeled sections:

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

- `Click/ConvertValue.lean`
- `Click/Helpers.lean`
- `Click/ParseArgs.lean`
- `Click/Relations.lean`
- `Click/ResolveParam.lean`
- `Click/Types.lean`
