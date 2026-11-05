-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Pypdf.Types

namespace Pypdf


/-! ## Pure helpers for postconditions -/

/-- Helper: extract text strings from TJ array items. -/
def tjArrayText : List PdfObject → String
  | [] => ""
  | (.str s) :: rest => s ++ tjArrayText rest
  | _ :: rest => tjArrayText rest


/-- Helper: concatenate text from a list of content ops. -/
def opsText : List ContentOp → String
  | [] => ""
  | (ContentOp.Tj s) :: rest => s ++ opsText rest
  | (ContentOp.TJ items) :: rest => tjArrayText items ++ opsText rest
  | _ :: rest => opsText rest

end Pypdf
-- === END: FIXED_FINAL ===
