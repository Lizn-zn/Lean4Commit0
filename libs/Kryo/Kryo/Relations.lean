-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Kryo.Validity
import Std
import Lean

import Kryo.Types
import Kryo.Helpers
import Kryo.WriteVarInt
import Kryo.Serialize
import Kryo.Deserialize

namespace Kryo

/-! ## Relational: serialize/deserialize roundtrip -/

@[reducible]
def serialize_deserialize_roundtrip_rel (v : KryoValue) (result : Option KryoValue) : Prop :=
  result = some v

theorem serialize_deserialize_roundtrip_spec (v : KryoValue) 
    (hlossless : v.Lossless) :
    serialize_deserialize_roundtrip_rel v (deserialize (serialize v)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Kryo
-- === END: FIXED_FINAL ===
