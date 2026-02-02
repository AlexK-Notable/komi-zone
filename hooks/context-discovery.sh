#!/bin/bash
# context-discovery.sh — Auto-discovers installed MCP servers, commands, skills, and agents
# Fires on SessionStart (startup|resume|clear|compact)
# Generates a dynamic tools reference in TOON (Token Oriented Object Notation) format
# for token-efficient context injection.
#
# Test standalone:
#   echo '{"session_id":"test","cwd":"/home/komi/repos/komi-zone"}' | bash hooks/context-discovery.sh

set -euo pipefail

# Consume stdin (hook input)
input=$(cat)
raw_cwd=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null || echo "")
# Canonicalize to prevent path traversal via crafted cwd
cwd=$(realpath -e "$raw_cwd" 2>/dev/null || echo "")

CLAUDE_DIR="${HOME}/.claude"
SETTINGS_FILE="${CLAUDE_DIR}/settings.json"
CACHE_DIR="${CLAUDE_DIR}/plugins/cache"

# Bail if no settings
if [[ ! -f "$SETTINGS_FILE" ]]; then
  exit 0
fi

# ── Collect MCP Servers ──────────────────────────────────────────────

mcp_toon_rows=""
mcp_count=0
declare -A seen_servers  # server_name -> 1 (for deduplication)

# 1. Plugin-bundled MCP servers
# Deduplicate: same plugin may appear under multiple marketplaces
# Resolve all unique plugin paths first, preferring later versions
declare -A plugin_paths  # plugin_name -> version_dir
enabled_plugins=$(jq -r '.enabledPlugins // {} | to_entries[] | select(.value == true) | .key' "$SETTINGS_FILE" 2>/dev/null || echo "")

while IFS= read -r plugin_entry; do
  [[ -z "$plugin_entry" ]] && continue

  plugin_name="${plugin_entry%%@*}"
  marketplace="${plugin_entry##*@}"
  plugin_cache="${CACHE_DIR}/${marketplace}/${plugin_name}"

  [[ ! -d "$plugin_cache" ]] && continue

  version_dir=$(find "$plugin_cache" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort -V | tail -1)
  [[ -z "$version_dir" ]] && continue

  # Keep the latest version if same plugin appears under multiple marketplaces
  plugin_paths["$plugin_name"]="$version_dir"
done <<< "$enabled_plugins"

