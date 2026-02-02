# Agent Catalog: /znote:implement

> Tabular data uses TOON format — `label[count]{fields}: rows` — for token efficiency.

## Required Agents

agents[3]{name,role}:
  gate-keeper,Defines deterministic runnable verification criteria before code is written
  feature-implementer,Primary code-writing agent; implements plan phases; self-validates against gates
  test-scaffolder,Writes behavioral tests in parallel with feature-implementer

## Supporting Agents (select as needed)

agents[4]{name,when_to_use}:
  test-strategist,When test coverage is a concern or TDD approach desired
  architecture-planner,When phase involves structural decisions not covered in plan
  refactor-agent,When phase requires improving existing code alongside new code
  regression-hunter,When changes risk breaking existing functionality

## Orchestration Rules

- **gate-keeper** runs ONCE for ALL phases before any code is written
- Phases execute **sequentially**; parallelism happens **within** phases
- Default per-phase: feature-implementer + test-scaffolder in parallel
- After each phase: orchestrator independently re-runs gate checks (never trust self-reporting alone)
- Up to 2 retries on gate failure before escalating to user

## Complementary Pairs

pairs[2]{agents,synergy}:
  gate-keeper + feature-implementer,Independent verification defines acceptance bar for implementation
  feature-implementer + test-scaffolder,Code and tests written in parallel from same phase spec

## Selection Guidelines

- **Always deploy**: gate-keeper + feature-implementer
- **Usually deploy**: test-scaffolder (unless phase has zero test requirements)
- **Sometimes deploy**: test-strategist (complex test needs); architecture-planner (structural ambiguity)
- For phases that split into independent modules → multiple feature-implementer instances

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
