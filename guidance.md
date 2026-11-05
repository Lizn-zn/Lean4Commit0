# Benchmark contribution guidance

Read README.md, TASKS.md, MODEL_LIMITS.md and the per-library review. Record exact source hashes, distinguish contradictions from underconstraints and prose mismatches, and validate related contracts together. Preserve the original experiment artifacts and results; semantic, boundary, dependency and scoring changes require a new version and new measurements.

Default solution verification uses the trusted protected-source baseline, a fresh build, required declaration/type checks and whole-module transitive axiom audit. Partial inspection modes are not solve verdicts. Use an external OS sandbox for untrusted submissions and immutable evaluator-owned toolchain/dependencies. Algorithmic properties absent from the formal predicates are not implied. No P³ skill, agent workflow or paper harness is supplied.
