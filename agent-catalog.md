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
*For test strategy and coverage*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **test-strategist** | Test architecture, mock auditing, behavioral contracts; prevents mock theater | Test planning, coverage gaps, test quality review |

### Debugging
*For problem investigation and root cause analysis*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **lateral-debugger** | Unconventional problem-solving; challenges assumptions, reframes problems | Stuck bugs, counterintuitive issues, fresh perspectives |
| **systematic-debugger** | Methodical investigation; hypothesis formation, controlled experiments | Complex bugs, intermittent issues, evidence-based debugging |

### Research
*For knowledge gathering and documentation*

| Agent | Purpose | Good For |
|-------|---------|----------|
| **docs-investigator** | Checks documentation before assuming bugs are novel; searches existing knowledge | Library issues, "is this a bug?" questions, prior art |

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
- code-simplifier (for polish/cleanup passes)

### /znote:debug
**Suggested:** Debugging, Research, Testing

Debugging typically benefits from:
- lateral-debugger + systematic-debugger (complementary pair)
- docs-investigator (to check if issue is known)
- test-strategist (for regression test planning)

### /znote:research
**Suggested:** Research, any specialist as needed

Research is flexible - orchestrator often drives directly, but may spawn:
- docs-investigator (for documentation research)
- Any specialist agent based on research domain

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

### Always Present Your Plan
Before spawning agents, present to user:
1. Which agents you selected and why
2. What each will focus on
3. Ask if they want to add/remove any
4. Wait for confirmation
