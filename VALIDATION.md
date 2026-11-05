# Validation — release-candidate-v3, 2026-11-05

| Check | Result | Coverage and limitation |
|---|---|---|
| Actual Lean/Lake targets | 108/108 pass | Current task source SHA256 recorded per target; template warnings/holes expected |
| Required declarations and compiler types | 108/108 baselines complete | Explicit declarations and public generated instances; exact types locked; template axioms include sorryAx |
| Source integrity | 108/108 pass | Fixed predicates/signatures/support; all 1,032 holes assigned editable |
| Incomplete-template rejection | 108/108 scan and default reject | Prevents counting a compiling template as solved |
| Evaluator regressions | 19/19 pass | Positive toy proof, boundary/quoted-hole attacks, changed types, missing declarations, forged cache, unused hidden axiom, import restrictions and other cases |
| Fresh authenticated workspace | pass | Actual AhoCorasick target builds; relocated compiler types match; template sorryAx detected |
| Lean revision regressions | 36/36 pass | Specific predicate/domain/numeric examples; no sorryAx in reported axiom dependencies; trusted native reduction axioms appear where used |
| Historical isolated evidence | 49 files previously compiled together | Historical contradictions, numeric/runtime and underconstraint witnesses; not all are contradiction proofs or tests of revised predicates |
| Dependency source pins | 9/9 match | Reused local dependency artifacts; cache-empty download/bootstrap not rerun |
| Third-party notices | 132/132 byte-identical | Author attestation covers independently authored Lean models, not relicensing upstream source |
| Original supplied archives | SHA256 preserved | Preserved separately; exact experiment-run identity not independently authenticated |

Machine records: BUILD_VALIDATION.json, DECLARATION_VALIDATION.json, GATE_VALIDATION.json, REVISION_REGRESSION_VALIDATION.json, DEPENDENCY_VALIDATION.json, LICENSE_RECHECK.json and PACKAGE_CONTENT_RECHECK.json. Raw build logs, compiler reports and Lean revision-regression sources are in the separate **private review evidence** archive; witnesses are deliberately excluded from the public benchmark.

**Not run:** model completions/solve rates on v3; full constructive solutions or global satisfiability proofs for all tasks; complete upstream interoperability/security suites; cache-empty dependency bootstrap; other OS builds. No paper experiment result was modified. See UNRESOLVED.md and MODEL_LIMITS.md.
