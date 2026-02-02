#!/bin/bash
# Injects a command-specific TOON agent catalog into Claude's context when znote commands are invoked.
# Uses TOON (Token Oriented Object Notation) catalogs that contain only agents relevant to the
# specific command, reducing token usage by 60-70% compared to injecting the full markdown catalog.
#
# Catalog resolution order:
#   1. ${CLAUDE_PLUGIN_ROOT}/catalogs/${command}.md  (command-specific TOON catalog)
#   2. ${CLAUDE_PLUGIN_ROOT}/agent-catalog.md        (full markdown fallback)
#
# NOTE: Uses "*" matcher in hooks.json because UserPromptSubmit matchers cannot
# filter on prompt content — filtering is done here via regex instead.

set -euo pipefail

input=$(cat)
user_prompt=$(echo "$input" | jq -r '.user_prompt // ""')

# Check if this is a znote command and extract the command name
if [[ "$user_prompt" =~ ^[[:space:]]*/znote:([a-z-]+) ]]; then
  cmd_name="${BASH_REMATCH[1]}"
  catalog_path=""

  # Try command-specific TOON catalog first
  toon_catalog="${CLAUDE_PLUGIN_ROOT}/catalogs/${cmd_name}.md"
  full_catalog="${CLAUDE_PLUGIN_ROOT}/agent-catalog.md"

  if [[ -f "$toon_catalog" ]]; then
    catalog_path="$toon_catalog"
  elif [[ -f "$full_catalog" ]]; then
    catalog_path="$full_catalog"
  fi

  if [[ -n "$catalog_path" && -f "$catalog_path" ]]; then
    # Use --rawfile to avoid shell expansion of catalog contents
    jq -n --rawfile catalog "$catalog_path" \
      '{"systemMessage": ("# Agent Catalog (Auto-Injected)\n\n" + $catalog)}'
  fi
fi

exit 0
