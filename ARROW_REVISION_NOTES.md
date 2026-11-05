> Historical record for arrow-valid-input-v1. Current v3 changes and validation are in REVISION_NOTES.md and VALIDATION.md.

# Arrow revision: arrow-valid-input-v1

This is an author-authorized benchmark revision based on source commit `0e91089e55c230e40e4c8e9fa946d556832294e4`. **It is not an experimental rerun and does not replace or update the paper's measured results.**

## Preserved baseline

The unmodified-source review snapshot is preserved separately as `lean4commit0-before-arrow-revision-review.tar.gz`. The original source checkout and the original review directory remain unchanged. Source identity is recorded explicitly; we have not independently authenticated that snapshot as the full original experiment artifact.

## Minimal source changes

1. `Arrow/Types.lean`: add `ArrowDateTime.Valid`, expressing month 1–12, day 1 through `daysInMonth year month`, hour ≤23, minute/second ≤59 and microsecond ≤999999. Year and timezone offset retain their existing unrestricted integer domains. This follows the calendar helpers, field comments and existing construction postcondition; the public record/function types remain unchanged.
2. `Arrow/Shift.lean`: add an explicit `hvalid : ArrowDateTime.Valid dt` premise to `shift_spec`. The postcondition body itself remains unchanged. Invalid records remain representable, but the correctness contract is asserted only for valid input dates. This excludes the demonstrated month=0 counterexample rather than claiming a valid result for every unrestricted record.
3. `Arrow/Helpers.lean`: replace the duplicate global `String.containsSubstr` declaration with `Arrow.containsSubstr`, retaining its original algorithm verbatim. `Arrow/IsoFormat.lean` explicitly calls that helper. Review checks prove the helper and the entire ISO-format postcondition definitionally equivalent to their original algorithmic expressions, without sorryAx or custom axioms, and exercise eight runtime cases.
4. Update Arrow's instruction and protected-region fingerprint, and regenerate the trusted integrity baseline for this authorized revision.

Only these four Arrow task Lean files were changed (Types, Shift, Helpers, IsoFormat); other task Lean definitions were not changed. The 108 library tasks and 511 implementation+519 theorem placeholder counts remain unchanged. Given/unmarked-hole policies in other tasks remain unresolved.

## Validation and limits

- `lake build Arrow` now passes with expected unfinished-template and linter warnings; the baseline failed on the duplicate string declaration.
- A Lean proof rejects month=0 under `Valid`.
- A Lean theorem proves the **complete existing zero-shift postcondition for every valid input**, using result=input and without invoking the unfinished implementation or theorem. Its axiom report contains no sorryAx.
- Leap-day and invalid month/day/hour examples validate the intended boundary. The correctness theorem's checked type now requires the validity premise.
- Helper and complete ISO-format predicate preservation are checked by `rfl` theorems with only the allowed standard axioms and no sorryAx, supplemented by eight runtime examples.
- This does not implement the unfinished Arrow algorithms, prove all nonzero-shift obligations satisfiable, rerun quality scoring, or reproduce benchmark solve rates. Other calendar/relational specifications still require normal validation.

The current paper's experimental tables are unchanged. Any future results for this revised contract must name this revision and its task hashes rather than being presented as results from the original experiment version.

Extract the baseline and revision separately. The revised archive has a revision-specific top-level folder to avoid overlaying the baseline.
