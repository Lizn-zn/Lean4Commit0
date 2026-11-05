-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Babel.Types

namespace Babel

/-! ## Locale Parsing and Serialization -/

def parseLocale (s : String) : Option Locale :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseLocale_postcond (s : String) (result : Option Locale) : Prop :=
  (s = "" → result = none) ∧
  (∀ loc, result = some loc → loc.language ≠ "") ∧
  (∀ loc, result = some loc → loc.language.length ≤ s.length) ∧
  (s = "en" → result = some ⟨"en", none, none, none⟩) ∧
  (s = "en_US" → result = some ⟨"en", some "US", none, none⟩) ∧
  (s = "fr" → result = some ⟨"fr", none, none, none⟩) ∧
  (s = "de" → result = some ⟨"de", none, none, none⟩)

theorem parseLocale_spec (s : String) :
    parseLocale_postcond s (parseLocale s) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def Locale.toString (loc : Locale) : String :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def Locale.toString_postcond (loc : Locale) (result : String) : Prop :=
  (loc.language ≠ "" → result.length > 0) ∧
  (loc.language ≠ "" → containsSub result loc.language = true) ∧
  (loc.language = "" → result = "") ∧
  (∀ t, loc.territory = some t → t ≠ "" → loc.language ≠ "" → containsSub result t = true) ∧
  (loc = ⟨"en", none, none, none⟩ → result = "en") ∧
  (loc = ⟨"en", some "US", none, none⟩ → result = "en_US") ∧
  (loc = ⟨"fr", some "FR", none, none⟩ → result = "fr_FR") ∧
  (loc = ⟨"de", none, none, none⟩ → result = "de") ∧
  (loc = ⟨"ja", some "JP", none, none⟩ → result = "ja_JP") ∧
  (loc = ⟨"zh", some "CN", some "Hans", none⟩ → result = "zh_Hans_CN")

theorem Locale.toString_spec (loc : Locale) :
    Locale.toString_postcond loc (Locale.toString loc) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/-! ## Relational: parseLocale/toString roundtrip -/

@[reducible]
def parseLocale_toString_roundtrip_rel (loc : Locale) (result : Option Locale) : Prop :=
  loc.language ≠ "" → result = some loc

theorem parseLocale_toString_roundtrip_spec (loc : Locale)
    (h : loc.language ≠ "") :
    parseLocale_toString_roundtrip_rel loc (parseLocale (Locale.toString loc)) := by
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



@[reducible]
def toString_parseLocale_roundtrip_rel (s : String) (loc : Locale) (result : String) : Prop :=
  result = s

theorem toString_parseLocale_roundtrip_spec (s : String) (loc : Locale)
    (hp : parseLocale s = some loc) :
    toString_parseLocale_roundtrip_rel s loc (Locale.toString loc) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Babel
-- === END: FIXED_FINAL ===
