---
description: Research and knowledge synthesis with zettelkasten documentation. Orchestrator-driven workflow that may or may not invoke agents depending on research scope. Captures research findings, sources, and conclusions as permanent linked notes for future reference.
argument-hint: Research topic, question to investigate, or area to explore
---

# Research Workflow

You are conducting a research session with zettelkasten documentation. Unlike other znote commands, this workflow is orchestrator-driven—you may invoke agents if the research scope warrants it, but you drive the investigation directly.

## Core Principles

- **Document as you go**: Create notes for significant findings, not just final conclusions
- **Source everything**: Track where information comes from
- **Build connections**: Link new findings to existing knowledge
- **Preserve context**: Future-you needs to understand why this mattered

---

## Phase 1: Research Scoping

**Goal**: Understand what needs to be researched and how

**Input**: $ARGUMENTS

**Actions**:
1. Clarify the research question:
   - What specifically needs to be understood?
   - What decisions does this research inform?
   - What's the scope boundary?

2. Search existing knowledge:
   - `zk_search_notes` for relevant existing notes
   - `zk_fts_search` for specific terms/concepts
   - Check if this question has been partially answered before

3. Determine research approach:
   - **Library/framework documentation**: Use context7 MCP tools
   - **Web research**: Use WebSearch and WebFetch
   - **Codebase investigation**: Use code exploration tools
   - **Multi-domain**: May warrant spawning specialist agents

4. If scope is unclear, ask user:
   - What depth is needed?
   - What sources are authoritative for this question?
   - What format should findings take?

---

## Phase 2: Research Execution

**Goal**: Gather information from appropriate sources

### For Library/Framework Research:
```
1. Use mcp__context7__resolve-library-id to find the library
2. Use mcp__context7__query-docs to search documentation
3. Document findings in notes with source citations
```

### For Web Research:
```
1. Use WebSearch to find relevant sources
2. Use WebFetch to read authoritative sources
3. Document findings with URLs and publication dates
4. Assess source credibility
```

### For Codebase Investigation:
```
1. Use code exploration tools (Glob, Grep, Read)
2. Trace through implementations
3. Document patterns and behaviors discovered
4. Link to specific files/lines where appropriate
```

### For Complex Research (agent delegation):
If the research spans multiple domains or would benefit from parallel investigation:

**Option A**: Spawn exploration agents with specific questions
```
Use Task tool with subagent_type=Explore:
"Investigate [specific question]. Document findings including:
- Key facts discovered
- Sources consulted
- Confidence level
- Questions that remain"
```

**Option B**: Spawn docs-investigator for documentation-heavy research
```
Research [topic] using documentation sources.
Context: [What we're trying to understand]
Requirements:
- Create a zettelkasten note with findings
- Use note_type: "permanent"
- Include source citations
- Return the note ID
```

---

## Phase 3: Documentation

**Goal**: Create permanent record of research findings

### For Each Significant Finding:

**Create a detail note using zk_create_note**:

```markdown
## Summary
[1-2 paragraph summary of finding]

## Key Facts
- [Fact 1] — Source: [citation]
- [Fact 2] — Source: [citation]
- [Fact 3] — Source: [citation]

## Context
[Why this matters, what question it answers]

## Source Details
| Source | Type | Credibility | URL/Reference |
|--------|------|-------------|---------------|
| [Name] | [Official docs/Blog/Code/etc] | [High/Medium/Low] | [link] |

## Implications
[What this means for the original question]

## Related Concepts
[Other topics this connects to]
```

**Note metadata**:
- note_type: "permanent" or "literature" (for source-heavy notes)
- project: [relevant project]
- tags: "research,[topic-tag],[domain-tag]"

---

## Phase 4: Synthesis

**Goal**: Create hub note tying research together (if multiple findings)

### If research produced multiple notes:

**Create hub note using zk_create_note**:

```markdown
## Research Question
[Original question being investigated]

## Summary
[2-3 paragraph synthesis of findings]

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
[Questions that remain for future investigation]
```

**Hub note metadata**:
- note_type: "hub"
- project: [relevant project]
- tags: "research,hub,[topic-tag]"

---

## Phase 5: Integration

**Goal**: Connect research to existing knowledge

**Actions**:
1. Link new notes to related existing notes using `zk_create_link`:
   - `extends [[existing-note]]` if building on prior research
   - `related [[existing-note]]` if conceptually connected
   - `refines [[existing-note]]` if updating previous understanding

2. If research answers a question from a prior planning/review session:
   - Link back to that session's hub note
   - Update that hub if appropriate (add link, not modify content)

3. Present findings to user:
   - Key conclusions
   - Confidence level
   - What notes were created
   - What connections were made

---

## Workflow Decision Tree

```
Research request received
        │
        ▼
┌─────────────────────────┐
│  Scope and complexity?  │
└─────────────────────────┘
        │
   ┌────┴────┐
   │         │
Simple    Complex/
   │      Multi-domain
   │         │
   ▼         ▼
Orchestrator   Consider
drives research   agents
directly      │
   │         │
   ▼         ▼
Document    Spawn specialists
findings    or explorers
   │         │
   └────┬────┘
        │
        ▼
Create detail notes
for significant findings
        │
        ▼
┌─────────────────────────┐
│  Multiple findings?     │
└─────────────────────────┘
   │              │
  Yes             No
   │              │
   ▼              ▼
Create hub      Single note
note synthesis  is sufficient
   │              │
   └──────┬───────┘
          │
          ▼
   Link to existing
   knowledge base
          │
          ▼
   Present to user
```
