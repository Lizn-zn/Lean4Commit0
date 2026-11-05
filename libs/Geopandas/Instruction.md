# Geopandas

## Background

Geopandas is a Python library for working with geospatial data. It extends Pandas DataFrames with geometry columns, supporting geometry types (points, lines, polygons), spatial measurements (area, length, bounding boxes), spatial predicates (contains, intersects, within), geometric set operations (union, intersection, difference), coordinate reference systems, and serialization formats (GeoJSON, WKT). This core spec focuses on the three most essential capabilities: computing area, computing bounding boxes, and the algebraic laws governing spatial predicates.

## Task

Complete implementation holes in explicitly editable regions in `Geopandas/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `area`

- **Signature**: `def area (g : Geometry) : Float`
- **Description**: Computes the area of a geometry. Only polygons and multi-polygons have non-zero area.
- **Postcondition**:
  - `Geometry.empty` → returns 0.0
  - `Geometry.point _` → returns 0.0
  - `Geometry.lineString _` → returns 0.0
  - `Geometry.multiPoint _` → returns 0.0
  - `Geometry.multiLineString _` → returns 0.0
  - Result is always ≥ 0.0
- **Key constraints**: The result must be non-negative (`decide (result ≥ 0.0) = true`). For polygons, use the shoelace formula on the exterior ring (subtract hole areas).

### 2. `bounds`

- **Signature**: `def bounds (g : Geometry) : Option BBox`
- **Description**: Computes the axis-aligned bounding box of a geometry.
- **Postcondition**:
  - `Geometry.empty` → returns `none`
  - `Geometry.point c` → returns `some ⟨c.x, c.y, c.x, c.y⟩` (degenerate bbox)
  - If result is `some bbox`, then `bbox.minX ≤ bbox.maxX` and `bbox.minY ≤ bbox.maxY`
- **Key constraints**: The validity invariant must hold for all geometry types. For a point, the min and max coordinates are identical.

### 3. `spatialPredicates` (combined spec)

This is a combined specification that establishes 9 algebraic laws governing the spatial predicate functions. All 7 predicate functions (`contains`, `within`, `intersects`, `disjoint`, `overlaps`, `touches`, `crosses`) must be implemented consistently to satisfy these laws.

- **Laws**:
  1. `contains a b = within b a` — containment/within duality
  2. `disjoint a b = !intersects a b` — disjoint is the complement of intersects
  3. `intersects a b = intersects b a` — intersects is symmetric
  4. `disjoint a b = disjoint b a` — disjoint is symmetric
  5. `overlaps a b = overlaps b a` — overlaps is symmetric
  6. `touches a b = touches b a` — touches is symmetric
  7. `a ≠ empty → contains a a = true` — non-empty geometry contains itself
  8. `a ≠ empty → intersects a a = true` — non-empty geometry intersects itself
  9. `disjoint empty a = true` — empty is disjoint from everything

## Relational Properties

- **`contains_within_duality`**: `contains a b = within b a` — containment and within are dual predicates.
- **`disjoint_intersects_complement`**: `disjoint a b = !intersects a b` — disjoint is the logical negation of intersects.

## Types

- **`Coord`**: A 2D coordinate with `x : Float` and `y : Float`.
- **`BBox`**: An axis-aligned bounding box with `minX`, `minY`, `maxX`, `maxY` (all `Float`).
- **`Geometry`**: An inductive type representing geometric shapes:
  - `point` — a single coordinate
  - `lineString` — an array of coordinates forming a polyline
  - `polygon` — an exterior ring (array of coords) plus an array of hole rings
  - `multiPoint` — an array of point coordinates
  - `multiLineString` — an array of polylines
  - `multiPolygon` — an array of (exterior ring, holes) pairs
  - `empty` — a null/empty geometry

## Hints

- For `area`, pattern match on the geometry type. Return 0.0 for everything except `polygon` and `multiPolygon`. For a polygon, use the shoelace formula: `|Σ (x_i * y_{i+1} - x_{i+1} * y_i)| / 2`, then subtract hole areas. Use `Float.abs` to ensure non-negativity.
- For `bounds`, iterate over all coordinates in the geometry and track the min/max x and y values. For `empty`, return `none`. For `point c`, return `some ⟨c.x, c.y, c.x, c.y⟩` directly.
- For the spatial predicates, the key insight is that `contains`, `within`, `intersects`, and `disjoint` must be defined in terms of each other to satisfy the algebraic laws. A simple approach:
  - Define `intersects` as the primary predicate (e.g., based on bounding box overlap + point-in-polygon tests)
  - Define `disjoint a b := !intersects a b`
  - Define `contains a b` in terms of all points of `b` being inside `a`
  - Define `within a b := contains b a`
  - Ensure `contains a a = true` for non-empty geometries and `intersects a a = true` for non-empty geometries
  - `overlaps` and `touches` must be symmetric — implement them symmetrically
  - `disjoint empty a` must return `true`, so `intersects empty a` must return `false`
- The `decide (result ≥ 0.0) = true` pattern is how Float comparisons are checked in Lean 4 proofs. Ensure your implementations produce non-negative results.

## Edit Boundaries

`Geopandas/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Geopandas/Area.lean`
- `Geopandas/Bounds.lean`
- `Geopandas/Helpers.lean`
- `Geopandas/Relations.lean`
- `Geopandas/SpatialPredicates.lean`
- `Geopandas/Types.lean`
