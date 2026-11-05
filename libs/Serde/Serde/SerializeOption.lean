-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Serde.Helpers

namespace Serde

def serializeOption [Serialize α] (o : Option α) : Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def serializeOption_postcond [Serialize α] (o : Option α) (result : Value) : Prop :=
  (o = Option.none → result = Value.none) ∧
  (∀ a, o = Option.some a → result = Value.some (Serialize.serialize a))

theorem serializeOption_spec [Serialize α] (o : Option α) :
    serializeOption_postcond o (serializeOption o) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Serde
-- === END: FIXED_FINAL ===
