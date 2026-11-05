-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace Hashbrown

/-! ## Hash Trait -/

/-- A hash function type class. -/
class Hashable (α : Type) where
  hash : α → UInt64

instance : Hashable Nat where
  hash n := 
            
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
            sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



instance : Hashable String where
  hash s := 
            
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
            sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



instance : Hashable Int where
  hash n := 
            
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
            sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-! ## HashMap -/

/-- A hash map from keys to values.
    Internally modeled as a list of (key, value) pairs (the spec abstraction). -/
structure HashMap (α β : Type) [BEq α] [Hashable α] where
  mk ::
  buckets : List (List (α × β))
  size'   : Nat
  capacity' : Nat
  deriving Repr

/-- Create an empty hash map. -/
def HashMap.empty [BEq α] [Hashable α] : HashMap α β :=
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/-- Check if the map is empty. -/
def HashMap.isEmpty [BEq α] [Hashable α] (m : HashMap α β) : Bool :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



/-- Check if a key exists. -/
def HashMap.contains [BEq α] [Hashable α] (m : HashMap α β) (k : α) : Bool :=
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_7 (provided) ===



/-- Return all key-value pairs. -/
def HashMap.entries [BEq α] [Hashable α] (m : HashMap α β) : List (α × β) :=
  
  
-- === END: FIXED_7 ===
-- === BEGIN: OBLIGATION_7 (editable) ===
  sorry
-- === END: OBLIGATION_7 ===
-- === BEGIN: FIXED_8 (provided) ===



/-! ## Core Function 1: HashMap.insert -/

/-- Insert a key-value pair. Overwrites if key exists. -/
def HashMap.insert [BEq α] [Hashable α] (m : HashMap α β) (k : α) (v : β) : HashMap α β :=
  
  
-- === END: FIXED_8 ===
-- === BEGIN: OBLIGATION_8 (editable) ===
  sorry
-- === END: OBLIGATION_8 ===
-- === BEGIN: FIXED_9 (provided) ===



/-- Look up a key. -/
def HashMap.get [BEq α] [Hashable α] (m : HashMap α β) (k : α) : Option β :=
  
  
-- === END: FIXED_9 ===
-- === BEGIN: OBLIGATION_9 (editable) ===
  sorry
-- === END: OBLIGATION_9 ===
-- === BEGIN: FIXED_10 (provided) ===



@[reducible]
def HashMap.insert_postcond [BEq α] [Hashable α] (m : HashMap α β) (k : α) (v : β) (result : HashMap α β) : Prop :=
  result.size' ≥ m.size' ∧
  result.size' ≤ m.size' + 1 ∧
  (m.size' = 0 → result.size' = 1) ∧
  result.contains k = true ∧
  result.get k = some v ∧
  (∀ k' : α, (k' == k) = false → result.get k' = m.get k')

theorem HashMap.insert_spec [BEq α] [LawfulBEq α] [Hashable α] (m : HashMap α β) (k : α) (v : β) :
    HashMap.insert_postcond m k v (m.insert k v) := by
  
  
-- === END: FIXED_10 ===
-- === BEGIN: OBLIGATION_10 (editable) ===
  sorry
-- === END: OBLIGATION_10 ===
-- === BEGIN: FIXED_11 (provided) ===



/-! ## Core Function 2: HashMap.get -/

@[reducible]
def HashMap.get_postcond [BEq α] [Hashable α] (m : HashMap α β) (k : α) (result : Option β) : Prop :=
  (m.isEmpty = true → result = none) ∧
  (result.isSome = true → m.size' ≥ 1) ∧
  (result.isSome = true → m.contains k = true) ∧
  (m.contains k = false → result = none) ∧
  (m.contains k = true → result.isSome = true) ∧
  (∀ v, result = some v → (k, v) ∈ m.entries)

theorem HashMap.get_spec [BEq α] [LawfulBEq α] [Hashable α] (m : HashMap α β) (k : α) :
    HashMap.get_postcond m k (m.get k) := by
  
  
-- === END: FIXED_11 ===
-- === BEGIN: OBLIGATION_11 (editable) ===
  sorry
-- === END: OBLIGATION_11 ===
-- === BEGIN: FIXED_12 (provided) ===



/-! ## HashSet -/

/-- A hash set. -/
structure HashSet (α : Type) [BEq α] [Hashable α] where
  private mk ::
  inner : HashMap α Unit
  deriving Repr

def HashSet.contains [BEq α] [Hashable α] (s : HashSet α) (v : α) : Bool :=
  
  
-- === END: FIXED_12 ===
-- === BEGIN: OBLIGATION_12 (editable) ===
  sorry
-- === END: OBLIGATION_12 ===
-- === BEGIN: FIXED_13 (provided) ===



def HashSet.toList [BEq α] [Hashable α] (s : HashSet α) : List α :=
  
  
-- === END: FIXED_13 ===
-- === BEGIN: OBLIGATION_13 (editable) ===
  sorry
-- === END: OBLIGATION_13 ===
-- === BEGIN: FIXED_14 (provided) ===



/-! ## Core Function 3: HashSet.difference -/

/-- Set difference (a \ b). -/
def HashSet.difference [BEq α] [Hashable α] (a b : HashSet α) : HashSet α :=
  
  
-- === END: FIXED_14 ===
-- === BEGIN: OBLIGATION_14 (editable) ===
  sorry
-- === END: OBLIGATION_14 ===
-- === BEGIN: FIXED_15 (provided) ===



@[reducible]
def HashSet.difference_postcond [BEq α] [Hashable α] (a b : HashSet α) (result : HashSet α) : Prop :=
  result.inner.size' ≤ a.inner.size' ∧
  result.inner.size' + b.inner.size' ≥ a.inner.size' ∧
  (∀ v ∈ result.toList, a.contains v = true ∧ b.contains v = false) ∧
  (∀ v ∈ a.toList, b.contains v = false → result.contains v = true)

theorem HashSet.difference_spec [BEq α] [LawfulBEq α] [Hashable α] (a b : HashSet α) :
    HashSet.difference_postcond a b (a.difference b) := by
  
  
-- === END: FIXED_15 ===
-- === BEGIN: OBLIGATION_15 (editable) ===
  sorry
-- === END: OBLIGATION_15 ===
-- === BEGIN: FIXED_16 (provided) ===



/-! ## Relational: HashSet difference contains -/

@[reducible]
def HashSet.difference_contains_rel [BEq α] [Hashable α] [LawfulBEq α]
    (a b : HashSet α) (v : α) (diff_result a_result b_result : Bool) : Prop :=
  diff_result = (a_result && !b_result)

theorem HashSet.difference_contains_spec [BEq α] [Hashable α] [LawfulBEq α]
    (a b : HashSet α) (v : α) :
    HashSet.difference_contains_rel a b v ((a.difference b).contains v) (a.contains v) (b.contains v) := by
  
  
-- === END: FIXED_16 ===
-- === BEGIN: OBLIGATION_16 (editable) ===
  sorry
-- === END: OBLIGATION_16 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Hashbrown
-- === END: FIXED_FINAL ===
