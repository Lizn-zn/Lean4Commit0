-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Loguru.Types

def _root_.Loguru.containsSubstr (s sub : String) : Bool :=
  if sub == "" then true
  else (s.splitOn sub).length > 1

namespace Loguru
def Level.toNat : Level → Nat
  | .TRACE    => 5
  | .DEBUG    => 10
  | .INFO     => 20
  | .SUCCESS  => 25
  | .WARNING  => 30
  | .ERROR    => 40
  | .CRITICAL => 50

/-- Compare two levels by severity. -/
def Level.le (a b : Level) : Bool :=
  a.toNat ≤ b.toNat

end Loguru
-- === END: FIXED_FINAL ===