# Now iterate deduplicated plugins for MCP servers
for plugin_name in "${!plugin_paths[@]}"; do
  version_dir="${plugin_paths[$plugin_name]}"

  # Extract MCP servers from .mcp.json
  mcp_file="${version_dir}/.mcp.json"
  if [[ -f "$mcp_file" ]]; then
    servers=$(jq -r '.mcpServers // {} | keys[]' "$mcp_file" 2>/dev/null || echo "")
    while IFS= read -r server; do
      if [[ -n "$server" && -z "${seen_servers[$server]+x}" ]]; then
        seen_servers["$server"]=1
        mcp_toon_rows+="  ${server},${plugin_name}"$'\n'
        ((mcp_count++)) || true
      fi
    done <<< "$servers"
  fi

  # Also check mcp-servers/ subdirectory pattern (some plugins nest servers)
  if [[ -d "${version_dir}/mcp-servers" ]]; then
    for srv_dir in "${version_dir}/mcp-servers"/*/; do
      [[ ! -d "$srv_dir" ]] && continue
      srv_name=$(basename "$srv_dir")
      # Only add if not already found via .mcp.json
      if [[ -z "${seen_servers[$srv_name]+x}" ]]; then
        seen_servers["$srv_name"]=1
        mcp_toon_rows+="  ${srv_name},${plugin_name} (bundled)"$'\n'
        ((mcp_count++)) || true
      fi
    done
  fi
done

# 2. User-configured MCP servers (in settings.json)
user_mcp=$(jq -r '.mcpServers // {} | keys[]' "$SETTINGS_FILE" 2>/dev/null || echo "")
while IFS= read -r server; do
  if [[ -n "$server" ]]; then
    mcp_toon_rows+="  ${server},user-configured"$'\n'
    ((mcp_count++)) || true
  fi
done <<< "$user_mcp"

# 3. Project-level MCP servers
if [[ -n "$cwd" && -f "${cwd}/.mcp.json" ]]; then
  project_mcp=$(jq -r '.mcpServers // {} | keys[]' "${cwd}/.mcp.json" 2>/dev/null || echo "")
  while IFS= read -r server; do
    if [[ -n "$server" ]]; then
      mcp_toon_rows+="  ${server},project"$'\n'
      ((mcp_count++)) || true
    fi
  done <<< "$project_mcp"
fi

# ── Collect Commands (slash commands) ────────────────────────────────

cmd_toon_rows=""
cmd_count=0

for plugin_name in "${!plugin_paths[@]}"; do
  version_dir="${plugin_paths[$plugin_name]}"

  if [[ -d "${version_dir}/commands" ]]; then
    for cmd_file in "${version_dir}/commands"/*.md; do
      [[ ! -f "$cmd_file" ]] && continue
      cmd_name=$(basename "$cmd_file" .md)
      # Extract description from frontmatter, strip surrounding quotes
      desc=$(sed -n '/^---$/,/^---$/{ /^description:/{ s/^description: *//; s/^["'"'"']//; s/["'"'"']$//; p; q; } }' "$cmd_file" 2>/dev/null || echo "")
      # Truncate long descriptions and replace commas with semicolons for TOON compatibility
      if [[ ${#desc} -gt 60 ]]; then
        desc="${desc:0:57}..."
      fi
      desc="${desc//,/;}"
      cmd_toon_rows+="  /${plugin_name}:${cmd_name},${desc}"$'\n'
      ((cmd_count++)) || true
    done
  fi
done

# ── Collect Skills & Agent counts ────────────────────────────────────

skill_count=0
agent_count=0

for plugin_name in "${!plugin_paths[@]}"; do
  version_dir="${plugin_paths[$plugin_name]}"

  # Count skills
  if [[ -d "${version_dir}/skills" ]]; then
    count=$(find "${version_dir}/skills" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l)
    skill_count=$((skill_count + count))
  fi

  # Count agents
  if [[ -d "${version_dir}/agents" ]]; then
    count=$(find "${version_dir}/agents" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
    agent_count=$((agent_count + count))
  fi
done

# Also count user-level skills
if [[ -d "${CLAUDE_DIR}/skills" ]]; then
  count=$(find "${CLAUDE_DIR}/skills" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l)
  skill_count=$((skill_count + count))
fi

# ── Format Output (TOON) ────────────────────────────────────────────

output=""

if [[ $mcp_count -eq 0 && $cmd_count -eq 0 && $skill_count -eq 0 && $agent_count -eq 0 ]]; then
  exit 0
fi

output+=$'\n'"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$'\n'
output+="Available Tools (Auto-Discovered)"$'\n'
output+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$'\n'

if [[ -n "$mcp_toon_rows" ]]; then
  output+=$'\n'"## MCP Servers"$'\n'
  output+="mcp_servers[${mcp_count}]{name,source}:"$'\n'
  output+="${mcp_toon_rows}"
fi

if [[ -n "$cmd_toon_rows" ]]; then
  output+=$'\n'"## Commands"$'\n'
  output+="commands[${cmd_count}]{command,description}:"$'\n'
  output+="${cmd_toon_rows}"
fi

summary_parts=()
[[ $skill_count -gt 0 ]] && summary_parts+=("${skill_count} skills")
[[ $agent_count -gt 0 ]] && summary_parts+=("${agent_count} agents")

if [[ ${#summary_parts[@]} -gt 0 ]]; then
  output+=$'\n'"Also available: $(IFS=', '; echo "${summary_parts[*]}") (use Skill tool or Task tool to invoke)"$'\n'
fi

output+=$'\n'"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$'\n'

printf '%s' "$output"

exit 0
