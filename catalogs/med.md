# Agent Catalog: /znote:med

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Medical Policy Agents

agents[4]{name,purpose}:
  policy-analyst,Parses policy documents; extracts conditions; criteria; requirements from LCDs/NCDs
  logic-extractor,Transforms natural language rules into formal logical structures and predicates
  terminology-resolver,Medical coding expertise (ICD-10; CPT; HCPCS); resolves terminology questions
  rule-comparator,Compares implementations against source policies; finds gaps and discrepancies

## Recommended Pipeline

pipeline[4]{step,agent,purpose}:
  1,policy-analyst,Parse and extract from source policy document
  2,terminology-resolver,Verify and resolve all medical codes and terminology
  3,logic-extractor,Formalize extracted criteria into logical rules
  4,rule-comparator,Validate rules against source policy for completeness

## Complementary Pairs

pairs[2]{agents,synergy}:
  policy-analyst + logic-extractor,Parsing + formalization
  terminology-resolver + rule-comparator,Code accuracy + rule validation

## Selection Guidelines

- **policy-analyst** for document parsing and criteria extraction
- **logic-extractor** for formalization into rules
- **terminology-resolver** for coding expertise and term resolution
- **rule-comparator** for gap analysis and validation
- Typical workflow uses all four agents in pipeline order

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
