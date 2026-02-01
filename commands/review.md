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
2. Search zettelkasten for related context (**use at least 5 different search terms**):
   - Prior implementation plans
   - Previous review findings
   - Known issues or technical debt
   - **Search variations**: Try synonyms, component names, error patterns, author terms, date ranges
3. Analyze the code to understand its characteristics:
   - What domain is it? (API, UI, data processing, etc.)
   - Is it security-sensitive? (auth, payments, user data)
   - Is it performance-critical? (hot paths, large data)
   - How well-tested does it appear?

### Step 1.5: Classify Review Effort

Based on your assessment, classify this review:

| Level | Criteria | Reviewer Count | Review Depth |
|-------|----------|----------------|--------------|
| **Quick** | Single file or small change, narrow concern | 1-2 reviewers | Targeted review, focused findings |
| **Standard** | Module or feature scope, multiple concerns | 2-4 reviewers | Full convergent review, severity scoring |
| **Deep** | System-wide changes, architectural impact, security-sensitive | 4+ reviewers | Exhaustive analysis, cross-domain patterns, regression assessment |

Include the classification in your plan presentation to the user.

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

For each selected reviewer, use the Task tool with this structured dispatch:

```
## Agent Assignment: [Reviewer Name]

**Memory Continuity**: Before starting your review, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags matching your reviewer specialty
2. Use `zk_fts_search` with key terms from the review scope
3. Read any relevant prior notes — past reviews of the same code, known issues
4. Reference prior work in your review where applicable: "Building on [[prior-note-id]]..."

**Objective**: [Specific review focus — what aspects of the code should this reviewer examine?]

**Review Scope**: [Files/components to review]

**Tools to Prioritize**:
- [Tool 1]: [Why this tool is relevant for this review]
- [Tool 2]: [Why this tool is relevant]

**Source Guidance**:
- Search zettelkasten first: [Prior reviews, known issues, related implementation notes]
- Examine code: [Specific files, patterns, or modules to focus on]
- Check tests: [Related test files to assess coverage]

**Task Boundaries**:
- IN SCOPE: [What this reviewer should examine — their domain lens]
- OUT OF SCOPE: [What other reviewers are covering — avoid duplication]
- If you discover issues outside your scope, add them to your Flags for Investigation section

**Context from Prior Phases**:
[Summarize relevant findings from Phase 0 and Phase 1]

**Requirements**:
- Create a zettelkasten note documenting your review
- Use note_type: "permanent", project: "[project name]"
- Tag appropriately for your specialty
- Score severity of findings (Critical / High / Medium / Low)
- Include a "Flags for Investigation" section for cross-reviewer concerns
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

## Phase 3.5: Flag Review & Cross-Pollination

**Goal**: Handle any flags raised by reviewers for other agents

### Step 1: Collect Flags

Check each reviewer's note for "Flags for Investigation" section.

### Step 2: Present Flags to User (if any)

```
## Review Analysis Complete - Flags Raised

**Review Summary**: [Brief overview - overall health, critical issues found]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| code-detective | test-strategist | "[specific concern]" | [Priority] |
| security-reviewer | performance-analyzer | "[specific concern]" | [Priority] |

**Options**:
- Proceed with all flags (before synthesis)
- Skip flag: [specify which]
- Add investigation: [describe additional concern]
- Skip all flags and continue to synthesis
```

**WAIT for user decision on which flags to pursue.**

### Step 3: Deploy Response Agents (if flags approved)

For each approved flag:

```
Respond to flag from [source-reviewer] in note [[note-id]].

Read the note and locate the flag in "Flags for Investigation" section.
The specific concern is: "[flag text]"

Create a RESPONSE NOTE:

## Response: [Topic]
**Responding to**: [[note-id]]
**Original Flag**: "[flag text]"
**Flagged by**: [source-reviewer]
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

## Cross-Pollination (if flags were processed)
| Flag | From | To | Response Note | Resolution |
|------|------|----|---------------|------------|
| [concern] | [source] | [target] | [[response-note-id]] | [Addressed/Needs Review] |
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
