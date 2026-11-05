-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Geopandas.Types
import Geopandas.Helpers

namespace Geopandas

/-! ## Core Function 1: area -/

def area (g : Geometry) : Float := 
                                   
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                   sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def area_postcond (g : Geometry) (result : Float) : Prop :=
  -- Zero-dimensional and one-dimensional geometries have zero area
  (g = Geometry.empty → result = 0.0) ∧
  (∀ c, g = Geometry.point c → result = 0.0) ∧
  (∀ cs, g = Geometry.lineString cs → result = 0.0) ∧
  (∀ cs, g = Geometry.multiPoint cs → result = 0.0) ∧
  (∀ ls, g = Geometry.multiLineString ls → result = 0.0) ∧
  -- Non-negative
  decide (result ≥ 0.0) = true ∧
  -- Degenerate polygon (< 3 vertices) has zero area
  (∀ ext holes, g = Geometry.polygon ext holes → ext.size < 3 → result = 0.0) ∧
  -- Concrete: unit square → 1.0
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨1.0, 0.0⟩, ⟨1.0, 1.0⟩, ⟨0.0, 1.0⟩] → holes = #[] →
    result = 1.0) ∧
  -- Concrete: right triangle (0,0)(1,0)(0,1) → 0.5
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨1.0, 0.0⟩, ⟨0.0, 1.0⟩] → holes = #[] →
    result = 0.5) ∧
  -- Concrete: 2×3 rectangle → 6.0
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨2.0, 0.0⟩, ⟨2.0, 3.0⟩, ⟨0.0, 3.0⟩] → holes = #[] →
    result = 6.0) ∧
  -- Concrete: 3-4-5 right triangle → 6.0
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨3.0, 0.0⟩, ⟨0.0, 4.0⟩] → holes = #[] →
    result = 6.0) ∧
  -- Concrete: reversed winding gives same area
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨0.0, 1.0⟩, ⟨1.0, 1.0⟩, ⟨1.0, 0.0⟩] → holes = #[] →
    result = 1.0) ∧
  -- Concrete: 2×2 square with 1×1 hole → 3.0
  (∀ ext holes, g = Geometry.polygon ext holes →
    ext = #[⟨0.0, 0.0⟩, ⟨2.0, 0.0⟩, ⟨2.0, 2.0⟩, ⟨0.0, 2.0⟩] →
    holes = #[#[⟨0.5, 0.5⟩, ⟨1.5, 0.5⟩, ⟨1.5, 1.5⟩, ⟨0.5, 1.5⟩]] →
    result = 3.0) ∧
  -- Concrete: multiPolygon of two unit squares → 2.0
  (∀ polys, g = Geometry.multiPolygon polys →
    polys = #[(#[⟨0.0,0.0⟩, ⟨1.0,0.0⟩, ⟨1.0,1.0⟩, ⟨0.0,1.0⟩], #[]),
              (#[⟨2.0,0.0⟩, ⟨3.0,0.0⟩, ⟨3.0,1.0⟩, ⟨2.0,1.0⟩], #[])] →
    result = 2.0)

theorem area_spec (g : Geometry) : area_postcond g (area g) := by 
                                                                  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Geopandas
-- === END: FIXED_FINAL ===
