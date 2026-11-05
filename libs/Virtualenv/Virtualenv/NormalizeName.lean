-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Virtualenv.Types
import Virtualenv.Helpers

namespace Virtualenv

def normalizeName (name : String) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def normalizeName_postcond (name : String) (result : String) : Prop :=
  (name = "" → result = "") ∧
  (name ≠ "" → result ≠ "") ∧
  result.length ≤ name.length ∧
  result.toLower = result ∧
  (¬ result.any (fun c => c == '.' || c == '_')) ∧
  (∀ c ∈ result.data, c.isAlpha ∨ c.isDigit ∨ c == '-') ∧
  ((name.data.filter (fun c => c.isAlpha || c.isDigit)).map Char.toLower =
   result.data.filter (fun c => c != '-')) ∧
  ((result.splitOn "--").length < 2) ∧
  result = pep503Normalize name


theorem normalizeName_spec (name : String) 
    (hname : ∀ c ∈ name.toList, c.isAlphanum = true ∨ c = '-' ∨ c = '_' ∨ c = '.') :
    normalizeName_postcond name (normalizeName name) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: normalizeName is idempotent -/

@[reducible]
def normalizeName_idempotent_postcond (name : String) (result : String) : Prop :=
  result = normalizeName name


theorem normalizeName_idempotent_spec (name : String) 
    (hname : ∀ c ∈ name.toList, c.isAlphanum = true ∨ c = '-' ∨ c = '_' ∨ c = '.') :
    normalizeName_idempotent_postcond name (normalizeName (normalizeName name)) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Virtualenv
-- === END: FIXED_FINAL ===
