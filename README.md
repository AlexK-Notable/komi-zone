# komi-zone

A Claude Code plugin marketplace with zettelkasten workflows, specialized agents, and productivity tools.

## Available Plugins

| Plugin | Install Command | Description |
|--------|-----------------|-------------|
| **anamnesis** | `claude plugin install anamnesis@komi-zone` | Semantic code intelligence: AST parsing, pattern learning, codebase blueprints |
| **znote** | `claude plugin install znote@komi-zone` | Zettelkasten-integrated workflows with 10 specialized agents and 4 slash commands |

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed
- [uv](https://github.com/astral-sh/uv) (Python package manager) - for MCP servers

### Quick Install

```bash
# Add the marketplace
claude plugin marketplace add https://github.com/YOUR_USERNAME/komi-zone

# Install plugins (pick what you need)
claude plugin install anamnesis@komi-zone   # Code intelligence
claude plugin install znote@komi-zone       # Zettelkasten workflows
```

Restart Claude Code and you're done.

### Managing Plugins

```bash
# List installed plugins
claude plugin list

# Disable/enable a plugin
claude plugin disable znote@komi-zone
claude plugin enable znote@komi-zone

# Update plugins
claude plugin update znote@komi-zone

# Update marketplace
claude plugin marketplace update komi-zone
```

---

## anamnesis Plugin

Semantic code intelligence MCP server supporting 11 languages.

### Capabilities

- **AST Parsing** - Tree-sitter based parsing for TypeScript, JavaScript, Python, Rust, Go, Java, C, C++, C#, SQL, Ruby
- **Pattern Learning** - Learns codebase conventions and idioms
- **Codebase Blueprints** - High-level architectural overviews
- **Approach Prediction** - Suggests files and patterns for implementing features

### MCP Tools

The anamnesis server provides tools for semantic code analysis (tools prefixed with codebase analysis operations).

---

## znote Plugin

Zettelkasten-integrated workflows that spawn specialized agents to analyze code from multiple perspectives, documenting findings as permanent linked notes.

### Slash Commands

| Command | Description |
|---------|-------------|
| `/znote-plans` | Multi-agent implementation planning with zettelkasten documentation |
| `/znote-review` | Multi-agent code review with permanent notes |
| `/znote-debug` | Multi-agent debugging session with documentation |
| `/znote-research` | Research and knowledge synthesis |

### Specialized Agents

| Agent | Purpose |
|-------|---------|
| **architecture-planner** | Strategic architecture design, phase planning |
| **refactor-agent** | Identifies improvement opportunities (productive tension with architecture-planner) |
| **code-quality-reviewer** | Maintainability, readability, best practices |
| **code-detective** | Finds stubs, TODOs, dead code, incomplete implementations |
| **security-reviewer** | Security vulnerabilities and patterns |
| **performance-analyzer** | Bottleneck identification and optimization |
| **test-strategist** | Test architecture and mock auditing |
| **lateral-debugger** | Unconventional problem-solving through reframing |
| **systematic-debugger** | Rigorous, methodical hypothesis-driven debugging |
| **docs-investigator** | Checks documentation before assuming bugs are novel |

### Bundled MCP Server

**znote-mcp** - Zettelkasten knowledge management:
- Note operations: `zk_create_note`, `zk_get_note`, `zk_update_note`, `zk_delete_note`
- Linking: `zk_create_link`, `zk_remove_link`, `zk_find_related`
- Search: `zk_search_notes`, `zk_fts_search`, `zk_list_notes`
- System: `zk_status`, `zk_system`

Notes are stored in `~/.zettelkasten/` by default.

---

## Structure

```
komi-zone/                              # Marketplace root
├── .claude-plugin/
│   └── marketplace.json                # Marketplace manifest
├── plugins/
│   ├── anamnesis/                      # anamnesis@komi-zone
│   │   ├── .claude-plugin/plugin.json
│   │   ├── .mcp.json
│   │   └── mcp-servers/anamnesis/      # Submodule
│   │
│   └── znote/                          # znote@komi-zone
│       ├── .claude-plugin/plugin.json
│       ├── .mcp.json
│       ├── agents/                     # 10 specialized agents
│       ├── commands/                   # 4 slash commands
│       └── mcp-servers/znote-mcp/      # Submodule
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
   claude plugin list  # Find install path
   cd <install-path>/mcp-servers/<server-name>
   uv run python -m <module>.main
   ```

3. Restart Claude Code session

### Plugin not loading

```bash
claude plugin list
claude plugin uninstall <plugin>@komi-zone
claude plugin install <plugin>@komi-zone
```

### Update marketplace

```bash
claude plugin marketplace update komi-zone
```

## License

MIT
