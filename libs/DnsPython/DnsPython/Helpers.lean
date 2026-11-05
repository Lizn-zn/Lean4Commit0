-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import DnsPython.Types
import ByteArrayUtils

namespace DnsPython

/-! ## Helpers used in postconditions -/

/-- Compute the expected DNS wire format size of a domain name from its labels.
    Each non-empty label takes 1 (length byte) + label.length bytes, plus 1 byte for the root. -/
def DomainName.wireSize (name : DomainName) : Nat :=
  (name.labels.filter (· ≠ "")).foldl (fun acc l => acc + 1 + l.length) 0 + 1

/-- Pure helper: RRType to numeric value (per RFC 1035/etc.). -/
def RRType.numericValue : RRType → UInt16
  | .A => 1 | .NS => 2 | .CNAME => 5 | .SOA => 6 | .PTR => 12
  | .MX => 15 | .TXT => 16 | .AAAA => 28 | .SRV => 33 | .NAPTR => 35
  | .OPT => 41 | .DS => 43 | .RRSIG => 46 | .NSEC => 47 | .DNSKEY => 48
  | .NSEC3 => 50 | .TLSA => 52 | .CAA => 257 | .ANY => 255

/-- Pure helper: DnsClass to numeric value (per RFC 1035). -/
def DnsClass.numericValue : DnsClass → UInt16
  | .IN => 1 | .CH => 3 | .HS => 4 | .NONE => 254 | .ANY => 255

/-- Read a big-endian UInt16 from a ByteArray at a given offset. -/
def getUInt16BE (ba : ByteArray) (off : Nat) : UInt16 :=
  if off + 1 < ba.size then
    (ba.get! off).toUInt16 <<< 8 ||| (ba.get! (off + 1)).toUInt16
  else 0

/-- Read a big-endian UInt32 from a ByteArray at a given offset. -/
def getUInt32BE (ba : ByteArray) (off : Nat) : UInt32 :=
  if off + 3 < ba.size then
    (ba.get! off).toUInt32 <<< 24 |||
    (ba.get! (off + 1)).toUInt32 <<< 16 |||
    (ba.get! (off + 2)).toUInt32 <<< 8 |||
    (ba.get! (off + 3)).toUInt32
  else 0


end DnsPython
-- === END: FIXED_FINAL ===
