# Published model limits

The required behavior is the fixed Lean predicates. The benchmark does not claim full upstream API conformance. These known limitations are explicit task scope, not experimentally measured performance or pending contradiction claims.

**Blake3**. This task verifies its published simplified hash model; it does not establish cryptographic security or official BLAKE3 test-vector compatibility.

**Flask**. The parameter-capture contract permits a parameter value containing slashes. This is a path-style capture in this model; segment-only routing is not required.

**LlHttp**. Parsing success is pinned for the finite examples stated in the formal contracts. General HTTP language completeness is outside this model.

**Pytest**. Fixture resolution uses the explicit pair-cycle predicate and output-order/request coverage clauses. It does not establish general dependency-graph completeness or require every returned fixture to be an input record.

**RustItertools**. The combinations contract checks output lengths, binomial cardinality and element membership. It does not establish position-wise no-replacement completeness or multiplicities. The formal task is this weaker collection contract.

**Sphinx**. Cross-reference resolution pins empty and matching-singleton cases and a matching-target existence implication. General resolved-target membership and ambiguity completeness are outside the formal contract.

**SerdeJson**. JSON pointer lookup uses the raw-key simplified model in the Lean predicates; RFC escape decoding is not required.

**Zstd**. This is an internal simplified framing/roundtrip model. External Zstandard interoperability and compression ratios are not measured.

**RapidJson**. The formal contracts specify the included simplified JSON model; they do not establish upstream implementation equivalence.

**Parsel**. Selector success covers the explicit simple-selector families in the revised predicate. General CSS selector completeness is outside the task.

**Pydantic**. Success completeness is required only for the explicit unique-key, correctly typed unconstrained primitive-field domain. Combined constraints and other upstream features are not implied.

**FlatBuffers**. Serialization success is required for the explicit primitive domain, including bounded int32 values. General FlatBuffers schema interoperability is not implied.

All libraries: finite review cannot establish global consistency. Validity premises and numerical domains constrain theorem obligations, not necessarily executable function input types; behavior outside an obligation's premise is not certified by that theorem. No cryptographic security, side-channel resistance, external codec compatibility, or unspecified algorithmic efficiency is certified.
