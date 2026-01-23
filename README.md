# komi-zone

A self-contained Claude Code enhancement package with zettelkasten workflows, semantic code intelligence, and productivity tools.

## What's Included

| Component | Description |
|-----------|-------------|
| **znote** | Zettelkasten-integrated workflows: planning, code review, research, debugging |
| **znote-mcp** | MCP server for zettelkasten knowledge management |
| **anamnesis** | MCP server for semantic code analysis and intelligence |
| **hooks/** | Customizable automation hooks (template) |
| **skills/** | Domain knowledge and guardrails (template) |

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed
- [uv](https://github.com/astral-sh/uv) (Python package manager)
- Git

### Quick Install

```bash
# Clone with submodules
git clone --recursive https://github.com/YOUR_USERNAME/komi-zone.git

# Or if already cloned without --recursive:
git submodule update --init --recursive

# Install MCP server dependencies
cd komi-zone/mcp-servers/znote-mcp && uv sync
cd ../anamnesis && uv sync
```

### Register the Plugin

Add to your Claude Code plugins:

```bash
# Using Claude Code CLI
claude plugins add /path/to/komi-zone

# Or manually add to ~/.claude/settings.json:
# "enabledPlugins": {
#   "komi-zone@local": true
# }
```

### Configure Zettelkasten Path (Optional)

The znote-mcp server stores notes in `~/.zettelkasten/` by default. To customize:

```bash
export ZETTELKASTEN_NOTES_DIR="$HOME/my-notes"
export ZETTELKASTEN_DATABASE_PATH="$HOME/my-notes/zettelkasten.db"
```

## Usage

### Slash Commands (from znote)

| Command | Description |
|---------|-------------|
| `/znote-plans` | Multi-agent implementation planning with zettelkasten docs |
| `/znote-review` | Multi-agent code review with permanent notes |
| `/znote-debug` | Multi-agent debugging session with documentation |
| `/znote-research` | Research and knowledge synthesis |

### MCP Tools

Once installed, you'll have access to:

**znote-mcp tools:**
- `zk_create_note`, `zk_get_note`, `zk_update_note`, `zk_delete_note`
- `zk_create_link`, `zk_remove_link`
- `zk_search_notes`, `zk_fts_search`
- `zk_add_tag`, `zk_remove_tag`
- And more...

**anamnesis tools:**
- `analyze_codebase` - Semantic code analysis
- `search_codebase` - Intelligent code search
- `get_semantic_insights` - Code pattern insights
- `predict_coding_approach` - Context-aware suggestions
- And more...

## Structure

```
komi-zone/
├── .claude-plugin/
│   └── plugin.json           # Main plugin manifest
├── .mcp.json                  # MCP server configurations
├── hooks/
│   ├── hooks.json            # Hook definitions
│   └── HOOKS_README.md       # How to add hooks
├── skills/
│   └── SKILLS_README.md      # How to add skills
├── mcp-servers/
│   ├── znote-mcp/            # Zettelkasten MCP (submodule)
│   └── anamnesis/            # Code intelligence MCP (submodule)
└── znote/                    # Znote plugin (agents + commands)
    ├── agents/               # 10 specialized agents
    └── commands/             # 4 slash commands
```

## Customization

### Adding Hooks

See `hooks/HOOKS_README.md` for how to add automation hooks.

### Adding Skills

See `skills/SKILLS_README.md` for how to add domain knowledge and guardrails.

## Troubleshooting

### MCP servers not appearing

1. Verify dependencies installed:
   ```bash
   cd mcp-servers/znote-mcp && uv sync
   cd ../anamnesis && uv sync
   ```

2. Test server manually:
   ```bash
   cd mcp-servers/znote-mcp && uv run python -m znote_mcp.main
   ```

3. Restart Claude Code session

### Submodules not cloned

```bash
git submodule update --init --recursive
```

## License

MIT
