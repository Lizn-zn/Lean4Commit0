-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Fabric.Types

namespace Fabric

def _root_.Fabric.containsSubstr (s sub : String) : Bool :=
  if sub == "" then true
  else (s.splitOn sub).length > 1

/-! ## Helpers -/

/-- Numeric precedence of a ConfigLevel. -/
def ConfigLevel.precedence : ConfigLevel → Nat
  | .defaults => 0
  | .system   => 1
  | .user     => 2
  | .project  => 3
  | .runtime  => 4

/-- Find the index of the first occurrence of an element in a list. -/
def listIndexOf [BEq α] (xs : List α) (a : α) : Nat :=
  match xs with
  | []      => 0
  | x :: rest => if x == a then 0 else 1 + listIndexOf rest a

/-- Create an empty configuration. -/
def Config.empty : Config := ⟨[]⟩


end Fabric
-- === END: FIXED_FINAL ===
