# TlsLite

## Background

TlsLite (tlslite-ng) is a Python library for TLS protocol structures. It models the TLS record layer, handshake messages, cipher suites, certificates, extensions, and state machines as pure data structures — no actual cryptographic operations or network I/O. This spec covers the core protocol logic: the handshake state machine, cipher suite lookup, and terminal state detection.

## Task

Complete implementation holes in explicitly editable regions in `TlsLite/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `HandshakeState.transition`

- **Signature**: `def HandshakeState.transition (state : HandshakeState) (event : HandshakeEvent) : Option HandshakeState`
- **Description**: Compute the next TLS handshake state given the current state and an event. Returns `none` if the transition is invalid.
- **Postcondition**: `HandshakeState.transition_postcond` requires (14 clauses):
  - `initial` + `sendClientHello` → `clientHelloSent`
  - `error` → always `none` (sink state)
  - `connected` → always `none` (sink state)
  - `clientHelloSent` + `recvServerHello` → `serverHelloReceived`
  - `protocolError` from any non-terminal state → `error`
  - Result is never `initial` (can't go back to start)
  - Full chain: serverHelloReceived → certificateReceived → serverKeyExchangeReceived → serverHelloDoneReceived → clientKeyExchangeSent → changeCipherSpecSent → finishedSent → serverChangeCipherSpecReceived → connected
- **Key constraints**: The state machine must follow the exact TLS handshake flow. Both `error` and `connected` are sink states. The `protocolError` event transitions to `error` from any non-terminal state.

### 2. `CipherSuite.ofId`

- **Signature**: `def CipherSuite.ofId (id : UInt16) : Option CipherSuite`
- **Description**: Look up a cipher suite by its 2-byte numeric ID from the known cipher suites database.
- **Postcondition**: `CipherSuite.ofId_postcond` requires (4 clauses):
  - If result is `some cs`, then `cs.id = id` (correct ID)
  - If a cipher suite with matching ID exists in `cipherSuites`, result is `some cs` (completeness)
  - If result is `some cs`, then `cs ∈ cipherSuites` (result comes from database)
  - If result is `none`, no cipher suite in `cipherSuites` has that ID (soundness of none)
- **Key constraints**: The `cipherSuites` list is also `sorry` and must be implemented as the database of known cipher suites.

### 3. `HandshakeState.isTerminal`

- **Signature**: `def HandshakeState.isTerminal (state : HandshakeState) : Bool`
- **Description**: Check if a handshake state is terminal (no further transitions possible).
- **Postcondition**: `HandshakeState.isTerminal_postcond` requires (7 clauses):
  - `connected` → true; `error` → true
  - `initial` → false; `clientHelloSent` → false; `serverHelloReceived` → false; `finishedSent` → false
  - Biconditional: `result = true ↔ (state = connected ∨ state = error)`
- **Key constraints**: The iff clause requires proving both directions — exactly `connected` and `error` are terminal.

## Relational Properties

- **`terminal_no_transition`**: If `isTerminal state = true`, then `transition state event = none` for all events. This ensures terminal states are truly sinks in the state machine.

## Types

- **`ProtocolVersion`** — TLS version with major/minor bytes (e.g., 3.3 for TLS 1.2)
- **`KeyExchange`** — Key exchange algorithms: RSA, DHE_RSA, ECDHE_RSA, ECDHE_ECDSA, PSK
- **`BulkCipher`** — Encryption algorithms: AES-128/256 CBC/GCM, ChaCha20-Poly1305, 3DES, RC4
- **`MacAlgorithm`** — MAC algorithms: HMAC-SHA1/SHA256/SHA384, AEAD
- **`CipherSuite`** — A cipher suite with ID, name, key exchange, cipher, MAC, and minimum TLS version
- **`HandshakeState`** — 12 states of the TLS handshake: initial → clientHelloSent → ... → connected, plus error
- **`HandshakeEvent`** — 11 events driving the state machine: send/recv of handshake messages, plus protocolError

## Hints

- `cipherSuites` is an infrastructure definition (marked `sorry`) that must be implemented as a list of well-known TLS cipher suites. Include at least a few standard suites (e.g., TLS_RSA_WITH_AES_128_CBC_SHA = 0x002F, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 = 0xC02F).
- For `HandshakeState.transition`, implement a match on `(state, event)` pairs. The postcondition fully specifies the happy path transitions. Return `none` for invalid combinations, `some .error` for `protocolError` events.
- For `HandshakeState.isTerminal`, simply match on `connected` and `error` returning true, everything else false.
- For `CipherSuite.ofId`, search `cipherSuites` for a matching ID. The postcondition assumes unique IDs in the database.
- The relational spec `terminal_no_transition` should follow directly from the definitions of `isTerminal` and `transition` — if you implement both correctly, the proof should be straightforward.

## Edit Boundaries

`TlsLite/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `TlsLite/Helpers.lean`
- `TlsLite/IsTerminal.lean`
- `TlsLite/OfId.lean`
- `TlsLite/Transition.lean`
- `TlsLite/Types.lean`
