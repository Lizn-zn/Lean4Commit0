-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Babel (Core Summary)
   A library for internationalization (i18n) and localization (l10n),
   including locale-aware formatting for numbers, dates, currencies, and text.

   Summarized from the full spec to 3 core functions: parseLocale, formatDecimal, formatDate.
   Plus Locale.toString as a supporting function for roundtrip relational specs.
   Original: https://github.com/python-babel/babel

   ## Task
   Implement all functions marked with `sorry` and prove all theorems.
   Success criterion: `lake env lean libs/Babel/Babel.lean` passes with no `sorry` remaining.
-/

/-! ## Helpers -/

/-- Check whether `sub` occurs as a substring of `s`. -/
def containsSub (s sub : String) : Bool :=
  (s.splitOn sub).length > 1

namespace Babel

/-! ## Types -/

/-- Text direction -/
inductive TextDirection where
  | ltr : TextDirection
  | rtl : TextDirection
  deriving Repr, BEq, DecidableEq

/-- A parsed locale identifier -/
structure Locale where
  language  : String
  territory : Option String
  script    : Option String
  variant   : Option String
  deriving Repr, BEq

/-- Number formatting symbols for a locale -/
structure NumberSymbols where
  decimal       : String
  group         : String
  plusSign      : String
  minusSign    : String
  percentSign  : String
  perMilleSign : String
  exponential  : String
  infinity     : String
  nan          : String
  deriving Repr, BEq

/-- A number format pattern (parsed CLDR pattern) -/
structure NumberPattern where
  pattern            : String
  positivePrefix     : String
  positiveSuffix     : String
  negativePrefix     : String
  negativeSuffix     : String
  groupingSize       : Nat
  secondaryGrouping  : Option Nat
  minIntDigits       : Nat
  minFracDigits      : Nat
  maxFracDigits      : Nat
  deriving Repr, BEq

/-- A simple date representation -/
structure SimpleDate where
  year  : Int
  month : Nat
  day   : Nat
  deriving Repr, BEq

/-- Locale data containing formatting rules -/
structure LocaleData where
  locale          : Locale
  numberSymbols   : NumberSymbols
  decimalFormat   : NumberPattern
  percentFormat   : NumberPattern
  scientificFormat : NumberPattern
  currencyFormat  : NumberPattern
  textDirection   : TextDirection
  deriving Repr, BEq

end Babel
-- === END: FIXED_FINAL ===
