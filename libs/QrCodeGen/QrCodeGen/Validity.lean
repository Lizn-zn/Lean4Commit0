-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import QrCodeGen.Types

namespace QrCodeGen

def Grid.Valid (g : Grid) : Prop :=
  g.modules.length = g.size ∧ ∀ row ∈ g.modules, row.length = g.size

end QrCodeGen
-- === END: FIXED_FINAL ===
