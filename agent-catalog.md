# Agent Catalog

This catalog describes all available agents for znote workflows. Use this to select appropriate agents for each task.

## How to Use This Catalog

1. **Understand the task** from conversation history and zettelkasten
2. **Consider command affinity** - each command has suggested agent categories
3. **Select agents** based on task requirements, not rigid rules
4. **Present selection** to user with reasoning before execution

---

## Categories & Agents

### Architecture & Design
*For planning, structural decisions, and system evolution*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **architecture-planner** | Strategic architecture design; maps system boundaries, breaks features into phases | New features, system changes, multi-phase implementations |
| **refactor-agent** | Identifies improvement opportunities; consolidation, extraction, pattern unification | Technical debt, code reorganization, pattern inconsistencies |
| **api-designer** | API contract design; endpoint structure, request/response schemas, versioning | New APIs, API refactoring, integration points |
| **migration-specialist** | Upgrade and migration planning; dependency updates, breaking changes, rollout strategy | Framework upgrades, library migrations, deprecation handling |

### Code Quality
*For reviewing, improving, and maintaining code standards*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **code-quality-reviewer** | Maintainability, readability, best practices; scores across quality dimensions | Code reviews, PR reviews, quality assessments |
| **code-detective** | Finds stubs, TODOs, dead code, orphaned components, misleading comments | Completeness audits, codebase cleanup, debt discovery |
| **code-simplifier** | Simplifies code for clarity while preserving functionality; reduces complexity | Post-implementation polish, readability improvements |

### Security & Performance
*For non-functional requirements and risk assessment*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **security-reviewer** | Security vulnerabilities, insecure patterns, remediation recommendations | Security-sensitive code, auth flows, data handling |
| **performance-analyzer** | Bottleneck identification, complexity analysis, optimization recommendations | Performance-critical code, scaling concerns, efficiency |
| **dependency-auditor** | Dependency health, security vulnerabilities, update recommendations | Dependency reviews, supply chain security, version management |

### Testing
*For test strategy, implementation, and quality*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **test-strategist** | Test architecture, mock auditing, behavioral contracts; prevents mock theater | Test planning, coverage gaps, test quality review |
| **test-implementer** | Writes high-quality, meaningful tests; no mock theater | Implementing tests based on strategy |
| **coverage-analyst** | Finds tested vs untested code, identifies blind spots | Coverage assessment, test prioritization |
| **test-reviewer** | Adversarial review of tests; catches mock theater and weak assertions | Test quality audits, CI/CD gates |
| **e2e-specialist** | System-level and integration testing; real dependencies | E2E test design, integration verification |
| **regression-hunter** | Identifies tests needed after changes; prevents regressions | Change impact analysis, regression prevention |

### Debugging
*For problem investigation and root cause analysis*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **lateral-debugger** | Unconventional problem-solving; challenges assumptions, reframes problems | Stuck bugs, counterintuitive issues, fresh perspectives |
| **systematic-debugger** | Methodical investigation; hypothesis formation, controlled experiments | Complex bugs, intermittent issues, evidence-based debugging |

### Research
*For knowledge gathering, synthesis, and fact-finding*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **docs-investigator** | Checks documentation before assuming bugs are novel; searches existing knowledge | Library issues, "is this a bug?" questions, prior art |
| **domain-learner** | Deep dives into unfamiliar topics; builds structured understanding | Learning new technologies, domain expertise |
| **options-analyst** | Compares alternatives, evaluates trade-offs, recommends approaches | Technology selection, approach comparison |
| **synthesizer** | Integrates information from multiple sources into coherent summaries | Multi-source distillation, knowledge consolidation |
| **fact-finder** | Strictly factual retrieval; no inference, cites sources | Accuracy-critical queries, claim verification |

### Documentation
*For generating and maintaining codebase documentation*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **doc-auditor** | Scans for missing, stale, incorrect docs; produces gap reports | Documentation health assessment, audit |
| **architecture-documenter** | System overviews, boundaries, data flows | Architecture documentation |
| **module-documenter** | Package READMEs, module guides, dependency docs | Module-level documentation |
| **api-documenter** | Function/class documentation, API references | API documentation |
| **doc-verifier** | Cross-checks generated docs against code | Documentation accuracy verification |
| **claude-md-specialist** | CLAUDE.md audit, generation, improvement | Project context files |

