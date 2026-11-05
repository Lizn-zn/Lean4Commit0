# Lean4Commit0

Lean4Commit0 contains 108 library-level Lean program-and-proof tasks. Each task asks you to complete implementations and prove their contracts, including properties that relate several APIs. See the [task list](TASKS.md).

This repository contains the revised **v3** benchmark. The results in the [P³ paper](https://arxiv.org/abs/2608.09277) use the original benchmark version. See the [version notes](REVISION_NOTES.md).

## Quick start

Install Git, Python 3.9 or newer, and [elan](https://github.com/leanprover/elan#installation). Elan selects Lean and Lake 4.28.0 from the repository's toolchain file.

```sh
git clone https://github.com/Lizn-zn/Lean4Commit0.git
cd Lean4Commit0
lake exe cache get
python3 check_templates.py --library Memchr
```

The cache command downloads artifacts for the pinned dependencies. Keep `lake-manifest.json` to retain the dependency revisions. To compile all 108 templates, run:

```sh
LEAN_NUM_THREADS=2 python3 check_templates.py --all --report build-report.json
```

Template builds check that the starting files compile. They permit the task's unfinished `sorry` placeholders.

## Solve and check a task

1. Read the library's instructions, for example [Memchr](libs/Memchr/Instruction.md).
2. Complete the explicit editable regions and leave the provided code and specifications intact. Optional proof imports belong in the marked import regions.
3. Run the checker from the repository root:

```sh
python3 check_solution.py --library Memchr
```

Exit code 0 from the default checker means the library passes source integrity, compilation, required declaration and type checks, and the transitive axiom audit. A library with unfinished obligations fails. Diagnostic modes such as `--integrity-only` and `--compile-only` check only the named condition. Run `python3 check_solution.py --help` for options.

For external evaluation, use a trusted checkout of the benchmark and an evaluator-owned dependency cache. Run untrusted submissions in an OS sandbox:

```sh
python3 /trusted/Lean4Commit0/check_solution.py --root /candidate \
  --baseline /trusted/Lean4Commit0/INTEGRITY_BASELINE.json \
  --trusted-dependencies /trusted/Lean4Commit0/.lake/packages \
  --library Memchr
```

The scoring unit is one library. The checker evaluates the stated Lean contracts. See the [model scope](MODEL_LIMITS.md) for task-specific limits.

## License

Original benchmark material is [MIT licensed](LICENSE). [License scope](LICENSE_SCOPE.md) and [third-party notices](THIRD_PARTY_LICENSES/) describe the terms for other materials.
