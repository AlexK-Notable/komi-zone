# Design: `/znote:implement` Command

**Date**: 2026-02-01
**Status**: Approved
**Scope**: 1 new command, 3 new agents, zettelkasten note structures

## Problem

The znote plugin has a structural gap in its development lifecycle:

```
/znote:plans → [hub note with phases] → ??? → [code exists] → /znote:review
```

Every existing command follows the same paradigm: agents produce zettelkasten notes, not code. The only exceptions are test-implementer (writes tests) and doc agents in `/znote:docs` (write documentation files). No command currently takes a plan and dispatches agents to write source code.

The plan-reviewer agent even identifies "Agentic Workflow Opportunities" with autonomy classifications — but nothing consumes that output.

## Solution

A new `/znote:implement` command that bridges planning and review with agent-driven phased code implementation.

### Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Autonomy model | Agent-driven | Agents write code to disk with user approval gates. Similar to how /znote:docs agents write documentation files. |
| Input requirement | Plan-first | Always takes a plan hub note (from /znote:plans) as input. Enforces the plan→implement→review lifecycle. |
| Verification gates | User-configurable | Continuous (auto-proceed), Gated (manual approval), or Adaptive (start gated, user can release). Determined per-session based on user preference. |
| Agent strategy | New dedicated agents | Purpose-built implementation agents separate from analysis agents. Clean separation of concerns. |

## Command: `/znote:implement`

### Frontmatter

```yaml
---
name: implement
description: Agent-driven phased implementation from a plan note. Dispatches gate-keeper, feature-implementer, and test-scaffolder agents to write code according to plan phases with verification gates.
argument-hint: Plan note ID or search term to find the plan
---
```

### Phase Structure

#### Phase 0: Plan Ingestion & Strategy

The orchestrator reads the plan hub note and all linked agent analysis notes. It extracts:
- The phase sequence (ordered list of implementation phases)
- Key architectural decisions and constraints
- Risk register items relevant to implementation
- Test strategy recommendations
- Any "Agentic Workflow Opportunities" identified by plan-reviewer

Then it asks the user for their execution preference:
- **Continuous**: auto-proceed through phases, stop only on gate failure
- **Gated**: pause after each phase for user approval
- **Adaptive**: start gated, user can say "continue through the rest" at any checkpoint

Presents a summary: "This plan has N phases. Here's the execution strategy I propose." Waits for approval.

#### Phase 1: Gate Definition

Before any code is written, dispatch **gate-keeper** for all phases at once. Gate-keeper produces one verification note per phase, each containing deterministic pass/fail criteria.

The orchestrator reads all gate notes and presents a summary:

```
Phase 1 (Database schema): 3 checks — migrations apply, models importable, existing tests pass
Phase 2 (API endpoints): 5 checks — routes registered, responses correct, OpenAPI spec valid
Phase 3 (Frontend integration): 4 checks — components render, API calls succeed, a11y audit passes
```

User approves or adjusts the gates before implementation begins.

#### Phase 2: Phased Implementation

For each phase in sequence:

1. **Decomposition**: Analyze the phase for multi-agent opportunities. Can this phase be split into independent work streams? Examples:
   - Feature code + test code → feature-implementer + test-scaffolder in parallel
   - Two independent modules → two feature-implementer instances in parallel
   - Implementation + database migration → parallel if no dependency

2. **Dispatch**: Launch selected agents with structured context: plan phase description, architectural decisions, gate-keeper verification criteria, and outputs from prior phases.

3. **Verification**: After agents complete, run gate-keeper's checks (the actual commands — pytest, build, lint, etc.). Record results.

4. **Phase Note**: Create a zettelkasten note documenting: files changed, symbols added/modified, verification results, any deviations from plan.

5. **Gate Decision**:
   - All checks pass → proceed (continuous) or present results and wait (gated)
   - Some checks fail → present failures, attempt self-correction (re-dispatch agent with failure context), or escalate to user
   - Critical failure → stop, present full context, ask user how to proceed

#### Phase 3: Implementation Record

After all phases complete (or if halted mid-way):
- Create implementation hub note linking to all phase notes and gate notes
- Link implementation hub ↔ plan hub (bidirectional)
- Record: total phases completed, files changed, test results, plan deviations
- Suggest: "Run `/znote:review` to review this implementation?"

### Key Differences from Other Commands

1. **Sequential phase execution** rather than parallel-everything. Phases depend on prior phases. Parallelism happens *within* a phase (multiple agents on independent streams), not across phases.

2. **Agents write to the filesystem**, not just to zettelkasten. Implementation agents produce code files as primary output, with zettelkasten notes as documentation. This inverts the existing pattern where notes ARE the output.

## New Agents

### `gate-keeper`

**Purpose**: Defines verification criteria for each implementation phase. Runs before any code is written.

**Behavioral Contract**:
- Reads plan phase + risk register + test-strategist analysis + existing test infrastructure
- Produces ONE note per phase with structured verification checklist
- Every check must be a **runnable command** with a **deterministic expected outcome** — no subjective assessments
- Must inspect the actual codebase to calibrate: if there's pytest, checks use pytest. If there's a Makefile, checks reference make targets. No generic "run tests" — always specific.
- **Ruthless but not absurd**: require everything that CAN be mechanically verified, but don't require things that need human judgment. Save those for `/znote:review`.
- Must include a **regression guard**: list of existing tests/checks that must continue passing
- Scope boundaries: explicitly state what is NOT required for this phase, preventing scope creep

**Tools**: Read, Glob, Grep, Bash, Serena (code understanding), Anamnesis (project patterns), ZK tools (note output)

### `feature-implementer`

