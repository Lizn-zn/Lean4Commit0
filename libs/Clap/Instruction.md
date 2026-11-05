# Clap

## Background

Clap is a Rust command-line argument parsing library. Users define a `Command` with typed `Arg` definitions (flags, positional args, optional args with defaults), and Clap parses a list of command-line strings into structured `ArgMatches`. It also validates constraints (required args, conflicts) and generates help text. This spec models the parsing and help generation as pure functions on lists and records.

## Task

Complete implementation holes in explicitly editable regions in the `Clap/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parseAndValidate`

- **Signature**: `def parseAndValidate (cmd : Command) (args : List String) : Except ParseError ArgMatches`
- **Description**: Parse a list of command-line argument strings against a command definition, then validate that all constraints are satisfied (required args present, no unknown args, etc.).
- **Postcondition** (`parseAndValidate_postcond`):
  - On success: every required arg in `cmd.args` has a value in `matches_.values`
  - When no args are required and `args = []`: parsing succeeds
  - On success: every entry in `matches_.values` corresponds to some arg in `cmd.args`
  - On `missingRequired` error: the named arg exists in `cmd.args` and is required
- **Key constraints**: Args are matched by name. Flags (long options) are prefixed with `--`. The result must contain no values for undefined arguments.

### 2. `generateHelp`

- **Signature**: `def generateHelp (cmd : Command) : String`
- **Description**: Generate a human-readable help text string for a command, including the command name, description, and all argument names with their help strings.
- **Postcondition** (`generateHelp_postcond`):
  - Every arg's `name` appears as a substring of the result
  - If `cmd.about` is non-empty, it appears in the result
  - `cmd.name` appears in the result
  - Every arg's non-empty `help` string appears in the result
- **Key constraints**: Uses `String.containsSubstr` (also needs implementing) to check substring presence. The format is flexible — any string containing all required substrings satisfies the spec.

### 3. `ArgMatches.getString`

- **Signature**: `def ArgMatches.getString (m : ArgMatches) (name : String) : Option String`
- **Description**: Look up a parsed string value by argument name from the match results.
- **Postcondition** (`ArgMatches.getString_postcond`):
  - If result is `some s`, then `(name, ArgValue.string s)` is in `m.values`
  - If `name` is not in `m.values` at all (via `List.lookup`), result is `none`
  - If a string value for `name` exists, result is `isSome`
- **Key constraints**: Only returns `ArgValue.string` values, not flags or lists. Uses `List.lookup` for absence check (which finds the first matching key in an association list).

## Relational Properties

- **`parse_flag_rel`**: After successful `parseAndValidate`, if a flag arg with `long = some flagName` and `numArgs = .zero` is defined in the command, then `getBool flagName` returns `true` iff `"--{flagName}"` was in the argument list, and `false` otherwise.

## Types

- **`Arg`**: An argument definition with `name`, optional `short` char, optional `long` string, `help` text, `required` flag, optional `defaultValue`, `numArgs` (zero for flags, one for single value, many for lists), `possibleValues` whitelist, `conflicts` list, and `requires_` dependencies.
- **`Command`**: A command with `name`, `about` description, `version`, list of `Arg`s, and nested `subcommands`.
- **`ArgMatches`**: Parse result containing `values` (association list of name → `ArgValue`) and optional `subcommand` match.
- **`ArgValue`**: Either `.string s`, `.flag b`, or `.list ss`.
- **`NumArgs`**: How many values an arg takes: `.zero` (flag), `.one`, `.many`, or `.range min max`.
- **`ParseError`**: Error variants for missing required args, unknown args, invalid values, conflicts, etc.

## Hints

- `String.containsSubstr` can be implemented using `String.splitOn` — if splitting `s` on `sub` yields more than 1 piece, `sub` is a substring.
- For `parseAndValidate`, process args left-to-right: `--name value` for long options, `-x` for short flags, bare strings for positionals. After parsing, validate that all required args have values.
- `ArgMatches.getString` should scan `m.values` for the first entry with matching name that is an `ArgValue.string`.
- `ArgMatches.getBool` should scan for `ArgValue.flag` entries; default to `false` if not found.
- For `generateHelp`, concatenate the command name, about, and each arg's name/help into a formatted string. The exact format doesn't matter as long as all required substrings are present.
- `List.lookup` on `(String × ArgValue)` uses `BEq String` to find the first matching key.

## Edit Boundaries

The editable module files under `Clap/` are divided into labeled sections:

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

- `Clap/GenerateHelp.lean`
- `Clap/GetString.lean`
- `Clap/Helpers.lean`
- `Clap/ParseAndValidate.lean`
- `Clap/Relations.lean`
- `Clap/Types.lean`
