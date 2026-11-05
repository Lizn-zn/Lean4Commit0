-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Serde.Types

namespace Serde

/-! ## Primitive Deserialize Instances -/

def deserializeBool : Value → Option Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def deserializeInt : Value → Option Int :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def deserializeFloat : Value → Option Float :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



def deserializeString : Value → Option String :=
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



def deserializeChar : Value → Option Char :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



instance : Deserialize Bool where
  deserialize := deserializeBool

instance : Deserialize Int where
  deserialize := deserializeInt

instance : Deserialize Float where
  deserialize := deserializeFloat

instance : Deserialize String where
  deserialize := deserializeString

instance : Deserialize Char where
  deserialize := deserializeChar

/-! ## Struct Helpers -/

/-- Access a field of a Serde struct value by name. -/
def structGetField (v : Value) (field : String) : Option Value :=
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_7 (provided) ===



/-- Return all field names of a struct value. -/
def structFields (v : Value) : List String :=
  
  
-- === END: FIXED_7 ===
-- === BEGIN: OBLIGATION_7 (editable) ===
  sorry
-- === END: OBLIGATION_7 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Serde
-- === END: FIXED_FINAL ===
