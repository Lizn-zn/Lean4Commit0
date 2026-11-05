# AhoCorasick

## Background

Aho-Corasick is a classic multi-pattern string matching algorithm. Given a set of pattern strings, it builds a finite automaton (a trie augmented with failure links) that can find all occurrences of any pattern in a haystack string in a single pass. 

## Task

Complete implementation holes in explicitly editable regions in the split AhoCorasick modules and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

Current file layout:

- `libs/AhoCorasick/AhoCorasick.lean`
- `libs/AhoCorasick/AhoCorasick/Types.lean`
- `libs/AhoCorasick/AhoCorasick/Build.lean`
- `libs/AhoCorasick/AhoCorasick/Search.lean`
- `libs/AhoCorasick/AhoCorasick/Replace.lean`

## Edit Boundaries

Each Lean module is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Provided sections must not be modified. Editable sections are your workspace.

Editable sections:

- `Build.lean`: `BUILD_IMPL`, `BUILD_PROOF`
- `Search.lean`: `FINDALL_IMPL`, `FINDALL_PROOF`, `ISMATCH_IMPL`
- `Replace.lean`: `REPLACEALL_IMPL`, `REPLACEALL_PROOF`

Provided sections cover imports, shared types, helper definitions, and fixed postcondition statements.

Integrity checking commands:

- Check that all provided sections are unchanged:
  `./check.sh --integrity-only`
- Check that the library still compiles:
  `./check.sh --compile`
- Run both checks:
  `./check.sh`

## Core Functions

### 1. `build`

- **Signature**: `def build (patterns : List String) : Automaton`
- **Description**: Construct an Aho-Corasick automaton from a list of pattern strings. This involves building a trie from the patterns and computing failure links via BFS.
- **Postcondition** (`build_postcond`):
  - `result.patterns = patterns` (patterns stored verbatim)
  - At least 1 node (the root); root has failure link 0 and depth 0
  - All failure links point to valid node IDs
  - All output indices are valid pattern indices
  - Root has no output (unless `""` is a pattern)
  - All child node IDs are within bounds
  - Node depths are bounded by the longest pattern length
  - For each non-empty pattern, the trie path from root exists and the final node has that pattern's index in its output list
- **Key constraints**: The `traceTriePath` helper is already implemented and is used in the postcondition to verify trie paths exist. Your automaton's `nodes` list must be structured so that following children from root spells out each pattern.

### 2. `findAll`

- **Signature**: `def findAll (a : Automaton) (haystack : String) : List Match`
- **Description**: Find all non-overlapping matches of the automaton's patterns in the haystack, using leftmost-first semantics.
- **Postcondition** (`findAll_postcond`):
  - Every match has a valid pattern index, `start ≤ end ≤ haystack.length`, and the corresponding substring equals the matched pattern
  - Matches are non-overlapping: `List.Pairwise (fun m1 m2 => m1.end ≤ m2.start)`
  - Completeness: every occurrence of every non-empty pattern in the haystack is "covered" by some match (i.e., some match's span overlaps with it)
- **Key constraints**: The completeness condition says that for any position where a pattern occurs, there exists a match in the result whose span contains that position (`m.start ≤ pos ∧ pos < m.end`). This allows leftmost-first to "shadow" later occurrences.

### 3. `replaceAll`

- **Signature**: `def replaceAll (a : Automaton) (haystack : String) (replacements : List String) : String`
- **Description**: Replace all non-overlapping matches in the haystack. `replacements[i]` is the replacement for `patterns[i]`.
- **Postcondition** (`replaceAll_postcond`):
  - If no patterns, result equals haystack
  - If haystack is empty, result is empty
  - If no match exists (`isMatch` returns false), result equals haystack
  - If all replacements equal their patterns, result equals haystack
  - When `replacements.length = patterns.length`, the result equals `buildReplacedString haystack (findAll a haystack) a.patterns replacements`
- **Key constraints**: The `buildReplacedString` helper is already implemented — it walks the match list left-to-right, copying gaps and inserting replacements. Your `replaceAll` must produce the same result.

## Types

- **`Match`**: A match result with `patternIndex`, `start`, and `end` (half-open interval `[start, end)` in the haystack).
- **`TrieNode`**: A node in the trie with `children` (char-to-nodeID mapping), `failure` (failure link node ID), `output` (list of pattern indices ending here), and `depth`.
- **`Automaton`**: The complete automaton with `nodes` (list of `TrieNode`) and `patterns` (the original pattern list).
- **`MatchKind`**: Match semantics enum (standard, leftmostFirst, leftmostLongest) — defined but not directly used in postconditions.

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `AhoCorasick/Build.lean`
- `AhoCorasick/Replace.lean`
- `AhoCorasick/Search.lean`
- `AhoCorasick/Types.lean`
