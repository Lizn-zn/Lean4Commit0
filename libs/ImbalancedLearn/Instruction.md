# ImbalancedLearn

## Background

imbalanced-learn is a Python library for handling class-imbalanced datasets in machine learning. It provides oversampling methods (random oversampling, SMOTE, ADASYN), undersampling methods (Tomek Links, Edited Nearest Neighbors), and combined strategies. This spec models the core data analysis, oversampling, and boundary cleaning operations as pure functions over a `Dataset` structure.

## Task

Complete implementation holes in explicitly editable regions in `ImbalancedLearn/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `classDistribution`

- **Signature**: `def classDistribution (labels : Array Nat) : Array (Nat × Nat)`
- **Description**: Compute the class distribution of a label array, returning an array of (class_label, count) pairs.
- **Postcondition**: `classDistribution_postcond` requires:
  - Empty labels produce empty result
  - All counts sum to `labels.size` (partition property)
  - Every class in the result actually appears in labels (soundness)
  - No duplicate class keys in the result
  - Every label in the input appears as a class in the result (completeness)
- **Key constraints**: The result is a complete, non-overlapping partition of the labels. The counts must be exact — they must sum to the total number of labels. No class can appear twice in the result array.

### 2. `randomOversampling`

- **Signature**: `def randomOversampling (ds : Dataset) (strategy : SamplingStrategy) (seed : Nat) : Dataset`
- **Description**: Oversample a dataset by duplicating existing samples from specified classes to reach target counts. The strategy is an array of (class_label, target_count) pairs.
- **Postcondition**: `randomOversampling_postcond` requires:
  - Result has at least as many samples as the original (`ds.nSamples ≤ result.nSamples`)
  - `result.features.size = result.labels.size` (consistency)
  - Original samples are preserved as a prefix (both features and labels)
  - Empty dataset with empty strategy stays empty
  - Result size is bounded: `≤ ds.features.size + sum of strategy targets`
- **Key constraints**: The original data must appear as an exact prefix — `result.features[i]? = ds.features[i]?` for all `i < ds.features.size`. New samples are appended after the originals. The `seed` parameter controls randomness but the postcond doesn't constrain which samples are duplicated.

### 3. `detectTomekLinks`

- **Signature**: `def detectTomekLinks (ds : Dataset) : Array TomekLink`
- **Description**: Detect Tomek Links in a dataset. A Tomek Link is a pair of samples from different classes that are each other's nearest neighbor — these are boundary/noisy samples.
- **Postcondition**: `detectTomekLinks_postcond` requires:
  - Every link connects samples from different classes (`class1 ≠ class2`)
  - All indices are valid (`idx1 < ds.features.size`, `idx2 < ds.features.size`)
  - Empty dataset produces empty result
  - Canonical ordering: `idx1 < idx2` (prevents duplicate pairs)
  - Classes match the actual labels at those indices
  - If all labels are the same class, no Tomek Links can exist (result is empty)
- **Key constraints**: Two samples form a Tomek Link only if they are mutual nearest neighbors AND belong to different classes. The canonical ordering `idx1 < idx2` ensures each pair appears at most once.

## Relational Properties

- **`classDistribution_complete_rel`**: The counts in the class distribution sum to exactly `labels.size`. This is a key partition property — no labels are lost or double-counted.
- **`randomOversampling_preserves_features_rel`**: When the input dataset has features, oversampling preserves the feature dimensionality (`nFeatures`).

## Types

- **`Dataset`**: A labeled dataset with `features : Array (Array Float)` (each inner array is one sample's feature vector) and `labels : Array Nat` (class labels, one per sample).
- **`SamplingStrategy`**: Alias for `Array (Nat × Nat)` — each pair is `(class_label, target_count)`.
- **`TomekLink`**: A detected boundary pair with `idx1`, `idx2` (sample indices) and `class1`, `class2` (their class labels).
- **`PRNG`**: A pure pseudo-random number generator with a `state : Nat` field. Defined but not directly used in the core spec.

## Hints

- `Dataset.nSamples` and `Dataset.nFeatures` are also `sorry` — implement them as `ds.features.size` and `(if ds.features.size > 0 then (ds.features[0]!).size else 0)` respectively.
- For `classDistribution`, iterate through labels and count occurrences. A simple approach: collect unique labels, then for each, count how many times it appears. Ensure the result array has no duplicate first-elements.
- For `randomOversampling`, start with the original dataset as a prefix. For each (class, target) in the strategy, if the class has fewer samples than target, randomly duplicate existing samples of that class (using `seed` for determinism) until reaching the target. Append all new samples after the originals.
- For `detectTomekLinks`, compute nearest neighbors for each sample (using Euclidean distance). For each pair (i, j) where i < j: if i's nearest neighbor is j AND j's nearest neighbor is i AND they have different labels, emit a TomekLink. The all-same-class check is a logical consequence — if all labels match, no pair can have different classes.
- The `classDistribution_complete_rel` proof follows directly from the main postcondition (it's the second conjunct of `classDistribution_postcond`).

## Edit Boundaries

`ImbalancedLearn/*.lean` is divided into labeled sections:

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

- `ImbalancedLearn/ClassDistribution.lean`
- `ImbalancedLearn/DetectTomekLinks.lean`
- `ImbalancedLearn/RandomOversampling.lean`
- `ImbalancedLearn/Relations.lean`
- `ImbalancedLearn/Types.lean`
- `ImbalancedLearn/Validity.lean`
