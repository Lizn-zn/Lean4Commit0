-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import ImapClient.Types
import ImapClient.Helpers
import ImapClient.Render

namespace ImapClient

/-! ## Core Function 2: addFlag -/

def addFlag (flags : List MessageFlag) (f : MessageFlag) : List MessageFlag := 
                                                                               
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                               sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def addFlag_postcond (flags : List MessageFlag) (f : MessageFlag) (result : List MessageFlag) : Prop :=
  hasFlag result f = true ∧
  (∀ g, hasFlag flags g = true → hasFlag result g = true) ∧
  (hasFlag flags f = true → result = flags)

theorem addFlag_spec (flags : List MessageFlag) (f : MessageFlag) :
    addFlag_postcond flags f (addFlag flags f) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end ImapClient
-- === END: FIXED_FINAL ===
