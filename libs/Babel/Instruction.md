# Babel

## Background

Babel is a Python internationalization (i18n) and localization (l10n) library. It provides locale-aware formatting for numbers, dates, currencies, and text based on CLDR (Unicode Common Locale Data Repository) data. This spec focuses on the three pillars of i18n: locale parsing, number formatting, and date formatting.

## Task

Complete implementation holes in explicitly editable regions in the `Babel/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parseLocale`

- **Signature**: `def parseLocale (s : String) : Option Locale`
- **Description**: Parse a locale identifier string (e.g., "en", "en_US", "zh_Hans_CN") into a structured `Locale` with language, territory, script, and variant fields.
- **Postcondition**: Empty string returns `none`. Any successful parse has a non-empty language whose length doesn't exceed the input. Specific pins: "en" → `⟨"en", none, none, none⟩`, "en_US" → `⟨"en", some "US", none, none⟩`, etc.
- **Key constraints**: The underscore `_` separates components. The format is `language[_script][_territory][_variant]`. Script codes are 4-letter title-case (e.g., "Hans"), territory codes are 2-letter uppercase (e.g., "US").

### 2. `Locale.toString` (supporting function)

- **Signature**: `def Locale.toString (loc : Locale) : String`
- **Description**: Serialize a `Locale` back to its string representation, joining components with underscores.
- **Postcondition**: Non-empty language produces non-empty result containing the language. Territory appears in result if present. Exact pins: `⟨"en", none, none, none⟩` → "en", `⟨"zh", some "CN", some "Hans", none⟩` → "zh_Hans_CN", etc.
- **Key constraints**: Must produce the canonical format that `parseLocale` can roundtrip. Note the ordering: `language_script_territory` (not `language_territory_script`), as shown by the "zh_Hans_CN" pin.

### 3. `formatDecimal`

- **Signature**: `def formatDecimal (loc : LocaleData) (n : Int) : String`
- **Description**: Format an integer according to the locale's number formatting rules, including grouping separators and sign handling.
- **Postcondition**:
  - Result is always non-empty
  - Zero contains "0"; positive numbers contain digits; negative numbers contain the locale's minus sign
  - Positive numbers do NOT contain the minus sign
  - Specific value pins: 42 → contains "42", 1000 with group="," → contains "1,000", 1000000 with group="," → contains "1,000,000"
- **Key constraints**: Grouping is controlled by `loc.numberSymbols.group`. The minus sign is `loc.numberSymbols.minusSign` (not necessarily "-").

### 4. `formatDate`

- **Signature**: `def formatDate (loc : LocaleData) (d : SimpleDate) (formatStr : String := "medium") : String`
- **Description**: Format a date according to the specified format style ("short", "medium", "long", "full").
- **Postcondition**:
  - Valid dates with non-empty format produce non-empty result with digits, length ≥ 4
  - Empty format → empty result
  - **Long format**: includes full month name, day number, and year (e.g., "March 15, 2024")
  - **Full format**: includes day-of-week name, full month name, and year (e.g., "Friday, March 15, 2024")
  - **Medium format**: includes abbreviated month, day, and year (e.g., "Jan 15, 2024")
  - Invalid inputs (month=0, month>12, day=0) → empty result
- **Key constraints**: Full format requires computing the day of week (e.g., March 15, 2024 is a Friday; Feb 29, 2024 is a Thursday). Month names must be in English for the pins given.

## Relational Properties

- **`parseLocale_toString_roundtrip_rel`**: For any locale with non-empty language, `parseLocale (Locale.toString loc) = some loc` — serializing then parsing recovers the original locale.
- **`toString_parseLocale_roundtrip_rel`**: For any string that successfully parses to a locale, `Locale.toString loc = s` — parsing then serializing recovers the original string.

## Types

- **`Locale`**: A parsed locale identifier with `language` (String), `territory` (Option String), `script` (Option String), `variant` (Option String).
- **`LocaleData`**: Full locale formatting configuration containing a `Locale`, `NumberSymbols`, format patterns (`NumberPattern`), and `TextDirection`.
- **`NumberSymbols`**: Locale-specific symbols for decimal point, grouping separator, plus/minus signs, percent, etc.
- **`NumberPattern`**: A parsed CLDR number format pattern with prefix/suffix, grouping sizes, and digit constraints.
- **`SimpleDate`**: A date with `year` (Int), `month` (Nat), `day` (Nat).
- **`TextDirection`**: Either `.ltr` or `.rtl`.

## Hints

- The `containsSub` helper is already implemented — it checks if a substring occurs within a string using `String.splitOn`.
- For `formatDate` full format, you need a day-of-week algorithm (e.g., Zeller's congruence or similar). The pins test: 2024-03-15 = Friday, 2024-02-29 = Thursday.
- The roundtrip specs are the strongest constraints in this spec — they force `parseLocale` and `Locale.toString` to be exact inverses. Design both functions together.
- For `formatDecimal`, the grouping logic inserts `loc.numberSymbols.group` every 3 digits from the right (standard Western grouping).

## Edit Boundaries

`Babel/*.lean` is divided into labeled sections:

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

- `Babel/Date.lean`
- `Babel/Locale.lean`
- `Babel/Number.lean`
- `Babel/Types.lean`
