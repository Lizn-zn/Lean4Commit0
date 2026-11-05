# Logos

## Background

Logos is a fast lexer generator for Rust. It defines lexers as a set of token rules (each pairing a pattern with a token kind name) and produces a tokenizer that scans input strings left-to-right, matching patterns greedily and emitting tokens with their source spans and slices. This core spec models the three layers of the lexer: low-level pattern matching against individual patterns, single-token extraction using a lexer definition, and full tokenization of an entire input string.

## Task

Complete implementation holes in explicitly editable regions in `Logos/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `matchPattern`

- **Signature**: `def matchPattern (p : Pattern) (input : String) (pos : Nat) : Option Nat`
- **Description**: Matches a pattern against an input string starting at position `pos`. Returns the end position if matched, or `none` if not.
- **Postcondition** (12 clauses):
  - `literal s` with matching prefix → `some (pos + s.length)`
  - `literal s` with non-matching prefix → `none`
  - `charRange lo hi` in range → `some (pos + 1)`; out of range or past end → `none`
  - `charSet cs` with char in set → `some (pos + 1)`; not in set or past end → `none`
  - `any` within bounds → `some (pos + 1)`; past end → `none`
  - Result always satisfies `endPos ≥ pos` and `endPos ≤ input.length`
- **Key constraints**: Uses `String.drop` and `String.startsWith` for literal matching, `String.front` of the dropped string for character matching. Pattern variants `sequence`, `oneOrMore`, `zeroOrMore`, `optional`, `alt` are not directly constrained by the postcondition but must be implemented for completeness.

### 2. `nextToken`

- **Signature**: `def nextToken (def_ : LexerDef) (state : LexerState) : Option (Token × LexerState)`
- **Description**: Tries all rules in the lexer definition against the current position, picks the longest match (ties broken by priority), and returns the token with the updated state. Returns `none` if no rule matches.
- **Postcondition** (9 clauses):
  - On success: position strictly advances (`state'.position > state.position`)
  - Token kind is one of the rule kinds (`tok.kind ∈ def_.rules.map TokenRule.kind`)
  - Span is valid: `start ≤ end ≤ source.length`
  - Source is preserved across state transitions
  - Token slice matches the source substring at the span
  - Empty rules → `none`
  - EOF (position ≥ source length) → `none`
  - If no skip pattern and a literal rule matches at current position → result is not `none`
- **Key constraints**: Must try all rules and select the longest match. The last clause ensures that when a literal rule clearly matches, the function doesn't incorrectly return `none`.

### 3. `tokenize`

- **Signature**: `def tokenize (def_ : LexerDef) (input : String) : Option (List Token)`
- **Description**: Tokenizes the entire input string using the lexer definition, returning all tokens in order.
- **Postcondition** (7 clauses):
  - Tokens are non-overlapping and ordered: `Pairwise (fun a b => a.span.end ≤ b.span.start)`
  - All token spans are within input bounds
  - All spans are valid (`start ≤ end`)
  - All token kinds come from the lexer rules
  - All token slices match the input at their spans
  - Empty input → empty token list
  - Non-empty input with no skip pattern → non-empty token list
- **Key constraints**: The `Pairwise` constraint is the strongest — it ensures tokens don't overlap and appear in order. The function should repeatedly call `nextToken` (possibly with skip handling) until EOF.

## Relational Properties

None included in the core spec.

## Types

- **`Span`**: A half-open character range `[start, end)` within the source string.
- **`Pattern`**: A pattern for matching: `literal` (exact string), `charRange` (lo-hi inclusive), `charSet` (list of chars), `sequence` (concatenation), `oneOrMore`/`zeroOrMore`/`optional` (repetition), `alt` (alternation), `any` (any single character).
- **`TokenRule`**: A rule mapping a `Pattern` to a `kind` name (String) with an optional `priority` (Nat).
- **`LexerDef`**: A lexer definition with a list of `TokenRule`s and an optional `skip` pattern (for whitespace/comments).
- **`Token`**: A produced token with `kind` (String), `slice` (the matched text), and `span` (position in source).
- **`LexerState`**: Lexer state with `source` (the full input) and `position` (current scan position).

## Hints

- For `matchPattern`, pattern match on the `Pattern` variant:
  - `literal s`: check `(input.drop pos).startsWith s`, return `some (pos + s.length)` or `none`
  - `charRange lo hi`: get char at position, check `lo ≤ c ∧ c ≤ hi`
  - `charSet cs`: get char at position, check `c ∈ cs`
  - `any`: if `pos < input.length`, return `some (pos + 1)`
  - `sequence ps`: fold through patterns, threading the position
  - `alt p1 p2`: try `p1` first, fall back to `p2`
  - `zeroOrMore p`: greedily match `p` repeatedly
  - `oneOrMore p`: match `p` at least once, then greedily
  - `optional p`: try `p`, return `pos` if it fails
- For `nextToken`, iterate through `def_.rules`, call `matchPattern` for each, collect matches with their end positions, and pick the longest (break ties by priority). Construct a `Token` from the winning rule.
- For `tokenize`, create a `LexerState` at position 0, repeatedly call `nextToken` (handling skips between tokens), collect tokens until EOF or failure.
- The `Pairwise` constraint in `tokenize` follows naturally if you advance the position past each token's end before looking for the next one.

## Edit Boundaries

`Logos/*.lean` is divided into labeled sections:

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

- `Logos/Helpers.lean`
- `Logos/MatchPattern.lean`
- `Logos/NextToken.lean`
- `Logos/Tokenize.lean`
- `Logos/Types.lean`
