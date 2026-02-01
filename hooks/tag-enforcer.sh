#!/bin/bash
# tag-enforcer.sh — Ensures note_type value is included as a tag on zk_create_note
# PreToolUse hook scoped to mcp__plugin_znote_znote-mcp__zk_create_note
#
# Test standalone:
#   echo '{"tool_name":"mcp__plugin_znote_znote-mcp__zk_create_note","tool_input":{"title":"Test","note_type":"permanent","tags":"architecture"}}' | bash hooks/tag-enforcer.sh

set -euo pipefail

input=$(cat)
tool_input=$(echo "$input" | jq -r '.tool_input // "{}"' 2>/dev/null)

# Extract current tags (normalize arrays to comma-separated string) and note_type
current_tags=$(echo "$tool_input" | jq -r '
  if (.tags | type) == "array" then (.tags | join(","))
  elif (.tags | type) == "string" then .tags
  else "" end
' 2>/dev/null || echo "")
note_type=$(echo "$tool_input" | jq -r '.note_type // ""' 2>/dev/null)

# Nothing to enforce if no note_type
if [[ -z "$note_type" ]]; then
  exit 0
fi

# Check if note_type is already in tags
if [[ ",$current_tags," == *",$note_type,"* ]] || [[ "$current_tags" == "$note_type" ]]; then
  # Already present, no changes needed
  exit 0
fi

# Add note_type to tags
if [[ -n "$current_tags" ]]; then
  new_tags="${current_tags},${note_type}"
else
  new_tags="$note_type"
fi

# Return updatedInput with corrected tags
updated_input=$(echo "$tool_input" | jq --arg tags "$new_tags" '.tags = $tags' 2>/dev/null)

jq -n --argjson input "$updated_input" '{
  "hookSpecificOutput": {
    "updatedInput": $input
  }
}'

exit 0
