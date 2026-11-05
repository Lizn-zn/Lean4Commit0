-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Utf8Proc.Types

namespace Utf8Proc

def normalize (s : String) (form : NormForm) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def normalize_postcond (s : String) (form : NormForm) (result : String) : Prop :=
  (s = "" → result = "") ∧
  (s.data.all (fun c => c.val ≤ 0x7F) → result = s) ∧
  (s ≠ "" → result ≠ "") ∧
  (form = .NFC ∧ s.data = [⟨0x65, by decide⟩, ⟨0x301, by decide⟩] →
    result.data = [⟨0xE9, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xE9, by decide⟩] →
    result.data = [⟨0x65, by decide⟩, ⟨0x301, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xC0, by decide⟩] →
    result.data = [⟨0x41, by decide⟩, ⟨0x300, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0xC0, by decide⟩] →
    result.data = [⟨0xC0, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xF3, by decide⟩] →
    result.data = [⟨0x6F, by decide⟩, ⟨0x301, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0x6F, by decide⟩, ⟨0x301, by decide⟩] →
    result.data = [⟨0xF3, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xFC, by decide⟩] →
    result.data = [⟨0x75, by decide⟩, ⟨0x308, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0xF1, by decide⟩] →
    result.data = [⟨0xF1, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xF1, by decide⟩] →
    result.data = [⟨0x6E, by decide⟩, ⟨0x0303, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xC5, by decide⟩] →
    result.data = [⟨0x41, by decide⟩, ⟨0x030A, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0x41, by decide⟩, ⟨0x030A, by decide⟩] →
    result.data = [⟨0xC5, by decide⟩]) ∧
  (form = .NFKD ∧ s.data = [⟨0xFB01, by decide⟩] →
    result.data = [⟨0x66, by decide⟩, ⟨0x69, by decide⟩]) ∧
  (form = .NFKC ∧ s.data = [⟨0xFB01, by decide⟩] →
    result.data = [⟨0x66, by decide⟩, ⟨0x69, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xFB01, by decide⟩] →
    result.data = [⟨0xFB01, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0xFB01, by decide⟩] →
    result.data = [⟨0xFB01, by decide⟩]) ∧
  (form = .NFKD ∧ s.data = [⟨0xB2, by decide⟩] →
    result.data = [⟨0x32, by decide⟩]) ∧
  (form = .NFKC ∧ s.data = [⟨0xB2, by decide⟩] →
    result.data = [⟨0x32, by decide⟩]) ∧
  (form = .NFD ∧ s.data = [⟨0xB2, by decide⟩] →
    result.data = [⟨0xB2, by decide⟩]) ∧
  (form = .NFC ∧ s.data = [⟨0xB2, by decide⟩] →
    result.data = [⟨0xB2, by decide⟩])


theorem normalize_spec (s : String) (form : NormForm) :
    normalize_postcond s form (normalize s form) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## codePointToUtf8 -/


end Utf8Proc
-- === END: FIXED_FINAL ===
