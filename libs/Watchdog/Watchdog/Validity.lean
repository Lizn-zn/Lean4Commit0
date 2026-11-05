-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Watchdog.Types

namespace Watchdog

def FileSystemState.Valid (s : FileSystemState) : Prop :=
  (s.entries.map Prod.fst).Nodup

end Watchdog
-- === END: FIXED_FINAL ===
