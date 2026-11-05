# Xarray

## Background

Xarray is a Python library for working with labeled multi-dimensional arrays, widely used in climate science, geoscience, and other scientific computing domains. Its key innovation is named dimensions and coordinate labels, enabling operations like "select along the 'time' dimension where time='2020'" instead of raw integer indexing. This spec models DataArray with named dimensions, coordinate labels, dimension-based indexing, element-wise transforms, and global reductions as pure functions.

## Task

Complete implementation holes in explicitly editable regions in `Xarray/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `DataArray.isel`

- **Signature**: `def DataArray.isel (da : DataArray) (dimName : String) (pos : Nat) : Option DataArray`
- **Description**: Selects a slice along a named dimension by integer position, reducing the dimensionality by 1 (like `da.isel(time=0)` in Python xarray).
- **Postcondition**: (1) On success: `ndim` decreases by 1, `dims.size` decreases by 1, `data.size ≤` original. (2) If `dimName` not found (dimIndex returns none) → result is none.
- **Key constraints**: Must locate the dimension by name using `dimIndex`, then extract the slice at the given position. The resulting DataArray has one fewer dimension.

### 2. `DataArray.map`

- **Signature**: `def DataArray.map (da : DataArray) (f : Float → Float) : DataArray`
- **Description**: Applies a function element-wise to all data values, preserving shape and dimensions.
- **Postcondition**: (1) `result.shape = da.shape`. (2) `result.dims = da.dims`. (3) `result.data.size = da.data.size`. (4) For all `i < da.data.size`: `result.data[i]? = some (f da.data[i]!)`.
- **Key constraints**: The per-element formula must hold exactly. Shape, dims, and data size are all preserved. This is a total function (always succeeds).

### 3. `DataArray.sumAll`

- **Signature**: `def DataArray.sumAll (da : DataArray) : Float`
- **Description**: Computes the sum of all elements in the DataArray.
- **Postcondition**: (1) Empty data → 0.0. (2) Single element → that element. (3) Exact formula: `result = da.data.foldl (· + ·) 0.0`.
- **Key constraints**: Must use left fold with addition starting from 0.0. The postcondition specifies the exact computation, not just properties of the result.

## Relational Properties

- **`sel_isel_rel`**: When a dimension has label `L` at position `p`, `sel da dimName L = isel da dimName p` — label-based selection is equivalent to position-based selection.
- **`sumAll_meanAll_rel`**: When data is non-empty, `sumAll da = meanAll da * size` — the standard sum/mean relationship.
- **`map_id_postcond`**: `map da id` preserves data, shape, and dims — mapping with identity is a no-op.

## Types

- **`Label`**: A coordinate label, which can be a float (`num`), string (`str`), or integer (`int`).
- **`Dimension`**: A named dimension with `name : String` and `labels : Array Label` — e.g., a "time" dimension with labels [2020, 2021, 2022].
- **`DataArray`**: The core type with `name`, `dims` (named dimensions), `shape` (size of each dimension), `data` (flat array of floats), and `attrs` (metadata).

## Hints

- `DataArray.ndim` should return `da.dims.size`. `DataArray.size` should return `da.data.size`. `DataArray.dimIndex` should find the index of a dimension by name (linear search through `da.dims`).
- For `DataArray.isel`: find the dimension index with `dimIndex`, then extract the slice. For a multi-dimensional array stored flat, slicing along dimension `d` at position `p` means selecting every element where the index in dimension `d` equals `p`. Compute strides from the shape to determine which flat indices to keep.
- For `DataArray.map`: simply apply `f` to each element of `da.data` while preserving all other fields. Use `da.data.map f` or equivalent.
- For `DataArray.sumAll`: use `da.data.foldl (· + ·) 0.0`.
- For `DataArray.sel`: find the dimension, search for the label in its labels array to get the position, then delegate to `isel`. This makes the `sel_isel_rel` proof straightforward.
- For `DataArray.meanAll`: compute `sumAll da / Float.ofNat da.data.size` (with 0.0 for empty). The `sumAll_meanAll_rel` proof then follows from the definition.
- The `map_id_spec` proof requires showing that mapping `id` over an array preserves it element-wise.

## Edit Boundaries

`Xarray/*.lean` is divided into labeled sections:

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

- `Xarray/Helpers.lean`
- `Xarray/Isel.lean`
- `Xarray/Map.lean`
- `Xarray/MeanAll.lean`
- `Xarray/Sel.lean`
- `Xarray/SumAll.lean`
- `Xarray/Types.lean`
- `Xarray/Validity.lean`
