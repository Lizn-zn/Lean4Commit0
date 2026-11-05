# ImapClient

## Background

ImapClient is a Python library for interacting with IMAP email servers. It provides command construction (rendering IMAP protocol commands to wire format), response parsing, mailbox management, message flag operations, search criteria building, and Modified UTF-7 encoding for mailbox names. This core spec focuses on three essential operations: rendering IMAP commands to protocol strings, and adding/removing message flags with set-theoretic guarantees.

## Task

Complete implementation holes in explicitly editable regions in `ImapClient/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `ImapCommand.render`

- **Signature**: `def ImapCommand.render (cmd : ImapCommand) (tag : String) : String`
- **Description**: Renders an IMAP command with a given tag prefix into the IMAP wire format string (e.g., `"A001 SELECT \"INBOX\""`).
- **Postcondition**: 25+ clauses, one per command type:
  - Result always starts with the tag
  - Simple commands: `capability` → `"tag CAPABILITY"`, `noop` → `"tag NOOP"`, `logout` → `"tag LOGOUT"`, etc.
  - Parameterized commands: `login u p` → `"tag LOGIN \"u\" \"p\""`, `select m` → `"tag SELECT \"m\""`, etc.
  - Commands with message sets: `fetch ms items` → starts with `"tag FETCH " ++ ms.toImapString`, etc.
  - Search: `search c` → `"tag SEARCH " ++ c.toImapString`
  - UID variants: `uidFetch`, `uidStore`, `uidCopy`, `uidSearch` prepend `"UID "` before the command keyword
- **Key constraints**: String arguments must be quoted with `\"`. Message set and search criterion arguments use their respective `toImapString` helpers.

### 2. `addFlag`

- **Signature**: `def addFlag (flags : List MessageFlag) (f : MessageFlag) : List MessageFlag`
- **Description**: Adds a message flag to a flag list if not already present (set-add semantics).
- **Postcondition**:
  - `hasFlag result f = true` — the flag is present in the result
  - All flags previously present are still present
  - If the flag was already present, the list is unchanged (`result = flags`)
- **Key constraints**: Must be idempotent — adding an already-present flag returns the same list.

### 3. `removeFlag`

- **Signature**: `def removeFlag (flags : List MessageFlag) (f : MessageFlag) : List MessageFlag`
- **Description**: Removes a message flag from a flag list (set-remove semantics).
- **Postcondition**:
  - `hasFlag result f = false` — the flag is absent from the result
  - All other flags (where `f == g = false`) are preserved
  - If the flag wasn't present, the list is unchanged (`result = flags`)
- **Key constraints**: Must be idempotent — removing an absent flag returns the same list. Uses `BEq` for flag comparison.

### 4. `hasFlag` (helper)

- **Signature**: `def hasFlag (flags : List MessageFlag) (f : MessageFlag) : Bool`
- **Description**: Checks if a flag is present in the list using `BEq` comparison.

### 5. `MessageSet.toImapString` (helper stub)

- **Signature**: `def MessageSet.toImapString (ms : MessageSet) : String`
- **Description**: Renders a message set to IMAP wire format (e.g., `"1:5"`, `"1,3,5"`, `"*"`).

### 6. `SearchCriterion.toImapString` (helper stub)

- **Signature**: `def SearchCriterion.toImapString : SearchCriterion → String`
- **Description**: Renders a search criterion to IMAP wire format (e.g., `"ALL"`, `"FROM \"user@example.com\""`).

## Relational Properties

- **`hasFlag_after_addFlag`**: `hasFlag (addFlag flags f) f = true` — after adding a flag, it's present.
- **`hasFlag_after_removeFlag`**: `hasFlag (removeFlag flags f) f = false` — after removing a flag, it's absent.
- **`addFlag_removeFlag_cancel`**: When `hasFlag flags f = false`, `removeFlag (addFlag flags f) f = flags` — adding then removing a flag that wasn't there recovers the original list.

## Types

- **`MessageFlag`**: IMAP message flags — standard flags (seen, answered, flagged, deleted, draft, recent) plus custom string flags.
- **`MessageSet`**: IMAP message identifier sets — single number, range, star (`*`), range-to, or a list of sets.
- **`SearchCriterion`**: IMAP search criteria — boolean combinators (and, or, not) and leaf criteria (from, to, subject, date ranges, flags, size constraints, etc.).
- **`ImapCommand`**: All IMAP commands — session (capability, login, logout), mailbox (select, examine, create, delete, rename, list), message (fetch, store, copy, search, expunge), and UID variants.

## Hints

- For `ImapCommand.render`, pattern match on the command variant and construct the string. Use `MessageSet.toImapString` and `SearchCriterion.toImapString` for their respective arguments. Quote string arguments with `\"`.
- For `hasFlag`, check membership using `BEq`: `flags.any (· == f)` or similar.
- For `addFlag`, check `hasFlag flags f` first. If true, return `flags` unchanged. If false, append `f`.
- For `removeFlag`, check `hasFlag flags f` first. If false, return `flags` unchanged. If true, filter out elements where `(· == f)`.
- The `addFlag_removeFlag_cancel` proof requires that `addFlag` on an absent flag produces `flags ++ [f]` (or `f :: flags`), and `removeFlag` removes exactly `f`, recovering the original list. The hypothesis `hasFlag flags f = false` ensures `f` wasn't already present.
- `MessageSet.toImapString` and `SearchCriterion.toImapString` are helper stubs — implement them to produce valid IMAP syntax (e.g., `single 5` → `"5"`, `range 1 10` → `"1:10"`, `star` → `"*"`).

## Edit Boundaries

`ImapClient/*.lean` is divided into labeled sections:

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

- `ImapClient/AddFlag.lean`
- `ImapClient/Helpers.lean`
- `ImapClient/Relations.lean`
- `ImapClient/RemoveFlag.lean`
- `ImapClient/Render.lean`
- `ImapClient/Types.lean`
