# komi-zone

A Claude Code plugin marketplace with zettelkasten workflows, specialized agents, and productivity tools.

## Available Plugins

| Plugin | Enable With | Description |
|--------|-------------|-------------|
| **znote** | `znote@komi-zone` | Zettelkasten-integrated workflows with 10 specialized agents, 4 slash commands, and bundled MCP servers |

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed
- [uv](https://github.com/astral-sh/uv) (Python package manager) - for MCP servers

### Quick Install

```bash
# Add the marketplace
claude plugin marketplace add https://github.com/YOUR_USERNAME/komi-zone

# Install the znote plugin
claude plugin install znote@komi-zone
```

Restart Claude Code and you're done.

### Managing Plugins

```bash
# List installed plugins
claude plugin list

# Disable a plugin
claude plugin disable znote@komi-zone

# Enable a plugin
claude plugin enable znote@komi-zone

# Update plugins
claude plugin update znote@komi-zone

# Update marketplace
claude plugin marketplace update komi-zone
```

## znote Plugin

### Slash Commands

| Command | Description |
|---------|-------------|
| `/znote-plans` | Multi-agent implementation planning with zettelkasten documentation |
| `/znote-review` | Multi-agent code review with permanent notes |
| `/znote-debug` | Multi-agent debugging session with documentation |
| `/znote-research` | Research and knowledge synthesis |

### Specialized Agents

- **architecture-planner** - Strategic architecture planning
- **code-detective** - Finds incomplete implementations, dead code, rot
- **code-quality-reviewer** - Maintainability and best practices
- **docs-investigator** - Checks documentation before assuming bugs
- **lateral-debugger** - Unconventional problem-solving approaches
- **performance-analyzer** - Bottleneck identification and optimization
- **refactor-agent** - Identifies refactoring opportunities
- **security-reviewer** - Security vulnerabilities and patterns
- **systematic-debugger** - Rigorous, methodical debugging
- **test-strategist** - Test architecture and mock auditing

### Bundled MCP Servers

The znote plugin includes these MCP servers (loaded automatically):

**znote-mcp** - Zettelkasten knowledge management:
- `zk_create_note`, `zk_get_note`, `zk_update_note`, `zk_delete_note`
- `zk_create_link`, `zk_remove_link`, `zk_find_related`
- `zk_search_notes`, `zk_fts_search`, `zk_list_notes`
- `zk_status`, `zk_system`

**anamnesis** - Semantic code memory:
- Session context and code understanding

### Configure Zettelkasten Path (Optional)

The znote-mcp server stores notes in `~/.zettelkasten/` by default. The plugin's `.mcp.json` sets:

```json
{
  "env": {
    "ZETTELKASTEN_NOTES_DIR": "${HOME}/.zettelkasten/notes",
    "ZETTELKASTEN_DATABASE_PATH": "${HOME}/.zettelkasten/zettelkasten.db"
  }
}
```

## Structure

```
komi-zone/                              # Marketplace root
├── .claude-plugin/
│   └── marketplace.json                # Marketplace manifest
├── plugins/
│   └── znote/                          # znote@komi-zone plugin
│       ├── .claude-plugin/
│       │   └── plugin.json             # Plugin manifest
│       ├── .mcp.json                   # MCP server config
│       ├── agents/                     # 10 specialized agents
│       ├── commands/                   # 4 slash commands
│       └── mcp-servers/                # Bundled servers (submodules)
│           ├── znote-mcp/
│           └── anamnesis/
└── README.md
```

## Adding More Plugins

To add a new plugin to this marketplace:

1. Create `plugins/your-plugin/`
2. Add `.claude-plugin/plugin.json` with name, description, version
3. Add agents, commands, skills, hooks as needed
4. Update `.claude-plugin/marketplace.json` to list the new plugin

## Troubleshooting

### MCP servers not appearing

1. Ensure `uv` is installed and in PATH:
   ```bash
   uv --version
   ```

2. Test the server manually:
   ```bash
   # Find the plugin install location
   claude plugin list

   # Test the server
   cd <install-path>/mcp-servers/znote-mcp
   uv run python -m znote_mcp.main
   ```

3. Restart Claude Code session

### Plugin not loading

```bash
# Check if installed
claude plugin list

# Reinstall if needed
claude plugin uninstall znote@komi-zone
claude plugin install znote@komi-zone
```

### Update marketplace

```bash
claude plugin marketplace update komi-zone
```

## License

MIT
