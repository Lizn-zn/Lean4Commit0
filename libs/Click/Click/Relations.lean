-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Click.Types
import Click.Helpers
import Click.ConvertValue

namespace Click

/-! ## Relational: convertValue roundtrips -/

@[reducible]
def convertValue_string_roundtrip_rel (s : String) (result : Except String String) : Prop :=
  result = Except.ok s

theorem convertValue_string_roundtrip_spec (s : String) :
    convertValue_string_roundtrip_rel s
      (do let v ← convertValue ParamType.STRING s; pure (paramValueToString v)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def convertValue_int_roundtrip_rel (n : Int) (result : Except String String) : Prop :=
  result = Except.ok (toString n)

theorem convertValue_int_roundtrip_spec (n : Int) :
    convertValue_int_roundtrip_rel n
      (do let v ← convertValue ParamType.INT (toString n); pure (paramValueToString v)) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def convertValue_bool_roundtrip_rel (result : Except String String) : Prop :=
  result = Except.ok "true"

theorem convertValue_bool_roundtrip_spec :
    convertValue_bool_roundtrip_rel
      (do let v ← convertValue ParamType.BOOL "true"; pure (paramValueToString v)) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Click
-- === END: FIXED_FINAL ===
