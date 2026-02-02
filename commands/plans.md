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

1. If input references prior work, search zettelkasten (**use at least 5 different search terms**):
   - Use `zk_search_notes` or `zk_fts_search` to find relevant notes
   - Read related notes to understand current state
   - **Search variations**: Try component names, feature keywords, author names, related concepts, error patterns
2. Review conversation history for additional context
3. Identify the nature of the planning task:
   - Is this a new feature, refactor, migration, or improvement?
   - What systems/components are involved?
   - What concerns matter most (architecture, testing, security, performance)?

### Step 1.5: Classify Task Effort

Based on your assessment, classify this task:

effort_levels[3]{level,criteria,agent_count,output_depth}:
  Quick,Well-defined scope; single component; clear path forward,1-2 agents,Concise notes; focused recommendations
  Standard,Moderate scope; 2-3 components; some design decisions needed,2-4 agents,Thorough analysis; full phase plans
  Deep,Broad scope; many components; significant architectural decisions,4+ agents,Detailed notes with extensive evidence; alternatives explored

Include the classification in your plan presentation to the user.

### Step 2: Select Agents

Reference the **Agent Catalog** (agent-catalog.md) and select agents based on task needs.

**For implementation planning, consider:**

agent_considerations[8]{agent,consider_when}:
  architecture-planner,Almost always — structural planning is core to implementation
  refactor-agent,Improving existing code; technical debt concerns
  api-designer,Designing APIs; integration points
  migration-specialist,Upgrading frameworks; major version changes
  test-strategist,Test coverage is a concern; TDD approach desired
  security-reviewer,Auth flows; data handling; security-sensitive features
  performance-analyzer,Performance-critical paths; scaling concerns
  dependency-auditor,Adding/updating dependencies

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
agent_team[N]{agent,role_in_this_task}:
  [agent],[what they'll focus on]
  ...,...


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

For each selected agent, use the Task tool with this structured dispatch:

```
## Agent Assignment: [Agent Name]

**Memory Continuity**: Before starting your analysis, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags matching your agent specialty
2. Use `zk_fts_search` with key terms from your objective
3. Read any relevant prior notes to build on previous findings
4. Reference prior work in your analysis where applicable: "Building on [[prior-note-id]]..."

**Objective**: [Specific goal — what question must this agent answer?]

**Tools to Prioritize**:
- [Tool 1]: [Why this tool is relevant for this task]
- [Tool 2]: [Why this tool is relevant]

**Source Guidance**:
- Search zettelkasten first: [Specific search terms relevant to this task]
- Examine code: [Specific files, modules, or patterns to focus on]
- External sources: [If applicable — documentation, web]

**Task Boundaries**:
- IN SCOPE: [What this agent should analyze]
- OUT OF SCOPE: [What other agents are handling — avoid duplication]
- If you discover issues outside your scope, add them to your Flags for Investigation section

**Context from Prior Phases**:
[Summarize relevant findings from Phase 0 and Phase 1]

**Requirements**:
- Create a zettelkasten note documenting your analysis
- Use note_type: "permanent", project: "[project name]"
- Tag appropriately for your specialty
- Include a "Flags for Investigation" section for cross-agent concerns
- Append a Self-Assessment section to your note (see below)
- Return the note ID when complete

**Self-Assessment** (required at end of your note):
## Self-Assessment
- **Objective Addressed?**: [Fully / Partially / Minimally] — [brief justification]
- **Confidence**: [High / Medium / Low] — [what supports or undermines confidence]
- **Key Uncertainty**: [What are you least sure about?]
- **Completeness**: [Did you use the suggested tools? Which did you skip and why?]
- **Further Investigation**: [What would you explore with more time?]
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

## Phase 3.5: Flag Review & Cross-Pollination

**Goal**: Handle any flags raised by agents for other agents

### Step 1: Collect Flags

Check each agent's note for "Flags for Investigation" section.

### Step 2: Present Flags to User (if any)

```
## Planning Analysis Complete - Flags Raised

**Analysis Summary**: [Brief overview of agent findings]

**Flags Requiring Follow-up**:
flags[N]{from,for,what_to_investigate,priority}:
  [agent],[target-agent],[specific concern],[Priority]

**Options**:
- Proceed with all flags
- Skip flag: [specify which]
- Add investigation: [describe]
- Skip all flags and continue to synthesis
```

**WAIT for user decision on which flags to pursue.**

### Step 3: Deploy Response Agents (if flags approved)

For each approved flag:

```
Respond to flag from [source-agent] in note [[note-id]].

Read the note and locate the flag in "Flags for Investigation" section.
The specific concern is: "[flag text]"

Create a RESPONSE NOTE:

## Response: [Topic]
**Responding to**: [[note-id]]
**Original Flag**: "[flag text]"
**Flagged by**: [source-agent]
**Priority**: [from flag]

## Investigation
[Your analysis]

## Findings
[What you discovered]

## Resolution
- **Status**: [Addressed/Partially Addressed/Needs Human Review]
- **Action Taken**: [What was done]
- **Remaining Concerns**: [If any]

Use note_type: "permanent", project: "[project]"
Return the note ID when complete.
```

**Note**: Response agents get ONE reply. Make it count.

---

## Phase 4: Hub Note Creation

**Goal**: Create a synthesis hub note

**Create hub note using zk_create_note**:

```markdown
## Overview
[2-3 paragraph synthesis of the planning session]

## Agent Analysis Summary

agent_analysis[N]{agent,focus,key_recommendations,note}:
  [agent],[focus],[Brief summary],reference [[note-id]]

## Synthesized Implementation Plan

### Phase Sequence
[Reconciled phase plan drawing from agent inputs]

### Key Decisions Required
[Decisions that need user/team input]

### Risk Register
risk_register[N]{risk,source,mitigation}:
  [Risk],[Which agent flagged],[Proposed mitigation]

## Tensions & Tradeoffs
[Document productive tensions between agent perspectives]

### Orchestrator Recommendation
[Your synthesis and recommendation]

## Next Steps
- [ ] [Action item]
- [ ] [Action item]

## Linked Documentation
- reference [[agent-note-ids]]

## Cross-Pollination (if flags were processed)
cross_pollination[N]{flag,from,to,response_note,resolution}:
  [concern],[source],[target],[[response-note-id]],[Addressed/Needs Review]
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
