# Stb

## Background

stb is a collection of single-file public domain C libraries by Sean Barrett, most famously stb_image (image loading), stb_image_write (image writing), and stb_image_resize (image resizing). This spec models PNG image decoding, nearest-neighbor image resizing, and pixel-level read/write operations as pure functions over a simple `Image` structure backed by a `List UInt8`.

## Task

Complete implementation holes in explicitly editable regions in `Stb/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `decodePng`

- **Signature**: `def decodePng (input : List UInt8) : Option Image`
- **Description**: Decodes a PNG file (given as raw bytes) into an `Image`. Returns `none` for invalid input.
- **Postcondition**: (1) Successful decode produces a well-formed image (`width > 0`, `height > 0`, `data.length = w * h * channels`, `channels ∈ [1,4]`). (2) Input without the 8-byte PNG signature must return `none`. (3) If decode succeeds, input had the PNG signature. (4) If IHDR chunk is present (bytes 16–23), decoded dimensions must match the IHDR width/height (big-endian 32-bit).
- **Key constraints**: The PNG signature is `[137, 80, 78, 71, 13, 10, 26, 10]`. IHDR width is at bytes 16–19 and height at bytes 20–23, both big-endian. Use `readBE32` (already implemented) for parsing.

### 2. `resize`

- **Signature**: `def resize (img : Image) (newWidth newHeight : Nat) : Image`
- **Description**: Resizes an image to the target dimensions using nearest-neighbor interpolation.
- **Postcondition**: (1) `result.width = newWidth`, `result.height = newHeight`. (2) `result.channels = img.channels`. (3) `result.data.length = newWidth * newHeight * img.channels`. (4) Identity resize (`newWidth = img.width ∧ newHeight = img.height`) preserves data exactly. (5) Each output pixel matches the nearest-neighbor source pixel: `src_x = x * img.width / newWidth`, `src_y = y * img.height / newHeight`.
- **Key constraints**: The nearest-neighbor formula uses integer division. Every channel byte of each output pixel must match the corresponding source pixel byte exactly.

### 3. `setPixel`

- **Signature**: `def setPixel (img : Image) (x y : Nat) (c : Color) : Image`
- **Description**: Writes a color to the pixel at position (x, y) in the image.
- **Postcondition**: (1) Dimensions and data length preserved. (2) For ≥3-channel images: target pixel bytes set to `c.r`, `c.g`, `c.b` (and `c.a` if ≥4 channels). (3) Non-target pixel bytes unchanged. (4) Out-of-bounds write returns data unchanged.
- **Key constraints**: Pixel index is `(y * width + x) * channels`. The byte-level preservation of non-target pixels is specified per-byte using `listGetOpt`. The `getPixel` function (also needs implementation) is used in the relational spec.

## Relational Properties

- **`getPixel_after_setPixel_rel`**: For in-bounds coordinates, `getPixel (setPixel img x y c) x y = some c` — reading a pixel after writing it returns the written color.

## Types

- **`Color`**: RGBA pixel color with `r`, `g`, `b` : `UInt8` and `a : UInt8` (default 255).
- **`Image`**: An image with `width`, `height`, `channels` : `Nat` and `data : List UInt8`. Pixel data is stored in row-major order, with `channels` bytes per pixel.

## Hints

- `listGetOpt` (already implemented) is `l[i]?` — use it for byte-level access in both implementation and proof.
- `readBE32` (already implemented) converts 4 bytes to a big-endian `Nat`.
- `pngSignature` (already defined) is the 8-byte PNG magic number.
- For `decodePng`: you need to validate the PNG signature, parse at least the IHDR chunk for dimensions, and produce pixel data. The postcondition does not require full PNG decompression — it only requires structural correctness (signature, dimensions, data length).
- For `resize`: iterate over each `(x, y)` in the output, compute `srcX = x * img.width / newWidth` and `srcY = y * img.height / newHeight`, then copy all channel bytes from the source pixel.
- For `setPixel`/`getPixel`: the pixel at `(x, y)` starts at byte index `(y * width + x) * channels`. For `setPixel`, use `List.set` to write individual bytes. For `getPixel`, use `listGetOpt` to read bytes and construct a `Color`.
- The relational spec `getPixel_after_setPixel_rel` requires `setPixel` and `getPixel` to agree on the pixel layout — design them together.

## Edit Boundaries

`Stb/*.lean` is divided into labeled sections:

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

- `Stb/DecodePng.lean`
- `Stb/GetPixel.lean`
- `Stb/Helpers.lean`
- `Stb/Resize.lean`
- `Stb/SetPixel.lean`
- `Stb/Types.lean`
