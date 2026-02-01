#!/bin/bash
# verify-agent-output.sh — Verifies agent created a zettelkasten note with required tags
# Agent-scoped Stop hook (command type). Called with required tags as arguments.
#
# Usage in agent frontmatter:
#   hooks:
#     Stop:
#       - type: command
#         command: "bash ${CLAUDE_PLUGIN_ROOT}/hooks/verify-agent-output.sh architecture implementation-plan"
#
# Test standalone:
#   echo '{"transcript_path":"/path/to/transcript.jsonl"}' | bash hooks/verify-agent-output.sh architecture implementation-plan
#   echo '{"transcript_path":"__MOCK__"}' | MOCK_TAGS="architecture,code-review" bash hooks/verify-agent-output.sh architecture

set -euo pipefail

# Required tags passed as positional arguments — note must have at least ONE
required_tags=("$@")

if [[ ${#required_tags[@]} -eq 0 ]]; then
  # No tags to verify — allow through
  exit 0
fi

input=$(cat)
raw_path=$(echo "$input" | jq -r '.transcript_path // ""' 2>/dev/null)
# Canonicalize and validate: must be a .jsonl file that exists
if [[ "$raw_path" == "__MOCK__" ]]; then
  transcript_path="__MOCK__"
elif [[ "$raw_path" == *.jsonl ]]; then
  transcript_path=$(realpath -e "$raw_path" 2>/dev/null || echo "")
else
  transcript_path=""
fi

# ── Collect tags from all zk_create_note calls ────────────────────────

found_tags=""

if [[ "$transcript_path" == "__MOCK__" ]]; then
  # Test mode: use MOCK_TAGS env var
  found_tags="${MOCK_TAGS:-}"

elif [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
  # Guard against oversized transcripts that could timeout the hook
  file_size=$(stat -c%s "$transcript_path" 2>/dev/null || echo 0)
  if [[ "$file_size" -gt 52428800 ]]; then
    # Over 50MB — fail open rather than risk timeout bypass
    exit 0
  fi
  # Extract tags from zk_create_note tool_use blocks in transcript
  # Two paths in JSONL:
  #   1. Top-level assistant: .message.content[].input.tags
  #   2. Progress (subagent): .data.message.message.content[].input.tags
  found_tags=$(grep 'zk_create_note' "$transcript_path" 2>/dev/null | head -1000 | jq -r '
    # Path 1: top-level assistant messages
    (.message?.content? // [] | .[]
      | select(.type == "tool_use")
      | select(.name | test("zk_create_note"))
      | .input.tags // empty),
    # Path 2: progress messages (subagent)
    (.data?.message?.message?.content? // [] | .[]
      | select(.type == "tool_use")
      | select(.name | test("zk_create_note"))
      | .input.tags // empty)
  ' 2>/dev/null | paste -sd',' - || echo "")

else
  # No transcript available — fail open
  exit 0
fi

# ── Check results ─────────────────────────────────────────────────────

# No zk_create_note calls found at all
if [[ -z "$found_tags" ]]; then
  cat >&2 <<MSG
You must create a zettelkasten note before completing. Use zk_create_note with:
- Your analysis findings as content
- note_type: "permanent"
- tags: include at least one of: ${required_tags[*]}
Then return the note ID.
MSG
  exit 2
fi

# Normalize: collapse all found tags into a single comma-separated string,
# strip spaces around commas for consistent matching
normalized=$(echo "$found_tags" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | sort -u | paste -sd',' -)

# Check if at least one required tag is present
for req_tag in "${required_tags[@]}"; do
  # Check each normalized tag individually
  while IFS= read -r tag; do
    if [[ "$tag" == "$req_tag" ]]; then
      # Found a match — allow
      exit 0
    fi
  done <<< "$(echo "$normalized" | tr ',' '\n')"
done

# Note was created but without any required tag
cat >&2 <<MSG
Your note is missing a required tag. Add at least one of: ${required_tags[*]}
Use zk_update_note on your existing note to add the tag, then confirm completion.
MSG
exit 2
