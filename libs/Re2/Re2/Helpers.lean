-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Re2.Types

namespace Re2


/-! ## Infrastructure: findFirst (used by fullMatch and findAll postconds) -/

def findFirst (pattern : String) (input : String) : Option (Nat × Nat) := 
                                                                          
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                          sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




/-- Helper: compute total span length of match list -/
def matchSpanTotal (ms : List (Nat × Nat)) : Nat :=
  ms.foldl (fun acc m => acc + (m.2 - m.1)) 0

end Re2
-- === END: FIXED_FINAL ===
