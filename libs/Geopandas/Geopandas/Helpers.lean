-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Geopandas.Types

namespace Geopandas

/-! ## Structural helpers -/

/-- Collect all coordinates from a geometry -/
def allCoords (g : Geometry) : Array Coord :=
  match g with
  | .empty => #[]
  | .point c => #[c]
  | .lineString cs => cs
  | .polygon ext holes => ext ++ holes.foldl (init := #[]) (· ++ ·)
  | .multiPoint cs => cs
  | .multiLineString ls => ls.foldl (init := #[]) (· ++ ·)
  | .multiPolygon polys => polys.foldl (init := #[]) fun acc ⟨ext, holes⟩ =>
      acc ++ ext ++ holes.foldl (init := #[]) (· ++ ·)


end Geopandas
-- === END: FIXED_FINAL ===
