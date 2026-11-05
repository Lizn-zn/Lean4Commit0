# TinyExpr

## Background

TinyExpr is a tiny C library for parsing and evaluating mathematical expressions from strings. It supports standard arithmetic operators (+, -, *, /, ^), unary functions (sin, cos, sqrt, log, etc.), variables, and parenthesized sub-expressions. This spec models the expression AST, a recursive-descent parser, an evaluator, and an expression simplifier as pure functions.

## Task

Complete implementation holes in explicitly editable regions in `TinyExpr/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parse`

- **Signature**: `def parse (input : String) : Option Expr`
- **Description**: Parses a mathematical expression string into an `Expr` AST. Returns `none` for invalid input.
- **Postcondition**: (1) Empty string → none. (2) Single digits and multi-digit numbers parse to `Expr.num`. (3) Float literals like "3.14" parse correctly. (4) Invalid strings like "!!!" and "()" return none. (5) Binary expressions like "1+2", "5-3", "2*3", "6/2" parse to the corresponding `Expr.binary` AST nodes.
- **Key constraints**: Must handle operator precedence (* and / bind tighter than + and -). The postcondition specifies exact AST structure for simple expressions (e.g., "1+2" must be `Expr.binary .add (Expr.num 1.0) (Expr.num 2.0)`).

### 2. `eval`

- **Signature**: `def eval (e : Expr) (env : Env) : Option Float`
- **Description**: Evaluates an expression AST with a variable environment, returning the computed value or `none` if a variable is unbound.
- **Postcondition**: (1) `Expr.num n` → `some n`. (2) `Expr.var name` looks up name in env: found → `some v`, missing → `none`. (3) Unary/binary on `Expr.num` arguments always succeeds (isSome). (4) Unary/binary with missing variable propagates `none`.
- **Key constraints**: `Env` is `List (String × Float)`. Variable lookup uses `env.find? (fun p => p.1 == name)`. Must recursively evaluate sub-expressions and propagate `none` for unbound variables.

### 3. `simplify`

- **Signature**: `def simplify (e : Expr) : Expr`
- **Description**: Simplifies an expression by applying constant folding and algebraic identity rules.
- **Postcondition**: (1) `Expr.num` and `Expr.var` are preserved as-is. (2) **Semantic preservation**: `eval (simplify e) env = eval e env` for ALL environments. (3) Constant folding: `binary op (Num n) (Num m)` → `Num v`. (4) Identity rules: `0+x → x`, `x+0 → x`, `1*x → x`, `x*1 → x`, `0*x → Num 0`.
- **Key constraints**: The semantic preservation property is the strongest requirement — simplification must never change the meaning of an expression. Constant folding requires evaluating the binary operation at simplification time.

## Relational Properties

- **`parse_roundtrip_rel`**: `parse "2+3"` succeeds and evaluating the result yields `some 5.0`.
- **`simplify_preserves_eval_rel`**: `eval (simplify e) env = eval e env` — simplification preserves evaluation semantics.
- **`eval_num_rel`**: `eval (Expr.num n) env = some n` — numeric literals evaluate to themselves regardless of environment.

## Types

- **`Expr`**: Expression AST with variants `num Float`, `var String`, `unary UnaryOp Expr`, `binary BinaryOp Expr Expr`.
- **`UnaryOp`**: Unary operations — `neg`, `abs`, `sqrt`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `log`, `log2`, `log10`, `exp`, `ceil`, `floor`, `round`, `fac`.
- **`BinaryOp`**: Binary operations — `add`, `sub`, `mul`, `div`, `pow`, `fmod`, `atan2`, `min`, `max`.
- **`Env`**: Variable environment, an alias for `List (String × Float)`.

## Hints

- For `parse`: implement a recursive-descent parser with standard precedence levels. Additive (+, -) at the lowest level, multiplicative (*, /) next, then power (^), then unary, then atoms (numbers, variables, parenthesized expressions). Use `String.Iterator` or index-based parsing.
- For `eval`: pattern match on the `Expr` constructors. For `Expr.num n`, return `some n`. For `Expr.var`, use `env.find?`. For unary/binary, recursively evaluate sub-expressions and apply the operation if both succeed. Use Lean's built-in `Float` operations (e.g., `Float.sin`, `Float.sqrt`, `+`, `-`, `*`, `/`, `Float.pow`).
- For `simplify`: recursively simplify sub-expressions first, then apply rules. For constant folding, evaluate `binary op (Num n) (Num m)` by computing the operation and wrapping in `Num`. For identity rules, check for specific patterns (e.g., `add (Num 0.0) x`). Use `Float.beq` to compare with 0.0 and 1.0.
- The `simplify_preserves_eval_rel` proof requires showing that every simplification rule preserves semantics. The constant folding case requires that your `simplify` uses the same operation semantics as `eval`.
- The `parse_roundtrip_rel` proof ties `parse` and `eval` together — ensure "2+3" parses to `binary .add (Num 1.0) ... ` wait, actually it should parse to `binary .add (Num 2.0) (Num 3.0)`, and eval of that should give `some 5.0`.

## Edit Boundaries

`TinyExpr/*.lean` is divided into labeled sections:

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

- `TinyExpr/Eval.lean`
- `TinyExpr/Parse.lean`
- `TinyExpr/Simplify.lean`
- `TinyExpr/Types.lean`
