-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import FilesystemSpec.Types

namespace FilesystemSpec

def _root_.FilesystemSpec.containsSubstr (s : String) (sub : String) : Bool :=
  let sl := s.toList
  let subl := sub.toList
  if subl.length > sl.length then false
  else (List.range (sl.length - subl.length + 1)).any fun i =>
    (sl.drop i).take subl.length == subl


end FilesystemSpec
-- === END: FIXED_FINAL ===
