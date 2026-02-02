---
description: Multi-agent debugging session with zettelkasten documentation. Dynamically selects investigators based on bug characteristics, presents plan for user approval, then executes parallel investigation.
argument-hint: Bug description, symptoms, or reference to failing behavior
---

# Debugging Workflow

You are orchestrating a multi-agent debugging session. Your job is to characterize the bug, select appropriate investigators, get user approval, then coordinate parallel investigation.

## Core Principles

- **Dynamic selection**: Choose investigators based on bug characteristics
- **User collaboration**: Present your plan and get approval before executing
- **Document the journey**: Future bugs may relate; capture the investigation
- **Agents document directly**: Agents create their own zettelkasten notes

---

## Phase 0: Bug Assessment & Agent Selection

**Goal**: Understand the bug and propose an investigation team

### Step 1: Characterize the Bug

**Input**: $ARGUMENTS

1. Gather bug profile:
   - **Symptom**: What's the observable behavior?
   - **Expected**: What should happen?
   - **Reproducibility**: Always? Intermittent? Under what conditions?
   - **Context**: When did this start? What changed?

2. Search existing knowledge (**use at least 5 different search terms**):
   - `zk_search_notes` for similar past bugs
   - `zk_fts_search` for error messages or symptoms
   - Check if this has been investigated before
   - **Search variations**: Try error codes, stack trace fragments, component names, symptom descriptions, related feature names

3. Analyze bug characteristics:
   - Is it deterministic or intermittent?
   - Does it seem like logic error, configuration, or external?
   - Is it potentially a known library/framework issue?
   - Are there test gaps that should have caught this?

### Step 1.5: Classify Investigation Effort

Based on your assessment, classify this investigation:

effort-levels[3]{Level,Criteria,Investigator Count,Investigation Depth}:
  **Quick**,Reproducible bug; narrow scope; likely single cause,1-2 investigators,Targeted investigation; direct fix
  **Standard**,Intermittent or multi-component; several hypotheses,2-3 investigators,Systematic investigation; hypothesis testing
  **Deep**,Systemic issue; multiple possible root causes; architectural implications,3+ investigators,Exhaustive analysis; cross-domain exploration; prevention measures

Include the classification in your plan presentation to the user.

### Step 2: Select Agents

Reference the **Agent Catalog** (agent-catalog.md) and select investigators based on bug characteristics.

**For debugging, consider:**

agents[7]{Agent,Consider When}:
  systematic-debugger,Almost always—rigorous methodology is valuable
  lateral-debugger,Bug defies explanation; conventional approaches failed
  docs-investigator,Might be documented behavior; library issue
  test-strategist,Want regression tests; test gaps enabled bug
  performance-analyzer,Performance-related symptoms
  code-detective,Suspect incomplete implementation; hidden issues
  security-reviewer,Security-related symptoms

**Selection guidelines:**
- 2-3 investigators is typical for debugging
- systematic-debugger is usually valuable
- lateral-debugger helps when stuck or counterintuitive
- docs-investigator is key when library behavior is suspect

### Step 3: Present Plan to User

Before proceeding, present your proposed approach:

```
## Investigation Approach

**Bug Profile**:
- Symptom: [what's happening]
- Expected: [what should happen]
- Reproducibility: [conditions]

**Proposed Investigation Team**:
team[N]{Investigator,Approach}:
  [agent],[what they'll investigate]
  ...,...

**Why This Team**: [Brief reasoning]

**Alternative Investigators Available**: [list any you considered but didn't select]

---

Would you like to:
- Approve this approach
- Add investigator: [name]
- Remove investigator: [name]
- Modify investigation focus
```

**WAIT for user confirmation before proceeding to Phase 1.**

---

## Phase 1: Additional Context (if needed)

**Goal**: Gather more information if needed

If bug details are incomplete:
- Can you reproduce it consistently?
- What have you already tried?
- When did you first notice this?
- What changed recently?

---

## Phase 2: Agent Deployment

**Goal**: Launch approved investigators in parallel

For each selected investigator, use the Task tool with this structured dispatch:

