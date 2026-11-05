-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Voluptuous.Types

namespace Voluptuous

instance : Inhabited Value := ⟨.null⟩


def Value.isBool : Value → Bool
  | .bool _ => true
  | _       => false


def Value.isInt : Value → Bool
  | .int _ => true
  | _      => false


def Value.isFloat : Value → Bool
  | .float _ => true
  | _        => false


def Value.isStr : Value → Bool
  | .str _ => true
  | _      => false


def Value.isList : Value → Bool
  | .list _ => true
  | _       => false


def Value.isDict : Value → Bool
  | .dict _ => true
  | _       => false


def Value.toFloat? : Value → Option Float
  | .int n   => some (Float.ofInt n)
  | .float f => some f
  | _        => none


def Value.length? : Value → Option Nat
  | .str s  => some s.length
  | .list l => some l.length
  | _       => none


def Value.lookup (entries : List (String × Value)) (key : String) : Option Value :=
  entries.lookup key

/-! ## Error Types -/


def isBoolean : SchemaNode :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## Core Function 1: validate -/

/- Validate a value against a schema node. -/

end Voluptuous
-- === END: FIXED_FINAL ===
