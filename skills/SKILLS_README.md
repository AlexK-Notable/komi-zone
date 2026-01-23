# Skills Guide

Skills are domain-specific knowledge and guidance that Claude loads when relevant.

## Creating a Skill

Create a markdown file with YAML frontmatter:

```markdown
---
name: my-skill
description: Brief description with trigger keywords. Include topics and use cases.
---

# My Skill

## Purpose
What this skill helps with

## When to Use
Specific scenarios

## Key Information
The actual guidance, patterns, examples
```

## Best Practices

- **Name**: lowercase, hyphens, gerund form preferred (e.g., `debugging-python`)
- **Description**: Include ALL trigger keywords (max 1024 chars)
- **Content**: Keep under 500 lines - use reference files for details
- **Examples**: Include real code examples

## Skill Types

### Domain Skills
Provide comprehensive guidance for specific areas:
- `backend-dev-guidelines.md` - Node.js/Express patterns
- `frontend-patterns.md` - React/TypeScript best practices

### Guardrail Skills
Enforce critical practices:
- `database-verification.md` - Verify schema before queries
- `security-checks.md` - Security validation

## File Structure

```
skills/
├── SKILLS_README.md          # This file
├── my-domain-skill.md        # Domain skill
├── my-guardrail-skill.md     # Guardrail skill
└── resources/                # Reference files for larger skills
    └── detailed-patterns.md
```

## Auto-Activation

Skills are automatically suggested based on:
- Keywords in user prompts
- File paths being edited
- Content patterns in files

See the skill-developer skill documentation for advanced trigger configuration.
