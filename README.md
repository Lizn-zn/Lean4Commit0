# Lean4Commit0

108 library-level Lean tasks. Complete the implementations and prove their contracts, including properties that relate several APIs. Read the [P³ paper](https://arxiv.org/abs/2608.09277) for the research behind the benchmark.

## Run one task

Install Git, Python 3.9 or newer, and [elan](https://github.com/leanprover/elan#installation). Elan selects Lean and Lake 4.28.0 from the repository's toolchain file.

```sh
git clone https://github.com/Lizn-zn/Lean4Commit0.git
cd Lean4Commit0
lake exe cache get
python3 -m tools.check_templates --library Memchr
```

Read the [Memchr instructions](libs/Memchr/Instruction.md) and complete the editable regions. Then check the solution:

```sh
python3 -m tools.check_solution --library Memchr
```

A template build permits unfinished `sorry` placeholders. The solution checker requires all obligations to be completed and reports one verdict per library.

## Find your way around

| Location | Contents |
|---|---|
| [`libs/`](libs/) | Task sources, per-library instructions, and shared Lean definitions. Start with the [task index](docs/TASKS.md). |
| [`tools/`](tools/) | Build and solution-checking commands, the inventory generator, the integrity baseline, and the Lean declaration auditor. |
| [`docs/`](docs/) | [Evaluation guide](docs/EVALUATION.md) and [model scope](docs/MODEL_LIMITS.md). |

The benchmark code and documentation use the [MIT license](LICENSE). See the [license scope](docs/LICENSE_SCOPE.md).
