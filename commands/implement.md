---
description: Agent-driven phased implementation from a plan note. Dispatches gate-keeper, feature-implementer, and test-scaffolder agents to write code according to plan phases with verification gates.
argument-hint: Plan note ID or search term to find the plan
---

# Implementation Workflow

You are orchestrating an agent-driven implementation session. Your job is to take a plan hub note, define verification gates, then dispatch agents to write code phase by phase.

## Core Principles

- **Plan-first**: Implementation follows a plan hub note from `/znote:plans`
- **Gate before code**: Verification criteria are defined BEFORE implementation begins
- **Agents write code**: Implementation agents write actual files to disk, not just notes
- **Phased execution**: Phases execute sequentially; parallelism happens WITHIN phases
- **Self-validation**: Agents run gate checks before reporting completion

---

## Phase 0: Plan Ingestion & Strategy

**Goal**: Read the plan, extract phases, and establish execution mode

### Step 1: Locate the Plan

**Input**: $ARGUMENTS

1. If input is a note ID, read it directly with `zk_get_note`
2. If input is a search term, search zettelkasten (**use at least 5 different search terms**):
   - Use `zk_search_notes` with tags: "implementation-plan", "hub", "planning"
   - Use `zk_fts_search` with the search term and variations
   - Present matching plans to user if multiple found
3. If no plan is found, inform the user: "No plan found. Run `/znote:plans` first to create one."
   - Do NOT proceed without a plan — this command requires one

### Step 2: Parse the Plan

Read the plan hub note AND all linked agent analysis notes. Extract:
- **Phase sequence**: The ordered list of implementation phases
- **Architectural decisions**: Constraints and design choices from architecture-planner
- **Risk register**: Items that affect implementation approach
- **Test strategy**: Recommendations from test-strategist (if present)
- **Agentic workflow opportunities**: Multi-agent recommendations from plan-reviewer (if present)

### Step 3: Present Execution Strategy

```
## Implementation Strategy

**Plan**: [[plan-note-id]] — [plan title]
**Phases**: [N] phases identified

### Phase Breakdown
phases[N]{num,name,description,scope}:
  1,[name],[brief description],[files/components affected]
  ...

### Execution Mode
How should phases proceed?
- **Continuous**: Auto-proceed through phases, stop only on gate failure
- **Gated**: Pause after each phase for your approval before continuing
- **Adaptive**: Start gated — you can say "continue through the rest" at any checkpoint

### Key Constraints
[Architectural decisions, risks, or constraints from the plan]
```

**WAIT for user to choose execution mode and approve before proceeding.**

---

## Phase 1: Gate Definition

**Goal**: Define verification criteria for ALL phases before any code is written

### Step 1: Dispatch Gate-Keeper

Launch **gate-keeper** with a single Task call covering all phases:

```
## Agent Assignment: gate-keeper

**Memory Continuity**: Before starting, search zettelkasten for:
1. Prior verification patterns: `zk_search_notes` with tags "gate", "verification"
2. Project testing conventions: `zk_fts_search` with "test", "verification", "CI"

**Objective**: Define deterministic verification criteria for each of the following implementation phases. Create ONE note per phase.

**Plan Reference**: [[plan-hub-note-id]]

**Phases to define gates for**:
[List each phase with its description, scope, and relevant architectural decisions]

**Context**:
- Risk register items: [list relevant risks]
- Test strategy notes: [summarize test-strategist recommendations if present]
- Key constraints: [architectural decisions that affect verification]

**Requirements**:
- Create one zettelkasten note per phase
- Each note must contain runnable verification commands
- Inspect the actual codebase to calibrate checks
- Include regression guards for existing test suites
- Define explicit scope boundaries per phase
- Use note_type: "permanent", project: "[project name]"
- Tag each note: "gate,verification,[phase-domain]"
- Return ALL note IDs when complete
```

### Step 2: Review Gate Notes

