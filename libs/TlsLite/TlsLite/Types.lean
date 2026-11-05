-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace TlsLite

structure ProtocolVersion where
  major : UInt8
  minor : UInt8
  deriving Repr, BEq

/-! ## Cipher Suites -/


inductive KeyExchange where
  | rsa       : KeyExchange
  | dhe_rsa   : KeyExchange
  | ecdhe_rsa : KeyExchange
  | ecdhe_ecdsa : KeyExchange
  | psk       : KeyExchange
  deriving Repr, BEq, DecidableEq


inductive BulkCipher where
  | aes128_cbc : BulkCipher
  | aes256_cbc : BulkCipher
  | aes128_gcm : BulkCipher
  | aes256_gcm : BulkCipher
  | chacha20_poly1305 : BulkCipher
  | tripleDes_cbc : BulkCipher
  | rc4       : BulkCipher
  deriving Repr, BEq, DecidableEq


inductive MacAlgorithm where
  | hmac_sha1   : MacAlgorithm
  | hmac_sha256 : MacAlgorithm
  | hmac_sha384 : MacAlgorithm
  | aead        : MacAlgorithm
  deriving Repr, BEq, DecidableEq


structure CipherSuite where
  id          : UInt16
  name        : String
  keyExchange : KeyExchange
  cipher      : BulkCipher
  mac         : MacAlgorithm
  minVersion  : ProtocolVersion
  deriving Repr, BEq

/-- Well-known cipher suites. -/

inductive HandshakeState where
  | initial
  | clientHelloSent
  | serverHelloReceived
  | certificateReceived
  | serverKeyExchangeReceived
  | serverHelloDoneReceived
  | clientKeyExchangeSent
  | changeCipherSpecSent
  | finishedSent
  | serverChangeCipherSpecReceived
  | connected
  | error
  deriving Repr, BEq, DecidableEq

inductive HandshakeEvent where
  | sendClientHello
  | recvServerHello
  | recvCertificate
  | recvServerKeyExchange
  | recvServerHelloDone
  | sendClientKeyExchange
  | sendChangeCipherSpec
  | sendFinished
  | recvChangeCipherSpec
  | recvFinished
  | protocolError
  deriving Repr, BEq, DecidableEq

end TlsLite
-- === END: FIXED_FINAL ===