```
## Agent Assignment: [Investigator Name]

**Memory Continuity**: Before starting your investigation, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags matching your investigator specialty (e.g., "debugging", "root-cause")
2. Use `zk_fts_search` with key terms from the bug profile — error messages, component names
3. Read any relevant prior notes — past bugs in the same area, related investigations
4. Reference prior work in your investigation where applicable: "Building on [[prior-note-id]]..."

**Objective**: [Specific investigation angle — what hypothesis or approach should this investigator pursue?]

**Bug Profile**:
- Symptom: [What's happening]
- Expected: [What should happen]
- Reproducibility: [Conditions]
- Context: [When it started, what changed]

**Tools to Prioritize**:
- [Tool 1]: [Why this tool is relevant for this investigation]
- [Tool 2]: [Why this tool is relevant]

**Source Guidance**:
- Search zettelkasten first: [Prior bugs, related components, known issues]
- Examine code: [Files/components likely involved, specific functions to trace]
- Test evidence: [Relevant test files, failing test output]

**Task Boundaries**:
- IN SCOPE: [What this investigator should explore — their approach angle]
- OUT OF SCOPE: [What other investigators are covering — avoid duplication]
- If you discover issues outside your scope, add them to your Flags for Investigation section

**Context from Prior Phases**:
[Summarize relevant findings from Phase 0 and Phase 1]

**Requirements**:
- Create a zettelkasten note documenting your investigation
- Use note_type: "permanent", project: "[project name]"
- Tag with: debugging, investigation, [approach-tag]
- Include a "Flags for Investigation" section for cross-investigator concerns
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

**Launch all investigators in parallel** using multiple Task tool calls in a single message.

---

## Phase 3: Analysis Synthesis

**Goal**: Synthesize findings into diagnosis

**Actions**:
1. Wait for all investigators to complete
2. Read each investigator's note using `zk_get_note`
3. Cross-reference findings:
   - Do different approaches converge on same root cause?
   - Did docs-investigator find this is known/documented?
   - Are there conflicting hypotheses?
4. Identify most likely root cause with supporting evidence

---

## Phase 3.5: Flag Review & Cross-Pollination

**Goal**: Handle any flags raised by investigators for other agents

### Step 1: Collect Flags

Check each investigator's note for "Flags for Investigation" section.

### Step 2: Present Flags to User (if any)

```
## Investigation Complete - Flags Raised

**Investigation Summary**: [Root cause hypothesis and confidence]

**Flags Requiring Follow-up**:
flags[N]{From,For,What to Investigate,Priority}:
  systematic-debugger,test-strategist,"[e.g.; needs regression test for this bug class]",[Priority]
  lateral-debugger,security-reviewer,"[e.g.; edge case might have security implications]",[Priority]

**Options**:
- Proceed with all flags (before creating hub note)
- Skip flag: [specify which]
- Add investigation: [describe additional concern]
- Skip all flags and continue to synthesis
```

**WAIT for user decision on which flags to pursue.**

### Step 3: Deploy Response Agents (if flags approved)

For each approved flag, deploy the target agent with the Response Note format.

**Note**: Response agents get ONE reply. Make it count.

---

## Phase 4: Hub Note Creation

**Goal**: Create a debugging session hub note

**Create hub note using zk_create_note**:

```markdown
## Bug Summary
**Symptom**: [Observable behavior]
**Expected**: [Correct behavior]
**Severity**: [Critical/High/Medium/Low]
**Resolution Status**: [Diagnosed/Fixed/Workaround/Unresolved]

## Investigation Summary

investigation[N]{Investigator,Approach,Key Finding,Note}:
  [agent],[approach],[Key insight],reference [[note-id]]

## Root Cause Analysis

### Identified Root Cause
**What**: [Technical description]
**Where**: [file:line or component]
**Why**: [Mechanism explanation]

### Evidence
- [Evidence 1]
- [Evidence 2]

### Confidence Level
[High/Medium/Low] — [Why this confidence level]

## Resolution

### Fix Applied
[Description of fix, or "Not yet fixed"]

### Verification
- [ ] Fix addresses root cause, not just symptom
- [ ] No regression in related functionality
- [ ] Edge cases considered

### Alternative Approaches Considered
[From investigators' alternative framings]

## Broader Implications

### Similar Code Patterns
[Where else this bug class might exist]

### Prevention Measures
[What would prevent similar bugs]

## Linked Documentation
- reference [[investigator-note-ids]]
- related [[prior-similar-bug]] (if found)

## Cross-Pollination (if flags were processed)
cross-pollination[N]{Flag,From,To,Response Note,Resolution}:
  [concern],[source],[target],[[response-note-id]],[Addressed/Needs Review]
```

**Hub note metadata**:
- note_type: "hub"
- project: [relevant project]
- tags: "debugging,hub,bug-fix"

---

## Phase 5: Resolution

**Actions**:
1. If root cause is identified:
   - Propose fix to user
   - After fix, update hub note

2. If root cause is uncertain:
   - Present competing hypotheses
   - Recommend experiments to distinguish
   - Update hub note with current state

3. Create links using `zk_create_link`:
   - Hub → each investigator note
   - Link to prior related bugs if found

4. Present to user:
   - Diagnosis summary
   - Fix recommendation
   - Confidence level
   - Outstanding questions
