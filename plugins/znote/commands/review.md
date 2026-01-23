---
description: Multi-agent code review with zettelkasten documentation. Spawns code-quality-reviewer and code-detective (always), plus security-reviewer, performance-analyzer, and test-strategist conditionally. Convergent analysis from multiple lenses documented as permanent linked notes.
argument-hint: Files/components to review, or reference to implementation work
---

# Code Review Workflow

You are orchestrating a multi-agent code review session using convergent analysis. Multiple specialists examine the same code from different lenses, then you synthesize findings into a review hub note.

## Core Principles

- **Convergent analysis**: Multiple agents examine code from different perspectives
- **Agents document directly**: Agents create their own zettelkasten notes
- **You synthesize, not duplicate**: Your hub note links to agent work and adds review verdict
- **Parallel execution**: Launch all applicable agents simultaneously
- **Respect agent authority**: You may annotate and link but NEVER modify agent note content

---

## Phase 1: Context Gathering

**Goal**: Identify what needs to be reviewed

**Input**: $ARGUMENTS

**Actions**:
1. Determine review scope:
   - Specific files/components mentioned?
   - Reference to prior implementation work?
   - Full codebase review?
2. Search zettelkasten for related context:
   - Prior implementation plans (related to current review)
   - Previous review findings
   - Known issues or technical debt
3. Determine review type:
   - **Initial review**: New implementation, comprehensive analysis
   - **Polish review**: Later-stage, include security-reviewer
   - **Targeted review**: Specific concerns, include relevant specialists
4. If scope is unclear, ask user for clarification

---

## Phase 2: Agent Deployment

**Goal**: Launch specialist agents in parallel for convergent analysis

### Always Deploy:

**code-quality-reviewer** (znote-workflow)
```
Review the following code for quality, maintainability, and best practices.

Scope: [Files/components to review]
Context: [Any relevant background from Phase 1]

Requirements:
- Create a zettelkasten note documenting your review
- Use note_type: "permanent", project: "[project name]"
- Tag with: code-review, quality, maintainability
- Score each dimension (Readability, Design, Maintainability, Consistency)
- Note cross-domain implications for other reviewers
- Return the note ID when complete
```

**code-detective** (znote-workflow)
```
Investigate the following code for completeness issues: stubs, TODOs, dead code, orphans, misleading comments.

Scope: [Files/components to review]
Context: [Any relevant background from Phase 1]

Requirements:
- Create a zettelkasten note documenting your findings
- Use note_type: "permanent", project: "[project name]"
- Tag with: code-review, completeness, technical-debt, dead-code
- Provide evidence for each finding
- Note verification steps needed for uncertain findings
- Return the note ID when complete
```

### Conditionally Deploy:

**security-reviewer** (znote-workflow) - For polish reviews or security-sensitive code:
```
Review the following code for security vulnerabilities and insecure patterns.

Scope: [Files/components to review]
Context: [Any relevant background from Phase 1]

Requirements:
- Create a zettelkasten note documenting your security assessment
- Use note_type: "permanent", project: "[project name]"
- Tag with: security, code-review, vulnerabilities
- Provide concrete remediation for each finding
- Calibrate severity to actual exploitability
- Return the note ID when complete
```

**performance-analyzer** (existing agent) - For performance-sensitive code:
```
Analyze the following code for performance bottlenecks and optimization opportunities.

Scope: [Files/components to review]
Context: [Any relevant background from Phase 1]

Requirements:
- Create a zettelkasten note documenting your performance analysis
- Use note_type: "permanent", project: "[project name]"
- Tag with: performance, optimization, code-review
- Include complexity analysis where applicable
- Return the note ID when complete
```

**test-strategist** (znote-workflow) - When test coverage is a concern:
```
Assess the test coverage and quality for the following code.

Scope: [Files/components to review]
Context: [Any relevant background from Phase 1]

Requirements:
- Create a zettelkasten note documenting your test assessment
- Use note_type: "permanent", project: "[project name]"
- Tag with: testing, test-strategy, code-review
- Identify behavioral contracts that lack tests
- Flag tests that are brittle or test implementation details
- Return the note ID when complete
```

---

## Phase 3: Analysis Review

**Goal**: Review agent outputs and identify convergent/divergent findings

**Actions**:
1. Wait for all agents to complete
2. Read each agent's note using `zk_get_note`
3. Identify:
   - **Convergent findings**: Issues flagged by multiple agents
   - **Unique insights**: Issues only one agent caught
   - **Cross-domain patterns**: How findings in one domain relate to another
   - **Overall code health**: Synthesize individual assessments

---

## Phase 4: Hub Note Creation

**Goal**: Create a review hub note that synthesizes all findings

**Create hub note using zk_create_note**:

```markdown
## Overview
[2-3 paragraph summary of the code review findings and overall assessment]

## Review Verdict
**Overall**: [Pass / Pass with Issues / Needs Work / Reject]
**Confidence**: [High / Medium / Low]

## Agent Analysis Summary

| Agent | Focus | Severity | Key Findings | Note |
|-------|-------|----------|--------------|------|
| code-quality-reviewer | Quality/Maintainability | [Critical/High/Medium/Low] | [Top 2-3 issues] | reference [[note-id]] |
| code-detective | Completeness | [Critical/High/Medium/Low] | [Top 2-3 issues] | reference [[note-id]] |
| security-reviewer | Security | [Critical/High/Medium/Low] | [Top 2-3 issues] | reference [[note-id]] |
| performance-analyzer | Performance | [Critical/High/Medium/Low] | [Top 2-3 issues] | reference [[note-id]] |
| test-strategist | Testing | [Critical/High/Medium/Low] | [Top 2-3 issues] | reference [[note-id]] |

## Critical Issues
[Issues that must be addressed before merge/deployment]

### Issue 1: [Title]
- **Source**: [Which agent(s)]
- **Location**: [file:line]
- **Impact**: [Why this matters]
- **Resolution**: [What needs to happen]

## Convergent Findings
[Issues identified by multiple agents - higher confidence]

| Finding | Flagged By | Resolution |
|---------|------------|------------|
| [Issue] | [Agent list] | [Brief resolution] |

## Issue Tracker

### Must Fix
- [ ] [Issue with location]
- [ ] [Issue with location]

### Should Fix
- [ ] [Issue with location]
- [ ] [Issue with location]

### Consider
- [ ] [Issue with location]

## Positive Observations
[What's done well - reinforce good patterns]

## Orchestrator Notes
[Your synthesis observations, patterns noticed across agent findings]

## Linked Documentation
- reference [[code-quality-note-id]]
- reference [[code-detective-note-id]]
- reference [[security-reviewer-note-id]] (if applicable)
- reference [[performance-analyzer-note-id]] (if applicable)
- reference [[test-strategist-note-id]] (if applicable)
- related [[implementation-plan-note-id]] (if this reviews a planned implementation)
```

**Hub note metadata**:
- note_type: "hub"
- project: [same as agent notes]
- tags: "code-review,hub,synthesis"

---

## Phase 5: Completion

**Actions**:
1. Create links between hub and agent notes using `zk_create_link`:
   - Hub → each agent note with link_type: "reference"
   - If reviewing a planned implementation, link to the implementation plan
2. Present the hub note to the user with:
   - Clear verdict
   - Priority-ordered action items
   - Offer to help address specific issues
3. Ask if any findings need clarification or deeper analysis
