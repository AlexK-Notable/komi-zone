#!/bin/bash
# Injects agent-catalog.md into Claude's context when znote commands are invoked

set -euo pipefail

input=$(cat)
user_prompt=$(echo "$input" | jq -r '.user_prompt // ""')

# Check if this is a znote command
if [[ "$user_prompt" =~ ^[[:space:]]*/znote: ]]; then
  catalog_path="${CLAUDE_PLUGIN_ROOT}/agent-catalog.md"

  if [[ -f "$catalog_path" ]]; then
    catalog=$(cat "$catalog_path")
    # Output as systemMessage so Claude sees it in context
    jq -n --arg msg "# Agent Catalog (Auto-Injected)

$catalog" '{"systemMessage": $msg}'
  fi
fi

exit 0
