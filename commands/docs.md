---
description: Multi-agent codebase documentation workflow with zettelkasten audit trail. Audits documentation gaps, generates missing docs using specialized writers, then verifies accuracy. Scope is optional.
argument-hint: Optional scope path (e.g., src/auth/) or leave empty for full codebase
---

# Documentation Workflow

You are orchestrating a multi-agent documentation generation session. Your job is to audit existing documentation, identify gaps, select appropriate documentation writers, generate docs, and verify accuracy.

## Core Principles

- **Audit-driven**: Start by understanding what documentation exists and what's missing
- **User collaboration**: Present audit findings and plan before generating
- **Specialized writers**: Match documentation type to appropriate agent
- **Verification required**: Cross-check generated docs against actual code
- **Dual output**: Docs go to repo files; audit trail goes to zettelkasten

---

## Phase 0: Scope Determination

**Goal**: Understand what needs documentation

### Step 1: Parse Input

**Input**: $ARGUMENTS

1. If scope provided (e.g., `src/auth/`):
   - Focus audit on that directory/module
   - Will generate docs only for that scope
2. If no scope:
   - Full codebase documentation audit
   - May take longer, will prioritize findings

### Step 1.5: Classify Documentation Effort

Based on the scope, classify this documentation task:

| Level | Criteria | Agent Count | Output Depth |
|-------|----------|-------------|--------------|
| **Quick** | Single module or file, targeted gap | 1-2 agents (audit + 1 writer) | Focused documentation, single output |
| **Standard** | Subsystem scope, multiple gap types | 2-4 agents (audit + writers + verifier) | Full audit, multi-type documentation |
| **Deep** | Full codebase, comprehensive coverage target | 4+ agents (audit + all writer types + verifier) | Exhaustive audit, complete documentation suite, full verification |

Include the classification in your plan presentation to the user.

### Step 2: Initialize MCP Tools

Verify access to:
- **Serena**: For symbol-level code understanding
- **Anamnesis**: For codebase patterns and structure
- **Zettelkasten**: For audit trail and summaries

---

## Phase 1: Documentation Audit

**Goal**: Discover documentation gaps, staleness, and inaccuracies

### Step 1: Deploy doc-auditor

Use the Task tool to launch the doc-auditor agent:

```
Audit documentation for [scope or "entire codebase"].

Use Serena to inventory actual code symbols.
Use Anamnesis to understand codebase structure.

Analyze:
- Project-level docs (README, CLAUDE.md)
- Architecture documentation
- Module-level docs (package READMEs)
- API-level docs (docstrings, API references)

Produce a gap report covering:
- Missing documentation (with priority)
- Stale documentation (outdated)
- Inaccurate documentation (wrong)
- Coverage percentages by level

Create a zettelkasten note with your findings.
Return the note ID when complete.
```

### Step 2: Review Audit Results

Read the audit note using `zk_get_note` and analyze:
- Total documentation health score
- Gap categories and priorities
- Scope of work needed

---

## Phase 1.5: Flag Review & User Approval

**Goal**: Review any flags raised by audit agent and get user approval for follow-up

### Step 1: Check for Flags

After doc-auditor completes, check the note's "Flags for Investigation" section.

### Step 2: Present Flags to User (if any)

If flags were raised:

```
## Audit Complete - Flags Raised

**Audit Summary**: [Brief overview of documentation health]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| doc-auditor | [agent] | "[specific concern]" | [Priority] |

**Options**:
- Proceed with all flags
- Skip flag: [specify which]
- Add investigation: [describe additional concern]
- Skip all flags and continue to Phase 2
```

**WAIT for user confirmation on which flags to pursue.**

### Step 3: Deploy Response Agents (if flags approved)

For each approved flag, deploy the flagged agent:

```
Respond to flag from doc-auditor in note [[note-id]].

Read the note and locate the flag in "Flags for Investigation" section.
The specific concern is: "[flag text]"

Create a RESPONSE NOTE using this format:

## Response: [Topic]
**Responding to**: [[note-id]]
**Original Flag**: "[flag text]"
**Flagged by**: doc-auditor
**Priority**: [from flag]

## Investigation
[Your analysis of the flagged concern]

## Findings
[What you discovered]

## Resolution
- **Status**: [Addressed/Partially Addressed/Needs Human Review]
- **Action Taken**: [What was done]
- **Remaining Concerns**: [If any]

Use note_type: "permanent", project: "[project]"
Return the note ID when complete.
```

---

## Phase 2: Planning & Agent Selection

**Goal**: Select appropriate documentation agents and get user approval

### Step 1: Categorize Gaps

Based on audit findings, categorize gaps:

