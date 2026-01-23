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
- Git

### Step 1: Clone the Repository

```bash
git clone --recursive https://github.com/YOUR_USERNAME/komi-zone.git ~/repos/komi-zone

# If you forgot --recursive:
cd ~/repos/komi-zone && git submodule update --init --recursive
```

### Step 2: Register the Marketplace

Add komi-zone to `~/.claude/plugins/known_marketplaces.json`:

```json
{
  "komi-zone": {
    "source": {
      "source": "directory",
      "path": "/home/YOUR_USERNAME/repos/komi-zone"
    },
    "installLocation": "/home/YOUR_USERNAME/repos/komi-zone",
    "lastUpdated": "2026-01-22T00:00:00.000Z"
  }
}
```

### Step 3: Enable Plugins

Add to `~/.claude/settings.json` under `enabledPlugins`:

```json
{
  "enabledPlugins": {
    "znote@komi-zone": true
  }
}
```

### Step 4: Register Plugin Installation

Add to `~/.claude/plugins/installed_plugins.json`:

```json
{
  "znote@komi-zone": [
    {
      "scope": "user",
      "installPath": "/home/YOUR_USERNAME/repos/komi-zone/plugins/znote",
      "version": "1.0.0",
      "installedAt": "2026-01-22T00:00:00.000Z",
      "lastUpdated": "2026-01-22T00:00:00.000Z"
    }
  ]
}
```

### Step 5: Restart Claude Code

The plugins will load on the next session.

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

1. Verify submodules are cloned:
   ```bash
   cd ~/repos/komi-zone
   git submodule update --init --recursive
   ```

2. Test server manually:
   ```bash
   cd plugins/znote/mcp-servers/znote-mcp
   uv run python -m znote_mcp.main
   ```

3. Check that `uv` is installed and in PATH

4. Restart Claude Code session

### Plugin not loading

1. Verify paths in `known_marketplaces.json` match your actual clone location
2. Verify `installed_plugins.json` has correct `installPath`
3. Check `settings.json` has `"znote@komi-zone": true`
4. Restart Claude Code

### Submodules empty

```bash
git submodule update --init --recursive
```

## License

MIT
