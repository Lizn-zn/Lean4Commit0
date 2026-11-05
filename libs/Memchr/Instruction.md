# Memchr

## Background

memchr is Rust's foundational byte search crate, providing highly optimized routines for finding bytes and byte substrings within byte slices. It powers many Rust libraries including regex and ripgrep. This spec models the three core search operations as pure list functions: forward single-byte search, substring search, and reverse single-byte search.

## Task

Complete implementation holes in explicitly editable regions in `Memchr/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `memchr`

- **Signature**: `def memchr (needle : UInt8) (haystack : List UInt8) : Option Nat`
- **Description**: Find the index of the first occurrence of a byte in a byte list.
- **Postcondition**: `memchr_postcond` requires:
  - If `some i`: `i < haystack.length`, `haystack[i]? = some needle`, and no index `j < i` has `haystack[j]? = some needle` (first occurrence)
  - If `none`: no index in the haystack contains the needle byte
- **Key constraints**: The postcond fully determines the result — it's the minimum index where the needle appears, or `none` if absent. Both directions are constrained (found → valid first match, not found → truly absent).

### 2. `memmem`

- **Signature**: `def memmem (needle : List UInt8) (haystack : List UInt8) : Option Nat`
- **Description**: Find the starting index of the first occurrence of a byte substring within a byte list.
- **Postcondition**: `memmem_postcond` requires:
  - If `some i`: `i + needle.length ≤ haystack.length`, the substring at position `i` matches (`List.take needle.length (List.drop i haystack) = needle`), and no earlier position matches
  - Empty needle always returns `some 0`
  - If `none`: no valid position contains the needle substring
- **Key constraints**: Substring matching uses `List.drop i haystack |> List.take needle.length`. The empty needle edge case (`needle = [] → result = some 0`) is explicitly required. The postcond fully pins down first-occurrence semantics.

### 3. `memrchr`

- **Signature**: `def memrchr (needle : UInt8) (haystack : List UInt8) : Option Nat`
- **Description**: Find the index of the last occurrence of a byte in a byte list.
- **Postcondition**: `memrchr_postcond` requires:
  - If `some i`: `i < haystack.length`, `haystack[i]? = some needle`, and no index `j > i` (within bounds) has `haystack[j]? = some needle` (last occurrence)
  - If `none`: no index in the haystack contains the needle byte
- **Key constraints**: Symmetric to `memchr` but searches from the end. The "no later match" constraint uses `j > i` instead of `j < i`.

## Relational Properties

- **`memchr_memrchr_rel`**: `memchr` returns `some` if and only if `memrchr` returns `some`. In other words, a byte exists in the list iff both forward and reverse search find it. This is an `↔` — neither can succeed without the other.

## Types

No custom types — all functions operate on `UInt8`, `List UInt8`, `Nat`, and `Option Nat`.

## Hints

- For `memchr`: scan left-to-right, return the index of the first matching byte. Use `List.findIdx?` or a recursive scan with an accumulator.
- For `memrchr`: scan right-to-left (or scan the entire list and keep the last match). A simple approach: `memchr` on the reversed list, then adjust the index (`haystack.length - 1 - i`).
- For `memmem`: slide a window of `needle.length` across the haystack, checking equality at each position. Return the first matching position. Handle `needle = []` as a special case returning `some 0`.
- The `memchr_memrchr_rel` proof follows from the fact that both functions search the same list for the same byte — if the byte exists at any index, both will find it (memchr at the first, memrchr at the last).
- All three postconds have the "none → truly absent" direction, which requires showing that if the search returns `none`, no valid index contains a match. This typically follows by contradiction from the search logic.

## Edit Boundaries

`Memchr/*.lean` is divided into labeled sections:

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

- `Memchr/FindByte.lean`
- `Memchr/FindLastByte.lean`
- `Memchr/FindSubstring.lean`
- `Memchr/Helpers.lean`
- `Memchr/Relations.lean`
- `Memchr/Types.lean`