| Gap Type | Agent | Description |
|----------|-------|-------------|
| System-level | architecture-documenter | System overviews, boundaries, data flows |
| Module-level | module-documenter | Package READMEs, module guides |
| API-level | api-documenter | Function/class documentation |
| CLAUDE.md | claude-md-specialist | Project context files |

### Step 2: Present Plan to User

```
## Documentation Plan

**Scope**: [What's being documented]
**Current Coverage**: [X]% (from audit)
**Target Coverage**: [Y]%

### Audit Summary
[Key findings from doc-auditor]

### Proposed Documentation Team
| Agent | Assignment | Priority |
|-------|------------|----------|
| [agent] | [What they'll document] | [High/Med/Low] |

### Estimated Outputs
- [N] architecture docs
- [N] module READMEs
- [N] API reference files
- [N] CLAUDE.md updates

### Alternative Agents Available
[Any documentation agents not selected]

---

Would you like to:
- Approve this plan
- Add agent: [name]
- Remove agent: [name]
- Adjust scope or priorities
```

**WAIT for user confirmation before proceeding to Phase 3.**

---

## Phase 3: Documentation Generation

**Goal**: Deploy documentation agents in parallel

### Step 1: Prepare Agent Assignments

For each selected agent, prepare specific assignments based on audit findings:

**architecture-documenter**:
```
## Agent Assignment: architecture-documenter

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "documentation", "architecture"
2. Use `zk_fts_search` with key terms from the scope
3. Build on any existing documentation notes: "Building on [[prior-note-id]]..."

**Objective**: Document system architecture for [scope] — create/update architecture docs that explain boundaries, data flows, and component relationships.

**Tools to Prioritize**:
- Serena (get_symbols_overview, find_symbol): Map component relationships and module boundaries
- Anamnesis (get_project_blueprint): Get high-level architecture context

**Source Guidance**:
- Search zettelkasten first: Prior architecture notes, implementation plans
- Examine code: Entry points, module boundaries, dependency patterns

**Task Boundaries**:
- IN SCOPE: System-level docs, component boundaries, data flows
- OUT OF SCOPE: API-level docs (api-documenter), module READMEs (module-documenter)
- If you discover gaps outside your scope, add them to your Flags for Investigation section

Create/update:
- docs/architecture/[relevant-file].md
- System overview if missing
- Component boundaries and data flows

Create a zettelkasten note summarizing your work.
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
Return the note ID when complete.
```

**module-documenter**:
```
## Agent Assignment: module-documenter

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "documentation", "module"
2. Use `zk_fts_search` with module names from the assignment
3. Build on any existing module documentation notes: "Building on [[prior-note-id]]..."

**Objective**: Document the following modules: [list from audit] — create/update READMEs that explain purpose, exports, dependencies, and usage examples.

**Tools to Prioritize**:
- Serena (get_symbols_overview): Inventory module exports and structure
- Anamnesis (get_pattern_recommendations): Understand conventions for documentation

**Source Guidance**:
- Search zettelkasten first: Prior module documentation, related implementation notes
- Examine code: Module entry points, public API surface, usage patterns

**Task Boundaries**:
- IN SCOPE: Module-level READMEs, package guides
- OUT OF SCOPE: System architecture (architecture-documenter), API reference (api-documenter)
- If you discover gaps outside your scope, add them to your Flags for Investigation section

Create/update:
- [module]/README.md for each module
- Include: purpose, exports, dependencies, examples

Create a zettelkasten note summarizing your work.
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
Return the note ID when complete.
```

**api-documenter**:
```
## Agent Assignment: api-documenter

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "documentation", "api"
2. Use `zk_fts_search` with API names and module names from the assignment
3. Build on any existing API documentation notes: "Building on [[prior-note-id]]..."

**Objective**: Document APIs in: [files from audit] — create precise function signatures, parameter docs, return values, and usage examples.

**Tools to Prioritize**:
- Serena (find_symbol, find_referencing_symbols): Get exact signatures and usage examples
- Anamnesis (search_codebase): Find usage patterns across the codebase

**Source Guidance**:
- Search zettelkasten first: Prior API documentation, related design notes
- Examine code: Function signatures, type definitions, existing docstrings, test files for examples

**Task Boundaries**:
- IN SCOPE: Function/class-level documentation, API reference
- OUT OF SCOPE: System architecture (architecture-documenter), module guides (module-documenter)
- If you discover gaps outside your scope, add them to your Flags for Investigation section

Create/update:
- Docstrings in source files, OR
- docs/api/[module].md reference files

Create a zettelkasten note summarizing your work.
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
Return the note ID when complete.
```

