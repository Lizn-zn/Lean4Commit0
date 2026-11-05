-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Bytes.Types

namespace Bytes

/-! ## Helpers -/

def Bytes.len (b : Bytes) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Bytes.len_postcond (b : Bytes) (result : Nat) : Prop :=
  result = b.data.length

theorem Bytes.len_spec (b : Bytes) :
    Bytes.len_postcond b (b.len) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def BytesMut.len (b : BytesMut) : Nat :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def BytesMut.len_postcond (b : BytesMut) (result : Nat) : Prop :=
  result = b.data.length

theorem BytesMut.len_spec (b : BytesMut) :
    BytesMut.len_postcond b (b.len) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



def BufReader.remaining (r : BufReader) : Nat :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



@[reducible]
def BufReader.remaining_postcond (r : BufReader) (result : Nat) : Prop :=
  result = r.data.length - r.pos

theorem BufReader.remaining_spec (r : BufReader) :
    BufReader.remaining_postcond r (r.remaining) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Bytes
-- === END: FIXED_FINAL ===
