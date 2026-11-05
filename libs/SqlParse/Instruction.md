# SqlParse

## Background

SqlParse is a non-validating SQL parser for Python. It provides tools to lex SQL strings into tokens, parse them into statement trees, split multi-statement SQL, format/pretty-print SQL, and extract table names. This spec covers the core pipeline: tokenizing SQL into a token stream, parsing tokens into statement trees, and formatting SQL with various options.

## Task

Complete implementation holes in explicitly editable regions in the split files under `SqlParse/` and complete the proof obligations assigned to editable regions.

Helpers are grouped in `SqlParse/Helpers.lean`. The three core APIs each live in their own file:

- `SqlParse/Tokenize.lean`
- `SqlParse/Parse.lean`
- `SqlParse/Format.lean`

Relational specs are grouped in `SqlParse/Relations.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `tokenize`

- **Signature**: `def tokenize (sql : String) : List Token`
- **Description**: Lex a SQL string into a flat list of tokens, where each token has a type (keyword, name, whitespace, etc.) and a string value.
- **Postcondition**: `tokenize_postcond` requires (7 clauses):
  - Non-empty SQL → non-empty token list
  - Concatenating all token values reconstructs the original SQL
  - Empty SQL → empty list
  - Every token has a non-empty value
  - Whitespace tokens contain only spaces and tabs
  - Newline tokens contain only `\n` and `\r`
  - SQL with both spaces and non-spaces → at least 2 tokens
- **Key constraints**: The tokenizer must be lossless — joining token values must exactly reproduce the input. Token types must accurately classify the content.

### 2. `parse`

- **Signature**: `def parse (sql : String) : List TokenTree`
- **Description**: Parse a SQL string into a list of statement-level token trees. Each top-level tree represents one SQL statement.
- **Postcondition**: `parse_postcond` requires (3 clauses):
  - Concatenating all tree values reconstructs the original SQL
  - Empty SQL → empty list
  - Every top-level tree is a `TokenTree.group .statement _`
- **Key constraints**: All top-level results must be statement groups. The parser is non-validating, so even malformed SQL should produce statement groups.

### 3. `format`

- **Signature**: `def format (sql : String) (options : FormatOptions := {}) : String`
- **Description**: Format a SQL string according to the given options (keyword case, strip comments, strip whitespace, etc.).
- **Postcondition**: `format_postcond` requires (7 clauses):
  - Default options → output equals input
  - Empty SQL → empty output
  - Non-empty SQL → non-empty output
  - `keywordCase = upper` → all keyword tokens in result have uppercase values
  - `keywordCase = lower` → all keyword tokens in result have lowercase values
  - `stripComments = true` → no comment tokens in result
  - `stripWhitespace = true` → result equals its trimmed version
- **Key constraints**: Default options must be identity. The keyword case clauses check the *re-tokenized* output, so the formatted SQL must still tokenize correctly.

## Relational Properties

- **`tokenize_parse_consistent`**: The joined token values from `parse sql` equal the joined token values from `tokenize sql` — both reconstruct the same string.
- **`format_identity`**: `format sql {} = sql` — formatting with default options is the identity function.

## Types

- **`TokenType`** — 24 token type variants covering SQL lexical categories: numbers, strings, keywords (5 sub-kinds), operators, punctuation, names, whitespace, comments, wildcards
- **`Token`** — A token with a type and string value
- **`GroupType`** — 15 group types for parsed structures: statement, identifier, parenthesis, where, comparison, function, etc.
- **`TokenTree`** — Either a leaf token or a group containing child trees
- **`KeywordCase`** — upper, lower, capitalize
- **`IdentifierCase`** — upper, lower
- **`OutputFormat`** — sql, python, php
- **`FormatOptions`** — Configuration for formatting: keyword/identifier case, indent settings, strip options, etc.

## Hints

- `TokenTree.value` is an infrastructure function (marked `sorry`) that must also be implemented. It should concatenate the string values of all leaf tokens in the tree.
- For `tokenize`, build a lexer that scans the SQL string character by character, classifying runs of characters into appropriate token types. The lossless property (value join = input) is critical.
- For `parse`, you can build on `tokenize` — tokenize first, then group tokens into statement trees (split on semicolons).
- For `format`, apply transformations to the token stream: case conversion for keywords, filtering for comment/whitespace stripping. The default-options-is-identity property means you should start from the original SQL and only modify when options are set.
- The `format_postcond` checks keyword case on `tokenize result` — the *output* must tokenize cleanly, with keyword tokens having the correct case.

## Edit Boundaries

The split files under `SqlParse/` are divided into labeled sections:

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

- `SqlParse/Format.lean`
- `SqlParse/Helpers.lean`
- `SqlParse/Parse.lean`
- `SqlParse/Relations.lean`
- `SqlParse/Tokenize.lean`
- `SqlParse/Types.lean`
