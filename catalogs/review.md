# Agent Catalog: /znote:review

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Code Quality Agents

agents[3]{name,purpose}:
  code-quality-reviewer,Maintainability; readability; best practices; scores across quality dimensions
  code-detective,Finds stubs; TODOs; dead code; orphaned components; misleading comments
  code-simplifier,Simplifies code for clarity while preserving functionality; reduces complexity

## Security & Performance Agents

agents[3]{name,purpose}:
  security-reviewer,Security vulnerabilities; insecure patterns; remediation recommendations
  performance-analyzer,Bottleneck identification; complexity analysis; optimization recommendations
  dependency-auditor,Dependency health; security vulnerabilities; update recommendations

## Testing Agents

agents[2]{name,purpose}:
  test-strategist,Test architecture; mock auditing; behavioral contracts; prevents mock theater
  test-reviewer,Adversarial review of tests; catches mock theater and weak assertions

## Additional Reviewers

agents[2]{name,when_to_use}:
  api-designer,When reviewing API changes or contract modifications
  regression-hunter,When assessing change impact on existing functionality

## Effort Classification

levels[3]{level,criteria,reviewer_count}:
  Quick,Single file or small change; narrow concern,1-2 reviewers
  Standard,Module or feature scope; multiple concerns,2-4 reviewers
  Deep,System-wide changes; architectural impact; security-sensitive,4+ reviewers

## Complementary Pairs

pairs[3]{agents,synergy}:
  code-quality-reviewer + code-detective,Quality + completeness
  security-reviewer + performance-analyzer,Security + efficiency
  test-strategist + test-reviewer,Strategy + adversarial validation

## Selection Guidelines

- **code-quality-reviewer + code-detective** is a solid baseline for any review
- Add **security-reviewer** for auth flows; data handling; user input processing
- Add **performance-analyzer** for hot paths; algorithms; resource usage
- Add **code-simplifier** for polish/cleanup passes
- Add **test-strategist** when test coverage or quality is a concern
- Convergent analysis: multiple agents examine same code from different lenses

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
