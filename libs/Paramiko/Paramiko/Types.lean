-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import ByteArrayUtils

namespace Paramiko

/-! ## Types -/

/-- SSH key algorithm types -/
inductive KeyType where
  | rsa      : KeyType
  | dsa      : KeyType
  | ecdsa256 : KeyType
  | ecdsa384 : KeyType
  | ecdsa521 : KeyType
  | ed25519  : KeyType
  deriving Repr, BEq, DecidableEq

/-- SSH channel states -/
inductive ChannelState where
  | opening    : ChannelState
  | open_      : ChannelState
  | eofSent    : ChannelState
  | eofRecvd   : ChannelState
  | eofBoth    : ChannelState
  | closing    : ChannelState
  | closed     : ChannelState
  deriving Repr, BEq, DecidableEq

/-- Events that can trigger channel state transitions -/
inductive ChannelEvent where
  | openConfirmed : ChannelEvent
  | openFailed    : ChannelEvent
  | sendEof       : ChannelEvent
  | recvEof       : ChannelEvent
  | sendClose     : ChannelEvent
  | recvClose     : ChannelEvent
  deriving Repr, BEq, DecidableEq

/-- An SSH public key (pure data, no crypto operations) -/
structure PublicKey where
  keyType : KeyType
  keyData : ByteArray
  comment : Option String
  deriving Repr, BEq

/-- A known hosts file entry -/
structure KnownHostEntry where
  hostnames : List String
  keyType   : KeyType
  keyData   : ByteArray
  comment   : Option String
  isHashed  : Bool
  deriving Repr, BEq

end Paramiko
-- === END: FIXED_FINAL ===
