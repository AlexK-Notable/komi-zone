# znote Plugin Expansion Design

**Date:** 2025-01-30
**Status:** Approved

## Overview

Expand komi-zone plugin with new workflow commands and specialized agents to address gaps in:
- Creative/language capabilities (documentation, medical policy analysis)
- General-purpose research
- Testing depth
- UI/Frontend support

Integrate Serena and Anamnesis MCP tools throughout workflows.

---

## New Commands

### `/znote:docs`

**Purpose:** Codebase documentation generation with verification

**Arguments:** Optional scope (e.g., `/znote:docs src/auth/`)

**Phases:**

1. **Audit** - doc-auditor scans for missing, stale, incorrect docs
   - Uses Serena (symbols) + Anamnesis (structure)
   - Output: Gap report as zettelkasten note

2. **Plan** - Orchestrator categorizes gaps by type
   - Architecture-level (system overview, boundaries)
   - Module-level (package purpose, dependencies)
   - API-level (signatures, usage examples)
   - CLAUDE.md (project context files)
   - Selects writer agents, presents plan to user

3. **Generate** - Writer agents work in parallel
   - architecture-documenter → system docs
   - module-documenter → package docs
   - api-documenter → API references
   - claude-md-specialist → CLAUDE.md files
   - Output: Docs to repo + summary notes in zettelkasten

4. **Verify** - doc-verifier cross-checks generated docs
   - Flags uncertainty for human review
   - Ensures accuracy before finalizing

### `/znote:med`

**Purpose:** Medical policy/rules analysis and formalization

**Arguments:** Task description guiding focus

**Example invocations:**
- "analyze this medicare LCD. give me the raw logic."
- "look at these rules and compare to this LCD. what's missing?"
- "extract coverage criteria from this policy document"

**Capabilities:**
- Document parsing and analysis
- Rule extraction and formalization
- Policy comparison (implementation vs source)
- Format translation (natural language ↔ PRSYS DSL ↔ structured logic)

**Outputs (context-dependent):**
- Zettelkasten notes (always)
- PRSYS rule files (when generating rules)
- Analysis reports (when comparing/auditing)

**Agents:** policy-analyst, logic-extractor, terminology-resolver, rule-comparator

---

## New Agents

### Documentation Agents (for `/znote:docs`)

| Agent | Purpose | MCP Tools |
|-------|---------|-----------|
| **doc-auditor** | Scans for missing, stale, incorrect docs; produces gap report | Serena (symbols), Anamnesis (structure) |
| **architecture-documenter** | Writes system overviews, boundaries, data flows | Serena (relationships), Anamnesis (blueprint) |
| **module-documenter** | Documents packages/modules, purpose, dependencies | Serena (symbols), Anamnesis (patterns) |
| **api-documenter** | Generates API references, signatures, usage examples | Serena (find_symbol, get_symbols_overview) |
| **doc-verifier** | Cross-checks generated docs against code, flags uncertainty | Serena (symbol bodies), Anamnesis (search) |
| **claude-md-specialist** | CLAUDE.md audit, generation, improvement using quality rubric | Serena, Anamnesis, quality criteria framework |

**claude-md-specialist details:**
- Uses quality scoring rubric (commands, architecture, patterns, conciseness, currency, actionability)
- Grades A-F based on 100-point scale
- Integrates Serena/Anamnesis for deep codebase understanding
- Based on official claude-md-management plugin patterns

### Medical/Policy Agents (for `/znote:med`)

| Agent | Purpose | Focus |
|-------|---------|-------|
| **policy-analyst** | Parses policy documents, identifies conditions and criteria | Extract structure from dense text |
| **logic-extractor** | Transforms natural language rules into formal logical structures | Precision, no ambiguity |
| **terminology-resolver** | Medical coding expertise (ICD, CPT, HCPCS), resolves terms | Domain accuracy |
| **rule-comparator** | Compares policies against implementations, finds gaps | What's missing, what's wrong |

### Research Agents

| Agent | Purpose | Focus |
|-------|---------|-------|
| **domain-learner** | Deep dives into unfamiliar topics; builds structured understanding | Comprehensive, organized knowledge acquisition |
| **options-analyst** | Compares alternatives, analyzes trade-offs, recommends approaches | Objective comparison, decision support |
| **synthesizer** | Pulls from multiple sources, creates coherent summaries | Multi-source integration, distillation |
| **fact-finder** | Strictly factual retrieval; no inference, no speculation | Verifiable, objective, citation-focused |

**Research philosophy:**
- Accuracy over speed
- Clearly distinguish known facts vs inferences vs speculation
- Output to zettelkasten for permanent reference
- Orchestrator summarizes findings and surfaces "leads" for user to pursue

**Complementary pairs:**
- domain-learner + synthesizer: Deep dive then distill
- fact-finder + options-analyst: Get facts then compare

### Testing Agents

| Agent | Purpose | Focus |
|-------|---------|-------|
| **test-implementer** | Writes tests based on strategy/requirements | High-quality, meaningful tests from the start |
| **coverage-analyst** | Analyzes tested vs untested code, finds blind spots | Uses Serena/Anamnesis to understand actual code paths |
| **test-reviewer** | Reviews existing tests for quality, mock abuse, false confidence | Adversarial stance; catches mock theater |
| **e2e-specialist** | System-level and integration testing | Real interactions, not isolated mocks |
| **regression-hunter** | Identifies what tests are needed after a change | Prevents regressions before they happen |

