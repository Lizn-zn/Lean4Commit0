# DnsPython

## Background

dnspython is the standard Python DNS toolkit, providing comprehensive support for DNS protocol operations including message construction, wire format serialization/deserialization, record type handling, and zone file parsing. This spec models DNS as pure data structures (no network I/O) and focuses on the core wire format encoding/decoding at three levels of the protocol stack: domain names, resource records, and message headers.

## Task

Complete implementation holes in explicitly editable regions in `DnsPython/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `DomainName.toWireFormat` / `DomainName.fromWireFormat`

- **Signatures**:
  - `def DomainName.toWireFormat (name : DomainName) : ByteArray`
  - `def DomainName.fromWireFormat (data : ByteArray) (offset : Nat) : Option (DomainName × Nat)`
- **Description**: Encode a domain name to DNS wire format (RFC 1035 Section 4.1.4) and decode it back. Wire format uses length-prefixed labels terminated by a zero byte. For example, `["www", "example", "com"]` becomes `[3, 'w', 'w', 'w', 7, 'e', 'x', 'a', 'm', 'p', 'l', 'e', 3, 'c', 'o', 'm', 0]`.
- **Postcondition (relational)**: `wireFormat_roundtrip_rel` requires that encoding then decoding at offset 0 returns `some (name, wire.size)` — the original name is recovered and the parser consumes exactly the entire encoded byte array.
- **Key constraints**: `fromWireFormat` takes an offset parameter and returns the decoded name plus the new offset (number of bytes consumed). Empty labels (`""`) in the label list should be treated as the root terminator.

### 2. `ResourceRecord.toWireFormat` / `ResourceRecord.fromWireFormat`

- **Signatures**:
  - `def ResourceRecord.toWireFormat (rr : ResourceRecord) : ByteArray`
  - `def ResourceRecord.fromWireFormat (data : ByteArray) (offset : Nat) : Option (ResourceRecord × Nat)`
- **Description**: Encode/decode a full DNS resource record. The wire format is: encoded domain name + 2 bytes RRType + 2 bytes DnsClass + 4 bytes TTL + 2 bytes RDLENGTH + RDATA bytes.
- **Postcondition (relational)**: `wireFormat_roundtrip_rel` requires:
  - Encoding then decoding at offset 0 recovers the original record and consumes the full wire
  - Wire size is at least `name.wireSize + 10` bytes (name + type + class + TTL + rdlength)
  - The 2 bytes at offset `name.wireSize` equal `rrtype.numericValue` (big-endian)
  - The 2 bytes at offset `name.wireSize + 2` equal `rrclass.numericValue` (big-endian)
- **Key constraints**: This is the strongest spec — it checks not just roundtrip correctness but also that specific bytes in the wire format have the correct values. Multi-byte integers must be big-endian per DNS conventions.

### 3. `Header.toWireFormat` / `Header.fromWireFormat`

- **Signatures**:
  - `def Header.toWireFormat (hdr : Header) : ByteArray`
  - `def Header.fromWireFormat (data : ByteArray) : Option Header`
- **Description**: Encode/decode a DNS message header. The header is always exactly 12 bytes per RFC 1035 Section 4.1.1: 2 bytes ID, 2 bytes flags (QR, Opcode, AA, TC, RD, RA, AD, CD, RCODE packed into bits), then 4 × 2-byte section counts (QDCOUNT, ANCOUNT, NSCOUNT, ARCOUNT).
- **Postcondition (relational)**: `wireFormat_roundtrip_rel` requires that encoding then decoding recovers the original header exactly.
- **Key constraints**: The flags field packs multiple values into a single 16-bit word using bit manipulation. The `fromWireFormat` takes a raw `ByteArray` (no offset) and should validate that the input is at least 12 bytes.

## Relational Properties

- **`DomainName.wireFormat_roundtrip_rel`**: Encoding a domain name then decoding at offset 0 recovers the original name, consuming exactly the encoded bytes.
- **`ResourceRecord.wireFormat_roundtrip_rel`**: Encoding a resource record then decoding recovers the original, with additional byte-level checks on wire format structure.
- **`Header.wireFormat_roundtrip_rel`**: Encoding a header then decoding recovers the original header.

## Types

- **`DnsClass`**: DNS class codes (IN, CH, HS, NONE, ANY) per RFC 1035.
- **`RCode`**: DNS response codes (NOERROR, FORMERR, SERVFAIL, NXDOMAIN, etc.).
- **`RRType`**: DNS resource record types (A, AAAA, CNAME, MX, NS, SOA, TXT, SRV, PTR, CAA, etc.).
- **`DomainName`**: A domain name as a list of label strings. E.g., `www.example.com.` → `["www", "example", "com", ""]`.
- **`IPv4Address` / `IPv6Address`**: IP addresses as raw byte arrays (4 or 16 bytes).
- **`RData`**: Sum type for record-type-specific data (A records hold IPv4, CNAME holds a DomainName, MX holds preference + exchange, etc.).
- **`ResourceRecord`**: A complete DNS record: name, type, class, TTL, and rdata.
- **`Opcode`**: DNS operation codes (QUERY, IQUERY, STATUS, NOTIFY, UPDATE).
- **`HeaderFlags`**: Packed header flags: QR, opcode, AA, TC, RD, RA, AD, CD, rcode.
- **`Header`**: DNS message header: ID, flags, and 4 section counts.

## Hints

- The following helpers are already implemented (not `sorry`) and are used in postconditions:
  - `DomainName.wireSize` — computes expected wire size from labels
  - `RRType.numericValue` — maps each RRType to its RFC numeric value
  - `DnsClass.numericValue` — maps each DnsClass to its RFC numeric value
  - `getUInt16BE` — reads a big-endian UInt16 from a ByteArray at a given offset
- For `DomainName.toWireFormat`, iterate through non-empty labels, writing `[length_byte, ...label_chars]` for each, then a final `0` byte.
- For `Header.toWireFormat`, pack the flags into a 16-bit word: QR at bit 15, Opcode at bits 14-11, AA at 10, TC at 9, RD at 8, RA at 7, AD at 5, CD at 4, RCODE at bits 3-0. Write all fields as big-endian UInt16.
- For `ResourceRecord.toWireFormat`, concatenate: encoded name + RRType (2 bytes BE) + DnsClass (2 bytes BE) + TTL (4 bytes BE) + RDLENGTH (2 bytes BE) + RDATA bytes.
- The file imports `ByteArrayUtils` — check what helpers it provides for ByteArray construction and manipulation.

## Edit Boundaries

`DnsPython/*.lean` is divided into labeled sections:

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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `DnsPython/Helpers.lean`
- `DnsPython/MessageWireFormat.lean`
- `DnsPython/ResourceRecordWireFormat.lean`
- `DnsPython/Types.lean`
- `DnsPython/ZoneFile.lean`
