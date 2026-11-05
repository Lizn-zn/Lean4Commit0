-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Parsel.Types

namespace Parsel

/-! ## Core Function 1: CSS Selector Parsing -/

def parseCssSelector (selector : String) : Except String SelectorList :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseCssSelector_postcond (selector : String) (result : Except String SelectorList) : Prop :=
  ((selector = "*" ∨ selector = ":first-child" ∨ selector = "[href]" ∨
     (selector ≠ "" ∧ selector.all Char.isAlpha = true) ∨
     (∃ s, s ≠ "" ∧ s.all (fun c => c.isAlpha || c == '-' || c == '_') = true ∧
       (selector = "." ++ s ∨ selector = "#" ++ s))) → result.isOk = true) ∧
  (∀ sels, result = .ok sels → sels ≠ []) ∧
  (selector = "" → result.isOk = false) ∧
  (∀ sels, result = .ok sels →
    ∀ cs ∈ sels, cs.head ≠ []) ∧
  (selector = "*" → ∀ sels, result = .ok sels →
    sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.universal] ∧ cs.tail = []) ∧
  (∀ tag, selector = tag → tag.all Char.isAlpha → tag ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.tag tag] ∧ cs.tail = []) ∧
  (∀ cls, selector = "." ++ cls → cls.all (fun c => c.isAlpha ∨ c = '-' ∨ c = '_') → cls ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.className cls] ∧ cs.tail = []) ∧
  (∀ i, selector = "#" ++ i → i.all (fun c => c.isAlpha ∨ c = '-' ∨ c = '_') → i ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.idSelector i] ∧ cs.tail = []) ∧
  (∀ tag cls, selector = tag ++ "." ++ cls →
    tag.all Char.isAlpha → tag ≠ "" →
    cls.all (fun c => c.isAlpha ∨ c = '-' ∨ c = '_') → cls ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.tag tag, .className cls] ∧ cs.tail = []) ∧
  (∀ tag1 tag2, selector = tag1 ++ " > " ++ tag2 →
    tag1.all Char.isAlpha → tag1 ≠ "" → tag2.all Char.isAlpha → tag2 ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels,
        cs.head = [.tag tag1] ∧ cs.tail = [(.child, [.tag tag2])]) ∧
  (∀ tag1 tag2, selector = tag1 ++ ", " ++ tag2 →
    tag1.all Char.isAlpha → tag1 ≠ "" → tag2.all Char.isAlpha → tag2 ≠ "" →
    ∀ sels, result = .ok sels → sels.length = 2 ∧
      (∃ cs ∈ sels, cs.head = [.tag tag1] ∧ cs.tail = []) ∧
      (∃ cs ∈ sels, cs.head = [.tag tag2] ∧ cs.tail = [])) ∧
  (selector = ":first-child" → ∀ sels, result = .ok sels →
    sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.pseudo .firstChild] ∧ cs.tail = []) ∧
  (selector = "[href]" → ∀ sels, result = .ok sels →
    sels.length = 1 ∧ ∃ cs ∈ sels, cs.head = [.attribute "href" .exists_ none] ∧ cs.tail = []) ∧
  (∀ tag1 tag2, selector = tag1 ++ " " ++ tag2 →
    tag1.all Char.isAlpha → tag1 ≠ "" → tag2.all Char.isAlpha → tag2 ≠ "" →
    ∀ sels, result = .ok sels →
      sels.length = 1 ∧ ∃ cs ∈ sels,
        cs.head = [.tag tag1] ∧ cs.tail = [(.descendant, [.tag tag2])])

theorem parseCssSelector_spec (selector : String) :
    parseCssSelector_postcond selector (parseCssSelector selector) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Parsel
-- === END: FIXED_FINAL ===
