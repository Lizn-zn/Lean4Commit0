-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Disruptor.Types

namespace Disruptor

/-- Increment a sequence by one. -/
def Sequence.next (s : Sequence) : Sequence :=
  { value := s.value + 1 }

/-- Initial sequence value (-1 conceptually, modeled as 0 with offset). -/
def Sequence.initial : Sequence :=
  { value := 0 }

end Disruptor
-- === END: FIXED_FINAL ===