After gate-keeper completes:
1. Read each gate note with `zk_get_note`
2. Present a summary to the user:

```
## Verification Gates Defined

| Phase | Checks | Key Verifications |
|-------|--------|-------------------|
| [Phase 1] | [N checks] | [brief list: build, test, lint, etc.] |
| [Phase 2] | [N checks] | [brief list] |

### Regression Baseline
[Current test status captured by gate-keeper]

### Notable Criteria
[Any particularly important or stringent checks worth highlighting]
```

**In gated/adaptive mode**: Wait for user approval of gates.
**In continuous mode**: Proceed automatically unless gate-keeper flagged issues.

---

## Phase 2: Phased Implementation

**Goal**: Execute each phase with appropriate agents

For each phase in sequence:

### Step 2.1: Decompose for Multi-Agent Opportunities

Analyze the current phase:
- Can feature code and test code be written in parallel? → feature-implementer + test-scaffolder
- Can the phase be split into independent modules? → multiple feature-implementer instances
- Does the phase have a single focused deliverable? → single feature-implementer

**Default decomposition**: If the phase includes both implementation and testing concerns, dispatch feature-implementer + test-scaffolder in parallel.

### Step 2.2: Dispatch Implementation Agents

For each agent in this phase, use the Task tool with this structured dispatch:

**For feature-implementer:**
```
## Agent Assignment: feature-implementer

**Memory Continuity**: Before starting, search zettelkasten for:
1. Prior implementation notes: `zk_search_notes` with tags "implementation", "phase"
2. Related code patterns: `zk_fts_search` with key terms from this phase

**Objective**: Implement Phase [N]: [phase name]

**Plan Phase Description**:
[Full description of what needs to be built]

**Architectural Decisions**:
[Relevant decisions from the plan]

**Gate-Keeper Verification Criteria** (from [[gate-note-id]]):
[Paste or reference the Required Checks and Scope Boundary]

**Prior Phase Outputs** (if not Phase 1):
[Summary of what was built in earlier phases — file paths, key symbols]

**Task Boundaries**:
- IN SCOPE: [What the gate note says is in scope]
- OUT OF SCOPE: [What the gate note says is out of scope]

**Requirements**:
- Write production code to disk
- Self-validate against ALL gate-keeper checks before completing
- Create a phase note documenting changes
- Use note_type: "permanent", project: "[project name]"
- Tag: "implementation,phase,[phase-domain]"
- Return the note ID when complete

**Self-Assessment** (required at end of your note):
## Self-Assessment
- **Gate Results**: [All pass / N of M pass — details]
- **Confidence**: [High / Medium / Low] — [justification]
- **Scope Adherence**: [Stayed in scope / Minor deviation — explain]
```

**For test-scaffolder** (when dispatched in parallel):
```
## Agent Assignment: test-scaffolder

**Memory Continuity**: Before starting, search zettelkasten for:
1. Prior test notes: `zk_search_notes` with tags "testing"
2. Test patterns: `zk_fts_search` with "test", "fixture", project-specific terms

**Objective**: Write tests for Phase [N]: [phase name]

**Plan Phase Description**:
[Full description — focus on the interface/behavior being added]

**Gate-Keeper Test Criteria** (from [[gate-note-id]]):
[Paste test-related checks from the gate note]

**Test Strategy Notes** (if available):
[Recommendations from test-strategist in the plan]

**Task Boundaries**:
- Write tests for the behavior defined in this phase
- Follow existing test conventions
- Tests may initially fail if feature code isn't written yet — that's expected

**Requirements**:
- Write test files to disk
- Create a note documenting tests written
- Use note_type: "permanent", project: "[project name]"
- Tag: "testing,implementation,[phase-domain]"
- Return the note ID when complete
```

**Launch parallel agents in a single message** with multiple Task tool calls.

### Step 2.3: Verify Phase Completion

After all agents for this phase complete:

