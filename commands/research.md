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

2. Search existing knowledge (**use at least 5 different search terms**):
   - `zk_search_notes` for relevant existing notes
   - `zk_fts_search` for specific terms
   - Check if partially answered before
   - **Search variations**: Try synonyms, related concepts, component names, technology keywords, problem domain terms

3. Assess research characteristics:
   - Is this library/framework documentation lookup?
   - Web research on concepts/patterns?
   - Codebase investigation?
   - Multi-domain requiring specialized expertise?

### Step 1.5: Classify Research Effort

Based on your assessment, classify this research:

| Level | Criteria | Approach | Output Depth |
|-------|----------|----------|--------------|
| **Quick** | Factual lookup, single source, narrow question | Orchestrator-driven | Single note, direct answer |
| **Standard** | Multi-source investigation, some synthesis needed | Orchestrator or 1-2 agents | Thorough notes with citations |
| **Deep** | Multi-domain, competing perspectives, significant synthesis | 2+ specialized agents | Comprehensive notes, comparison analysis, confidence ratings |

Include the classification in your plan presentation to the user.

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

For each selected agent, use the Task tool with this structured dispatch:

```
## Agent Assignment: [Agent Name]

**Memory Continuity**: Before starting your research, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags matching your research domain
2. Use `zk_fts_search` with key terms from the research question
3. Read any relevant prior notes — existing research, related findings
4. Reference prior work in your findings where applicable: "Building on [[prior-note-id]]..."

**Objective**: [Specific research question — what must this agent discover or analyze?]

**Research Context**: [Why this matters, what decisions this research informs]

**Tools to Prioritize**:
- [Tool 1]: [Why this tool is relevant — e.g., context7 for library docs, WebSearch for current info]
- [Tool 2]: [Why this tool is relevant]

**Source Guidance**:
- Search zettelkasten first: [Prior research, related notes, existing knowledge]
- [Library docs / Web sources / Codebase]: [Specific sources to consult]
- Assess source credibility and recency

**Task Boundaries**:
- IN SCOPE: [What this agent should research — their domain]
- OUT OF SCOPE: [What other agents or the orchestrator is handling]
- If you discover tangential findings, add them to your Flags for Investigation section

**Requirements**:
- Create a zettelkasten note documenting findings
- Use note_type: "permanent", project: "[project name]"
- Include source citations for all facts
- Tag with: research, [domain-tag]
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

**Launch agents in parallel** if multiple selected.

---

## Phase 1.5: Flag Review (Agent-Assisted Only)

**Goal**: Handle any flags raised by research agents

### If Agents Were Used

After agents complete, check each note for "Flags for Investigation" section.

If flags were raised:

```
## Research Phase Complete - Flags Raised

**Research Summary**: [What was discovered so far]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| [agent] | [target-agent] | "[specific concern]" | [Priority] |

**Options**:
- Proceed with all flags (before documentation)
- Skip flag: [specify which]
- Skip all flags and continue to documentation
```

**WAIT for user decision.** Deploy response agents if flags approved.

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

## Cross-Pollination (if flags were processed)
| Flag | From | To | Response Note | Resolution |
|------|------|----|---------------|------------|
| [concern] | [source] | [target] | [[response-note-id]] | [Addressed/Needs Review] |
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
