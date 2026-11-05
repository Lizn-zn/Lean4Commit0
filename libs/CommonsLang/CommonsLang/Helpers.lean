-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace CommonsLang

/-! ## Helpers -/

-- Helper: count non-overlapping occurrences of sub in chars
def countNonOverlap (chars : List Char) (sub : List Char) : Nat :=
  let rec go (fuel : Nat) (cs : List Char) (acc : Nat) : Nat :=
    match fuel with
    | 0 => acc
    | remaining + 1 =>
      if sub.isEmpty || cs.length < sub.length then acc
      else if cs.take sub.length == sub then
        go remaining (cs.drop sub.length) (acc + 1)
      else go remaining cs.tail! acc
  go (chars.length + 1) chars 0

end CommonsLang
-- === END: FIXED_FINAL ===