### Medical/Policy
*For medical policy analysis and rule formalization*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **policy-analyst** | Parses policy documents, extracts conditions and criteria | LCD/NCD analysis, coverage criteria extraction |
| **logic-extractor** | Transforms natural language rules into formal logical structures | Rule formalization, predicate definition |
| **terminology-resolver** | Medical coding expertise (ICD-10, CPT, HCPCS) | Code verification, terminology resolution |
| **rule-comparator** | Compares implementations against source policies | Gap analysis, rule validation |

### UI/Frontend
*For frontend architecture and user experience*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **ui-architect** | Component structure, state management, prop design | Frontend architecture planning |
| **ui-test-specialist** | UI testing, interaction, accessibility | Frontend test implementation |
| **ux-analyst** | User flow analysis, interaction patterns, usability | UX evaluation and improvement |

### Synthesis
*For plan validation and coherence checking*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **plan-reviewer** | Reviews multi-agent plans for coherence, feasibility, gaps | Plan validation, cross-agent coordination, implementation sanity checks |

---

## Command Affinities

These are **suggestions**, not requirements. Override based on actual task needs.

### /znote:plans
**Suggested:** Architecture & Design, Testing

Planning typically benefits from:
- architecture-planner (always valuable for structural planning)
- refactor-agent (when improving existing code)
- test-strategist (when planning includes test coverage)
- api-designer (when designing APIs)
- migration-specialist (when planning upgrades/migrations)

### /znote:review
**Suggested:** Code Quality, Security & Performance, Testing

Reviews typically benefit from:
- code-quality-reviewer (always valuable for reviews)
- code-detective (for completeness checking)
- security-reviewer (for security-sensitive code)
- performance-analyzer (for performance-critical code)
- test-strategist (for test coverage assessment)
- test-reviewer (adversarial test quality check)
- code-simplifier (for polish/cleanup passes)

### /znote:debug
**Suggested:** Debugging, Research, Testing

Debugging typically benefits from:
- lateral-debugger + systematic-debugger (complementary pair)
- docs-investigator (to check if issue is known)
- test-strategist (for regression test planning)
- regression-hunter (for identifying needed tests)

### /znote:research
**Suggested:** Research, any specialist as needed

Research benefits from:
- domain-learner (for comprehensive topic understanding)
- options-analyst (for comparing alternatives)
- synthesizer (for multi-source integration)
- fact-finder (for accuracy-critical information)
- docs-investigator (for documentation research)

**Orchestrator guidance**: After research agents complete, synthesize findings and surface "leads"—particularly valuable insights the user might want to pursue.

### /znote:docs
**Suggested:** Documentation

Documentation typically benefits from:
- doc-auditor (always—starts with gap assessment)
- architecture-documenter (system-level docs)
- module-documenter (package-level docs)
- api-documenter (function/class docs)
- claude-md-specialist (CLAUDE.md files)
- doc-verifier (accuracy verification)

### /znote:med
**Suggested:** Medical/Policy

Medical policy analysis benefits from:
- policy-analyst (document parsing and extraction)
- logic-extractor (formalization)
- terminology-resolver (coding expertise)
- rule-comparator (validation and gap analysis)

---

## Agent Selection Guidelines

### Consider deploying MORE agents when:
- Task is complex or high-stakes
- Multiple perspectives would be valuable
- User explicitly wants thorough analysis
- Prior work in zettelkasten suggests complexity

### Consider deploying FEWER agents when:
- Task is focused and well-defined
- User wants quick results
- Single perspective is sufficient
- Time/resource constraints

### Complementary Pairs
Some agents work well together:
- **architecture-planner + refactor-agent**: Balance stability vs improvement
- **lateral-debugger + systematic-debugger**: Creative + rigorous investigation
- **code-quality-reviewer + code-detective**: Quality + completeness
- **domain-learner + synthesizer**: Deep dive + distillation
- **fact-finder + options-analyst**: Verified facts + comparison
- **doc-auditor + doc-verifier**: Gap finding + accuracy checking
- **policy-analyst + logic-extractor**: Parsing + formalization

### Testing Agent Selection
When test work is needed, consider the full testing pipeline:
1. **test-strategist** → Plans approach
2. **coverage-analyst** → Finds gaps
3. **test-implementer** → Writes tests
4. **test-reviewer** → Validates quality (adversarial)
5. **e2e-specialist** → System-level tests
6. **regression-hunter** → Change impact

### Always Present Your Plan
Before spawning agents, present to user:
1. Which agents you selected and why
2. What each will focus on
3. Ask if they want to add/remove any
4. Wait for confirmation
