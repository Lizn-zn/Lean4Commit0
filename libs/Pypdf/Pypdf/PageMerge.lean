-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pypdf.Types
import Pypdf.Helpers
import Pypdf.ExtractTextFromOps

namespace Pypdf


/-! ## Core Function 2: Page Merge -/

def Page.merge (base : Page) (overlay_ : Page) (mode : MergeMode := .overlay) : Page :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Page.merge_postcond (base : Page) (overlay_ : Page) (mode : MergeMode) (result : Page) : Prop :=
  (mode = .overlay → result.contents = base.contents ++ overlay_.contents) ∧
  (mode = .underlay → result.contents = overlay_.contents ++ base.contents) ∧
  result.mediaBox = base.mediaBox ∧
  result.rotation = base.rotation ∧
  result.annotations = base.annotations ++ overlay_.annotations


theorem Page.merge_spec (base : Page) (overlay_ : Page) (mode : MergeMode := .overlay) :
    Page.merge_postcond base overlay_ mode (base.merge overlay_ mode) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pypdf
-- === END: FIXED_FINAL ===
