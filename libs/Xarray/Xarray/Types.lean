-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Xarray

inductive Label where
  | num (v : Float)
  | str (s : String)
  | int (n : Int)
  deriving Repr, BEq, Inhabited


structure Dimension where
  name : String
  labels : Array Label
  deriving Repr, Inhabited, BEq


structure DataArray where
  name : Option String
  dims : Array Dimension
  shape : Array Nat
  data : Array Float
  attrs : Array (String × String)
  deriving Repr, Inhabited, BEq

/-! ## Supporting: ndim, dimIndex (referenced in postconds) -/


end Xarray
-- === END: FIXED_FINAL ===
