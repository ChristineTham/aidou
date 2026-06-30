---
name: mermaid-to-drawio
description: 'Convert Mermaid diagrams into draw.io XML with high structural fidelity. Use when you need editable .drawio source from Mermaid code by analyzing nodes, edges, groups, and labels, then generating accurate draw.io output.'
argument-hint: 'Provide Mermaid source or file path, target output path for .drawio, desired layout direction, and whether PNG or SVG exports are required.'
user-invocable: true
---

# Mermaid To Draw.io Conversion

## Purpose

Convert Mermaid diagrams into editable draw.io XML while preserving intent, topology, labels, grouping, and flow direction as accurately as possible.

This skill reuses the existing `/mermaid-diagrams` workflow for Mermaid analysis and the existing `/draw-io` workflow for draw.io XML quality and export behavior.

## When to Use

- You have Mermaid code but need an editable `.drawio` source file.
- You need to move architecture or flow documentation from Mermaid into draw.io.
- You need a draw.io version for presentation editing while preserving the original Mermaid model.
- You need repeatable Mermaid-to-draw.io conversion with explicit fidelity checks.

## Inputs

- Mermaid source text or path to a Mermaid file.
- Expected output path for the `.drawio` file.
- Diagram type and direction hints if known.
- Export requirements for `.drawio.png` and or `.drawio.svg`.
- Any style constraints such as swimlanes, icon sets, or branding.

## Decision Guide

- If Mermaid is invalid, fix or normalize Mermaid first before conversion.
- If Mermaid includes unsupported constructs, preserve semantics first and simplify visuals second.
- If layout intent is unclear, preserve relationship direction over exact geometric placement.
- If style conflicts with readability, prioritize readability and explicit connector semantics.

## Procedure

1. Run Mermaid analysis using the `/mermaid-diagrams` workflow to identify diagram type, entities, relationships, groups, and labels.
2. Validate Mermaid syntax before conversion and resolve syntax issues first.
3. Build an intermediate semantic model containing:
   - nodes with labels and type hints
   - edges with direction and labels
   - groups or boundaries
   - layout direction and ordering cues
4. Map the semantic model to draw.io primitives:
   - nodes to `mxCell` vertex elements
   - edges to `mxCell` edge elements with explicit source and target
   - groups or boundaries to container cells
   - labels to cell values or edge label cells
5. Generate `.drawio` XML with stable ids, clear layering, and readable coordinates.
6. Apply the `/draw-io` workflow checks for spacing, alignment, connector clarity, and style consistency.
7. Verify structural fidelity by comparing Mermaid model counts against draw.io model counts:
   - node count
   - edge count
   - labeled relationship count
   - group or boundary count
8. Review known non-isomorphic features and document any intentional approximations.
9. Save the `.drawio` source as the authoritative editable output.
10. Export `.drawio.png` and or `.drawio.svg` when requested.
11. Report conversion summary, fidelity results, and any unresolved gaps.

## Fidelity Rules

- Preserve relationship direction exactly where Mermaid encodes direction.
- Preserve all node and edge labels unless they are empty in source.
- Preserve grouping and containment semantics where possible.
- Preserve branching and merge structure even if absolute coordinates differ.
- Do not drop nodes or edges silently.
- If an element cannot be mapped directly, use a nearest explicit shape and record the mapping decision.

## Quality Checks

- Mermaid input was validated before conversion.
- Draw.io XML is well-formed and opens as an editable diagram.
- Node, edge, and label coverage is complete or explicitly reconciled.
- Flow direction remains intelligible from the converted diagram.
- Containers or groups remain meaningful after conversion.
- Export artifacts were generated when requested.

## Completion Criteria

- A valid `.drawio` source file was generated or updated.
- The converted diagram preserves Mermaid semantics to the maximum practical extent.
- Fidelity check results are reported with pass or gap notes.
- Any approximations or unsupported mappings are listed clearly.

## Output Expectations

- Provide output file paths for `.drawio` and any exported artifacts.
- Provide a compact fidelity report including counts and notable differences.
- Provide a short list of approximation decisions when exact parity is not possible.