-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Schedule.Types

namespace Schedule

/-! ## Helpers -/

@[reducible]
def unitMultiplier (u : TimeUnit) : Nat :=
  match u with
  | .second    => 1
  | .minute    => 60
  | .hour      => 3600
  | .day       => 86400
  | .week      => 604800
  | .monday    => 86400
  | .tuesday   => 86400
  | .wednesday => 86400
  | .thursday  => 86400
  | .friday    => 86400
  | .saturday  => 86400
  | .sunday    => 86400

end Schedule
-- === END: FIXED_FINAL ===
