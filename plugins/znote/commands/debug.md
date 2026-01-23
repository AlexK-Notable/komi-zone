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

2. Search existing knowledge:
   - `zk_search_notes` for similar past bugs
   - `zk_fts_search` for error messages or symptoms
   - Check if this has been investigated before

3. Analyze bug characteristics:
   - Is it deterministic or intermittent?
   - Does it seem like logic error, configuration, or external?
   - Is it potentially a known library/framework issue?
   - Are there test gaps that should have caught this?

### Step 2: Select Agents

Reference the **Agent Catalog** (agent-catalog.md) and select investigators based on bug characteristics.

**For debugging, consider:**

| Agent | Consider When |
|-------|---------------|
| systematic-debugger | Almost always—rigorous methodology is valuable |
| lateral-debugger | Bug defies explanation, conventional approaches failed |
| docs-investigator | Might be documented behavior, library issue |
| test-strategist | Want regression tests, test gaps enabled bug |
| performance-analyzer | Performance-related symptoms |
| code-detective | Suspect incomplete implementation, hidden issues |
| security-reviewer | Security-related symptoms |

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
| Investigator | Approach |
|--------------|----------|
| [agent] | [what they'll investigate] |
| ... | ... |

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

For each selected investigator, use the Task tool with:

```
Investigate this bug using [your specific approach].

Bug Profile:
- Symptom: [What's happening]
- Expected: [What should happen]
- Reproducibility: [Conditions]
- Context: [When it started, what changed]

Scope: [Files/components likely involved]

Requirements:
- Create a zettelkasten note documenting your investigation
- Use note_type: "permanent", project: "[project name]"
- Tag with: debugging, investigation, [approach-tag]
- Return the note ID when complete
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

| Investigator | Approach | Key Finding | Note |
|--------------|----------|-------------|------|
| [agent] | [approach] | [Key insight] | reference [[note-id]] |

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
