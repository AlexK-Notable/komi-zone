# Agent Catalog: /znote:plans

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Architecture & Design Agents

agents[4]{name,purpose}:
  architecture-planner,Strategic architecture design; maps system boundaries; breaks features into phases
  refactor-agent,Identifies improvement opportunities; consolidation; extraction; pattern unification
  api-designer,API contract design; endpoint structure; request/response schemas; versioning
  migration-specialist,Upgrade and migration planning; dependency updates; breaking changes; rollout strategy

## Testing Agents

agents[2]{name,purpose}:
  test-strategist,Test architecture; mock auditing; behavioral contracts; prevents mock theater
  coverage-analyst,Finds tested vs untested code; identifies blind spots

## Security & Performance Agents

agents[3]{name,purpose}:
  security-reviewer,Security vulnerabilities; insecure patterns; remediation recommendations
  performance-analyzer,Bottleneck identification; complexity analysis; optimization recommendations
  dependency-auditor,Dependency health; security vulnerabilities; update recommendations

## Research Agents (when domain knowledge needed)

agents[2]{name,purpose}:
  domain-learner,Deep dives into unfamiliar topics; builds structured understanding
  options-analyst,Compares alternatives; evaluates trade-offs; recommends approaches

## Effort Classification

levels[3]{level,criteria,agent_count}:
  Quick,Well-defined scope; single component; clear path,1-2 agents
  Standard,Moderate scope; 2-3 components; some design decisions,2-4 agents
  Deep,Broad scope; many components; significant architectural decisions,4+ agents

## Complementary Pairs

pairs[3]{agents,synergy}:
  architecture-planner + refactor-agent,Balance stability vs improvement
  architecture-planner + test-strategist,Structure + testability
  domain-learner + options-analyst,Deep understanding + comparison

## Selection Guidelines

- 2-4 agents is typical for planning tasks
- **architecture-planner** is almost always valuable for structural planning
- Add **refactor-agent** when improving existing code
- Add **test-strategist** when planning includes test coverage
- Add **security-reviewer** or **performance-analyzer** only when those concerns are prominent
- Match agent expertise to actual task concerns — don't over-deploy

## Agent Count Heuristics

- **Deploy more** when: task is complex or high-stakes; multiple perspectives valuable; user wants thorough analysis
- **Deploy fewer** when: task is focused and well-defined; user wants quick results; single perspective sufficient

## Full Agent Reference

If the task requires agents outside the recommendations above; any of these are available:

all_agents[39]{name,category}:
  architecture-planner,Architecture & Design
  refactor-agent,Architecture & Design
  api-designer,Architecture & Design
  migration-specialist,Architecture & Design
  code-quality-reviewer,Code Quality
  code-detective,Code Quality
  code-simplifier,Code Quality
  security-reviewer,Security & Performance
  performance-analyzer,Security & Performance
  dependency-auditor,Security & Performance
  test-strategist,Testing
  test-implementer,Testing
  coverage-analyst,Testing
  test-reviewer,Testing
  regression-hunter,Testing
  gate-keeper,Implementation
  feature-implementer,Implementation
  test-scaffolder,Implementation
  lateral-debugger,Debugging
  systematic-debugger,Debugging
  docs-investigator,Research
  domain-learner,Research
  options-analyst,Research
  synthesizer,Research
  fact-finder,Research
  doc-auditor,Documentation
  architecture-documenter,Documentation
  module-documenter,Documentation
  api-documenter,Documentation
  doc-verifier,Documentation
  claude-md-specialist,Documentation
  policy-analyst,Medical/Policy
  logic-extractor,Medical/Policy
  terminology-resolver,Medical/Policy
  rule-comparator,Medical/Policy
  ui-architect,UI/Frontend
  ui-test-specialist,UI/Frontend
  ux-analyst,UI/Frontend
  plan-reviewer,Synthesis
