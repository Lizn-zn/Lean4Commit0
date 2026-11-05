-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CacheTools.Types

namespace CacheTools

/-! ## Helpers -/

def LRUCache.empty (maxsize : Nat) : LRUCache α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def LRUCache.get [BEq α] (cache : LRUCache α β) (key : α)
    : LRUCache α β × Option β :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def LRUCache.size (cache : LRUCache α β) : Nat :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



def LRUCache.maxsize (cache : LRUCache α β) : Nat :=
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



def TTLCache.empty (maxsize : Nat) (ttl : Nat) : TTLCache α β :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



def TTLCache.get [BEq α] (cache : TTLCache α β) (key : α) (now : Nat)
    : TTLCache α β × Option β :=
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_7 (provided) ===



def TTLCache.size (cache : TTLCache α β) : Nat :=
  
  
-- === END: FIXED_7 ===
-- === BEGIN: OBLIGATION_7 (editable) ===
  sorry
-- === END: OBLIGATION_7 ===
-- === BEGIN: FIXED_8 (provided) ===



def TTLCache.maxsize (cache : TTLCache α β) : Nat :=
  
  
-- === END: FIXED_8 ===
-- === BEGIN: OBLIGATION_8 (editable) ===
  sorry
-- === END: OBLIGATION_8 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CacheTools
-- === END: FIXED_FINAL ===
