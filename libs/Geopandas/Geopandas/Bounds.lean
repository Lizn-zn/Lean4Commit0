-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Geopandas.Types
import Geopandas.Helpers
import Geopandas.Area

namespace Geopandas

/-! ## Core Function 2: bounds -/

def bounds (g : Geometry) : Option BBox := 
                                           
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                           sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def bounds_postcond (g : Geometry) (result : Option BBox) : Prop :=
  -- No coordinates → none
  ((allCoords g).size = 0 → result = none) ∧
  -- Has coordinates → some bbox
  ((allCoords g).size > 0 → result ≠ none) ∧
  -- All coordinates lie within bbox
  (∀ bbox, result = some bbox →
    (allCoords g).all (fun c =>
      decide (bbox.minX ≤ c.x) && decide (c.x ≤ bbox.maxX) &&
      decide (bbox.minY ≤ c.y) && decide (c.y ≤ bbox.maxY)) = true) ∧
  -- Bbox is tight: each bound is achieved by some coordinate
  (∀ bbox, result = some bbox →
    (allCoords g).any (fun c => c.x == bbox.minX) = true ∧
    (allCoords g).any (fun c => c.x == bbox.maxX) = true ∧
    (allCoords g).any (fun c => c.y == bbox.minY) = true ∧
    (allCoords g).any (fun c => c.y == bbox.maxY) = true) ∧
  -- Validity: min ≤ max
  (∀ bbox, result = some bbox →
    decide (bbox.minX ≤ bbox.maxX) = true ∧
    decide (bbox.minY ≤ bbox.maxY) = true)

theorem bounds_spec (g : Geometry) 
    (hfinite : (allCoords g).all (fun c => c.x.isFinite && c.y.isFinite) = true) : bounds_postcond g (bounds g) := by 
                                                                                                                      
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                                                                      sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Geopandas
-- === END: FIXED_FINAL ===
