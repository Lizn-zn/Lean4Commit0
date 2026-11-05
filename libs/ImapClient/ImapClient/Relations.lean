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
import ImapClient.RemoveFlag

namespace ImapClient

/-! ## Relational: hasFlag after addFlag -/

@[reducible]
def hasFlag_after_addFlag_rel (flags : List MessageFlag) (f : MessageFlag) : Prop :=
  hasFlag (addFlag flags f) f = true

theorem hasFlag_after_addFlag_spec (flags : List MessageFlag) (f : MessageFlag) :
    hasFlag_after_addFlag_rel flags f := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: hasFlag after removeFlag -/

@[reducible]
def hasFlag_after_removeFlag_rel (flags : List MessageFlag) (f : MessageFlag) : Prop :=
  hasFlag (removeFlag flags f) f = false

theorem hasFlag_after_removeFlag_spec (flags : List MessageFlag) (f : MessageFlag) :
    hasFlag_after_removeFlag_rel flags f := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: addFlag then removeFlag cancel -/

@[reducible]
def addFlag_removeFlag_cancel_rel (flags : List MessageFlag) (f : MessageFlag) (result : List MessageFlag) : Prop :=
  result = flags

theorem addFlag_removeFlag_cancel_spec (flags : List MessageFlag) (f : MessageFlag)
    (h : hasFlag flags f = false) :
    addFlag_removeFlag_cancel_rel flags f (removeFlag (addFlag flags f) f) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end ImapClient
-- === END: FIXED_FINAL ===
