---
description: Multi-agent code review with zettelkasten documentation. Dynamically selects reviewers based on code characteristics, presents plan for user approval, then executes convergent analysis.
argument-hint: Files/components to review, or reference to implementation work
---

# Code Review Workflow

You are orchestrating a multi-agent code review session. Your job is to assess what kind of review is needed, select appropriate reviewers, get user approval, then coordinate convergent analysis.

## Core Principles

- **Dynamic selection**: Choose reviewers based on actual code characteristics
- **User collaboration**: Present your plan and get approval before executing
- **Convergent analysis**: Multiple agents examine code from different perspectives
- **Agents document directly**: Agents create their own zettelkasten notes

---

## Phase 0: Task Assessment & Agent Selection

**Goal**: Understand what's being reviewed and propose a review team

### Step 1: Gather Context

**Input**: $ARGUMENTS

1. Determine review scope:
   - Specific files/components mentioned?
   - Reference to prior implementation work?
   - Full codebase review?
2. Search zettelkasten for related context:
   - Prior implementation plans
   - Previous review findings
   - Known issues or technical debt
3. Analyze the code to understand its characteristics:
   - What domain is it? (API, UI, data processing, etc.)
   - Is it security-sensitive? (auth, payments, user data)
   - Is it performance-critical? (hot paths, large data)
   - How well-tested does it appear?

### Step 2: Select Agents

Reference the **Agent Catalog** (agent-catalog.md) and select reviewers based on code characteristics.

**For code review, consider:**

| Agent | Consider When |
|-------|---------------|
| code-quality-reviewer | Almost always—core quality perspective |
| code-detective | Checking for completeness, hidden debt |
| code-simplifier | Polish pass, complexity reduction |
| security-reviewer | Auth flows, data handling, user input |
| performance-analyzer | Hot paths, algorithms, resource usage |
| test-strategist | Test coverage concerns, brittle tests |
| dependency-auditor | New/updated dependencies |
| api-designer | API changes, contract review |

**Selection guidelines:**
- 2-4 reviewers is typical
- code-quality-reviewer + code-detective is a solid baseline
- Add specialists based on code characteristics
- Polish reviews benefit from code-simplifier

### Step 3: Present Plan to User

Before proceeding, present your proposed approach:

```
## Review Approach

**Scope**: [What's being reviewed]
**Code Characteristics**: [What you noticed about the code]

**Proposed Review Team**:
| Reviewer | Focus Area |
|----------|------------|
| [agent] | [what they'll examine] |
| ... | ... |

**Review Type**: [Initial / Polish / Targeted / Security-focused]

**Alternative Reviewers Available**: [list any you considered but didn't select]

---

Would you like to:
- Approve this approach
- Add reviewer: [name]
- Remove reviewer: [name]
- Change focus areas
```

**WAIT for user confirmation before proceeding to Phase 1.**

---

## Phase 1: Clarification (if needed)

**Goal**: Ensure sufficient context for reviewers

If scope is unclear after Phase 0:
- Which specific files or components?
- What level of detail is needed?
- Any known concerns to focus on?

---

## Phase 2: Agent Deployment

**Goal**: Launch approved reviewers in parallel for convergent analysis

For each selected reviewer, use the Task tool with:

```
Review the following code for [specific focus area].

Scope: [Files/components to review]
Context: [What you learned in Phase 0-1]

Requirements:
- Create a zettelkasten note documenting your review
- Use note_type: "permanent", project: "[project name]"
- Tag appropriately for your specialty
- Score severity of findings
- Return the note ID when complete
```

**Launch all reviewers in parallel** using multiple Task tool calls in a single message.

---

## Phase 3: Analysis Review

**Goal**: Review agent outputs and identify patterns

**Actions**:
1. Wait for all reviewers to complete
2. Read each reviewer's note using `zk_get_note`
3. Identify:
   - **Convergent findings**: Issues flagged by multiple reviewers
   - **Unique insights**: Issues only one reviewer caught
   - **Cross-domain patterns**: How findings relate across domains
   - **Overall code health**: Synthesize assessments

---

## Phase 4: Hub Note Creation

**Goal**: Create a review hub note synthesizing all findings

**Create hub note using zk_create_note**:

```markdown
## Overview
[2-3 paragraph summary of review findings]

## Review Verdict
**Overall**: [Pass / Pass with Issues / Needs Work / Reject]
**Confidence**: [High / Medium / Low]

## Reviewer Analysis Summary

| Reviewer | Focus | Severity | Key Findings | Note |
|----------|-------|----------|--------------|------|
| [agent] | [focus] | [Critical/High/Medium/Low] | [Top issues] | reference [[note-id]] |

## Critical Issues
[Issues that must be addressed]

### Issue 1: [Title]
- **Source**: [Which reviewer(s)]
- **Location**: [file:line]
- **Impact**: [Why this matters]
- **Resolution**: [What needs to happen]

## Convergent Findings
[Issues identified by multiple reviewers]

| Finding | Flagged By | Resolution |
|---------|------------|------------|
| [Issue] | [Reviewer list] | [Brief resolution] |

## Issue Tracker

### Must Fix
- [ ] [Issue with location]

### Should Fix
- [ ] [Issue with location]

### Consider
- [ ] [Issue with location]

## Positive Observations
[What's done well]

## Linked Documentation
- reference [[reviewer-note-ids]]
```

**Hub note metadata**:
- note_type: "hub"
- project: [same as reviewer notes]
- tags: "code-review,hub,synthesis"

---

## Phase 5: Completion

**Actions**:
1. Create links between hub and reviewer notes using `zk_create_link`
2. Present the hub note with:
   - Clear verdict
   - Priority-ordered action items
   - Offer to help address specific issues
3. Ask if any findings need clarification or deeper analysis
