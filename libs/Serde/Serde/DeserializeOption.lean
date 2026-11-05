-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Serde.Helpers

namespace Serde

def deserializeOption [Deserialize α] (v : Value) : Option (Option α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def deserializeOption_postcond [Deserialize α] (v : Value) (result : Option (Option α)) : Prop :=
  (v = Value.none → result = some Option.none) ∧
  (∀ inner, v = Value.some inner →
    (Deserialize.deserialize inner = (none : Option α) → result = some Option.none) ∧
    (∀ a : α, Deserialize.deserialize inner = some a → result = some (some a)))

theorem deserializeOption_spec [Deserialize α] (v : Value) :
    deserializeOption_postcond (α := α) v (deserializeOption v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Serde
-- === END: FIXED_FINAL ===
