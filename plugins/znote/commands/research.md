---
description: Research and knowledge synthesis with zettelkasten documentation. Dynamically selects specialists based on research domain, presents plan for user approval, then executes investigation.
argument-hint: Research topic, question to investigate, or area to explore
---

# Research Workflow

You are conducting a research session with zettelkasten documentation. Your job is to scope the research, decide whether agents are needed, get user approval on approach, then investigate and document.

## Core Principles

- **Dynamic approach**: Research may be orchestrator-driven or agent-assisted
- **User collaboration**: Present your plan and get approval before executing
- **Document as you go**: Create notes for significant findings
- **Source everything**: Track where information comes from

---

## Phase 0: Research Scoping & Approach Selection

**Goal**: Understand what's being researched and propose an approach

### Step 1: Clarify the Research Question

**Input**: $ARGUMENTS

1. Understand the question:
   - What specifically needs to be understood?
   - What decisions does this research inform?
   - What's the scope boundary?

2. Search existing knowledge:
   - `zk_search_notes` for relevant existing notes
   - `zk_fts_search` for specific terms
   - Check if partially answered before

3. Assess research characteristics:
   - Is this library/framework documentation lookup?
   - Web research on concepts/patterns?
   - Codebase investigation?
   - Multi-domain requiring specialized expertise?

### Step 2: Select Approach

Determine if agents are needed or if you'll drive directly.

**Orchestrator-driven (no agents)** when:
- Simple documentation lookup
- Focused web research
- Single-domain codebase investigation
- Question is narrow and well-defined

**Agent-assisted** when:
- Research spans multiple domains
- Specialized expertise would help
- Parallel investigation would be faster
- Deep analysis is needed

**For research, consider these agents:**

| Agent | Consider When |
|-------|---------------|
| docs-investigator | Documentation-heavy, library/framework research |
| architecture-planner | Researching system design patterns |
| security-reviewer | Security best practices research |
| performance-analyzer | Performance optimization research |
| api-designer | API design patterns research |
| dependency-auditor | Evaluating libraries/dependencies |

### Step 3: Present Plan to User

Before proceeding, present your proposed approach:

```
## Research Approach

**Research Question**: [What we're investigating]
**Scope**: [Boundaries of the research]

**Proposed Approach**:
[Orchestrator-driven / Agent-assisted]

**If agent-assisted:**
| Agent | Research Focus |
|-------|----------------|
| [agent] | [what they'll investigate] |

**If orchestrator-driven:**
- Sources to consult: [list]
- Methods: [context7 / WebSearch / code exploration]

**Alternative Approaches**: [what else could work]

---

Would you like to:
- Approve this approach
- Add agent: [name]
- Change to orchestrator-driven/agent-assisted
- Modify research scope
```

**WAIT for user confirmation before proceeding to Phase 1.**

---

## Phase 1: Research Execution

**Goal**: Gather information based on approved approach

### Orchestrator-Driven Research

**For Library/Framework Documentation:**
1. Use `mcp__context7__resolve-library-id` to find library
2. Use `mcp__context7__query-docs` to search documentation
3. Document findings with source citations

**For Web Research:**
1. Use WebSearch to find relevant sources
2. Use WebFetch to read authoritative sources
3. Assess source credibility
4. Document findings with URLs and dates

**For Codebase Investigation:**
1. Use exploration tools (Glob, Grep, Read)
2. Trace implementations
3. Document patterns discovered

### Agent-Assisted Research

For each selected agent, use the Task tool with:

```
Research [specific aspect] of [topic].

Research Question: [What we're investigating]
Context: [Why this matters]

Requirements:
- Create a zettelkasten note documenting findings
- Use note_type: "permanent", project: "[project name]"
- Include source citations for all facts
- Tag with: research, [domain-tag]
- Return the note ID when complete
```

**Launch agents in parallel** if multiple selected.

---

## Phase 2: Documentation

**Goal**: Create permanent record of findings

### For Each Significant Finding

**Create a detail note using zk_create_note**:

```markdown
## Summary
[1-2 paragraph summary]

## Key Facts
- [Fact 1] — Source: [citation]
- [Fact 2] — Source: [citation]

## Context
[Why this matters, what question it answers]

## Source Details
| Source | Type | Credibility | Reference |
|--------|------|-------------|-----------|
| [Name] | [Docs/Blog/Code] | [High/Medium/Low] | [link] |

## Implications
[What this means for the original question]

## Related Concepts
[Other topics this connects to]
```

**Note metadata**:
- note_type: "permanent" or "literature"
- project: [relevant project]
- tags: "research,[topic-tag]"

---

## Phase 3: Synthesis

**Goal**: Create hub note if multiple findings

### If research produced multiple notes:

**Create hub note using zk_create_note**:

```markdown
## Research Question
[Original question]

## Summary
[2-3 paragraph synthesis]

## Key Findings

### Finding 1: [Title]
[Brief summary]
reference [[detail-note-id]]

### Finding 2: [Title]
[Brief summary]
reference [[detail-note-id]]

## Conclusions
[What the research tells us]

## Confidence Assessment
**Overall confidence**: [High/Medium/Low]
**Gaps remaining**: [What we still don't know]

## Recommendations
[What actions this research suggests]

## Sources Consulted
| Source | Finding | Note |
|--------|---------|------|
| [Source] | [What it told us] | reference [[note-id]] |

## Future Research
[Questions for future investigation]
```

---

## Phase 4: Integration

**Goal**: Connect to existing knowledge

**Actions**:
1. Link new notes to related existing notes:
   - `extends [[existing-note]]` if building on prior work
   - `related [[existing-note]]` if connected
   - `refines [[existing-note]]` if updating understanding

2. If research answers a question from prior work:
   - Link back to that session's hub note

3. Present findings to user:
   - Key conclusions
   - Confidence level
   - What notes were created
   - What connections were made
