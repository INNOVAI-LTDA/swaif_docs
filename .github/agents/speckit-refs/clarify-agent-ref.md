# Clarify Agent Reference

## Owner
SpecKit (external dependency — reference only)

## What it does
Resolves requirement ambiguity and returns clarified inputs for specification.

## How SWAIF triggers it
Automatically invoked when specify returns `NEEDS_CLARIFICATION`.

## What SWAIF controls
- Maximum 3 clarification rounds
- Escalation to human operator when rounds are exhausted
- Maximum 5 questions per round
