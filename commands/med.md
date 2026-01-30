---
description: Medical policy analysis and rule formalization workflow. Analyzes coverage policies (LCDs, NCDs, commercial), extracts logical structure, and optionally generates formal rules. Task description guides focus.
argument-hint: Task description (e.g., "analyze this LCD", "compare rules to policy", "extract coverage criteria")
---

# Medical Policy Analysis Workflow

You are orchestrating a medical policy analysis session. Your job is to parse policy documents, extract formal logical structures, and optionally generate implementable rules. The specific task guides which capabilities to invoke.

## Core Principles

- **Precision over interpretation**: Flag ambiguity rather than resolve it silently
- **Traceability**: Every extracted element traces back to source
- **Domain expertise**: Use medical coding knowledge appropriately
- **Zettelkasten foundation**: All analysis stored as permanent notes

---

## Phase 0: Task Understanding

**Goal**: Determine what kind of analysis is needed

### Step 1: Parse Input

**Input**: $ARGUMENTS

Identify the task type:

| Pattern | Task Type | Agents Needed |
|---------|-----------|---------------|
| "analyze [policy]" | Policy Analysis | policy-analyst |
| "extract [rules/criteria]" | Rule Extraction | policy-analyst, logic-extractor |
| "compare [rules] to [policy]" | Comparison | rule-comparator |
| "what's missing" / "validate" | Gap Analysis | rule-comparator |
| "formalize" / "create rules" | Full Pipeline | all agents |

### Step 2: Identify Inputs

Determine available inputs:
- Policy document (LCD, NCD, commercial policy)
- Existing rules (PRSYS files, rule definitions)
- Prior analysis (search zettelkasten for related notes—**use at least 5 different search terms**: policy name, ICD codes, CPT codes, condition keywords, procedure keywords)

### Step 3: Present Approach

```
## Medical Policy Analysis

**Task Understanding**: [What you understand the task to be]
**Input Documents**: [What you have to work with]
**Task Type**: [Analysis/Extraction/Comparison/Full Pipeline]

**Proposed Approach**:
| Phase | Agent | Focus |
|-------|-------|-------|
| [1] | [agent] | [What they'll do] |

**Expected Outputs**:
- Zettelkasten notes (always)
- [PRSYS rules if generating]
- [Comparison report if comparing]

---

Would you like to:
- Approve this approach
- Adjust scope or focus
- Provide additional context
```

**WAIT for user confirmation before proceeding.**

---

## Phase 1: Policy Analysis

**Goal**: Parse policy documents and extract structured information

### When to Execute
- Task involves analyzing a policy document
- First step in any full pipeline

### Deploy policy-analyst

Use the Task tool:

```
Analyze the following medical policy document:

[Policy content or reference]

Extract:
- Covered indications with ICD-10 codes
- Required documentation elements
- Medical necessity criteria
- Exclusions and limitations
- Logical structure (IF/THEN conditions)
- Ambiguities and unclear language

Maintain traceability to source sections.

Create a zettelkasten note with your analysis.
Use tags: "medical-policy,coverage-criteria,lcd,analysis"
Return the note ID when complete.
```

### Review Analysis

Read policy-analyst's note and identify:
- Key coverage criteria extracted
- Ambiguities flagged
- Structure for formalization

### Flag Review (if flags raised)

Check policy-analyst's note for "Flags for Investigation" section.

If flags were raised:

```
## Policy Analysis Complete - Flags Raised

**Analysis Summary**: [Brief overview of coverage criteria found]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| policy-analyst | [agent] | "[specific concern]" | [Priority] |

**Options**:
- Proceed with flag (before next phase)
- Skip flag and continue
```

Deploy response agents if flags approved. Response agents get ONE reply.

---

## Phase 2: Terminology Resolution (if needed)

**Goal**: Resolve medical coding and terminology questions

### When to Execute
- Policy references codes that need verification
- Terminology is unclear or ambiguous
- Code sets need definition

### Deploy terminology-resolver

```
Resolve the following medical terminology/coding questions:

[Questions from policy analysis]

Verify:
- ICD-10 codes are valid and current
- Code descriptions match policy intent
- Code set definitions are complete
- Related codes are identified

Create a zettelkasten note with your findings.
Use tags: "medical-coding,terminology,icd-10,cpt"
Return the note ID when complete.
```

---

## Phase 3: Logic Extraction

**Goal**: Transform natural language rules into formal logical structures

### When to Execute
- Task requires formal rule structures
- Preparing for rule implementation
- Need unambiguous logical representation

### Deploy logic-extractor

