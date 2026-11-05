-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

def _root_.Tabulate.containsSubstr (s sub : String) : Bool := (s.splitOn sub).length > 1
-- === END: FIXED_FINAL ===
