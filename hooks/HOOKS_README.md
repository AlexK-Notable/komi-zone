# Hooks Guide

This directory contains hooks that automate actions in Claude Code.

## Available Hook Events

| Event | When it fires | Use case |
|-------|--------------|----------|
| `SessionStart` | When a Claude Code session begins | Initialize state, sync data |
| `UserPromptSubmit` | Before Claude sees user's prompt | Inject context, suggest skills |
| `PreToolUse` | Before a tool executes | Validate, warn, or block actions |
| `PostToolUse` | After a tool executes | Log results, trigger follow-ups |
| `Stop` | After Claude finishes responding | Cleanup, reminders |

## Adding a Hook

Edit `hooks.json`:

```json
{
  "description": "komi-zone hooks",
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/my-startup-script.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/validate-edit.py",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

## Hook Script Behavior

| Exit Code | Meaning |
|-----------|---------|
| 0 | Success - continue normally |
| 2 | Block - prevent the action (PreToolUse only) |
| Other | Error - logged but doesn't block |

- **stdout** → injected as context for Claude
- **stderr** → shown to user (for blocking messages)

## Examples

See the `examples/` directory for sample hook scripts.
