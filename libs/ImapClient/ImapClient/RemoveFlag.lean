-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import ImapClient.Types
import ImapClient.Helpers
import ImapClient.Render
import ImapClient.AddFlag

namespace ImapClient

/-! ## Core Function 3: removeFlag -/

def removeFlag (flags : List MessageFlag) (f : MessageFlag) : List MessageFlag := 
                                                                                  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def removeFlag_postcond (flags : List MessageFlag) (f : MessageFlag) (result : List MessageFlag) : Prop :=
  hasFlag result f = false ∧
  (∀ g, (f == g) = false → hasFlag flags g = true → hasFlag result g = true) ∧
  (hasFlag flags f = false → result = flags)

theorem removeFlag_spec (flags : List MessageFlag) (f : MessageFlag) :
    removeFlag_postcond flags f (removeFlag flags f) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end ImapClient
-- === END: FIXED_FINAL ===
