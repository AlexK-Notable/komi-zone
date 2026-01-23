---
description: Multi-agent debugging session with zettelkasten documentation. Spawns lateral-debugger (unconventional thinking), systematic-debugger (rigorous methodology), and docs-investigator (checks existing knowledge). Documents the debugging journey for future reference.
argument-hint: Bug description, symptoms, or reference to failing behavior
---

# Debugging Workflow

You are orchestrating a multi-agent debugging session. This workflow combines systematic methodology with lateral thinking and documentation research to investigate bugs from multiple angles simultaneously.

## Core Principles

- **Document the journey**: Future bugs may relate; capture the investigation
- **Three perspectives**: Systematic rigor + lateral thinking + documentation research
- **Agents document directly**: Agents create their own zettelkasten notes
- **You synthesize**: Your hub note captures the diagnosis and resolution
- **Parallel execution**: Launch all agents simultaneously for faster diagnosis

---

## Phase 1: Bug Characterization

**Goal**: Understand the bug well enough to direct investigation

**Input**: $ARGUMENTS

**Actions**:
1. Gather bug profile:
   - **Symptom**: What's the observable behavior?
   - **Expected**: What should happen?
   - **Reproducibility**: Always? Intermittent? Under what conditions?
   - **Context**: When did this start? What changed?

2. Search existing knowledge:
   - `zk_search_notes` for similar past bugs
   - `zk_fts_search` for error messages or symptoms
   - Check if this has been investigated before

3. Identify investigation scope:
   - Which files/components are likely involved?
   - What dependencies might be relevant?
   - Are there related features that work correctly?

4. If bug is unclear, ask user:
   - Can you reproduce it consistently?
   - What have you already tried?
   - When did you first notice this?

---

## Phase 2: Agent Deployment

**Goal**: Launch debugging specialists in parallel

### Always Deploy:

**lateral-debugger** (existing agent)
```
Investigate this bug using unconventional approaches and lateral thinking.

Bug Profile:
- Symptom: [What's happening]
- Expected: [What should happen]
- Reproducibility: [Conditions]
- Context: [When it started, what changed]

Scope: [Files/components likely involved]

Requirements:
- Challenge fundamental assumptions about what's happening
- Generate 3-5 radically different framings of the problem
- Create a zettelkasten note documenting your analysis
- Use note_type: "permanent", project: "[project name]"
- Tag with: debugging, lateral-thinking, investigation
- Return the note ID when complete
```

**systematic-debugger** (znote-workflow)
```
Investigate this bug using rigorous systematic methodology.

Bug Profile:
- Symptom: [What's happening]
- Expected: [What should happen]
- Reproducibility: [Conditions]
- Context: [When it started, what changed]

Scope: [Files/components likely involved]

Requirements:
- Form testable hypotheses
- Design experiments to distinguish between hypotheses
- Document evidence trail systematically
- Create a zettelkasten note documenting your investigation
- Use note_type: "permanent", project: "[project name]"
- Tag with: debugging, root-cause, investigation
- Return the note ID when complete
```

**docs-investigator** (znote-workflow)
```
Research whether this bug behavior is documented or known.

Bug Profile:
- Symptom: [What's happening]
- Expected: [What should happen]
- Technologies involved: [Libraries, frameworks, etc.]

Requirements:
- Search our zettelkasten for prior knowledge
- Check library documentation via context7
- Search for known issues in dependencies
- Create a zettelkasten note documenting your research
- Use note_type: "permanent", project: "[project name]"
- Tag with: documentation, research, investigation
- Include verdict: Documented Behavior / Known Issue / Novel Issue / Unclear
- Return the note ID when complete
```

### Conditionally Deploy:

**test-strategist** (znote-workflow) - When investigation reveals test gaps:
```
Design tests that would have caught this bug and will prevent regression.

Bug Profile: [Summary]
Root Cause: [If identified by other agents]

Requirements:
- Create a zettelkasten note documenting test recommendations
- Use note_type: "permanent", project: "[project name]"
- Tag with: testing, debugging, regression-prevention
- Focus on behavioral contracts, not implementation
- Return the note ID when complete
```

