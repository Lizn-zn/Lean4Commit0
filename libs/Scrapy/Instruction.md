# Scrapy

## Background

Scrapy is Python's most popular web scraping framework. This spec models its core as pure data structures and algorithms — no actual networking. It covers HTML tree representation, CSS selector parsing and matching, XPath expression evaluation, link extraction from HTML documents, and URL handling. The 3 core functions represent the three main ways Scrapy extracts data: finding links, querying with CSS selectors, and querying with XPath.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Scrapy/` and complete the proof obligations assigned to editable regions. Shared helpers are grouped in `Scrapy/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `extractLinks`

- **Signature**: `def extractLinks (root : Node) : List Link`
- **Description**: Extract all links from an HTML tree by finding all `<a>` elements with `href` attributes.
- **Postcondition**: `extractLinks_postcond` requires (7 clauses):
  - Every link comes from an `<a>` element (in descendants or root itself) that has an `href` attribute
  - Every link URL is non-empty
  - If there are no `<a>` elements, result is empty
  - Text and comment nodes produce empty results
  - Result count ≤ number of `<a>` elements (possibly +1 if root is `<a>`)
  - Every link's URL matches the `href` attribute of its source `<a>` element
- **Key constraints**: Must traverse the entire tree to find `<a>` elements. The link text should come from the text content of the `<a>` element. The `noFollow` field should be set based on the `rel="nofollow"` attribute.

### 2. `selectCSS`

- **Signature**: `def selectCSS (root : Node) (selector : CSSSelector) : List Node`
- **Description**: Select all nodes in the document tree that match the given CSS selector.
- **Postcondition**: `selectCSS_postcond` requires (6 clauses):
  - All result nodes are descendants of root or root itself
  - Empty selector chain → empty result
  - Text and comment root nodes → empty result
  - For simple selectors (single compound, no combinator): all matching descendants are included (completeness)
  - For simple selectors: if root itself matches, it's included
- **Key constraints**: Uses `matchesCompoundSelector` (infrastructure) to check if individual nodes match. For compound selectors with combinators (descendant, child, adjacent, sibling), the matching is more complex — the postcondition primarily constrains the simple (no-combinator) case.

### 3. `evalXPathStep`

- **Signature**: `def evalXPathStep (step : XPathStep) (contextNode : Node) : List Node`
- **Description**: Evaluate a single XPath step (axis + node test + predicates) against a context node, returning all matching nodes.
- **Postcondition**: `evalXPathStep_postcond` requires (11 clauses):
  - **child axis + nameTest**: results have matching tag name; all matching children are included
  - **child axis + wildcard**: results are elements; all element children are included
  - **child axis + textTest**: results are text nodes; all text children are included
  - **self axis + nodeTest**: result is exactly `[contextNode]`
  - **Text/comment context + child axis**: result is empty (no children)
  - **descendant axis + nameTest**: results have matching tag; all matching descendants are included
- **Key constraints**: The postcondition covers steps with empty predicate lists (`[]`). Predicate filtering is not directly constrained in the postcondition but must be implemented for correct behavior.

## Types

- **`Node`** — An HTML node: `text` (string content), `comment` (comment content), or `element` (tag name + attributes + child nodes)
- **`Attribute`** — A name-value pair on an element
- **`SelectorPart`** — A CSS selector component: tag, .class, #id, [attr], [attr=val], etc.
- **`CompoundSelector`** — Multiple selector parts that must all match the same element
- **`CSSSelector`** — A chain of compound selectors with combinators (descendant, child, adjacent, sibling)
- **`XPathAxis`** — XPath traversal direction: child, descendant, parent, ancestor, self, attribute, following, preceding
- **`XPathNodeTest`** — What to match: element name, wildcard (*), text(), node()
- **`XPathPredicate`** — Filtering condition: position, attribute existence/equality, text equality, contains
- **`XPathStep`** — One step: axis + node test + predicates
- **`Link`** — An extracted link: URL, link text, noFollow flag

## Hints

- **Node.tagName**, **Node.attributes**, **Node.children** are already implemented (not sorry) — use them directly.
- **Infrastructure functions** (getAttribute, hasAttribute, descendants, getElementsByTagName, matchesSelectorPart, matchesCompoundSelector) must be implemented but don't have postconditions in the core spec. Implement them correctly as the core functions depend on them.
- For `extractLinks`, traverse the tree (using `descendants`), filter for `<a>` elements with `href`, and construct `Link` values.
- For `selectCSS`, for the simple case (one compound selector, no combinator), filter `descendants ++ [root]` by `matchesCompoundSelector`. For combinator chains, implement the appropriate traversal logic.
- For `evalXPathStep`, dispatch on the axis: `child_` filters `contextNode.children`, `descendant_` filters `contextNode.descendants`, `selfAxis` returns `[contextNode]`. Then apply the node test and predicates.
- `matchesCompoundSelector` should check that ALL parts in the compound match: `sel.parts.all (fun p => matchesSelectorPart p node)`.

## Edit Boundaries

The editable module files under `Scrapy/` are divided into labeled sections:

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

- `Scrapy/EvalXPathStep.lean`
- `Scrapy/ExtractLinks.lean`
- `Scrapy/Helpers.lean`
- `Scrapy/SelectCSS.lean`
- `Scrapy/Types.lean`
