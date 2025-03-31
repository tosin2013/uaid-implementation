# UAID-001: Universal AI Development Standard

**RESEARCH PROJECT**

A common protocol for AI-assisted development tools.

## About

UAID-001 is a research project that defines a universal protocol and directory structure that AI development tools can adopt to provide consistent developer experiences, enable seamless tool-switching, and encourage shared context across tools.

This project aims to solve the fragmentation problem in the AI-assisted development ecosystem by creating a standard that multiple tools can implement, allowing developers to work across tools without losing context or functionality.

## Vision

Our vision is to create an ecosystem where:

1. **Developers can seamlessly switch between AI tools** without losing context or having to re-explain their project
2. **AI dev tools can focus on unique capabilities** rather than reinventing common infrastructure
3. **Projects maintain consistent AI context** regardless of the tools used
4. **Teams can collaborate** across different preferred tools
5. **The ecosystem becomes more interoperable** and less fragmented

## Project Status

This repository contains a phased implementation of the UAID standard:

- **Phase 1**: Shell scripts and prompt templates (current)
- **Phase 2**: Local server implementation (planned)
- **Phase 3**: Mission Control Panel (MCP) server (planned)
- **Phase 4**: Integration & ecosystem expansion (planned)

See the [Development Plan](#development-plan) section for more details.

## Getting Started

### Installation

Make the script executable:

```bash
chmod +x uaid.sh
```

### Basic Usage

Initialize UAID in your project:

```bash
./uaid.sh init
```

Analyze a file:

```bash
./uaid.sh analyze path/to/file.js
```

Build context for a file:

```bash
./uaid.sh context path/to/file.js
```

Manage memory:

```bash
# Save a memory entry
./uaid.sh memory save "How to optimize API performance?" path/to/api.js

# Search memory
./uaid.sh memory load "API performance"
```

Generate metrics for a file:

```bash
./uaid.sh metrics generate path/to/file.js
```

Work with adapters:

```bash
# List available adapters
./uaid.sh adapter list

# Get adapter information
./uaid.sh adapter info cursor
```

## Directory Structure

```
.ai-dev/                # UAID root directory
├── spec.json           # Specification and compatibility info
├── rules/              # Rule definitions
│   ├── core/           # Core rules
│   ├── tools/          # Tool-specific rules
│   └── custom/         # Project-specific rules
├── analysis/           # Analysis outputs
│   ├── codebase/       # Code analysis results
│   ├── context/        # Context building results
│   └── metrics/        # Code metrics
├── memory/             # Memory storage
│   ├── long-term/      # Persistent memory
│   └── sessions/       # Session-based memory
├── adapters/           # Tool adapters
│   ├── cursor/         # Cursor adapter
│   ├── windsurf/       # Windsurf adapter
│   └── roo/            # Roo adapter
└── prompts/            # AI prompt templates
```

## Prompt-Based Workflow

The Phase 1 implementation uses a prompt-based workflow:

1. The UAID shell script prepares the file analysis and context
2. The script generates AI prompts based on templates
3. You copy these prompts to your preferred AI assistant
4. You save the AI's responses back to the UAID directory
5. Future context building and memory operations use these stored analyses

## Development Plan

### Phase 1: Shell Scripts & Prompts (Current)
- Basic shell implementation
- Simple file analysis
- AI prompt templates
- Memory management
- Code metrics
- Tool adapters (placeholder)

### Phase 2: Local Server
- RESTful API
- Enhanced code analysis
- Context building
- Integrated AI calls
- Persistent data storage
- Plugin architecture

### Phase 3: MCP Server
- Centralized server
- Robust tool adapters
- Synchronization between local and central servers
- Team collaboration features
- Access control and permissions
- Analytics and insights

### Phase 4: Integration & Ecosystem
- Public API
- IDE plugins (VS Code, JetBrains, etc.)
- Community adapter library
- Enterprise features
- Standardization process
- Ecosystem growth initiatives

For more detailed plans and diagrams, see the [Documentation](./documentation/) directory.

## Contributing

This is a research project in active development, and contributions are welcome! Here are ways you can contribute:

- **Implementation**: Help develop the different phases
- **Documentation**: Improve explanations and examples
- **Testing**: Try using UAID with different projects and tools
- **Design**: Suggest improvements to the standard
- **Adapters**: Create adapters for additional AI development tools

Please feel free to submit Issues and Pull Requests.

## License

MIT
