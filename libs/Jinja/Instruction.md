# Jinja

## Background

Jinja2 is Python's most popular template engine, used by Flask, Django (compatible), Ansible, and many other tools. It supports variable interpolation (`{{ expr }}`), control flow (`{% if %}`, `{% for %}`), template inheritance, filters, tests, and automatic HTML escaping. This core spec focuses on three essential operations in the template rendering pipeline: evaluating expressions in a context, rendering individual template nodes, and escaping HTML special characters.

## Task

Complete implementation holes in explicitly editable regions in `Jinja/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `evalExpr`

- **Signature**: `def evalExpr (expr : Expr) (ctx : Context) : Value`
- **Description**: Evaluates a Jinja expression AST in a given context, producing a `Value`.
- **Postcondition** (11 clauses):
  - `Expr.literal v` → returns `v`
  - `Expr.variable name` → returns `ctx.get name` if found, else `Value.none`
  - `Expr.variable name` with `ctx.get name = some v` → returns `v`
  - `Expr.binOp "+" (literal (int a)) (literal (int b))` → returns `int (a + b)`
  - `Expr.binOp "-" (literal (int a)) (literal (int b))` → returns `int (a - b)`
  - `Expr.binOp "*" (literal (int a)) (literal (int b))` → returns `int (a * b)`
  - `Expr.binOp "==" (literal a) (literal b)` → returns `bool (a == b)`
  - `Expr.binOp "!=" (literal a) (literal b)` → returns `bool (a != b)`
  - `Expr.listExpr []` → returns `list []`
  - `Expr.unaryOp "not" (literal (bool e))` → returns `bool (!e)`
  - `Expr.unaryOp "-" (literal (int i))` → returns `int (-i)`
- **Key constraints**: Variable lookup falls back to `Value.none` when not found. Binary ops are only specified for literal integer operands. The postcondition uses `ctx.get` which must be implemented consistently.

### 2. `renderNode`

- **Signature**: `def renderNode (node : TemplateNode) (ctx : Context) : String`
- **Description**: Renders a single template AST node to a string in the given context.
- **Postcondition** (9 clauses):
  - `text s` → returns `s` (raw text passed through)
  - `output (literal v)` → returns `v.render` (value rendered to string)
  - `output (variable name)` → returns the rendered value from context lookup, or `""` if not found
  - `ifBlock cond then else` → renders `then` branch if condition is truthy, `else` branch otherwise
  - `forBlock varName (literal (list items)) body else` → joins rendered bodies for each item (setting the loop variable)
  - `raw s` → returns `s`
  - `comment` → returns `""`
  - `setVar name expr` → returns `""`
  - `extends_ parentName` → returns `""`
- **Key constraints**: The if/else clause uses `evalExpr` and `Value.isTruthy`. The for loop uses `Context.set` to bind the loop variable and `renderNodes` for the body. Both `evalExpr` and `renderNodes` must be implemented correctly for the postcondition to hold.

### 3. `escapeHtml`

- **Signature**: `def escapeHtml (s : String) : String`
- **Description**: Escapes HTML special characters in a string (& → `&amp;`, < → `&lt;`, > → `&gt;`, " → `&quot;`, ' → `&#39;`).
- **Postcondition**: `result = escapeHtmlRef s` — the result must exactly match the reference implementation, which processes each character individually via `escapeHtmlChar`.
- **Key constraints**: This is an exact-match postcondition. The reference functions `escapeHtmlChar` and `escapeHtmlRef` are already implemented and not `sorry` — your `escapeHtml` must produce identical output.

## Relational Properties

None included in the core spec.

## Types

- **`Value`**: A dynamically-typed template value — null (`none`), boolean, integer, float, string, list of values, or dict (list of key-value pairs).
- **`Context`**: Template rendering context with `bindings : List (String × Value)`. Variables are looked up by name.
- **`Expr`**: Expression AST — variable references, literals, attribute/item access, filter/test application, unary/binary operators, conditionals, function calls, list literals.
- **`TemplateNode`**: Template AST node — output expressions (`{{ }}`), raw text, if/else blocks, for loops, block definitions, extends/include, macros, set statements, raw blocks, comments.

## Hints

- **`Value.render`** is partially implemented: `none` → `""`, `bool true` → `"True"`, `bool false` → `"False"`, `int` → `toString`, `float` → `toString`, `str s` → `s`. The `list` and `dict` cases are `sorry` — implement them (e.g., as comma-separated representations).
- **`Value.isTruthy`** is fully implemented and can be used directly: `none`/`false`/`0`/`0.0`/`""`/`[]`/`{}` are falsy, everything else is truthy.
- **`bindingsLookup`** is fully implemented: first-match lookup in a list of bindings.
- **`Context.get`**: implement as `bindingsLookup ctx.bindings name` — the postcondition's last clause requires exact equality with `bindingsLookup`.
- **`Context.set`**: prepend `(name, value)` to `ctx.bindings` so that `bindingsLookup` finds it first (shadowing).
- **`escapeHtmlChar`** and **`escapeHtmlRef`** are fully implemented. Implement `escapeHtml` identically to `escapeHtmlRef` (or call it directly).
- **`renderNodes`**: concatenate `renderNode` results for each node in the list (`String.join (nodes.map (renderNode · ctx))`).
- For `evalExpr`, pattern match on the expression constructors. Handle literals, variables (via `ctx.get`), binary/unary ops on literals, and list expressions. For unhandled cases, return `Value.none`.
- For `renderNode`, pattern match on node constructors and delegate to `evalExpr`, `Value.render`, `Value.isTruthy`, `renderNodes`, and `Context.set` as specified by the postcondition.

## Edit Boundaries

`Jinja/*.lean` is divided into labeled sections:

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

- `Jinja/EscapeHtml.lean`
- `Jinja/EvalExpr.lean`
- `Jinja/Helpers.lean`
- `Jinja/RenderNode.lean`
- `Jinja/Types.lean`
