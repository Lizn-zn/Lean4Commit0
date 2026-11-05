# Statsmodels

## Background

Statsmodels is Python's comprehensive statistical modeling library, providing tools for regression analysis (OLS, logistic), hypothesis testing (t-tests, chi-square, ANOVA), time series analysis, and probability distribution functions. This spec models the three most fundamental capabilities — OLS regression fitting, one-sample t-testing, and normal CDF computation — as pure functions over arrays and matrices.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Statsmodels/` and complete the proof obligations assigned to editable regions.

The three core APIs each live in their own file:

- `Statsmodels/OlsFit.lean`
- `Statsmodels/TTestOneSample.lean`
- `Statsmodels/NormalCdf.lean`

Relational specs are grouped in `Statsmodels/Relations.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `olsFit`

- **Signature**: `def olsFit (x : Matrix) (y : Array Float) (addConstant : Bool := true) : Option OLSResult`
- **Description**: Fits an Ordinary Least Squares (OLS) linear regression model given a design matrix `x` and response vector `y`.
- **Postcondition**: When result is `some r`: (1) `coefficients.size = nParams`. (2) `residuals.size = fittedValues.size = nObs = y.size`. (3) `stdErrors`, `tStatistics`, `pValues` all have size = `coefficients.size`. (4) `rSquared ∈ [0, 1]`. (5) `fittedValues[i] + residuals[i] = y[i]` for all i. (6) `pValues[i] ∈ [0, 1]` for all i.
- **Key constraints**: The spec theorem tests with `addConstant = false`. The OLSResult structure contains coefficients, standard errors, t-statistics, p-values, R², adjusted R², F-statistic, residuals, fitted values, AIC, BIC, and log-likelihood.

### 2. `tTestOneSample`

- **Signature**: `def tTestOneSample (xs : Array Float) (mu0 : Float := 0.0) : TestResult`
- **Description**: Performs a one-sample t-test, testing whether the mean of `xs` differs significantly from `mu0`.
- **Postcondition**: When `xs.size ≥ 2`: (1) `degreesOfFreedom = n - 1`. (2) `pValue ∈ [0, 1]`. (3) When all `xs > mu0`, statistic is positive. (4) When all `xs < mu0`, statistic is negative.
- **Key constraints**: The t-statistic is `(mean - mu0) / (stddev / sqrt(n))`. The p-value is a two-tailed probability from the t-distribution. The directional sign constraints ensure the statistic reflects whether the sample mean is above or below `mu0`.

### 3. `normalCdf`

- **Signature**: `def normalCdf (x : Float) (mu : Float := 0.0) (sigma : Float := 1.0) : Float`
- **Description**: Computes the cumulative distribution function of the normal distribution at point `x` with given mean `mu` and standard deviation `sigma`.
- **Postcondition**: (1) Result is not NaN. (2) `normalCdf(mu) = 0.5`. (3) Result ∈ [0, 1]. (4) When `sigma > 0` and `x > mu`, result > 0.5. (5) When `sigma > 0` and `x < mu`, result < 0.5.
- **Key constraints**: Use a numerical approximation (e.g., the rational approximation or error function approach). The standard normal CDF can be computed via `Φ(z) = 0.5 * (1 + erf(z/√2))` where `z = (x - mu) / sigma`.

## Relational Properties

- **`normalCdf_monotone_rel`**: For `x1 < x2`, `normalCdf(x1) ≤ normalCdf(x2)` — the CDF is monotonically non-decreasing.
- **`normalCdf_symmetry_rel`**: `normalCdf(mu + x) + normalCdf(mu - x) = 1` — complement symmetry around the mean.

## Types

- **`Matrix`**: A row-major 2D matrix with `rows`, `cols`, and `data : Array (Array Float)`. Used as the design matrix for OLS regression.
- **`OLSResult`**: Complete regression output including `coefficients`, `stdErrors`, `tStatistics`, `pValues`, `rSquared`, `adjRSquared`, `fStatistic`, `residuals`, `fittedValues`, `nObs`, `nParams`, `aic`, `bic`, `logLikelihood`.
- **`TestResult`**: Hypothesis test output with `statistic`, `pValue`, and `degreesOfFreedom`.

## Hints

- For `olsFit`: The OLS formula is `β = (X^T X)^{-1} X^T y`. Fitted values = `Xβ`, residuals = `y - Xβ`. R² = 1 - SS_res/SS_tot. You'll need matrix multiplication, transpose, and inverse. Standard errors come from `diag(σ² (X^T X)^{-1})` where `σ² = SS_res / (n - k)`. T-statistics = coefficient / stdError.
- For `tTestOneSample`: Compute `t = (mean(xs) - mu0) / (stddev(xs) / sqrt(n))` with `df = n - 1`. For the p-value, you need the t-distribution CDF: `pValue = 2 * (1 - tCdf(|t|, df))`. A simple approximation of the t-CDF (e.g., using the normal approximation for large df) suffices.
- For `normalCdf`: A common approach is the Abramowitz & Stegun approximation or using `erf`. The symmetry property `Φ(mu+x) + Φ(mu-x) = 1` follows from the symmetry of the normal distribution. Ensure your approximation satisfies this exactly by implementing it as `normalCdf(x) = 1 - normalCdf(2*mu - x)` for the below-mean case, or by using a symmetric erf implementation.
- The `Float.beq` comparisons in postconditions require exact floating-point equality. Design your implementations so that the algebraic identities hold exactly at the bit level where required (e.g., `normalCdf(mu, mu, sigma) = 0.5` exactly).

## Edit Boundaries

The split files under `Statsmodels/` are divided into labeled sections:

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

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `Statsmodels/NormalCdf.lean`
- `Statsmodels/OlsFit.lean`
- `Statsmodels/Relations.lean`
- `Statsmodels/TTestOneSample.lean`
- `Statsmodels/Types.lean`