**Testing philosophy (unified across all):**
- Meaningful tests that catch real bugs
- No mock theater - mocks only at system boundaries
- Tests should answer "what bug would this catch?"
- Prefer integration/E2E for ground truth
- Use Serena (symbol relationships, call graphs) and Anamnesis (patterns) to understand what needs testing

**test-reviewer personality:**
- Adversarial/nitpicky stance
- Skeptical of all tests until proven adequate
- Better to flag false positives than miss issues
- Assumes tests are inadequate until proven otherwise

**Works with existing test-strategist:**
- Strategist plans the approach
- These agents execute and verify

### UI/Frontend Agents

| Agent | Purpose | Focus |
|-------|---------|-------|
| **ui-architect** | Component structure, state management, prop design | Structural planning |
| **ui-test-specialist** | UI-specific testing - interaction, accessibility, visual regression | Testing user experience |
| **ux-analyst** | User flow analysis, interaction patterns, usability concerns | Logic of UX, not pixels |

**UI/Frontend philosophy:**
- Focus on what Claude handles well: structure, logic, accessibility, user flows
- Avoid pixel-perfect visual claims
- Use descriptive language for design intent
- Lower priority; minimal viable set that can expand later

---

## Serena/Anamnesis Integration

### Tool Capabilities

| Tool | Provides | Primary Use |
|------|----------|-------------|
| **Serena** | Symbol-level code understanding | find_symbol, get_symbols_overview, find_referencing_symbols, read symbol bodies |
| **Anamnesis** | Codebase patterns and intelligence | get_project_blueprint, search_codebase, get_pattern_recommendations |
| **znote-mcp** | Zettelkasten operations | zk_create_note, zk_search_notes, zk_create_link |

### Integration by Agent Category

**Documentation agents:**
- Serena: Understand symbols, relationships, actual code structure
- Anamnesis: Get blueprint, patterns, conventions
- Both: Ensure docs match reality

**Testing agents:**
- Serena: Call graphs, symbol relationships, code paths
- Anamnesis: Testing patterns used in codebase, conventions
- Both: Understand what actually needs testing

**Research agents:**
- Anamnesis: search_codebase for codebase-related research
- Serena: Deep dive into specific symbols when needed

### Standard Agent Prompt Pattern

```markdown
You have access to:
- **Serena**: Use find_symbol, get_symbols_overview for code structure;
  find_referencing_symbols for relationships
- **Anamnesis**: Use get_project_blueprint for overview;
  search_codebase for semantic search
- **Zettelkasten**: Store findings as permanent notes with zk_create_note;
  link related notes with zk_create_link

Always ground your analysis in actual code via these tools.
```

---

## Agent Totals

| Category | Existing | New | Total |
|----------|----------|-----|-------|
| Architecture & Design | 4 | 0 | 4 |
| Code Quality | 3 | 0 | 3 |
| Security & Performance | 3 | 0 | 3 |
| Testing | 1 | 5 | 6 |
| Debugging | 2 | 0 | 2 |
| Research | 1 | 4 | 5 |
| Documentation | 0 | 6 | 6 |
| Medical/Policy | 0 | 4 | 4 |
| UI/Frontend | 0 | 3 | 3 |
| Synthesis | 1 | 0 | 1 |
| **Total** | **15** | **22** | **37** |

---

## Implementation Order

**Priority 1: Creative/Language**
1. Documentation agents (doc-auditor, architecture-documenter, module-documenter, api-documenter, doc-verifier, claude-md-specialist)
2. `/znote:docs` command
3. Medical/policy agents (policy-analyst, logic-extractor, terminology-resolver, rule-comparator)
4. `/znote:med` command

**Priority 2: Research**
5. Research agents (domain-learner, options-analyst, synthesizer, fact-finder)
6. Update `/znote:research` with orchestrator lead-surfacing

**Priority 3: Testing**
7. Testing agents (test-implementer, coverage-analyst, test-reviewer, e2e-specialist, regression-hunter)
8. Update agent-catalog.md with new testing options

**Priority 4: UI/Frontend**
9. UI agents (ui-architect, ui-test-specialist, ux-analyst)
10. Update agent-catalog.md

**Final:**
11. Update README.md with new agent/command counts
12. Update plugin.json version

---

## Files to Create/Modify

### New Files

**Commands:**
- `commands/docs.md` - `/znote:docs` workflow
- `commands/med.md` - `/znote:med` workflow

**Agents (22 new):**
- `agents/doc-auditor.md`
- `agents/architecture-documenter.md`
- `agents/module-documenter.md`
- `agents/api-documenter.md`
- `agents/doc-verifier.md`
- `agents/claude-md-specialist.md`
- `agents/policy-analyst.md`
- `agents/logic-extractor.md`
- `agents/terminology-resolver.md`
- `agents/rule-comparator.md`
- `agents/domain-learner.md`
- `agents/options-analyst.md`
- `agents/synthesizer.md`
- `agents/fact-finder.md`
- `agents/test-implementer.md`
- `agents/coverage-analyst.md`
- `agents/test-reviewer.md`
- `agents/e2e-specialist.md`
- `agents/regression-hunter.md`
- `agents/ui-architect.md`
- `agents/ui-test-specialist.md`
- `agents/ux-analyst.md`

### Modified Files

- `agent-catalog.md` - Add new categories and agents
- `README.md` - Update counts, add new commands
- `.claude-plugin/plugin.json` - Bump version
