# Sphinx

## Background

Sphinx is Python's standard documentation generator, used by most Python projects. It parses reStructuredText (RST) markup into an AST, resolves cross-references between documents, builds tables of contents, and produces output in multiple formats (HTML, PDF, etc.). This spec covers the core pipeline: parsing RST source into a document tree, resolving cross-references, and parsing inline markup (emphasis, strong, literal).

## Task

Complete implementation holes in explicitly editable regions in the split files under `Sphinx/` and complete the proof obligations assigned to editable regions.

The three core APIs each live in their own file:

- `Sphinx/ParseRst.lean`
- `Sphinx/ResolveRef.lean`
- `Sphinx/ParseInline.lean`

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parseRst`

- **Signature**: `def parseRst (source : String) : RstNode`
- **Description**: Parse a complete RST source string into a document AST. The result is always a `RstNode.document` wrapping a list of child nodes.
- **Postcondition**: `parseRst_postcond` requires (4 clauses):
  - Result is always a `RstNode.document children` (for some children list)
  - Empty source → `RstNode.document []`
  - Non-empty source with non-whitespace content → document has non-empty children
  - No nested documents: no child of the document is itself a `RstNode.document`
- **Key constraints**: The parser must handle all RST constructs (headings, paragraphs, directives, lists, etc.) but the postcondition only constrains the top-level structure. Children can be any non-document `RstNode` variant.

### 2. `resolveRef`

- **Signature**: `def resolveRef (targets : List RefTarget) (pending : PendingRef) : RefResult`
- **Description**: Resolve a pending cross-reference by searching the list of known targets for a match on kind and name.
- **Postcondition**: `resolveRef_postcond` requires (3 clauses):
  - Empty target list → `RefResult.unresolved msg`
  - Single target matching kind and name → `RefResult.resolved t`
  - Any target in the list matches kind and name → result is either `resolved` or `ambiguous`
- **Key constraints**: Matching uses `kind == pending.kind && name == pending.target`. When multiple targets match, the result should be `ambiguous`. When exactly one matches, it should be `resolved`.

### 3. `parseInline`

- **Signature**: `def parseInline (line : String) : List InlineNode`
- **Description**: Parse inline RST markup within a single line of text, recognizing emphasis (`*text*`), strong emphasis (`**text**`), and inline literals (`` ``text`` ``).
- **Postcondition**: `parseInline_postcond` requires (6 clauses):
  - Empty line → empty result
  - Plain text (no `*`, `` ` ``, `|`, `_`) → `[InlineNode.text line]`
  - Non-empty line → non-empty result
  - `*s*` (with no inner `*`) → result contains `InlineNode.emphasis s`
  - `**s**` (with no inner `*`) → result contains `InlineNode.strong s`
  - `` ``s`` `` (with no inner `` ` ``) → result contains `InlineNode.literal s`
- **Key constraints**: The emphasis/strong/literal detection requires the delimiters to wrap the entire line content. The postcondition uses `result.any` to check containment, not exact equality — there may be surrounding text nodes.

## Types

- **`HeadingLevel`** — RST heading levels: part, chapter, section, subsection, subsubsection, paragraph
- **`InlineNode`** — Inline markup: text, emphasis, strong, literal, reference, role, footnoteRef, substitutionRef
- **`FieldEntry`** — A field list entry with name and body lines
- **`DirectiveOptions`** — Key-value pairs for directive options
- **`RstNode`** — Block-level RST nodes: document, section, paragraph, literal block, block quote, lists, field list, line block, transition, comment, directive, substitution def, footnote, target, table, raw
- **`RefKind`** — Cross-reference types: label, doc, any, term, numref, keyword, option, envvar
- **`RefTarget`** — A reference target: kind, name, document name, anchor ID, optional title
- **`PendingRef`** — A pending reference to resolve: kind, target name, document name, line number
- **`RefResult`** — Resolution result: resolved (single target), unresolved (error message), or ambiguous (multiple targets)

## Hints

- For `parseRst`, start by splitting on blank lines to identify block boundaries, then classify each block (heading, paragraph, directive, list, etc.). Wrap everything in `RstNode.document`. The key proof obligation is showing no child is a `document`.
- For `resolveRef`, filter targets by `kind == pending.kind && name == pending.target`. If empty → unresolved. If exactly one → resolved. If multiple → ambiguous.
- For `parseInline`, scan for delimiter patterns (`*`, `**`, ` `` `). For plain text without any special characters, return `[InlineNode.text line]`. The postcondition only requires that the appropriate node *exists* in the result list, not that it's the only element.

## Edit Boundaries

The split files under `Sphinx/` are divided into labeled sections:

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

- `Sphinx/ParseInline.lean`
- `Sphinx/ParseRst.lean`
- `Sphinx/ResolveRef.lean`
- `Sphinx/Types.lean`

## Model scope

Cross-reference resolution pins empty and matching-singleton cases and a matching-target existence implication. General resolved-target membership and ambiguity completeness are outside the formal contract.
