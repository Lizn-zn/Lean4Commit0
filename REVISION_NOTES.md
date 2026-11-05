# Revision release-candidate-v3 — 2026-11-05

Parent: `review-2026-11-04-v2`, itself derived from the separately preserved Arrow revision. Neither supplied historical archive nor the paper experiment results were modified. This version requires new experiments before reporting new solve rates.

## Semantic repairs

`SEMANTIC_REPAIRS.json` records the exact per-file reasons and intermediate change hashes; `TASK_INVENTORY.json` and `SHA256SUMS` identify final files. `LIBRARY_REVIEW.json` separates historical evidence from current repair validation.

- Add coherent domain premises: valid Gregorian dates; unique cache/object/schema/path keys; consistent data shapes; lawful Boolean equality and order; valid ring buffers, image channels, compression blocks, Unicode scalars and serializable numeric domains; valid elliptic-curve/key/nonce inputs and parser progress.
- Resolve TTL zero expiry, duplicate-key preservation, malformed input roundtrips, template replacement self-recreation, file path canonicalization and empty-pattern matching conflicts. Remove incompatible clauses rather than requiring contradictory outputs. Arrow timestamp and shift relations now share valid-date premises.
- Use represented floating-point operations and finite/stable domains. Repair CDF rounded-mean pins, MoviePy endpoint arithmetic, Xarray reduction/signed-zero relations, TinyExpr IEEE-unsafe simplification, and histogram/KDE tolerance/domain issues. Floating-point computation is not treated as exact real arithmetic.
- Correct NetworkX queue fuel and make the CommonsLang count helper structurally total. Align whitespace-only SqlParse consistency with trimming.
- Strengthen success domains in FlatBuffers, Fabric, Parsel and Pydantic. Add PyJWT encode-success and Serde actual-composition proof obligations. These are deliberate semantic changes, not paper-era results.
- Retain explicit simplified-model limits for remaining partial contracts; correct misleading prose, including Fabric configuration precedence guidance. See `MODEL_LIMITS.md`.

## Boundaries, dependencies and evaluator

All original 1,030 holes remain, plus two new proofs: 511 implementation / 521 proof. The original 27 protected and 37 unmarked holes become assigned editable obligations. Disjoint body boundaries lock declaration types and predicates; no library is removed, and Re2 has editable obligations. Optional trusted proof-import gaps are explicit. See `BOUNDARY_MIGRATION.json`.

Retain v2's namespaced String.containsSubstr fixes and quoted Graphene field. Replace unnecessary giant Mathlib imports with Std/Lean and precise additional imports; keep the Lean toolchain and dependency revisions pinned. This changes the available default proof environment and is versioned accordingly.

The default verifier now uses a fresh authenticated source tree and evaluator-owned dependencies, requires all recorded declarations with exact trusted types (including public generated instances), and checks transitive axioms of all owned module declarations, including unused/private declarations. It rejects the demonstrated boundary-comment, quoted sorryAx, changed-type, missing-declaration, hidden-axiom and forged-cache cases. Diagnostic modes do not score solutions. The trusted evaluator and OS sandbox remain part of the evaluation assumptions.

## Evidence and limits

All 108 current library targets build. Nineteen gate regressions and 36 Lean revision regressions passed. Per-library declaration baselines, build statuses and source hashes are recorded separately. No model completion experiment, full constructive solution set, upstream conformance suite, or cache-empty bootstrap was run. Kernel checks of regression lemmas establish only their stated cases; a template build is not a satisfiability proof.

The author's independent-authorship confirmation covers all 108 Lean task models and removes the previous MiniTorch rights ambiguity for this material. It grants no rights to unrelated upstream source. All 132 preserved third-party license/notice texts retain their bytes and their own terms.
