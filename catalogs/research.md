# Agent Catalog: /znote:research

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Research Agents

agents[5]{name,purpose}:
  domain-learner,Deep dives into unfamiliar topics; builds structured understanding
  options-analyst,Compares alternatives; evaluates trade-offs; recommends approaches
  synthesizer,Integrates information from multiple sources into coherent summaries
  fact-finder,Strictly factual retrieval; no inference; cites sources
  docs-investigator,Checks documentation before assuming bugs are novel; searches existing knowledge

## Specialist Agents (cross-domain support)

agents[3]{name,when_to_use}:
  architecture-planner,When research informs structural decisions
  security-reviewer,When researching security-related topics
  performance-analyzer,When researching performance optimization strategies

## Complementary Pairs

pairs[3]{agents,synergy}:
  domain-learner + synthesizer,Deep dive + distillation
  fact-finder + options-analyst,Verified facts + comparison
  docs-investigator + domain-learner,Known knowledge + new learning

## Selection Guidelines

- **domain-learner** for comprehensive topic understanding
- **options-analyst** for comparing alternatives with trade-off analysis
- **synthesizer** for multi-source integration and distillation
- **fact-finder** for accuracy-critical queries and claim verification
- **docs-investigator** for documentation research and prior art
- After research agents complete: synthesize findings and surface "leads" the user might want to pursue

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
