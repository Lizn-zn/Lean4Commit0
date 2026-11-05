# LlHttp

## Background

llhttp is the HTTP/1.1 parser used by Node.js, written in C for maximum performance. It handles parsing HTTP request/response messages, chunked transfer encoding, and connection management headers. This spec models the parser as pure functions over strings and byte lists, focusing on request parsing, chunked body decoding, and keep-alive connection logic.

## Task

Complete implementation holes in explicitly editable regions in `LlHttp/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parseRequest`

- **Signature**: `def parseRequest (input : String) : Option HttpRequest`
- **Description**: Parse a complete HTTP/1.x request from a raw string, extracting the method, URL, version, headers, and body.
- **Postcondition**: `parseRequest_postcond` requires:
  - Empty input → `none`
  - On success: method is one of the 9 standard HTTP methods, version.major ≤ 2, url is non-empty, all header names are non-empty
  - On success: the input string contains the method string, the URL, and all headers in `"Name: Value"` format
  - Concrete test vector 1: `"GET / HTTP/1.1\r\n\r\n"` → GET request to `/` with HTTP/1.1, no headers, no body
  - Concrete test vector 2: `"GET / HTTP/1.1\r\nHost: example.com\r\n\r\n"` → same with Host header
- **Key constraints**: HTTP requests use `\r\n` (CRLF) line endings. Headers are terminated by a blank line (`\r\n\r\n`). The method string must match exactly (e.g., `"GET"` not `"get"`). The `containsSubstr` helper (already implemented) is used to verify parsed components exist in the original input.

### 2. `parseChunked`

- **Signature**: `def parseChunked (input : List UInt8) : Option (List UInt8)`
- **Description**: Decode a chunked transfer-encoded body from raw bytes. Each chunk has a hex size prefix, followed by CRLF, data bytes, and CRLF. A zero-length chunk terminates the stream.
- **Postcondition**: `parseChunked_postcond` requires:
  - Empty input → `none`
  - On success: decoded length ≤ input length, all decoded bytes appear in the input
  - 6 concrete test vectors:
    - `[48, 13, 10, 13, 10]` ("0\r\n\r\n") → `some []` (zero-terminator)
    - `[48, 13, 10]` ("0\r\n") → `some []` (zero-terminator without trailing CRLF)
    - `[49, 13, 10, 65, 13, 10, 48, 13, 10, 13, 10]` ("1\r\nA\r\n0\r\n\r\n") → `some [65]` (single byte 'A')
    - `[53, 13, 10, 72, 101, 108, 108, 111, 13, 10, 48, 13, 10, 13, 10]` ("5\r\nHello\r\n0\r\n\r\n") → `some [72, 101, 108, 108, 111]` ("Hello")
    - `[255]` → `none` (invalid byte)
    - `[49, 48, 13, 10]` ("10\r\n") → `none` (truncated: declares 16 bytes but has no data)
- **Key constraints**: Chunk sizes are hex-encoded ASCII. The format is: `<hex-size>\r\n<data>\r\n`, repeated, terminated by `0\r\n\r\n`. Must validate that declared chunk sizes match actual data available.

### 3. `isKeepAlive`

- **Signature**: `def isKeepAlive (version : HttpVersion) (headers : List Header) : Bool`
- **Description**: Determine whether an HTTP connection should be kept alive based on the HTTP version and Connection headers.
- **Postcondition**: `isKeepAlive_postcond` requires 4 cases:
  - HTTP/1.1+ with no Connection header → `true` (keep-alive is the default)
  - HTTP/1.0 with no Connection header → `false` (close is the default)
  - Connection: close present (and no keep-alive) → `false`
  - Connection: keep-alive present (and no close) → `true`
- **Key constraints**: Header name matching is case-insensitive (uses `String.toLower`). When both Connection: close and Connection: keep-alive are present, the postcond doesn't constrain the result (both third and fourth implications have a "the other is absent" precondition). HTTP/1.1 is `major = 1, minor ≥ 1`.

## Types

- **`HttpMethod`**: One of 9 standard methods — `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`, `CONNECT`, `TRACE`. Has a `toString` function (already implemented).
- **`HttpVersion`**: Major and minor version numbers (e.g., `{ major := 1, minor := 1 }` for HTTP/1.1).
- **`Header`**: A name-value pair (`name : String`, `value : String`).
- **`HttpRequest`**: A parsed request with `method`, `url`, `version`, `headers`, and `body : List UInt8`.

## Hints

- `String.containsSubstr` is already implemented (not `sorry`) — checks if a substring exists using `splitOn`.
- `HttpMethod.toString` is already implemented — maps each method to its canonical string.
- For `parseRequest`: split the input on `"\r\n\r\n"` to separate headers from body. Parse the first line as `"METHOD URL HTTP/M.N"`. Parse subsequent lines as `"Name: Value"` headers.
- For `parseChunked`: read hex digits until `\r\n` (bytes 13, 10), convert to a chunk size. Read that many data bytes, skip the trailing `\r\n`. Repeat until chunk size is 0. Return `none` for malformed input (non-hex characters, truncated data).
- For `isKeepAlive`: check if any header has name "connection" (case-insensitive). If present, check if value is "close" or "keep-alive". If absent, default based on version: HTTP/1.1+ defaults to keep-alive, HTTP/1.0 defaults to close.
- ASCII reference for test vectors: 48='0', 49='1', 53='5', 65='A', 72='H', 101='e', 108='l', 111='o', 13=CR, 10=LF, 255=invalid.

## Edit Boundaries

`LlHttp/*.lean` is divided into labeled sections:

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

- `LlHttp/Helpers.lean`
- `LlHttp/IsKeepAlive.lean`
- `LlHttp/ParseChunked.lean`
- `LlHttp/ParseRequest.lean`
- `LlHttp/Types.lean`

## Model scope

Parsing success is pinned for the finite examples stated in the formal contracts. General HTTP language completeness is outside this model.
