# Build and evaluation

Start at the [README](../README.md) for installation and the Memchr example. Use the [task index](TASKS.md) to choose a library. Run the commands below from the repository root.

## Build templates

```sh
python3 -m tools.check_templates --library Memchr
LEAN_NUM_THREADS=2 python3 -m tools.check_templates --all --report build-report.json
```

The all-library command writes a JSON report and a log for each library. Keep the pinned `lake-manifest.json` when setting up dependencies. Template builds permit `sorry`. Use the solution checker to obtain a task verdict.

## Verify a solution

Complete the explicit editable regions in the library's task files. Preserve provided definitions, predicates, and declaration types. Put optional imports in the marked proof-import regions.

```sh
python3 -m tools.check_solution --library Memchr
```

The default checker authenticates protected source, compiles the library in a fresh tree, checks required declarations and their types, and audits transitive axioms. Exit code 0 is a passing library verdict. The diagnostic modes `--integrity-only`, `--compile-only`, `--scan-only`, and `--mechanical-only` report partial checks. Use `--help` for the full command options.

The per-library `check.sh` and `check_hash.sh` scripts run solution verification and source integrity checks, respectively. To regenerate the task inventory, run `python3 -m tools.inventory`.

## Check an external submission

Invoke the checker from a trusted benchmark checkout, with the trusted baseline and an evaluator-owned dependency cache. Run untrusted submissions inside an operating-system sandbox.

```sh
python3 /trusted/Lean4Commit0/tools/check_solution.py --root /candidate \
  --baseline /trusted/Lean4Commit0/tools/INTEGRITY_BASELINE.json \
  --trusted-dependencies /trusted/Lean4Commit0/.lake/packages \
  --library Memchr
```

The scoring unit is one library. The [model scope](MODEL_LIMITS.md) describes limits of the published Lean contracts.
