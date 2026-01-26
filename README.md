# komi-zone

A Claude Code marketplace featuring zettelkasten workflows, specialized agents, and bundled MCP servers.

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed
- [uv](https://github.com/astral-sh/uv) (Python package manager) - for MCP servers

### Quick Install

```bash
# Add komi-zone as a marketplace
claude plugin marketplace add AlexK-Notable/komi-zone

# Install the plugin from the marketplace
claude plugin install komi-zone@komi-zone
```

Restart Claude Code and you're done.

### Managing the Marketplace & Plugin

```bash
# List marketplaces
claude plugin marketplace list

# Update marketplace catalog
claude plugin marketplace update komi-zone

# List installed plugins
claude plugin list

# Disable/enable
claude plugin disable komi-zone
claude plugin enable komi-zone

# Update plugin to latest
claude plugin update komi-zone

# Remove marketplace
claude plugin marketplace remove komi-zone
```

---

## Features

### Slash Commands

| Command | Description |
|---------|-------------|
| `/znote:plans` | Multi-agent implementation planning with zettelkasten documentation |
| `/znote:review` | Multi-agent code review with permanent notes |
| `/znote:debug` | Multi-agent debugging session with documentation |
| `/znote:research` | Research and knowledge synthesis |

### Specialized Agents (15)

**Architecture & Design**
| Agent | Purpose |
|-------|---------|
| **architecture-planner** | Strategic architecture design, phase planning |
| **refactor-agent** | Identifies improvement opportunities |
| **api-designer** | API contract design, endpoint structure |
| **migration-specialist** | Upgrade planning, breaking change management |

**Code Quality**
| Agent | Purpose |
|-------|---------|
| **code-quality-reviewer** | Maintainability, readability, best practices |
| **code-detective** | Finds stubs, TODOs, dead code, incomplete implementations |
| **code-simplifier** | Simplifies code while preserving functionality |

**Security & Performance**
| Agent | Purpose |
|-------|---------|
| **security-reviewer** | Security vulnerabilities and patterns |
| **performance-analyzer** | Bottleneck identification and optimization |
| **dependency-auditor** | Dependency health, vulnerabilities, updates |

**Testing**
| Agent | Purpose |
|-------|---------|
| **test-strategist** | Test architecture and mock auditing |

**Debugging**
| Agent | Purpose |
|-------|---------|
| **lateral-debugger** | Unconventional problem-solving through reframing |
| **systematic-debugger** | Rigorous, methodical hypothesis-driven debugging |

**Research**
| Agent | Purpose |
|-------|---------|
| **docs-investigator** | Checks documentation before assuming bugs are novel |

**Synthesis**
| Agent | Purpose |
|-------|---------|
| **plan-reviewer** | Reviews multi-agent plans for coherence, feasibility, gaps |

### Bundled MCP Servers

**znote-mcp** - Zettelkasten knowledge management:
- Note operations: `zk_create_note`, `zk_get_note`, `zk_update_note`, `zk_delete_note`
- Linking: `zk_create_link`, `zk_remove_link`, `zk_find_related`
- Search: `zk_search_notes`, `zk_fts_search`, `zk_list_notes`
- System: `zk_status`, `zk_system`

Notes are stored in `~/.zettelkasten/` by default.

**anamnesis** - Semantic code intelligence:
- AST parsing for 11 languages (TypeScript, JavaScript, Python, Rust, Go, Java, C, C++, C#, SQL, Ruby)
- Pattern learning from codebase conventions
- Codebase blueprints and architectural overviews
- Approach prediction for implementing features

---

## Structure

```
komi-zone/
├── .claude-plugin/
│   ├── marketplace.json          # Marketplace catalog
│   └── plugin.json               # Plugin manifest
├── .mcp.json                     # MCP server configs
├── agents/                       # 15 specialized agents
├── commands/                     # 4 slash commands
├── hooks/                        # Auto-injection hooks
├── mcp-servers/
│   ├── znote-mcp/               # Zettelkasten MCP (submodule)
│   └── anamnesis/               # Code intelligence MCP (submodule)
├── agent-catalog.md             # Agent selection guide
└── README.md
```

## Troubleshooting

### MCP servers not appearing

1. Ensure `uv` is installed and in PATH:
   ```bash
   uv --version
   ```

2. Test the servers manually:
   ```bash
   # znote-mcp
   cd ~/repos/komi-zone/mcp-servers/znote-mcp
   uv run python -m znote_mcp.main

   # anamnesis
   cd ~/repos/komi-zone/mcp-servers/anamnesis
   uv run python -m anamnesis.mcp_server
   ```

3. Restart Claude Code session

### Plugin not loading

```bash
claude plugin list
claude plugin uninstall komi-zone
claude plugin marketplace update komi-zone
claude plugin install komi-zone@komi-zone
```

## License

MIT
