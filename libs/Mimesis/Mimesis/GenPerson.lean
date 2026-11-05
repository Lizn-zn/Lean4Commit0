-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Mimesis.Types

namespace Mimesis

/-! ## Core Function 2: genPerson -/

def genPerson (state : PrngState) (locale : MimesisLocale) : PersonData × PrngState :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def genPerson_postcond (state : PrngState) (locale : MimesisLocale) (result : PersonData × PrngState) : Prop :=
  result.1.firstName ≠ "" ∧ result.1.lastName ≠ "" ∧ result.1.fullName ≠ "" ∧
  result.1.email ≠ "" ∧ result.1.phone ≠ "" ∧ result.1.username ≠ "" ∧
  result.1.age ≤ 120 ∧
  ' ' ∈ result.1.fullName.toList ∧
  '@' ∈ result.1.email.toList ∧
  '_' ∈ result.1.username.toList ∧
  result.1.firstName.length ≥ 1 ∧ result.1.firstName.length ≤ 50 ∧
  result.1.lastName.length ≥ 1 ∧ result.1.lastName.length ≤ 50 ∧
  (result.1.phone.toList.filter (fun c => c.isDigit)).length ≥ 7 ∧
  ¬ (result.1.firstName.toList.any (fun c => c.isDigit)) ∧
  ¬ (result.1.lastName.toList.any (fun c => c.isDigit)) ∧
  ¬ (result.1.fullName.toList.any (fun c => c.isDigit)) ∧
  (result.1.username.toList.filter Char.isDigit).length ≥ 4 ∧
  '.' ∈ result.1.email.toList ∧
  (result.1.email.toList.filter Char.isDigit).length ≥ 4 ∧
  (["duck.com", "example.com", "example.org", "gmail.com", "live.com",
     "outlook.com", "protonmail.com", "yahoo.com", "yandex.com"].any
    (fun dom => result.1.email.endsWith dom))

theorem genPerson_spec (state : PrngState) (locale : MimesisLocale) :
    genPerson_postcond state locale (genPerson state locale) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Mimesis
-- === END: FIXED_FINAL ===
