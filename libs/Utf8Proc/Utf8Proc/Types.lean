-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Utf8Proc

inductive Category where
  | Lu | Ll | Lt | Lm | Lo
  | Mn | Mc | Me
  | Nd | Nl | No
  | Pc | Pd | Ps | Pe | Pi | Pf | Po
  | Sm | Sc | Sk | So
  | Zs | Zl | Zp
  | Cc | Cf | Cs | Co | Cn
  deriving Repr, BEq, DecidableEq

/-- Unicode normalization form. -/

inductive NormForm where
  | NFD
  | NFC
  | NFKD
  | NFKC
  deriving Repr, BEq, DecidableEq

/-! ## charCategory -/


end Utf8Proc
-- === END: FIXED_FINAL ===