1. Read each agent's phase note with `zk_get_note`
2. **Run gate-keeper checks independently** — do NOT rely solely on agent self-reporting:
   ```bash
   # Run each Required Check from the gate note
   [command 1]
   [command 2]
   # Run Regression Guard
   [regression command]
   ```
3. Record the orchestrator-verified results

### Step 2.4: Create Phase Record

Create a zettelkasten note for this phase:

```markdown
## Phase [N]: [Phase name]
**Status**: [Complete / Partial / Failed]
**Agents Dispatched**: [list with note IDs]
**Gate Note**: [[gate-note-id]]

## Agent Outputs
agent-outputs[N]{agent,note,status,self-assessment}:
  [agent],[[note-id]],[Complete/Partial],[summary]

## Orchestrator Verification
orchestrator-checks[N]{num,check,agent-result,orchestrator-result,match}:
  1,[check],[Pass/Fail],[Pass/Fail],[Yes/No]

## Files Changed (Aggregate)
files-changed[N]{file,action,by-agent}:
  [path],[Created/Modified],[agent]

## Phase Summary
[Brief narrative: what was accomplished, any issues encountered]
```

- note_type: "permanent"
- project: [same as plan]
- tags: "implementation,phase-record,[phase-domain]"

### Step 2.5: Gate Decision

**All checks pass**:
- Continuous mode → proceed to next phase automatically
- Gated mode → present results and wait for approval
- Adaptive mode → present results, ask "Continue to next phase, or pause?"

**Some checks fail**:
- Present the failures clearly
- Options:
  1. Re-dispatch the failing agent with failure context (up to 2 retries)
  2. Skip this check and proceed (user must explicitly approve)
  3. Stop implementation and escalate

**Critical failure** (regression guard failures, build broken):
- Stop immediately regardless of execution mode
- Present full context
- Ask user how to proceed

---

## Phase 3: Implementation Record

**Goal**: Create the hub note and close the loop

### Step 1: Create Implementation Hub Note

```markdown
## Overview
[2-3 paragraph summary: what plan was implemented, how many phases, overall result]

## Source Plan
**Plan**: [[plan-hub-note-id]]
**Phases Planned**: [N]
**Phases Completed**: [M]
**Execution Mode**: [Continuous / Gated / Adaptive]

## Phase Summary
phase-summary[N]{phase,status,agents,files-changed,gate-result}:
  [name],[Complete/Partial/Skipped],[agents],[count],[Pass/Fail]

## Linked Notes
phase-records[N]{phase,note}:
  Phase 1,[[phase-record-note-id]]
  Phase 2,[[phase-record-note-id]]

gate-notes[N]{phase,note}:
  Phase 1,[[gate-note-id]]
  Phase 2,[[gate-note-id]]

agent-phase-notes[N]{note}:
  [[feature-implementer-phase-1-note-id]]
  [[test-scaffolder-phase-1-note-id]]
  ...

## Aggregate Changes
aggregate-changes[N]{metric,count}:
  Files created,[n]
  Files modified,[n]
  Tests added,[n]
  Total lines changed,[+/-]

## Plan Deviations
[Summary of any differences between plan and actual implementation]

## Suggested Next Steps
- [ ] Run `/znote:review` to review the implementation
- [ ] [Any follow-up items from agent flags]
- [ ] [Any deferred scope items]
```

- note_type: "hub"
- project: [same as plan]
- tags: "implementation,hub,[project-domain]"

### Step 2: Create Links

Use `zk_create_link` to connect:
1. Implementation hub ↔ Plan hub (bidirectional)
2. Implementation hub → each phase record note
3. Implementation hub → each gate note
4. Phase record notes → corresponding agent phase notes
5. Phase record notes → corresponding gate notes

### Step 3: Present Results

Present the implementation hub note to the user with:
- Overall status summary
- Aggregate change count
- Any flags or deviations worth noting
- The suggestion to run `/znote:review`
