# Jsoup

## Background

Jsoup is Java's leading HTML parsing and manipulation library, providing an HTML5-compliant parser, CSS selector-based DOM traversal, DOM tree manipulation, and HTML sanitization using configurable safelists. This spec models jsoup's core operations as pure functions over an inductive DOM tree, focusing on CSS selector matching, DOM node appending, and HTML cleaning.

## Task

Complete implementation holes in explicitly editable regions in `Jsoup/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `matchesSelector`

- **Signature**: `def matchesSelector (node : Node) (sel : Selector) : Bool`
- **Description**: Check whether a DOM node matches a CSS selector. This is the fundamental predicate underlying all query operations (select, getElementById, etc.).
- **Postcondition**: `matchesSelector_postcond` requires (for element nodes):
  - `Selector.universal` → always `true`
  - `Selector.tag name` → `true ↔ t = name` (tag name equality)
  - `Selector.id idVal` → `true ↔` element has an attribute with name "id" and value matching `idVal`
  - `Selector.cls clsVal` → `true ↔` element has a "class" attribute whose space-separated values contain `clsVal`
- **Key constraints**: All four selector types use `↔` (if and only if), meaning the postcond fully pins down the result for element nodes with these selectors. Non-element nodes (textNode, comment, etc.) are unconstrained by the postcond. The class matching splits on spaces — `"foo bar"` contains both `"foo"` and `"bar"`.

### 2. `append`

- **Signature**: `def append (parent : Node) (child : Node) : Node`
- **Description**: Append a child node to an element's children list.
- **Postcondition**: `append_postcond` requires:
  - For any element `parent = .element tag attrs children`, the result is exactly `.element tag attrs (children ++ [child])`
- **Key constraints**: This is a fully deterministic postcond — the result is uniquely specified. The tag, attributes, and existing children are all preserved exactly; the new child is appended at the end. Non-element parent nodes are unconstrained.

### 3. `clean`

- **Signature**: `def clean (node : Node) (safelist : Safelist) : Node`
- **Description**: Sanitize an HTML node tree by removing all elements whose tags are not on the safelist. This is jsoup's core security feature for preventing XSS.
- **Postcondition**: `clean_postcond` requires:
  - For every tag not allowed by the safelist (`Safelist.isTagAllowed safelist tag = false`), no element with that tag appears anywhere in the cleaned result (`select result (Selector.tag tag)` returns empty)
- **Key constraints**: The postcond references two other `sorry` functions: `select` (to find elements by tag) and `Safelist.isTagAllowed` (to check allowedness). All three must be implemented consistently. Text content from disallowed elements may be preserved — only the element wrappers must be removed.

## Relational Properties

- **`append_increases_children_rel`**: Appending a child to an element produces a result where the children count is exactly `children.length + 1`. This follows directly from the `append_postcond` but states it as a separate property about the length.

## Types

- **`Attribute`**: An HTML attribute with `name : String` and `value : String`.
- **`Node`**: An HTML DOM node — one of: `element` (tag name + attributes + children), `textNode` (text content), `comment`, `dataNode`, or `documentType`.
- **`Selector`**: A CSS selector AST — `tag`, `id`, `cls` (class), `attribute`, `attributeEq`, combinators (`descendant`, `child`, `adjacentSibling`, `generalSibling`), logical (`and`, `or`, `not`), `pseudo`, and `universal`.
- **`Safelist`**: An HTML sanitization whitelist with `allowedTags`, `allowedAttributes` (per-tag), `allowedProtocols` (per-tag-per-attribute), `enforceAttributes`, and `preserveRelativeLinks`.

## Hints

- For `matchesSelector`: pattern match on the selector type. For `.universal`, return `true` for any element. For `.tag name`, compare with the element's tag. For `.id idVal`, scan attributes for `name == "id"` with matching value. For `.cls clsVal`, find the "class" attribute, split its value on spaces, and check membership. Return `false` for non-element nodes.
- For `append`: pattern match on the parent. If it's `.element tag attrs children`, return `.element tag attrs (children ++ [child])`. For non-elements, return the parent unchanged (or handle as needed — the postcond doesn't constrain this case).
- For `clean`: recursively walk the tree. For each element, check `Safelist.isTagAllowed safelist tag`. If allowed, keep the element (with recursively cleaned children). If not allowed, replace the element with its recursively cleaned children (unwrap it).
- `Safelist.isTagAllowed` is also `sorry` — implement it as `sl.allowedTags.contains tag` (simple list membership check).
- `select` is also `sorry` — implement it as a recursive tree traversal that collects all nodes matching the selector (using `matchesSelector`).
- The `append_increases_children_rel` proof follows directly from `append_postcond` and `List.length_append`.

## Edit Boundaries

`Jsoup/*.lean` is divided into labeled sections:

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

- `Jsoup/Append.lean`
- `Jsoup/Clean.lean`
- `Jsoup/Helpers.lean`
- `Jsoup/MatchesSelector.lean`
- `Jsoup/Relations.lean`
- `Jsoup/Types.lean`
