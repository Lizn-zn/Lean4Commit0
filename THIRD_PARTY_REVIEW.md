# Third-party provenance and notices

All 108 Lean task models are independently authored according to the author's explicit confirmation. Their API reference URLs remain in per-library `mapping.toml`; unknown upstream version fields are intentionally left unknown. `UPSTREAM_LICENSES.json` retains the dated current-upstream metadata collected during review. This metadata is not an exact-source ancestry claim.

`THIRD_PARTY_LICENSES/` contains 132 preserved license/notice texts, checked byte-for-byte against the input. They retain their individual terms, including copyleft and multi-license notices where present. The root MIT grant does not replace these terms. No upstream source checkout, dependency source/cache or binary is bundled. The Lean toolchain and nine Lake dependency pins are identified by `lean-toolchain` and `lake-manifest.json`.

The earlier MiniTorch concern applied to an unidentified upstream license. The author has now confirmed its Lean task was independently written and can be published under the specified MIT license, and made the same confirmation for the remaining 107 tasks. This resolves the task-authorship question within the stated attestation scope; it does not license MiniTorch upstream code. See `AUTHOR_RIGHTS_CONFIRMATION.json` and `LICENSE_SCOPE.md`.
