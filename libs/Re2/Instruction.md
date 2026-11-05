# Re2

## Background

RE2 is Google's high-performance regular expression library that guarantees linear-time matching by using NFA/DFA simulation instead of backtracking. It provides regex parsing, Thompson NFA construction, and multiple matching strategies. This spec covers the core workflow: full-string matching, finding all occurrences, and compiling regex ASTs into NFA programs.

## Task

Complete implementation holes in explicitly editable regions in the `Re2/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `fullMatch`

- **Signature**: `def fullMatch (pattern : String) (input : String) : Bool`
- **Description**: Check whether the pattern matches the entire input string (not just a substring).
- **Postcondition**: `fullMatch_postcond` and `fullMatch_iff_postcond` require:
  - `result = true` implies `findFirst pattern input = some (0, input.length)` — the first match spans the entire input
  - The converse also holds (iff): if findFirst returns a full-span match, fullMatch is true
- **Key constraints**: This is a biconditional — fullMatch is exactly equivalent to findFirst returning `(0, input.length)`. The implementation must parse the pattern, compile it, and run a matching engine.

### 2. `findAll`

- **Signature**: `def findAll (pattern : String) (input : String) : List (Nat × Nat)`
- **Description**: Find all non-overlapping matches of the pattern in the input, returning (start, end) pairs.
- **Postcondition**: `findAll_postcond` requires (6 clauses):
  - Matches are pairwise non-overlapping: `List.Pairwise (fun a b => a.2 ≤ b.1)`
  - All match bounds are valid: `m.1 ≤ m.2 ∧ m.2 ≤ input.length`
  - If `findFirst` returns none, result is empty
  - If `findFirst` returns some, result is non-empty
  - First element of result equals `findFirst` result
  - Empty pattern produces exactly `input.length + 1` matches
- **Additional**: `findAll_valid_postcond` requires every match substring actually fullMatches the pattern
- **Key constraints**: Matches must be found left-to-right with no overlaps. The empty pattern matches at every position (including after the last character).

### 3. `compile`

- **Signature**: `def compile (op : RegexOp) : Prog`
- **Description**: Compile a regex AST into an NFA program using Thompson's construction.
- **Postcondition**: `compile_postcond` requires:
  - Instructions list is non-empty
  - Start index is within bounds (`start < insts.length`)
  - Instructions list has a last element (non-empty redundancy)
  - For capture nodes, `numCaptures ≥ idx + 1`
  - At least one `Inst.match_` instruction exists in the program
- **Key constraints**: The compiled program must be well-formed — valid instruction indices, at least one accept state. Thompson's construction produces exactly one match instruction per compiled regex.

## Types

- **`RegexOp`** — Regex AST: empty, literal char, literal string, character class (possibly negated), any char, concat (list), alternate (list), repeat (with min/max/greedy), capture group, anchor
- **`Inst`** — NFA instruction: match (accept), char (match one char + goto), charClass, anyChar, jump, split (two branches), save (capture), fail
- **`Prog`** — Compiled NFA program: list of instructions, start index, number of capture groups
- **`AnchorKind`** — Anchor types: none, start (^), end ($), both

## Hints

- **`findFirst`** is included as infrastructure (sorry) — it's referenced by both `fullMatch_postcond` and `findAll_postcond`. Implement it to find the leftmost match of the pattern in the input.
- **`matchSpanTotal`** is already implemented: `ms.foldl (fun acc m => acc + (m.2 - m.1)) 0`. Not directly used in the core postconditions but available.
- For `fullMatch`, a simple implementation: parse the pattern, compile to NFA, run the NFA on the input, check if the match spans the entire input. Alternatively, anchor the pattern with `^` and `$`.
- For `findAll`, iteratively find matches starting after the previous match's end position. For empty matches, advance by one character to avoid infinite loops.
- For `compile`, implement Thompson's construction: each `RegexOp` variant maps to a small NFA fragment. Concatenation chains fragments, alternation uses split instructions, repetition uses split + jump loops.
- The `findAll_valid_spec` theorem connects `findAll` and `fullMatch` — each found substring must itself fully match the pattern. This is a strong correctness property.

## Edit Boundaries

`Re2/*.lean` is divided into labeled sections:

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

- `Re2/Compile.lean`
- `Re2/FindAll.lean`
- `Re2/FullMatch.lean`
- `Re2/Helpers.lean`
- `Re2/Types.lean`
