# PromptToolkit

## Background

Python Prompt Toolkit is a library for building interactive command-line interfaces with features like syntax highlighting, auto-completion, and multi-line editing. This spec models the core document editing buffer and completion system as pure functions — inserting/deleting text at a cursor position, and matching completion candidates against a prefix.

## Task

Complete implementation holes in explicitly editable regions in the `PromptToolkit/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Document.insertText`

- **Signature**: `def Document.insertText (doc : Document) (text : String) : Document`
- **Description**: Inserts a string at the current cursor position in the document, advancing the cursor past the inserted text.
- **Postcondition**: (1) Result text length = original + inserted length. (2) Inserting empty string preserves the text. (3) Cursor moves forward by the inserted text length. (4) Result text = text before cursor ++ inserted text ++ text after cursor.
- **Key constraints**: The text construction must use `String.take`/`String.drop` with `.toString` conversion (since they return `String.Slice`). Cursor position must not exceed text length.

### 2. `Document.backspace`

- **Signature**: `def Document.backspace (doc : Document) : Document`
- **Description**: Deletes the character immediately before the cursor (like pressing Backspace), moving the cursor back by one position.
- **Postcondition**: When cursor > 0 and ≤ text length: result text length = original - 1, result text = text before (cursor-1) ++ text after cursor, cursor = original cursor - 1. When cursor = 0: returns the document unchanged.
- **Key constraints**: At position 0, backspace is a no-op (returns `doc` exactly). The text construction mirrors insertText's approach with `take`/`drop`.

### 3. `completeFromList`

- **Signature**: `def completeFromList (candidates : List String) (pfx : String) : List Completion`
- **Description**: Filters a list of candidate strings to those starting with the given prefix, returning them as `Completion` objects.
- **Postcondition**: (1) All result completions start with the prefix. (2) Empty prefix returns all candidates. (3) Result length = number of candidates matching the prefix. (4) All result texts come from the candidates list (soundness). (5) Every candidate matching the prefix has a corresponding result (completeness).
- **Key constraints**: Must be both sound and complete — every matching candidate must appear exactly once, and no non-matching candidate may appear.

## Relational Properties

- **`insert_backspace_rel`**: Inserting a single character then immediately backspacing restores the original document text: `(doc.insertText (String.singleton c)).backspace.text = doc.text`.
- **`completion_application_rel`**: Applying a completion by inserting its text grows the document: the result length equals original + completion text length, and the text equals before ++ completion ++ after.

## Types

- **`Document`**: A text buffer with a `text : String` field and a `cursorPosition : Nat` indicating the cursor's offset within the text.
- **`Completion`**: A completion candidate with `text : String` (the full completion text), `startOffset : Int` (where the completion starts relative to cursor), `displayText` and `description` (for UI display).

## Hints

- For `Document.insertText`, construct the result text as `(doc.text.take doc.cursorPosition).toString ++ text ++ (doc.text.drop doc.cursorPosition).toString` and set cursor to `doc.cursorPosition + text.length`. Handle the case where `cursorPosition > text.length` by clamping.
- For `Document.backspace`, when cursor > 0, construct `(doc.text.take (doc.cursorPosition - 1)).toString ++ (doc.text.drop doc.cursorPosition).toString`. When cursor = 0, return `doc` unchanged.
- For `completeFromList`, filter candidates with `String.startsWith` and wrap each matching string in a `Completion` with `text := s`. The proof needs to show the filtered list has the right properties.
- The `insert_backspace_rel` proof requires showing that inserting a character at position `p` then deleting at position `p+1` restores the original string — this is essentially `take p ++ [c] ++ drop p` followed by `take p ++ drop (p+1)` of the modified string.
- Note that `String.take` and `String.drop` return `String.Slice` in Lean 4, so `.toString` is needed to convert back to `String`.

## Edit Boundaries

`PromptToolkit/*.lean` is divided into labeled sections:

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

- `PromptToolkit/Backspace.lean`
- `PromptToolkit/CompleteFromList.lean`
- `PromptToolkit/InsertText.lean`
- `PromptToolkit/Relations.lean`
- `PromptToolkit/Types.lean`
