-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Jedi.Types

namespace Jedi

def Position.le (a b : Position) : Bool :=
  a.line < b.line ∨ (a.line = b.line ∧ a.column ≤ b.column)

def countFuncDefs : List Stmt → Nat
  | [] => 0
  | (Stmt.functionDef _ _ _ _ _ _) :: rest => 1 + countFuncDefs rest
  | _ :: rest => countFuncDefs rest

def countClassDefs : List Stmt → Nat
  | [] => 0
  | (Stmt.classDef _ _ _ _) :: rest => 1 + countClassDefs rest
  | _ :: rest => countClassDefs rest

end Jedi
-- === END: FIXED_FINAL ===