---

## Phase 3: Analysis Synthesis

**Goal**: Synthesize agent findings into diagnosis

**Actions**:
1. Wait for all agents to complete
2. Read each agent's note using `zk_get_note`
3. Cross-reference findings:
   - Do systematic and lateral approaches converge on same root cause?
   - Did docs-investigator find this is known/documented?
   - Are there conflicting hypotheses that need resolution?
4. Identify the most likely root cause with supporting evidence

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

| Agent | Approach | Key Finding | Note |
|-------|----------|-------------|------|
| lateral-debugger | Unconventional | [Key insight] | reference [[note-id]] |
| systematic-debugger | Methodical | [Key finding] | reference [[note-id]] |
| docs-investigator | Documentation | [Verdict] | reference [[note-id]] |
| test-strategist | Testing | [If invoked] | reference [[note-id]] |

## Root Cause Analysis

### Identified Root Cause
**What**: [Technical description]
**Where**: [file:line or component]
**Why**: [Mechanism explanation]

### Evidence
- [Evidence 1 from systematic investigation]
- [Evidence 2 from lateral thinking]
- [Documentation findings if relevant]

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
[From lateral-debugger's alternative framings]

## Broader Implications

### Similar Code Patterns
[Where else this bug class might exist]

### Systemic Issues
[Any process/design issues that enabled this bug]

### Prevention Measures
[What would prevent similar bugs]

## Test Coverage
[From test-strategist if invoked, or note that tests are needed]

## Linked Documentation
- reference [[lateral-debugger-note-id]]
- reference [[systematic-debugger-note-id]]
- reference [[docs-investigator-note-id]]
- reference [[test-strategist-note-id]] (if applicable)
- related [[prior-similar-bug]] (if found in zettelkasten)
```

**Hub note metadata**:
- note_type: "hub"
- project: [relevant project]
- tags: "debugging,hub,bug-fix"

---

## Phase 5: Resolution

**Goal**: Apply fix and ensure proper closure

**Actions**:
1. If root cause is identified:
   - Propose fix to user
   - After fix is applied, update hub note with resolution details

2. If root cause is uncertain:
   - Present competing hypotheses to user
   - Recommend experiments to distinguish between them
   - Update hub note with current state

3. Create links using `zk_create_link`:
   - Hub → each agent note with link_type: "reference"
   - If this relates to a prior bug, link with "related"

4. If test-strategist wasn't invoked but should be:
   - Recommend invoking to design regression tests
   - Or note test needs in hub for future action

5. Present to user:
   - Diagnosis summary
   - Fix recommendation
   - Confidence level
   - Outstanding questions

---

## Workflow Decision Tree

```
Bug reported
     │
     ▼
Characterize bug
(symptom, expected, reproducibility)
     │
     ▼
Search existing knowledge
     │
     ├─ Found prior investigation? ─► Review and extend
     │
     └─ Novel bug ─┐
                   │
                   ▼
     ┌─────────────┴─────────────┐
     │    Deploy all three:      │
     │  • lateral-debugger       │
     │  • systematic-debugger    │
     │  • docs-investigator      │
     └─────────────┬─────────────┘
                   │
                   ▼
         Synthesize findings
                   │
     ┌─────────────┼─────────────┐
     │             │             │
Converge on    Diverge on    Docs found
root cause     hypotheses    known issue
     │             │             │
     ▼             ▼             ▼
  Fix bug     Design tests   Apply known
     │        to distinguish  workaround
     │             │             │
     └──────┬──────┴──────┬──────┘
            │             │
            ▼             ▼
     Create hub note   Invoke
     with diagnosis    test-strategist
            │          if needed
            ▼
     Link and present
       to user
```
