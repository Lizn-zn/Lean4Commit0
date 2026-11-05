# Tornado

## Background

Tornado is a Python web framework and asynchronous networking library. This spec models it as pure data structures and algorithms — no actual I/O or networking. It covers URL routing (matching request paths to handlers), signed cookie creation and verification (HMAC-based security), and template rendering (variable substitution in template strings).

## Task

Complete implementation holes in explicitly editable regions in `Tornado/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `URLRouter.findHandler`

- **Signature**: `def URLRouter.findHandler (router : URLRouter) (path : String) : Option (String × List String)`
- **Description**: Search the routing table for a handler matching the given path. Returns the handler name and any captured groups, or `none` if no route matches.
- **Postcondition**: `URLRouter.findHandler_postcond` requires (3 clauses):
  - Empty specs list → `none`
  - If any spec's pattern matches the path, result is not `none`
  - If result is `some (handlerName, groups)`, there exists a spec with that handler name whose pattern matches the path producing those groups
- **Key constraints**: Uses `matchPattern` to test each spec's pattern against the path. The result must come from an actual spec in the router.

### 2. `signedCookie` (createSignedValue / decodeSignedValue)

- **Signature**: `def createSignedValue (secret : String) (name : String) (value : String) (timestamp : Nat) : String`
- **Signature**: `def decodeSignedValue (secret : String) (name : String) (signedValue : String) (maxAge : Nat) (currentTime : Nat) : Option String`
- **Description**: Create a signed (HMAC-based) cookie value, and verify/decode it. The signed value embeds a timestamp for expiration checking.
- **Postcondition**: `signedCookie_postcond` requires (2 clauses):
  - If `currentTime - timestamp < maxAge`, decoding with the same secret recovers the original value
  - If `currentTime - timestamp ≥ maxAge`, decoding returns `none` (expired)
- **Key constraints**: Both functions must use the same signing scheme. The timestamp is embedded in the signed value and checked against `maxAge` during decoding.

### 3. `renderTemplate`

- **Signature**: `def renderTemplate (templateStr : String) (ctx : TemplateContext) : String`
- **Description**: Render a template string by substituting `{{name}}` placeholders with values from the context.
- **Postcondition**: `renderTemplate_postcond` requires (5 clauses):
  - No `{{` in template → result equals template (identity)
  - Template is exactly `{{name}}` and context has `name → str value` → result is `value`
  - If template contains `{{name}}` and context has the value, value appears in result (containment)
  - After substitution, the placeholder `{{name}}` no longer appears in result (completeness)
  - For `pfx ++ "{{" ++ name ++ "}}"` with no `{{` in prefix or value → result is `pfx ++ value`
- **Key constraints**: Only `TemplateValue.str` values are substituted. The `containsSubstr` checks use `Prop` (decidable), defined via `splitOn`.

## Relational Properties

- **`signed_cookie_wrong_secret`**: If `secret1 ≠ secret2` and the cookie hasn't expired, `decodeSignedValue secret2 name (createSignedValue secret1 name value timestamp) maxAge currentTime = none`. This ensures signed cookies can't be forged with a different secret.

## Types

- **`URLSpec`** — A URL route: pattern string + handler name
- **`URLRouter`** — A list of URL specs (routing table)
- **`TemplateValue`** — Template context values: str, int, float, bool, list, dict
- **`TemplateContext`** — A list of (name, TemplateValue) bindings

## Hints

- `matchPattern` is infrastructure (`sorry`) — implement it as a simplified regex matcher. For the postcondition to work, it must return `some groups` when a pattern matches a path.
- `TemplateContext.get` is infrastructure (`sorry`) — look up a name in the bindings list, returning the first match.
- `String.containsSubstr` is already implemented (not `sorry`) as a `Prop` using `splitOn`. It's decidable, so it can be used in `if` expressions.
- For `createSignedValue`/`decodeSignedValue`, design an encoding that embeds the timestamp and an HMAC. A simple approach: `value|timestamp|hmac(secret, name|value|timestamp)`. Decoding splits, verifies the HMAC, checks expiry.
- For `renderTemplate`, scan for `{{...}}` patterns and replace with context lookups. The postcondition requires that substitution is complete (no remaining placeholders for known variables).
- The fifth clause of `renderTemplate_postcond` gives a precise result for templates of the form `prefix{{name}}` — this is the strongest constraint and determines the exact output.

## Edit Boundaries

`Tornado/*.lean` is divided into labeled sections:

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

- `Tornado/FindHandler.lean`
- `Tornado/Helpers.lean`
- `Tornado/RenderTemplate.lean`
- `Tornado/Types.lean`
