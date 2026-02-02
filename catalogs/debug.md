# Agent Catalog: /znote:debug

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Core Debugging Agents

agents[2]{name,purpose}:
  systematic-debugger,Methodical investigation; hypothesis formation; controlled experiments; evidence-based
  lateral-debugger,Unconventional problem-solving; challenges assumptions; reframes problems

## Supporting Investigators

agents[5]{name,when_to_use}:
  docs-investigator,Might be documented behavior or known library issue
  test-strategist,Want regression tests or test gaps enabled the bug
  performance-analyzer,Performance-related symptoms (slowness; memory; timeouts)
  code-detective,Suspect incomplete implementation or hidden issues
  regression-hunter,Need to identify what tests would prevent recurrence

## Effort Classification

levels[3]{level,criteria,investigator_count}:
  Quick,Reproducible bug; narrow scope; likely single cause,1-2 investigators
  Standard,Intermittent or multi-component; several hypotheses,2-3 investigators
  Deep,Systemic issue; multiple possible root causes; architectural implications,3+ investigators

## Complementary Pairs

pairs[2]{agents,synergy}:
  systematic-debugger + lateral-debugger,Rigorous methodology + creative reframing
  docs-investigator + systematic-debugger,Check known issues + fresh investigation

## Selection Guidelines

- **systematic-debugger** is almost always valuable — rigorous methodology matters
- Add **lateral-debugger** when bug defies explanation or conventional approaches failed
- Add **docs-investigator** when library behavior is suspect or error seems framework-related
- Add **regression-hunter** after diagnosis to prevent recurrence
- 2-3 investigators is typical for debugging sessions

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
