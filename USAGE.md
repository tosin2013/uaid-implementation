# UAID-001 Usage Guide

This guide demonstrates how to use the UAID-001 implementation to analyze code, build context, and manage memory.

## Prerequisites

- Bash shell
- An AI assistant (like Claude)

## Quick Start

Here's a simple workflow to get started with UAID:

### 1. Initialize UAID in your project

```bash
./uaid.sh init
```

This creates the `.ai-dev` directory with all necessary subdirectories and configuration files.

### 2. Analyze a file

```bash
./uaid.sh analyze sample/app.js
```

This will:
1. Collect basic stats about the file
2. Save analysis metadata to `.ai-dev/analysis/codebase/sample_app.js.json`
3. Generate an AI prompt for detailed analysis

### 3. Build context for the file

```bash
./uaid.sh context sample/app.js
```

This will:
1. Check for an existing analysis (or create one)
2. Find related files in the same directory
3. Generate an AI prompt for enhanced context building
4. Save basic context metadata to `.ai-dev/analysis/context/sample_app.js.json`

### 4. Save an interaction to memory

```bash
./uaid.sh memory save "How do I add authentication to this API?" sample/app.js
```

This will:
1. Create a memory entry in `.ai-dev/memory/sessions/`
2. Link the memory to the specified file
3. Provide a template for saving the AI's response

### 5. Retrieve relevant memory

```bash
./uaid.sh memory load "authentication"
```

This will:
1. Search for memory entries containing the term "authentication"
2. Display the paths to matching memory files

## Working with AI Prompts

UAID generates AI prompts that you can copy and paste to your preferred AI assistant:

1. Run the analysis or context command
2. Copy the generated prompt that appears in the terminal
3. Send it to your AI assistant
4. Save the AI's response to the appropriate file

### Example Workflow

```bash
# Analyze a file
./uaid.sh analyze sample/app.js

# Copy the generated prompt to Claude
# Save Claude's response to .ai-dev/analysis/codebase/sample_app.js_ai_analysis.txt

# Build context for the file
./uaid.sh context sample/app.js

# Copy the generated prompt to Claude
# Save Claude's response to .ai-dev/analysis/context/sample_app.js_ai_context.txt

# Save an interaction to memory
./uaid.sh memory save "How do I add authentication to this API?" sample/app.js

# Modify the memory file with Claude's response
# For subsequent related queries, retrieve and reference this memory
./uaid.sh memory load "authentication"
```

## Advanced Usage

### Custom Rules

UAID uses rules defined in JSON files to determine how to analyze code and build context:

- **Core rules** in `.ai-dev/rules/core/` apply to all projects
- **Custom rules** in `.ai-dev/rules/custom/` are project-specific

You can create new rules or modify existing ones to customize how UAID analyzes your code.

### Custom Prompt Templates

UAID includes several prompt templates in `.ai-dev/prompts/`:

- `code-analysis.txt`: For analyzing code files
- `context-building.txt`: For building comprehensive context
- `refactoring.txt`: For refactoring suggestions
- `documentation.txt`: For generating documentation
- `memory-retrieval.txt`: For using past interactions

You can customize these templates or create new ones to suit your specific needs.

## Next Steps

This is just the beginning of the UAID journey. Future phases will include:

- Phase 2: Local server implementation
- Phase 3: MCP server with centralized control
- Phase 4: Integration with development tools and ecosystem expansion

Stay tuned for updates!
