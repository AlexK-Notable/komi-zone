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

### Step 1.5: Classify Analysis Effort

Based on the task type and inputs, classify this analysis:

| Level | Criteria | Agent Count | Output Depth |
|-------|----------|-------------|--------------|
| **Quick** | Single policy check, code verification, narrow question | 1 agent | Targeted analysis, direct answer |
| **Standard** | Full policy analysis or rule extraction, moderate complexity | 1-2 agents (sequential) | Thorough analysis with traceability |
| **Deep** | Full pipeline (analysis → extraction → comparison), complex policy | 3-4 agents (full pipeline) | Comprehensive formal specifications, gap analysis, rule generation |

Include the classification in your approach presentation to the user.

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

Use the Task tool with this structured dispatch:

```
## Agent Assignment: policy-analyst

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "medical-policy", "coverage-criteria"
2. Use `zk_fts_search` with policy name, condition keywords, and relevant ICD/CPT codes
3. Build on any existing policy analyses: "Building on [[prior-note-id]]..."

**Objective**: Analyze the following medical policy document — extract all coverage criteria, logical structure, and ambiguities with full traceability to source sections.

[Policy content or reference]

**Tools to Prioritize**:
- Zettelkasten (zk_search_notes, zk_fts_search): Search for prior analyses of this policy or related policies
- WebSearch: If needed to clarify policy context or find related guidance

**Source Guidance**:
- Search zettelkasten first: Prior policy analyses, related coverage criteria, ICD/CPT code sets
- Reference the policy document directly for all claims

**Task Boundaries**:
- IN SCOPE: Coverage criteria extraction, logical structure, ambiguity identification
- OUT OF SCOPE: Code verification (terminology-resolver), formal logic (logic-extractor), rule comparison (rule-comparator)
- If you discover issues outside your scope, add them to your Flags for Investigation section

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
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
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
## Agent Assignment: terminology-resolver

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "medical-coding", "terminology"
2. Use `zk_fts_search` with specific codes and medical terms from the questions
3. Build on any existing terminology resolutions: "Building on [[prior-note-id]]..."

**Objective**: Resolve the following medical terminology/coding questions — verify all codes are valid, current, and match policy intent.

[Questions from policy analysis]

**Tools to Prioritize**:
- Zettelkasten (zk_search_notes): Prior terminology resolutions, code set notes
- WebSearch: Current ICD-10/CPT code databases and guidelines

**Task Boundaries**:
- IN SCOPE: Code verification, terminology clarification, code set completeness
- OUT OF SCOPE: Policy structure (policy-analyst), formal logic (logic-extractor)
- If you discover issues outside your scope, add them to your Flags for Investigation section

Verify:
- ICD-10 codes are valid and current
- Code descriptions match policy intent
- Code set definitions are complete
- Related codes are identified

Create a zettelkasten note with your findings.
Use tags: "medical-coding,terminology,icd-10,cpt"
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
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
## Agent Assignment: logic-extractor

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "formal-logic", "rule-extraction"
2. Use `zk_fts_search` with predicate names or policy keywords
3. Build on any existing formal specifications: "Building on [[prior-note-id]]..."

**Objective**: Formalize the following policy criteria into precise logical structures — transform natural language rules into unambiguous predicates and rule expressions.

Policy Analysis: [[note-id from policy-analyst]]

**Tools to Prioritize**:
- Zettelkasten (zk_get_note): Read the policy-analyst's note for source material
- Zettelkasten (zk_search_notes): Find prior formal logic extractions for pattern reference

**Task Boundaries**:
- IN SCOPE: Predicate definitions, formal rule expressions, type definitions, ambiguity resolution
- OUT OF SCOPE: Policy parsing (policy-analyst), code verification (terminology-resolver), rule comparison (rule-comparator)
- If you discover issues outside your scope, add them to your Flags for Investigation section

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
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
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
## Agent Assignment: rule-comparator

**Memory Continuity**: Before starting, search the zettelkasten for prior work:
1. Use `zk_search_notes` with tags: "rule-comparison", "gap-analysis"
2. Use `zk_fts_search` with rule names or policy identifiers
3. Build on any existing comparison results: "Building on [[prior-note-id]]..."

**Objective**: Compare implemented rules against source policy — identify gaps, discrepancies, and missing coverage.

Policy Analysis: [[note-id]]
Formal Logic: [[note-id if available]]
Implementation: [Rules/files to compare]

**Tools to Prioritize**:
- Zettelkasten (zk_get_note): Read policy analysis and logic extraction notes
- Code exploration (Read, Grep, Glob): Examine rule implementation files
- Zettelkasten (zk_search_notes): Prior comparison results for pattern reference

**Task Boundaries**:
- IN SCOPE: Rule-to-policy comparison, gap identification, discrepancy reporting
- OUT OF SCOPE: Policy parsing (policy-analyst), formal logic (logic-extractor), code verification (terminology-resolver)
- If you discover issues outside your scope, add them to your Flags for Investigation section

Identify:
- Missing rules (policy not implemented)
- Discrepancies (implementation differs from policy)
- Coverage gaps (criteria not checked)
- Consistency issues

Create a zettelkasten note with comparison results.
Use tags: "rule-comparison,gap-analysis,policy-validation"
Append a Self-Assessment: Objective Addressed? (Fully/Partially/Minimally), Confidence (High/Medium/Low), Key Uncertainty, Completeness, Further Investigation.
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
