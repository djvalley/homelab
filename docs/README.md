# docs/

Infrastructure decisions, runbooks, and operational notes. Source of truth for "why" decisions were made.

## Structure

```
docs/
├── decisions/      # Architecture Decision Records (ADRs) — why things are the way they are
├── runbooks/       # Step-by-step operational procedures
├── services/       # Per-service notes (ports, endpoints, quirks)
└── network.md      # Network topology and addressing
```

## ADR format (decisions/)

```
# ADR-001: Title

**Date:** YYYY-MM-DD
**Status:** Accepted | Superseded | Deprecated

## Context
What situation prompted this decision.

## Decision
What was decided.

## Consequences
What becomes easier or harder as a result.
```
