# Agent Catalog: /znote:docs

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Documentation Agents

agents[6]{name,purpose}:
  doc-auditor,Scans for missing; stale; incorrect docs; produces gap reports
  architecture-documenter,System overviews; boundaries; data flows; system guides
  module-documenter,Package READMEs; module guides; dependency docs
  api-documenter,Function/class documentation; API references; usage examples
  claude-md-specialist,CLAUDE.md audit; generation; improvement using quality scoring
  doc-verifier,Cross-checks generated docs against actual code; flags inaccuracies

## Recommended Pipeline

pipeline[4]{step,agent,purpose}:
  1,doc-auditor,Assess gaps — always start here
  2,*-documenter,Generate docs for identified gaps (select appropriate writers)
  3,doc-verifier,Validate generated docs against code
  4,claude-md-specialist,Update CLAUDE.md if project context changed

## Selection Guidelines

- **Always start with**: doc-auditor (gap assessment drives the rest)
- **architecture-documenter**: system-level docs; boundary descriptions
- **module-documenter**: package-level docs; module guides
- **api-documenter**: function/class docs; API references
- **claude-md-specialist**: CLAUDE.md files specifically
- **doc-verifier**: always run last to verify accuracy of generated docs

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