**claude-md-specialist**:
```
## Agent Assignment: claude-md-specialist

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "documentation", "claude-md"
2. Use `zk_fts_search` with "CLAUDE.md" and project names
3. Build on any existing CLAUDE.md audit notes: "Building on [[prior-note-id]]..."

**Objective**: Audit and improve CLAUDE.md files — ensure they accurately reflect commands, architecture, patterns, and conventions.

**Tools to Prioritize**:
- Serena (get_symbols_overview, list_dir): Verify file structure and module claims
- Anamnesis (get_project_blueprint, get_pattern_recommendations): Confirm patterns and conventions

**Source Guidance**:
- Search zettelkasten first: Prior CLAUDE.md audits, project documentation notes
- Examine code: Actual commands, build processes, test runners, project structure

**Task Boundaries**:
- IN SCOPE: CLAUDE.md files, project context for Claude Code sessions
- OUT OF SCOPE: Architecture docs, module READMEs, API reference
- If you discover gaps outside your scope, add them to your Flags for Investigation section

Apply quality rubric (commands, architecture, patterns, conciseness, currency, actionability).

Create/update CLAUDE.md files as needed.
Create a zettelkasten note with quality scores and changes.
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
Return the note ID when complete.
```

### Step 2: Deploy Agents

**Launch all documentation agents in parallel** using multiple Task tool calls in a single message.

---

## Phase 3.5: Writer Flag Review

**Goal**: Review any flags raised by documentation writers

### Step 1: Collect Writer Flags

After all writers complete:
1. Read each writer's note
2. Extract any "Flags for Investigation" sections
3. If no flags, proceed to Phase 4

### Step 2: Present Writer Flags to User (if any)

```
## Documentation Generation Complete - Flags Raised

**Documentation Created**: [Summary of files created/updated]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| [writer] | [agent] | "[specific concern]" | [Priority] |

**Options**:
- Proceed with all flags (before verification)
- Skip flags and continue to verification
- Skip specific flags
```

**WAIT for user decision.**

### Step 3: Deploy Response Agents (if flags approved)

Deploy flagged agents using the Response Note format (same as Phase 1.5).

**Note**: Response agents get ONE reply. They must make it count.

---

## Phase 4: Verification

**Goal**: Verify generated documentation is accurate

### Step 1: Deploy doc-verifier

After all writers complete, launch doc-verifier:

```
Verify documentation generated by these agents: [list note IDs]

Use Serena to cross-check:
- Function signatures match docs
- File paths exist
- Examples would work

Check:
- Accuracy of claims
- Validity of examples
- Correctness of references

Create a zettelkasten note with verification results.
Flag any discrepancies found.
Return the note ID when complete.
```

### Step 2: Review Verification

Read verification note and identify:
- Docs that pass verification
- Discrepancies that need correction
- Items needing human review

### Step 3: Address Discrepancies (if needed)

If verification found issues:
1. Present discrepancies to user
2. Offer to correct or flag for manual review
3. Re-verify after corrections

---

## Phase 5: Completion

**Goal**: Create hub note and present results

### Step 1: Create Hub Note

Create a documentation hub note using `zk_create_note`:

```markdown
## Documentation Session: [Scope]
**Date**: [Date]
**Initial Coverage**: [X]%
**Final Coverage**: [Y]%

## Overview
[Summary of documentation work completed]

## Agents Deployed
| Agent | Assignment | Status | Note |
|-------|------------|--------|------|
| doc-auditor | Initial audit | Complete | [[note-id]] |
| [writer] | [What documented] | Complete | [[note-id]] |
| doc-verifier | Verification | Complete | [[note-id]] |

## Documentation Created/Updated

### Architecture Docs
- [file]: [Status]

### Module Docs
- [module]/README.md: [Created/Updated]

### API Docs
- [file]: [Status]

### CLAUDE.md
- [file]: [Status/Score]

## Verification Summary
**Overall Accuracy**: [X]%
**Discrepancies Found**: [N]
**Resolved**: [N]
**Needs Review**: [N]

## Remaining Gaps
[Any documentation still missing after this session]

## Recommendations
[Suggestions for maintaining documentation]
```

### Step 2: Link Notes

Use `zk_create_link` to connect:
- Hub to all agent notes
- Agent notes to each other where relevant

### Step 3: Present Results

Present to user:
- Documentation coverage improvement
- Files created/updated
- Verification status
- Any items needing manual attention
- Offer to address specific gaps or questions

---

## Integration Notes

### Serena Tools
- `get_symbols_overview`: Inventory module exports
- `find_symbol`: Get exact function signatures
- `find_referencing_symbols`: Find usage examples
- `Read`: Check existing docs
- `list_dir`: Map directory structure

### Anamnesis Tools
- `get_project_blueprint`: Understand architecture
- `search_codebase`: Find patterns
- `get_pattern_recommendations`: Match conventions

### Zettelkasten Tools
- `zk_create_note`: Store audit trail and summaries
- `zk_get_note`: Read agent outputs
- `zk_create_link`: Connect related notes
- `zk_search_notes`: Find prior documentation work
