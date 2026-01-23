---
description: Multi-agent implementation planning with zettelkasten documentation. Spawns architecture-planner and refactor-agent (always), plus test-strategist when testing is involved. Creates phased implementation plans documented as permanent linked notes.
argument-hint: Description of what needs to be planned (or reference to prior work)
---

# Implementation Planning Workflow

You are orchestrating a multi-agent implementation planning session. Your job is to gather context, spawn specialist agents in parallel, review their notes, and synthesize findings into a hub note.

## Core Principles

- **Agents document directly**: Agents create their own zettelkasten notes using zk_create_note
- **You synthesize, not duplicate**: Your hub note links to and comments on agent work
- **Parallel execution**: Launch all applicable agents simultaneously
- **Respect agent authority**: You may annotate and link but NEVER modify agent note content

---

## Phase 1: Context Gathering

**Goal**: Understand what needs to be planned

**Input**: $ARGUMENTS

**Actions**:
1. If input references prior work, search zettelkasten for context:
   - Use `zk_search_notes` or `zk_fts_search` to find relevant notes
   - Read related notes to understand current state
2. If input is ambiguous or insufficient, ask the user for clarification:
   - What is the scope of the implementation?
   - Are there existing design documents or decisions?
   - What constraints should be considered?
3. Summarize your understanding before proceeding

---

## Phase 2: Agent Deployment

**Goal**: Launch specialist agents in parallel to analyze the planning challenge

### Always Deploy:

**architecture-planner** (znote-workflow)
```
Analyze the implementation requirements and design a phased implementation plan.

Context: [Summarize what you learned in Phase 1]

Requirements:
- Create a zettelkasten note documenting your analysis
- Use note_type: "permanent", project: "[project name]"
- Tag with: architecture, implementation-plan, phase-design
- Return the note ID when complete
```

**refactor-agent** (znote-workflow)
```
Analyze the codebase for refactoring opportunities relevant to this implementation.

Context: [Summarize what you learned in Phase 1]

Requirements:
- Create a zettelkasten note documenting your analysis
- Use note_type: "permanent", project: "[project name]"
- Tag with: refactoring, technical-debt, improvement-analysis
- Document any tension with architectural constraints
- Return the note ID when complete
```

### Conditionally Deploy:

**test-strategist** (znote-workflow) - When testing is part of the implementation:
```
Design the test strategy for this implementation.

Context: [Summarize what you learned in Phase 1]

Requirements:
- Create a zettelkasten note documenting your test strategy
- Use note_type: "permanent", project: "[project name]"
- Tag with: testing, test-strategy, quality-assurance
- Focus on behavioral contracts, not implementation details
- Return the note ID when complete
```

### Context-Driven (via prompts to general agents):
- If security is a concern, include security analysis in agent prompts
- If performance is critical, include performance considerations
- If risk assessment needed, ask agents to flag risks in their notes

---

## Phase 3: Analysis Review

**Goal**: Review agent outputs and identify synthesis points

**Actions**:
1. Wait for all agents to complete
2. Read each agent's note using `zk_get_note`
3. Identify:
   - Points of agreement between agents
   - Points of productive tension (especially architecture vs refactor)
   - Gaps or areas needing clarification
   - Dependencies between recommendations

---

## Phase 4: Hub Note Creation

**Goal**: Create a synthesis hub note that ties the analysis together

**Create hub note using zk_create_note**:

```markdown
## Overview
[2-3 paragraph synthesis of the implementation planning session]

## Agent Analysis Summary

| Agent | Focus | Key Recommendations | Note |
|-------|-------|--------------------|----|
| architecture-planner | Phased implementation | [Brief summary] | reference [[note-id]] |
| refactor-agent | Improvement opportunities | [Brief summary] | reference [[note-id]] |
| test-strategist | Test strategy | [Brief summary] | reference [[note-id]] |

## Synthesized Implementation Plan

### Phase Sequence
[Reconciled phase plan drawing from agent inputs]

### Key Decisions Required
[Decisions that need user/team input]

### Risk Register
| Risk | Source | Mitigation |
|------|--------|------------|
| [Risk] | [Which agent flagged] | [Proposed mitigation] |

## Push-Pull Analysis
[Document productive tensions between architecture and refactoring perspectives]

### Architecture Position
[Summary of preservation/alignment priorities]

### Refactor Position
[Summary of improvement opportunities]

### Orchestrator Recommendation
[Your synthesis and recommendation]

## Dependencies Graph
```
[ASCII diagram of implementation dependencies]
```

## Next Steps
- [ ] [Action item]
- [ ] [Action item]

## Linked Documentation
- reference [[architecture-planner-note-id]]
- reference [[refactor-agent-note-id]]
- reference [[test-strategist-note-id]] (if applicable)
```

**Hub note metadata**:
- note_type: "hub"
- project: [same as agent notes]
- tags: "implementation-plan,hub,synthesis"

---

## Phase 5: Completion

**Actions**:
1. Create links between hub and agent notes using `zk_create_link`:
   - Hub → each agent note with link_type: "reference"
2. Present the hub note to the user
3. Ask if any clarification or additional analysis is needed
