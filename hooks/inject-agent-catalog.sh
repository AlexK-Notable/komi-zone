#!/bin/bash
# Injects agent-catalog.md into Claude's context when znote commands are invoked
# NOTE: Uses "*" matcher in hooks.json because UserPromptSubmit matchers cannot
# filter on prompt content — filtering is done here via regex instead.

set -euo pipefail

input=$(cat)
user_prompt=$(echo "$input" | jq -r '.user_prompt // ""')

# Check if this is a znote command
if [[ "$user_prompt" =~ ^[[:space:]]*/znote: ]]; then
  catalog_path="${CLAUDE_PLUGIN_ROOT}/agent-catalog.md"

  if [[ -f "$catalog_path" ]]; then
    # Use --rawfile to avoid shell expansion of catalog contents
    jq -n --rawfile catalog "$catalog_path" \
      '{"systemMessage": ("# Agent Catalog (Auto-Injected)\n\n" + $catalog)}'
  fi
fi

exit 0
