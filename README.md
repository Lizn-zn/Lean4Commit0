# Lean4Commit0

108 library-level Lean program-and-proof tasks. This package contains the benchmark and its standalone verification utilities. P³ skills, agent harness, reference answers and model experiment artifacts are excluded.

## Version and paper experiments

This is **release-candidate-v3**, prepared 2026-11-05, a separately revised benchmark. It is not the version evaluated in the P³ paper. The preserved pre-revision snapshot has 511 implementation and 519 proof placeholders (1,030 total). This revision retains those sites and adds two proof obligations (PyJWT encode success and Serde composition): **511 implementation + 521 proof = 1,032**. The scoring unit is a library, denominator **108**. No model experiment was rerun; no paper result or measured success rate was changed.

See `REVISION_NOTES.md`, `SEMANTIC_REPAIRS.json`, `BOUNDARY_MIGRATION.json`, `REVISION_MANIFEST.json` and `PROVENANCE.json`. The source snapshot identifies commit `0e91089e55c230e40e4c8e9fa946d556832294e4`; this is snapshot provenance, not independent authentication of the exact historical experiment run. Both supplied pre-revision and Arrow-revision archives remain byte-identical in the separate private review delivery.

## Install and build

Requirements: Python 3.9+, Git, Lean/Lake **4.28.0**, and network access for the pinned dependencies. Install Lean with the official [elan instructions](https://github.com/leanprover/elan#installation). From this package root:

```sh
lake exe cache get
LEAN_NUM_THREADS=2 python3 check_templates.py --library Memchr
LEAN_NUM_THREADS=2 python3 check_templates.py --all --report build-report.json
```

Retain `lake-manifest.json`. Mathlib is pinned to `8f9d9cff6bd728b17a24e163c9402775d9e6a365`, with transitive dependencies locked. Do not run `lake update` as routine installation. Most task modules import Std/Lean; Requests additionally uses Batteries and MicroEcc uses a precise Mathlib prime-definition import. Optional proof imports may use the pinned Mathlib/Batteries/Std/Lean modules. The cache download can be large. Builds use one selected library at a time. Root `lake build` alone does not build all tasks.

**Template compilation permits sorry and is not a solution verdict.** All 108 revised library targets have been built; see `VALIDATION.md`. Download/bootstrap in a cache-empty machine has not been repeated.

## Complete and verify a library

Read `libs/<Library>/Instruction.md`, `mapping.toml` and `LIBRARY_REVIEW.json`. Edit only the explicit editable body or proof-import regions. All 1,032 placeholders are assigned obligations; there are no protected or unmarked holes. Provided signatures, predicates, helper definitions and task boundaries are fixed. `TASKS.md` and `TASK_INVENTORY.json` enumerate the tasks.

```sh
python3 inventory.py
python3 check_solution.py --library AhoCorasick --integrity-only
# After completing every assigned obligation in that library:
python3 check_solution.py --library AhoCorasick
python3 -m unittest -v test_mechanical_gate
```

Default exit 0 means the published Lean library contracts passed: protected-source integrity, static restrictions, fresh compilation, required declarations and exact trusted type fingerprints, and a transitive axiom audit of every declaration owned by its task modules. Permitted logical/compiler axioms are explicitly listed in the checker. Templates with sorry fail. A failure returns nonzero. The explicit `--scan-only`, `--compile-only`, `--mechanical-only` and `--integrity-only` modes are diagnostics; their exit 0 is never a solve verdict.

For external evaluation, invoke the evaluator's trusted checker and baseline, and an evaluator-owned pinned dependency cache:

```sh
python3 /trusted/release/check_solution.py --root /candidate \
  --baseline /trusted/release/INTEGRITY_BASELINE.json \
  --trusted-dependencies /trusted/release/.lake/packages --library AhoCorasick
```

The checker constructs a new temporary source/build tree from authenticated support files and permitted task files. Candidate build products and extra sources are not used. Keep the evaluator toolchain and dependencies immutable, and run untrusted submissions in an operating-system sandbox. Do not use solver-supplied baselines/checkers/caches. Library wrappers are convenience entry points, not a historical P³ harness.

The verdict concerns the published simplified formal model. It does not establish unstated upstream behavior or cryptographic security. Known model limits are documented per library and in `MODEL_LIMITS.md`. A finite review and regression suite do not prove global satisfiability of all tasks; full constructive solutions are not distributed.

## License and release status

Benchmark-owned tasks, specifications, helpers and tools use MIT: `Copyright (c) 2026 The Lean4Commit0 Authors`. The author confirmed independent authorship and licensing authority for all 108 libraries, including MiniTorch; the scope is recorded in `AUTHOR_RIGHTS_CONFIRMATION.json`. Third-party notices and downloaded dependencies retain their own licenses. See `LICENSE_SCOPE.md` and `THIRD_PARTY_REVIEW.md`.

This repository publishes benchmark v3. See the [P³ paper](https://arxiv.org/abs/2608.09277) for the experiments on the original benchmark version. The review and provenance records describe the status of the package at the time of the pre-publication audit.
