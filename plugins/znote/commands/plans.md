---
description: Multi-agent implementation planning with zettelkasten documentation. Dynamically selects agents based on task analysis, presents plan for user approval, then executes.
argument-hint: Description of what needs to be planned (or reference to prior work)
---

# Implementation Planning Workflow

You are orchestrating a multi-agent implementation planning session. Your job is to assess the task, select appropriate agents, get user approval, then coordinate execution and synthesis.

## Core Principles

- **Dynamic selection**: Choose agents based on actual task needs, not fixed rules
- **User collaboration**: Present your plan and get approval before executing
- **Agents document directly**: Agents create their own zettelkasten notes
- **You synthesize, not duplicate**: Your hub note links to and comments on agent work

---

## Phase 0: Task Assessment & Agent Selection

**Goal**: Understand the task and propose an agent team

### Step 1: Gather Context

**Input**: $ARGUMENTS

1. If input references prior work, search zettelkasten:
   - Use `zk_search_notes` or `zk_fts_search` to find relevant notes
   - Read related notes to understand current state
2. Review conversation history for additional context
3. Identify the nature of the planning task:
   - Is this a new feature, refactor, migration, or improvement?
   - What systems/components are involved?
   - What concerns matter most (architecture, testing, security, performance)?

### Step 2: Select Agents

Reference the **Agent Catalog** (agent-catalog.md) and select agents based on task needs.

**For implementation planning, consider:**

| Agent | Consider When |
|-------|---------------|
| architecture-planner | Almost always—structural planning is core to implementation |
| refactor-agent | Improving existing code, technical debt concerns |
| api-designer | Designing APIs, integration points |
| migration-specialist | Upgrading frameworks, major version changes |
| test-strategist | Test coverage is a concern, TDD approach desired |
| security-reviewer | Auth flows, data handling, security-sensitive features |
| performance-analyzer | Performance-critical paths, scaling concerns |
| dependency-auditor | Adding/updating dependencies |

**Selection guidelines:**
- 2-4 agents is typical for planning tasks
- Complementary pairs (architecture-planner + refactor-agent) provide balanced perspectives
- Match agent expertise to actual task concerns

### Step 3: Present Plan to User

Before proceeding, present your proposed approach:

```
## Planning Approach

**Task Understanding**: [1-2 sentence summary of what you understand]

**Proposed Agent Team**:
| Agent | Role in This Task |
|-------|-------------------|
| [agent] | [what they'll focus on] |
| ... | ... |

**Why This Team**: [Brief reasoning]

**Alternative Agents Available**: [list any you considered but didn't select]

---

Would you like to:
- Approve this approach
- Add agent: [name]
- Remove agent: [name]
- Modify focus areas
```

**WAIT for user confirmation before proceeding to Phase 1.**

---

## Phase 1: Clarification (if needed)

**Goal**: Ensure sufficient context for agents

If task details are ambiguous after Phase 0:
- What is the scope of the implementation?
- Are there existing design documents or decisions?
- What constraints should be considered?

Summarize your understanding before deploying agents.

---

## Phase 2: Agent Deployment

**Goal**: Launch approved agents in parallel

For each selected agent, use the Task tool with:

```
Analyze [specific aspect] for this implementation planning task.

Context: [What you learned in Phase 0-1]

Requirements:
- Create a zettelkasten note documenting your analysis
- Use note_type: "permanent", project: "[project name]"
- Tag appropriately for your specialty
- Return the note ID when complete
```

**Launch all agents in parallel** using multiple Task tool calls in a single message.

---

## Phase 3: Analysis Review

**Goal**: Review agent outputs and identify synthesis points

**Actions**:
1. Wait for all agents to complete
2. Read each agent's note using `zk_get_note`
3. Identify:
   - Points of agreement between agents
   - Points of productive tension
   - Gaps or areas needing clarification
   - Dependencies between recommendations

---

## Phase 4: Hub Note Creation

**Goal**: Create a synthesis hub note

**Create hub note using zk_create_note**:

```markdown
## Overview
[2-3 paragraph synthesis of the planning session]

## Agent Analysis Summary

| Agent | Focus | Key Recommendations | Note |
|-------|-------|--------------------|----|
| [agent] | [focus] | [Brief summary] | reference [[note-id]] |

## Synthesized Implementation Plan

### Phase Sequence
[Reconciled phase plan drawing from agent inputs]

### Key Decisions Required
[Decisions that need user/team input]

### Risk Register
| Risk | Source | Mitigation |
|------|--------|------------|
| [Risk] | [Which agent flagged] | [Proposed mitigation] |

## Tensions & Tradeoffs
[Document productive tensions between agent perspectives]

### Orchestrator Recommendation
[Your synthesis and recommendation]

## Next Steps
- [ ] [Action item]
- [ ] [Action item]

## Linked Documentation
- reference [[agent-note-ids]]
```

**Hub note metadata**:
- note_type: "hub"
- project: [same as agent notes]
- tags: "implementation-plan,hub,synthesis"

---

## Phase 5: Completion

**Actions**:
1. Create links between hub and agent notes using `zk_create_link`
2. Present the hub note to the user
3. Ask if any clarification or additional analysis is needed
