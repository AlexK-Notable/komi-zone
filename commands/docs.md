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
Document system architecture for [scope].

Use Serena to understand component relationships.
Use Anamnesis to get project blueprint.

Create/update:
- docs/architecture/[relevant-file].md
- System overview if missing
- Component boundaries and data flows

Create a zettelkasten note summarizing your work.
Return the note ID when complete.
```

**module-documenter**:
```
Document the following modules: [list from audit]

Use Serena get_symbols_overview for each module.
Use Anamnesis for pattern context.

Create/update:
- [module]/README.md for each module
- Include: purpose, exports, dependencies, examples

Create a zettelkasten note summarizing your work.
Return the note ID when complete.
```

**api-documenter**:
```
Document APIs in: [files from audit]

Use Serena find_symbol for exact signatures.
Use Anamnesis for usage patterns.

Create/update:
- Docstrings in source files, OR
- docs/api/[module].md reference files

Create a zettelkasten note summarizing your work.
Return the note ID when complete.
```

**claude-md-specialist**:
```
Audit and improve CLAUDE.md files.

Use Serena to verify file structure claims.
Use Anamnesis to confirm patterns and commands.

Apply quality rubric (commands, architecture, patterns, conciseness, currency, actionability).

Create/update CLAUDE.md files as needed.
Create a zettelkasten note with quality scores and changes.
Return the note ID when complete.
```

### Step 2: Deploy Agents

**Launch all documentation agents in parallel** using multiple Task tool calls in a single message.

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
- `read_file`: Check existing docs
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
