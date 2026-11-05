# Utf8Proc

## Background

utf8proc is a C library for Unicode text processing, providing character classification (General Category), case mapping, Unicode normalization (NFC, NFD, NFKC, NFKD), grapheme cluster segmentation, and UTF-8 encoding/decoding. This spec models the three most fundamental capabilities — character category lookup, Unicode normalization, and UTF-8 encoding — as pure functions over Lean 4's `Char`, `String`, and `UInt` types.

## Task

Complete implementation holes in explicitly editable regions in `Utf8Proc/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `charCategory`

- **Signature**: `def charCategory (c : Char) : Category`
- **Description**: Returns the Unicode General Category for a character (e.g., uppercase letter, digit, punctuation, symbol).
- **Postcondition**: Extensive range-based mappings including: ASCII uppercase (U+0041–U+005A) → `Lu`, ASCII lowercase (U+0061–U+007A) → `Ll`, ASCII digits (U+0030–U+0039) → `Nd`, space → `Zs`, C0 controls → `Cc`, Latin-1 Supplement uppercase/lowercase, Greek uppercase/lowercase, Cyrillic uppercase/lowercase, combining diacritical marks (U+0300–U+036F) → `Mn`, Euro sign → `Sc`, CJK Ideographs → `Lo`, Hebrew letters → `Lo`.
- **Key constraints**: The postcondition specifies exact categories for specific Unicode ranges. Characters not covered by any explicit range can return any valid category. The `Category` type has 30 variants matching the Unicode standard.

### 2. `normalize`

- **Signature**: `def normalize (s : String) (form : NormForm) : String`
- **Description**: Normalizes a Unicode string to the specified normalization form (NFC, NFD, NFKC, or NFKD).
- **Postcondition**: (1) Empty string → empty string. (2) Pure ASCII strings are already normalized → returned unchanged. (3) Non-empty input → non-empty result. (4) Concrete NFC test: "e" + combining acute → "é". (5) Concrete NFD tests: "é" → "e" + combining acute; "À" → "A" + combining grave. (6) NFC: "À" stays as "À".
- **Key constraints**: NFC = canonical decomposition followed by canonical composition. NFD = canonical decomposition only. The concrete test cases specify exact `Char` values (e.g., U+0301 = combining acute accent, U+00E9 = é).

### 3. `codePointToUtf8`

- **Signature**: `def codePointToUtf8 (cp : UInt32) : List UInt8`
- **Description**: Encodes a Unicode codepoint to its UTF-8 byte sequence.
- **Postcondition**: (1) Result length ∈ [1, 4]. (2) ASCII (≤ 0x7F) → single byte equal to codepoint. (3) 2-byte (0x80–0x7FF): first byte ∈ [0xC2, 0xDF], last byte ∈ [0x80, 0xBF]. (4) 3-byte (0x800–0xFFFF): first byte ∈ [0xE0, 0xEF]. (5) 4-byte (0x10000–0x10FFFF): first byte ∈ [0xF0, 0xF4]. (6) Concrete tests: 65 → [65], 0xE9 → [0xC3, 0xA9], 0x20AC → [0xE2, 0x82, 0xAC].
- **Key constraints**: UTF-8 encoding follows RFC 3629. The spec theorem has a precondition `cp ≤ 0x10FFFF`. The `utf8ToCodePoints` function (also needs implementation) is used in the roundtrip relational spec.

## Relational Properties

- **`utf8_roundtrip_rel`**: For any codepoint `cp ≤ 0x10FFFF`, `utf8ToCodePoints (codePointToUtf8 cp) = some [cp]` — encoding then decoding recovers the original codepoint.
- **`normalize_idempotent_rel`**: `normalize (normalize s form) form = normalize s form` — normalizing an already-normalized string is a no-op.

## Types

- **`Category`**: Unicode General Category with 30 variants: `Lu` (uppercase letter), `Ll` (lowercase letter), `Nd` (decimal digit), `Zs` (space separator), `Cc` (control), `Mn` (nonspacing mark), `Sm` (math symbol), `Sc` (currency symbol), `Lo` (other letter), etc.
- **`NormForm`**: Unicode normalization forms — `NFD`, `NFC`, `NFKD`, `NFKC`.

## Hints

- For `charCategory`: implement as a series of range checks on `c.val`. Start with specific cases (control chars, space) then handle ranges (ASCII uppercase, ASCII lowercase, digits, Latin-1, Greek, Cyrillic, combining marks, CJK, Hebrew). Return a default category (e.g., `Cn` for unassigned) for unrecognized codepoints.
- For `normalize`: NFD decomposes each character using canonical decomposition (e.g., é → e + combining acute). NFC does NFD first, then recomposes where possible. For the postcondition, you need to handle the specific test cases. A simple approach: decompose each char, then for NFC, scan for composable pairs and compose them.
- For `codePointToUtf8`: the standard UTF-8 encoding algorithm: if `cp ≤ 0x7F`, emit 1 byte; if `cp ≤ 0x7FF`, emit `[0xC0 | (cp >> 6), 0x80 | (cp & 0x3F)]`; if `cp ≤ 0xFFFF`, emit 3 bytes; if `cp ≤ 0x10FFFF`, emit 4 bytes. Use bitwise operations (`UInt32.shiftRight`, `UInt32.land`, `UInt32.lor`).
- For `utf8ToCodePoints`: reverse the encoding — read the first byte to determine sequence length, extract bits from each byte, combine into a codepoint. Return `none` for invalid sequences (continuation bytes alone, overlong encodings, 0xFF).
- The roundtrip proof requires showing that your encoding and decoding are exact inverses. Design them together.
- The normalize idempotent proof requires showing that the output of normalize is already in the target form.

## Edit Boundaries

`Utf8Proc/*.lean` is divided into labeled sections:

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

- `Utf8Proc/CharCategory.lean`
- `Utf8Proc/CodePointToUtf8.lean`
- `Utf8Proc/Normalize.lean`
- `Utf8Proc/Types.lean`
- `Utf8Proc/Utf8ToCodePoints.lean`
