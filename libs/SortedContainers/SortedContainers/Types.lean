-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # SortedContainers
   Pure sorted collections: SortedList, SortedDict, SortedSet.

   Ported from Python's `sortedcontainers` library.
   Original: https://github.com/grantjenks/python-sortedcontainers

   This is a summarized version containing only the 3 most essential
   function specs: SortedList.add, SortedDict.set, SortedSet.add.
-/

namespace SortedContainers

structure SortedList (α : Type) [Ord α] where
  data : List α
  deriving Repr, BEq

structure SortedDict (α β : Type) [Ord α] where
  data : List (α × β)
  deriving Repr

structure SortedSet (α : Type) [Ord α] [BEq α] where
  data : List α
  deriving Repr

end SortedContainers
-- === END: FIXED_FINAL ===