**Purpose**: Primary code-writing agent. Takes a plan phase + gate-keeper criteria and implements it.

**Behavioral Contract**:
- Writes production code: new files, modifications to existing files, configuration changes
- Uses Serena symbolic editing for precise modifications (replace_symbol_body, insert_after_symbol, etc.) and standard Write/Edit for new files
- Self-validates by running gate-keeper checks before reporting completion
- On self-validation failure: diagnose, attempt fix, retry (up to 3 attempts). If still failing, report what passed/failed with diagnosis.
- Creates a phase note documenting: files created/modified, symbols added/changed, design decisions, plan deviations
- Must follow existing codebase patterns (via Anamnesis `get_pattern_recommendations`)
- Must NOT touch files or functionality outside the phase's scope

**Tools**: Read, Glob, Grep, Write, Edit, Bash, Serena (full symbolic editing), Anamnesis (patterns), ZK tools (phase notes)

### `test-scaffolder`

**Purpose**: Writes tests for the implementation. Dispatched in parallel with feature-implementer when a phase includes both code and test requirements.

**Behavioral Contract**:
- Writes test files: unit tests, integration tests, fixtures, test utilities
- Discovers existing test patterns via Anamnesis and follows them (framework, assertion style, fixture conventions, directory structure)
- Tests behavior, not implementation — no mock theater, no testing that "the function was called"
- When in parallel with feature-implementer, writes tests against the *interface* defined in the plan. Tests may initially fail — they become green when feature-implementer finishes.
- Gate-keeper's test-related criteria should pass after test-scaffolder completes

**Tools**: Read, Glob, Grep, Write, Edit, Bash, Serena (full symbolic editing), Anamnesis (patterns), ZK tools (notes)

### Agent Separation Principle

Gate-keeper defines "done" independently from the agents doing the work. If feature-implementer also defined its own success criteria, it could unconsciously lower the bar. Gate-keeper sets the bar before code is written — a checks-and-balances pattern mirroring QA defining acceptance criteria separately from developers.

## Zettelkasten Note Structures

### Gate Note (one per phase, created by gate-keeper)

```markdown
## Phase: [Phase name from plan]

## Verification Criteria

### Required Checks
| # | Check | Command | Expected Result | Type |
|---|-------|---------|-----------------|------|
| 1 | [What it verifies] | `[exact command]` | [exit 0 / specific output] | [Build/Test/Lint/Custom] |

### Regression Guard
| Test Suite | Command | Current Status |
|-----------|---------|----------------|
| [suite name] | `[command]` | [N tests passing] |

### Scope Boundary
**In scope**: [what this phase MUST deliver]
**Out of scope**: [what this phase must NOT touch]

### Calibration Notes
[How criteria were derived — what was inspected in the codebase]
```

- note_type: "permanent"
- tags: "gate,verification,[phase-domain]"

### Phase Note (one per phase, created by implementation agents)

```markdown
## Phase: [Phase name]
**Status**: [Complete / Partial / Failed]
**Agents**: [which agents executed this phase]

## Changes Made
| File | Action | Summary |
|------|--------|---------|
| [path] | [Created/Modified/Deleted] | [what changed] |

## Symbols Added/Modified
| Symbol | File | Type | Description |
|--------|------|------|-------------|
| [name] | [path] | [function/class/method] | [what it does] |

## Verification Results
| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | [from gate note] | Pass / Fail | [details if failed] |

## Deviations from Plan
[Differences between plan and implementation, with reasoning]

## Implementation Decisions
[Decisions made during implementation not covered by plan]
```

- note_type: "permanent"
- tags: "implementation,phase,[phase-domain]"

### Implementation Hub Note (one per command invocation)

```markdown
## Overview
[1-2 paragraph summary: what plan was implemented, phases completed, result]

## Source Plan
**Plan**: [[plan-hub-note-id]]
**Phases Planned**: [N]
**Phases Completed**: [M]

## Phase Summary
| Phase | Status | Agents | Files Changed | Gate Result |
|-------|--------|--------|---------------|-------------|
| [name] | [Complete/Partial/Skipped] | [agents used] | [count] | [Pass/Fail] |

## Linked Phase Notes
- Phase 1: [[phase-1-note-id]] — gate: [[gate-1-note-id]]
- Phase 2: [[phase-2-note-id]] — gate: [[gate-2-note-id]]

## Aggregate Changes
| Metric | Count |
|--------|-------|
| Files created | [n] |
| Files modified | [n] |
| Tests added | [n] |
| Total lines changed | [+/-] |

## Plan Deviations
[Summary of differences between plan and implementation]

## Suggested Next Steps
- [ ] Run `/znote:review` to review implementation
- [ ] [Other follow-up items]
```

- note_type: "hub"
- tags: "implementation,hub,[project-domain]"

### Link Structure

```
plan hub ←→ implementation hub (bidirectional, "implements" / "implemented-by")
implementation hub → gate note 1, gate note 2, ... (reference)
implementation hub → phase note 1, phase note 2, ... (reference)
gate note N → phase note N (reference, "verified-by")
```

## Implementation Sequence

To build this feature:

1. **Create agent files** (agents/gate-keeper.md, agents/feature-implementer.md, agents/test-scaffolder.md) with frontmatter and prompt content
2. **Create command file** (commands/implement.md) with the orchestration workflow
3. **Update agent-catalog.md** with new Implementation category
4. **Update hooks** — new agents need Stop hooks with verify-agent-output.sh
5. **Update context-discovery.sh** — no changes needed (auto-discovers new agents)
6. **Test** — run /znote:implement against an existing plan note
7. **Version bump** — marketplace.json to 2.1.0