```
Formalize the following policy criteria into logical structures:

Policy Analysis: [[note-id from policy-analyst]]

Create:
- Predicate definitions with types
- Formal rule expressions
- Type and enumeration definitions
- Ambiguity resolution documentation
- Completeness analysis

Reference the policy-analyst's work for source material.
Resolve ambiguities explicitly (document interpretation choices).

Create a zettelkasten note with formal specifications.
Use tags: "formal-logic,rule-extraction,predicates,coverage-rules"
Return the note ID when complete.
```

---

## Phase 4: Rule Comparison (if needed)

**Goal**: Compare implemented rules against policy source

### When to Execute
- Task involves validating existing rules
- Need to find gaps between policy and implementation
- Checking rule completeness

### Deploy rule-comparator

```
Compare the following against source policy:

Policy Analysis: [[note-id]]
Formal Logic: [[note-id if available]]
Implementation: [Rules/files to compare]

Identify:
- Missing rules (policy not implemented)
- Discrepancies (implementation differs from policy)
- Coverage gaps (criteria not checked)
- Consistency issues

Create a zettelkasten note with comparison results.
Use tags: "rule-comparison,gap-analysis,policy-validation"
Return the note ID when complete.
```

---

## Phase 5: Output Generation

**Goal**: Produce requested outputs

### Output Types

**Zettelkasten Notes** (always produced):
- Policy analysis
- Logic extraction
- Terminology resolution
- Comparison results

**PRSYS Rules** (when requested):
If task requests rule generation:
1. Review logic-extractor's formal specifications
2. Generate PRSYS rule files based on specs
3. Include comments tracing to source policy
4. Note any assumptions or interpretation choices

**Analysis Reports** (when requested):
If task requests a summary report:
1. Synthesize all agent findings
2. Create markdown report with:
   - Executive summary
   - Key coverage criteria
   - Logical structure
   - Open questions/ambiguities

---

## Phase 6: Completion

**Goal**: Create hub note and present results

### Step 1: Create Hub Note

```markdown
## Medical Policy Analysis: [Policy Name]
**Date**: [Date]
**Task Type**: [Analysis/Extraction/Comparison]

## Overview
[Summary of analysis work]

## Agents Deployed
| Agent | Focus | Note |
|-------|-------|------|
| policy-analyst | [Focus] | [[note-id]] |
| terminology-resolver | [Focus] | [[note-id]] |
| logic-extractor | [Focus] | [[note-id]] |
| rule-comparator | [Focus] | [[note-id]] |

## Key Findings

### Coverage Criteria Summary
[Main criteria from policy]

### Logical Structure
```
[Simplified decision tree]
```

### Ambiguities Identified
| Source Text | Issue | Resolution |
|-------------|-------|------------|
| [Quote] | [What's unclear] | [How resolved/flagged] |

## Outputs Generated
- Zettelkasten notes: [list]
- PRSYS rules: [if generated]
- Report: [if generated]

## Open Questions
[Items needing human decision]

## Recommendations
[Next steps or follow-up work]

## Cross-Pollination (if flags were processed)
| Flag | From | To | Response Note | Resolution |
|------|------|----|---------------|------------|
| [concern] | [source] | [target] | [[response-note-id]] | [Addressed/Needs Review] |
```

### Step 2: Link Notes

Use `zk_create_link` to connect all analysis notes.

### Step 3: Present Results

Present to user:
- Summary of analysis
- Key coverage criteria identified
- Ambiguities that need resolution
- Generated outputs
- Offer to dive deeper on any aspect

---

## Task-Specific Workflows

### "Analyze this LCD/policy"
1. policy-analyst → Extract structure
2. terminology-resolver → Verify codes (if needed)
3. Present analysis summary

### "Extract the raw logic"
1. policy-analyst → Parse document
2. logic-extractor → Formalize rules
3. Present formal specifications

### "Compare rules to policy"
1. policy-analyst → Parse policy (if not already done)
2. rule-comparator → Compare implementation
3. Present gap analysis

### "What's missing from these rules?"
1. rule-comparator → Gap analysis
2. Present prioritized gaps

### "Generate PRSYS rules"
1. policy-analyst → Parse document
2. terminology-resolver → Verify codes
3. logic-extractor → Formalize
4. Generate PRSYS files
5. Present rules with source tracing

---

## Integration Notes

### Medical Coding Knowledge
Agents have access to:
- ICD-10-CM code sets and hierarchies
- CPT/HCPCS procedure codes
- Medical terminology
- Policy document conventions (LCD, NCD structure)

### Zettelkasten Usage
- All analysis stored as permanent notes
- Notes linked for cross-reference
- Prior analysis searchable for context
- Builds organizational knowledge over time

### PRSYS Integration
When generating rules:
- Reference existing PRSYS patterns
- Use established predicate naming
- Include source policy citations
- Follow project rule conventions
