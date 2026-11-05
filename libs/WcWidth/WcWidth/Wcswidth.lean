-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import WcWidth.Wcwidth

namespace WcWidth

def wcswidth (s : String) : Int :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===


/- Pure predicate: is this a CJK wide character (width = 2)? -/

@[reducible]
def isCjkWide (c : Char) : Bool :=
  (c.val ≥ 0x1100 ∧ c.val ≤ 0x115F) ∨
  (c.val ≥ 0x2E80 ∧ c.val ≤ 0x2E99) ∨
  (c.val ≥ 0x2E9B ∧ c.val ≤ 0x2EF3) ∨
  (c.val ≥ 0x2F00 ∧ c.val ≤ 0x2FD5) ∨
  (c.val ≥ 0x3000 ∧ c.val ≤ 0x303F) ∨
  (c.val ≥ 0x3041 ∧ c.val ≤ 0x3096) ∨
  (c.val ≥ 0x309B ∧ c.val ≤ 0x30FF) ∨
  (c.val ≥ 0x3400 ∧ c.val ≤ 0x4DBF) ∨
  (c.val ≥ 0x4E00 ∧ c.val ≤ 0x9FFF) ∨
  (c.val ≥ 0xAC00 ∧ c.val ≤ 0xD7A3) ∨
  (c.val ≥ 0xF900 ∧ c.val ≤ 0xFAFF) ∨
  (c.val ≥ 0xFF01 ∧ c.val ≤ 0xFF60)

/- Pure predicate: is this a zero-width character. -/

@[reducible]
def isZeroWidth (c : Char) : Bool :=
  c.val = 0 ∨
  (c.val ≥ 0x0300 ∧ c.val ≤ 0x036F) ∨
  c.val = 0x00AD ∨
  c.val = 0x200B

/- Pure predicate: is this a known narrow character (width = 1). -/

@[reducible]
def isKnownNarrow (c : Char) : Bool :=
  (c.val ≥ 0x20 ∧ c.val ≤ 0x7E) ∨
  (c.val ≥ 0xA0 ∧ c.val ≤ 0xFF ∧ c.val ≠ 0xAD) ∨
  (c.val ≥ 0x0100 ∧ c.val ≤ 0x02FF) ∨
  (c.val ≥ 0x0370 ∧ c.val ≤ 0x0482) ∨
  (c.val ≥ 0x048A ∧ c.val ≤ 0x04FF)


@[reducible]
def wcswidth_postcond (s : String) (result : Int) : Prop :=
  (s = "" → result = 0) ∧
  (result = -1 ∨ result ≥ 0) ∧
  (result ≥ 0 → result ≤ s.length * 2) ∧
  (s.toList.any isControlChar → result = -1) ∧
  (¬s.toList.any isControlChar → s ≠ "" → result ≥ 0) ∧
  (s.toList.all isAsciiPrintable → result = s.length) ∧
  (s.length = 1 ∧ s.toList.all isAsciiPrintable → result = 1) ∧
  (s.toList.all isCjkWide → result = s.length * 2) ∧
  (result ≥ 0 →
    result ≥ (s.toList.filter (fun c => !isZeroWidth c ∧ !isControlChar c)).length) ∧
  (result ≥ 0 →
    result ≥ (s.toList.filter isCjkWide).length * 2) ∧
  (s.toList.all isKnownNarrow → result = s.length) ∧
  (s.toList.all (fun c => isKnownNarrow c ∨ isCjkWide c) →
    result = (s.toList.filter isKnownNarrow).length + (s.toList.filter isCjkWide).length * 2)


theorem wcswidth_spec (s : String) :
    wcswidth_postcond s (wcswidth s) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/- Relational: wcwidth and classify consistency. -/

@[reducible]
def wcwidth_classify_rel (c : Char) (wc_result : Int) (cl_result : CharWidth) : Prop :=
  wc_result = cl_result.toInt


theorem wcwidth_classify_spec (c : Char) :
    wcwidth_classify_rel c (wcwidth c) (classify c) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/- Relational: wcswidth of singleton equals wcwidth. -/

@[reducible]
def wcswidth_singleton_rel (c : Char) (wcs_result wc_result : Int) : Prop :=
  wc_result ≥ 0 → wcs_result = wc_result


theorem wcswidth_singleton_spec (c : Char) :
    wcswidth_singleton_rel c (wcswidth (String.singleton c)) (wcwidth c) := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/- Relational: wcswidth is additive. -/

@[reducible]
def wcswidth_append_rel (s1 s2 : String) (r1 r2 r_cat : Int) : Prop :=
  r1 ≥ 0 → r2 ≥ 0 → r_cat = r1 + r2


theorem wcswidth_append_spec (s1 s2 : String) :
    wcswidth_append_rel s1 s2 (wcswidth s1) (wcswidth s2) (wcswidth (s1 ++ s2)) := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end WcWidth
-- === END: FIXED_FINAL ===
