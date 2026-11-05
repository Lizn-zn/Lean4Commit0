# Cookiecutter

## Background

Cookiecutter is a Python library for generating projects from templates. It uses Jinja2-style syntax (`{{variable}}`, `{%if%}`) to define template files and directories, resolves variables from a JSON config with user overrides, and renders the final project. This core spec focuses on the three essential operations: parsing templates into tokens, rendering templates with variable substitution, and building the context that drives rendering.

## Task

Complete implementation holes in explicitly editable regions in the `Cookiecutter/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `renderTemplate`

- **Signature**: `def renderTemplate (template : String) (ctx : TemplateContext) : Except RenderError String`
- **Description**: Renders a Jinja-like template string by substituting `{{varName}}` placeholders with values from the context.
- **Postcondition**:
  - A template that is exactly `{{varName}}` with a unique binding in ctx returns `Ok (v.asString)`
  - A plain template (no `{{` or `{%`) returns `Ok template` unchanged
  - After successful rendering, no `{{varName}}` placeholder for any unique ctx variable remains in the output
- **Key constraints**: Must handle the case where a variable appears in ctx. Plain text without any template syntax must pass through as-is.

### 2. `buildContext`

- **Signature**: `def buildContext (varDefs : List VarDef) (overrides : List (String × VarValue)) : TemplateContext`
- **Description**: Builds a template context from variable definitions and user-provided overrides. Overrides take precedence over defaults.
- **Postcondition**:
  - Every VarDef's name appears in the result
  - Every override key appears in the result
  - If a VarDef has no override, its `defaultValue` is used
  - If a VarDef has an override, the override value is used
- **Key constraints**: Must merge defaults and overrides correctly — overrides win.

### 3. `tokenizeTemplate`

- **Signature**: `def tokenizeTemplate (template : String) : List TemplateToken`
- **Description**: Parses a template string into a list of tokens (literals, variables, control blocks, comments).
- **Postcondition**:
  - Empty string → empty list
  - Non-empty string → non-empty list
  - A string with no `{{`, `{%`, or `{#` syntax → exactly `[TemplateToken.literal template]`
- **Key constraints**: Must detect template syntax markers (`{{`, `{%`, `{#`) to decide whether to split into multiple tokens or return a single literal.

## Relational Properties

- **`renderTemplate_novar`**: If `hasTemplateSyntax template = false`, then `renderTemplate template ctx = Ok template` (plain text is identity).
- **`tokenize_render_roundtrip_plain`**: If `hasTemplateSyntax s = false`, then `renderTokens (tokenizeTemplate s) = s` (tokenize then render plain text recovers the original).

## Types

- **`VarValue`**: A template variable value — can be string, int, float, bool, list of strings, dict, or null.
- **`VarDef`**: A variable definition with name, default value, optional prompt, optional choices list, and optional validation regex.
- **`TemplateContext`**: Alias for `List (String × VarValue)` — a list of variable bindings.
- **`RenderError`**: Error type for rendering failures — undefined variable, invalid template, validation error, or hook error.
- **`TemplateToken`**: A token from template parsing — literal text, variable reference, if/else/endif blocks, for/endfor blocks, or comments.
- **`HookType`**: Pre- or post-generation hook type (used in `RenderError.hookError`).

## Hints

- `VarValue.asString` is a helper that converts a `VarValue` to its string representation. It's used in `renderTemplate`'s postcondition — implement it first (pattern match on the value constructors).
- `hasTemplateSyntax` checks whether a string contains `{{` or `{%`. It's straightforward — use `String.containsSubstr` (already defined).
- `renderTokens` reconstructs a template string from tokens. For a single literal it returns the string as-is; for a single variable it wraps with `{{` and `}}`.
- For `tokenizeTemplate`, the key insight is: if the string has no template syntax markers, just wrap it as a single `TemplateToken.literal`. Otherwise, split on `{{`/`}}`/`{%`/`%}`/`{#`/`#}` boundaries.
- For `renderTemplate`, handle the plain-text case first (no `{{` or `{%` → return as-is), then implement variable substitution by finding and replacing `{{varName}}` patterns.
- For `buildContext`, iterate over `varDefs`, checking if each name has an override. If yes, use the override; if no, use `defaultValue`.
- `String.containsSubstr` is already defined at the top of the file and can be used freely.

## Edit Boundaries

The editable module files under `Cookiecutter/` are divided into labeled sections:

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

- `Cookiecutter/BuildContext.lean`
- `Cookiecutter/Helpers.lean`
- `Cookiecutter/Relations.lean`
- `Cookiecutter/RenderTemplate.lean`
- `Cookiecutter/TokenizeTemplate.lean`
- `Cookiecutter/Types.lean`
