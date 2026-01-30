# Agent Cross-Pollination Pattern

This document describes how agents communicate findings to each other through the orchestrator using zettelkasten notes.

## Overview

Agents cannot directly communicate with each other. Instead, they use a structured flagging system:

1. **Agent A** creates a note with findings and includes flags for other agents
2. **Orchestrator** reviews flags and presents them to the user
3. **User** approves which flags to pursue
4. **Agent B** is directed to read Agent A's note and create a response note
5. **Response notes** link back to original notes, creating an audit trail

## Key Constraints

- **Depth of 1**: Response notes can include flags, but those flags rarely trigger further responses. One reply per flag.
- **User gate**: All flag deployments require user approval. This prevents runaway agent chains.
- **Make it count**: Since agents get one response opportunity, flags should be high-confidence and specific.

## Flag Format

Agents include flags at the END of their notes in this table format:

```markdown
## Flags for Investigation
| Agent | What to Investigate | Priority | Context Location |
|-------|---------------------|----------|------------------|
| test-strategist | Auth module lacks regression tests for the bypass I found | High | Critical Findings section |
| security-reviewer | The performance optimization removes input validation | Medium | Issue 3 |
```

### Flag Guidelines

- **Only flag what you can't address**: Don't flag things you could handle yourself
- **Be specific**: "test-strategist should look at this" is too vague
- **Include context location**: Tell them where in your note to look
- **High confidence only**: Don't flag speculation
- **Priority matters**: High = blocking concern, Medium = should investigate

## Response Note Format

When an agent responds to a flag, they create a structured response note:

```markdown
## Response: [Topic from Original Flag]
**Responding to**: [[original-note-id]]
**Original Flag**: "[Exact flag text]"
**Flagged by**: [Source Agent Name]
**Priority**: [From original flag]

## Investigation
[Analysis of the flagged concern]

## Findings
[What was discovered - facts and evidence]

## Resolution
- **Status**: [Addressed / Partially Addressed / Needs Human Review]
- **Action Taken**: [What was done, if anything]
- **Remaining Concerns**: [Anything unresolved]

## Flags for Investigation
[Only if absolutely necessary - remember depth limit]
| Agent | What to Investigate | Priority | Context Location |
|-------|---------------------|----------|------------------|
| ... | ... | ... | ... |
```

### Response Note Metadata
- note_type: "permanent"
- project: [same as original note]
- tags: "response,[relevant-domain-tags]"

## Workflow Integration

### Phase X.5: Flag Review (in workflow commands)

After a phase where agents produce notes:

1. **Collect Flags**: Read each agent's note, extract "Flags for Investigation" sections
2. **Present to User**: Show flags with source, target, concern, and priority
3. **User Decides**: Approve all, skip specific flags, skip all, or add manual flags
4. **Deploy Responses**: For approved flags, deploy target agents with context

### User Presentation Format

```
## [Phase Name] Complete - Flags Raised

**Summary**: [Brief overview of phase results]

**Flags Requiring Follow-up**:
| From | For | What to Investigate | Priority |
|------|-----|---------------------|----------|
| doc-auditor | security-reviewer | "Auth docs claim OAuth but code uses JWT" | High |
| code-detective | test-strategist | "Dead code in payment module needs characterization tests" | Medium |

**Options**:
- Proceed with all flags
- Skip flag: [specify which]
- Add investigation: [describe]
- Skip all flags and continue
```

### Deploying Response Agents

Prompt template for deploying a response agent:

```
Respond to flag from [source-agent] in note [[note-id]].

Read the note and locate the flag in "Flags for Investigation" section.
The specific concern is: "[exact flag text]"

Create a RESPONSE NOTE that:
- Uses the Response Note format
- Links to the original note with relationship type "responds_to"
- Addresses the specific flagged concern
- Documents your findings clearly
- Notes any remaining concerns

Use note_type: "permanent", project: "[project]"
Return the note ID when complete.
```

## Hub Note Integration

When creating hub/synthesis notes, include a cross-pollination summary if flags were processed:

```markdown
## Cross-Pollination Summary
| Flag | From | To | Response Note | Resolution |
|------|------|----|---------------|------------|
| Auth docs mismatch | doc-auditor | security-reviewer | [[response-note-id]] | Addressed |
| Dead code tests | code-detective | test-strategist | [[response-note-id]] | Needs Human Review |
```

## Best Practices

### For Agents

1. **Don't over-flag**: If you can address it yourself, do so
2. **Be actionable**: Every flag should lead to a clear investigation
3. **Provide context**: Link to specific sections, not just "see my note"
4. **Prioritize correctly**: High priority means blocking or critical

### For Orchestrators

1. **Gate everything**: Always show flags to user before deploying
2. **Batch responses**: Deploy response agents in parallel when possible
3. **Track resolution**: Note which flags led to action vs. "already covered"
4. **Synthesize**: Hub notes should reflect the conversation between agents

### For Users

1. **Review flags critically**: Not every flag needs follow-up
2. **Add your own**: You can inject flags the agents didn't think of
3. **Skip liberally**: If a flag seems low-value, skip it
4. **Follow the trail**: Response notes link to originals for full context

## Example Flow

1. **doc-auditor** creates audit note, flags: "security-reviewer should check auth documentation claims"
2. **Orchestrator** presents flag to user: "doc-auditor flagged security-reviewer..."
3. **User** approves the flag
4. **Orchestrator** deploys security-reviewer with: "Respond to doc-auditor's flag..."
5. **security-reviewer** reads doc-auditor's note, creates response note
6. **Orchestrator** includes response in hub note's cross-pollination section
7. **User** sees the complete picture with linked notes
