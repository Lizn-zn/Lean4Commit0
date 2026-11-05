# Seaborn

## Background

Seaborn is a Python statistical data visualization library built on matplotlib. This spec models the statistical computations underlying seaborn's core plot types — histogram binning (histplot), kernel density estimation (kdeplot), and linear regression (regplot/lmplot) — as pure functions over arrays of floats, without any rendering or plotting.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Seaborn/` and complete the proof obligations assigned to editable regions. Shared helpers are grouped in `Seaborn/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `histBinsEqualWidth`

- **Signature**: `def histBinsEqualWidth (xs : Array Float) (nBins : Nat) : Array Bin`
- **Description**: Divides the data range into `nBins` equal-width bins and counts how many data points fall into each bin.
- **Postcondition**: (1) Result has exactly `nBins` bins (when nBins > 0, data non-empty). (2) Total count across all bins = input size. (3) Adjacent bins share boundaries (`bin[i].hi = bin[i+1].lo`). (4) Each bin has `lo ≤ hi`. (5) All bins have equal width.
- **Key constraints**: Every data point must be counted exactly once (total counts = input size). Bins must be contiguous (no gaps) and equal-width. Compute data range as `[min, max]`, then divide evenly.

### 2. `linearRegressionFit`

- **Signature**: `def linearRegressionFit (xs ys : Array Float) : Option LinearRegressionResult`
- **Description**: Fits a simple linear regression model `y = slope * x + intercept` using ordinary least squares (OLS).
- **Postcondition**: (1) Returns `none` when `xs.size ≠ ys.size` or `xs.size < 2`. (2) R² ∈ [0, 1]. (3) `intercept = mean(ys) - slope * mean(xs)`. (4) R² = 1.0 ↔ all points lie exactly on the line. (5) `slope = Sxy / Sxx` where `Sxx = Σx² - (Σx)²/n` and `Sxy = Σxy - (Σx)(Σy)/n`.
- **Key constraints**: The slope formula uses the standard OLS formula. `dotProduct` and `sumOfSquares` helpers are already implemented. R² must be exactly 1.0 when all residuals are zero.

### 3. `kde`

- **Signature**: `def kde (xs : Array Float) (evalPoints : Array Float) (bandwidth : Float) : Array Float`
- **Description**: Computes Gaussian kernel density estimation at specified evaluation points, given data points and a bandwidth parameter.
- **Postcondition**: (1) Output size = evalPoints size. (2) All values ≥ 0 (when bw > 0). (3) At least one positive value exists (when data and eval points are non-empty). (4) Upper bound: each value ≤ `1/(bw * sqrt(2π)) + 1e-10`. (5) At data points, density ≥ `1/(sqrt(2π) * n * bw) - 1e-10`. (6) Exact formula: `result[i] ≈ (1/(n*bw)) * Σ_j K((eval[i] - x[j]) / bw)` where `K(u) = (1/sqrt(2π)) * exp(-u²/2)`, with |error| ≤ 1e-10.
- **Key constraints**: The Gaussian kernel formula is `(1/√(2π)) * exp(-0.5 * u²)`. Use `π ≈ 3.14159265358979`. The density at each eval point is the average of kernels centered at each data point, scaled by bandwidth.

## Relational Properties

None.

## Types

- **`Bin`**: A histogram bin with `lo : Float` (lower bound), `hi : Float` (upper bound), and `count : Nat`.
- **`LinearRegressionResult`**: OLS result with `slope`, `intercept`, and `rSquared` (coefficient of determination).

## Hints

- `dotProduct` and `sumOfSquares` are already implemented (not `sorry`) and can be used directly in the linear regression implementation.
- `mean` is a supporting function that needs implementation: `mean xs = xs.foldl (· + ·) 0.0 / Float.ofNat xs.size`.
- For `histBinsEqualWidth`: find min/max of data, compute `binWidth = (max - min) / nBins`, create bins `[min + i*w, min + (i+1)*w)`, count points in each. Handle the edge case where the last bin includes the maximum value.
- For `linearRegressionFit`: compute `slope = Sxy/Sxx`, `intercept = mean(y) - slope*mean(x)`, then `R² = 1 - SSres/SStot` where `SSres = Σ(y - ŷ)²` and `SStot = Σ(y - mean(y))²`. Return `none` if Sxx = 0 (all x values identical).
- For `kde`: for each eval point, compute `result[i] = (1/(n*bw)) * Σ_j (1/√(2π)) * exp(-0.5*((eval[i]-x[j])/bw)²)`. Use `Float.exp` and `Float.sqrt`.
- The 1e-10 tolerance in KDE postconds accounts for floating-point imprecision — implement the exact formula and the tolerance should be satisfied naturally.

## Edit Boundaries

The editable module files under `Seaborn/` are divided into labeled sections:

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

- `Seaborn/Helpers.lean`
- `Seaborn/HistBinsEqualWidth.lean`
- `Seaborn/Kde.lean`
- `Seaborn/LinearRegressionFit.lean`
- `Seaborn/Types.lean`
