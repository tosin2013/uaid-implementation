#!/bin/bash
# UAID-001 Phase 1: Basic Shell Implementation
# This script creates and manages the core UAID directory structure and files

# Configuration
UAID_DIR=".ai-dev"
VERSION="0.1.0"

# Commands
CMD_INIT="init"
CMD_ANALYZE="analyze"
CMD_CONTEXT="context"
CMD_MEMORY="memory"
CMD_METRICS="metrics"
CMD_ADAPTER="adapter"
CMD_HELP="help"

# Function to show help
show_help() {
  echo "UAID - Universal AI Development Standard CLI"
  echo ""
  echo "Usage: ./uaid.sh [command] [options]"
  echo ""
  echo "Commands:"
  echo "  init                           Initialize UAID in the current project"
  echo "  analyze [file]                 Analyze a file and store the results"
  echo "  context [file]                 Build context for a file"
  echo "  memory [save|load]             Manage memory"
  echo "  metrics [generate|view] [file] Generate or view code metrics"
  echo "  adapter [list|info] [adapter]  Manage tool adapters"
  echo "  help                           Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./uaid.sh init"
  echo "  ./uaid.sh analyze src/main.js"
  echo "  ./uaid.sh context src/main.js"
  echo "  ./uaid.sh memory save 'Query about API optimizations' src/api.js"
  echo "  ./uaid.sh memory load 'API optimization'"
  echo "  ./uaid.sh metrics generate src/main.js"
  echo "  ./uaid.sh adapter list"
}

# Function to initialize UAID
init_uaid() {
  echo "Initializing UAID v$VERSION..."
  
  # Create the directory structure
  mkdir -p "$UAID_DIR/rules/"{core,custom,tools}
  mkdir -p "$UAID_DIR/analysis/"{codebase,context,metrics}
  mkdir -p "$UAID_DIR/memory/"{long-term,sessions}
  mkdir -p "$UAID_DIR/adapters/"{cursor,windsurf,roo}
  mkdir -p "$UAID_DIR/prompts"
  
  # Create spec.json
  cat > "$UAID_DIR/spec.json" << EOF
{
  "name": "UAID-001",
  "version": "$VERSION",
  "description": "Universal AI Development Standard - Simple Implementation",
  "phase": 1,
  "created_at": "$(date -Iseconds)",
  "compatibility": {
    "cursor": "^0.1.0",
    "windsurf": "^0.1.0",
    "roo": "^0.1.0"
  },
  "features": {
    "file_analysis": true,
    "context_building": true,
    "memory_management": true,
    "ai_prompts": true,
    "metrics": true,
    "adapters": true
  }
}
EOF
  
  # Create a sample rule
  cat > "$UAID_DIR/rules/core/code-context.json" << EOF
{
  "id": "core-001",
  "name": "Code Context Extraction",
  "version": "0.1.0",
  "scope": ["code", "ai"],
  "patterns": [
    {
      "type": "file",
      "match": "*.{js,ts,py,java,c,cpp,go,rb,php,cs}"
    }
  ]
}
EOF

  # Create a sample tool-specific rule
  cat > "$UAID_DIR/rules/tools/cursor-rules.json" << EOF
{
  "id": "tool-001",
  "name": "Cursor-specific Rules",
  "version": "0.1.0",
  "tool": "cursor",
  "scope": ["code", "ai"],
  "patterns": [
    {
      "type": "file",
      "match": "*.{js,ts,py}"
    }
  ]
}
EOF

  # Create sample adapters
  cat > "$UAID_DIR/adapters/cursor/adapter.json" << EOF
{
  "name": "cursor-adapter",
  "version": "0.1.0",
  "description": "UAID adapter for Cursor",
  "compatibility": {
    "cursor": "^0.1.0",
    "uaid": "^0.1.0"
  },
  "endpoints": {
    "analyze": "/cursor/analyze",
    "context": "/cursor/context",
    "memory": "/cursor/memory"
  },
  "capabilities": [
    "code-analysis",
    "context-building",
    "memory-management"
  ]
}
EOF

  cat > "$UAID_DIR/adapters/windsurf/adapter.json" << EOF
{
  "name": "windsurf-adapter",
  "version": "0.1.0",
  "description": "UAID adapter for Windsurf",
  "compatibility": {
    "windsurf": "^0.1.0",
    "uaid": "^0.1.0"
  },
  "endpoints": {
    "analyze": "/windsurf/analyze",
    "context": "/windsurf/context",
    "memory": "/windsurf/memory"
  },
  "capabilities": [
    "code-analysis",
    "context-building",
    "memory-management"
  ]
}
EOF

  cat > "$UAID_DIR/adapters/roo/adapter.json" << EOF
{
  "name": "roo-adapter",
  "version": "0.1.0",
  "description": "UAID adapter for Roo",
  "compatibility": {
    "roo": "^0.1.0",
    "uaid": "^0.1.0"
  },
  "endpoints": {
    "analyze": "/roo/analyze",
    "context": "/roo/context",
    "memory": "/roo/memory"
  },
  "capabilities": [
    "code-analysis",
    "context-building",
    "memory-management"
  ]
}
EOF

  # Create a sample prompt template
  cat > "$UAID_DIR/prompts/code-analysis.txt" << EOF
You are a code analysis expert. Please analyze the following code and provide:
1. A summary of what the code does
2. Key functions and their purposes
3. Any potential issues or improvements
4. Dependencies and their roles
5. Architecture patterns identified

CODE:
{{CODE}}

Please format your analysis in a clear, structured way with headings and bullet points for each section.
EOF

  # Create a context building prompt template
  cat > "$UAID_DIR/prompts/context-building.txt" << EOF
You are helping to build comprehensive context for AI-assisted development. Using the following information, create a rich context that would help an AI assistant understand this code better:

FILE: {{FILE}}
CODE SUMMARY: {{SUMMARY}}
RELATED FILES: {{RELATED_FILES}}
PROJECT STRUCTURE: {{PROJECT}}

Please organize this into a structured context that captures the essence of what this code is doing, its relationships to other parts of the project, and any relevant patterns or conventions.
EOF

  # Create a metrics prompt template
  cat > "$UAID_DIR/prompts/metrics-generation.txt" << EOF
You are a code metrics expert. Please analyze the following code and generate metrics for:
1. Code complexity (cyclomatic complexity, cognitive complexity)
2. Size metrics (lines of code, comment ratio)
3. Maintainability metrics (maintainability index, technical debt estimation)
4. Quality metrics (code smell identification, potential bugs)
5. Performance considerations

CODE:
{{CODE}}

Please provide these metrics in a structured JSON format that can be used for automated analysis.
EOF

  echo "UAID initialized successfully!"
  echo "Directory structure created at $UAID_DIR"
}

# Function to analyze a file
analyze_file() {
  local file="$1"
  
  if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    exit 1
  fi
  
  echo "Analyzing file: $file"
  
  # Create the output directory if it doesn't exist
  file_id=$(echo "$file" | tr '/' '_')
  output_dir="$UAID_DIR/analysis/codebase"
  mkdir -p "$output_dir"
  
  # Extract file extension
  ext="${file##*.}"
  
  # Basic file stats
  lines=$(wc -l < "$file")
  size=$(du -h "$file" | cut -f1)
  
  # Generate a simple analysis JSON
  cat > "$output_dir/$file_id.json" << EOF
{
  "file": "$file",
  "analyzed_at": "$(date -Iseconds)",
  "stats": {
    "lines": $lines,
    "size": "$size"
  }
}
EOF
  
  # Get the analysis prompt
  prompt=$(cat "$UAID_DIR/prompts/code-analysis.txt")
  code=$(cat "$file")
  prompt="${prompt//\{\{CODE\}\}/$code}"
  
  echo "Analysis complete! Output saved to $output_dir/$file_id.json"
  echo ""
  echo "-----------------------------------------------"
  echo "AI PROMPT FOR DETAILED ANALYSIS:"
  echo "-----------------------------------------------"
  echo "$prompt"
  echo "-----------------------------------------------"
  echo ""
  echo "Copy this prompt to your preferred AI assistant for detailed analysis."
  echo "Then save the AI's response to $output_dir/${file_id}_ai_analysis.txt"
}

# Function to build context for a file
build_context() {
  local file="$1"
  
  if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    exit 1
  fi
  
  echo "Building context for file: $file"
  
  # Create the output directory if it doesn't exist
  file_id=$(echo "$file" | tr '/' '_')
  output_dir="$UAID_DIR/analysis/context"
  mkdir -p "$output_dir"
  
  # Check if we have an analysis
  analysis_file="$UAID_DIR/analysis/codebase/$file_id.json"
  if [ ! -f "$analysis_file" ]; then
    echo "No analysis found for this file. Running analysis first..."
    analyze_file "$file"
  fi
  
  # Find related files (simple implementation)
  dir=$(dirname "$file")
  related_files=$(find "$dir" -type f -not -path "*/\.*" | grep -v "$file" | head -5 | tr '\n' ', ')
  
  # Simple project structure
  project_structure=$(find . -type f -not -path "*/\.*" -not -path "*/$UAID_DIR/*" | sort | head -20 | sed 's/^\.\///' | tr '\n' ', ')
  
  # Get the context building prompt
  prompt=$(cat "$UAID_DIR/prompts/context-building.txt")
  summary="Please analyze the code and provide a summary"
  prompt="${prompt//\{\{FILE\}\}/$file}"
  prompt="${prompt//\{\{SUMMARY\}\}/$summary}"
  prompt="${prompt//\{\{RELATED_FILES\}\}/$related_files}"
  prompt="${prompt//\{\{PROJECT\}\}/$project_structure}"
  
  # Save the context
  cat > "$output_dir/$file_id.json" << EOF
{
  "file": "$file",
  "generated_at": "$(date -Iseconds)",
  "related_files": "$related_files",
  "project_sample": "$project_structure"
}
EOF
  
  echo "Context building complete! Basic context saved to $output_dir/$file_id.json"
  echo ""
  echo "-----------------------------------------------"
  echo "AI PROMPT FOR ENHANCED CONTEXT:"
  echo "-----------------------------------------------"
  echo "$prompt"
  echo "-----------------------------------------------"
  echo ""
  echo "Copy this prompt to your preferred AI assistant to build enhanced context."
  echo "Then save the AI's response to $output_dir/${file_id}_ai_context.txt"
}

# Function to handle memory operations
handle_memory() {
  local operation="$1"
  shift
  
  case "$operation" in
    "save")
      local query="$1"
      local file="$2"
      
      if [ -z "$query" ] || [ -z "$file" ]; then
        echo "Error: Both query and file are required for memory save"
        echo "Usage: ./uaid.sh memory save 'Your query' path/to/file.js"
        exit 1
      fi
      
      echo "Saving memory entry for query: $query"
      
      # Generate a unique ID
      memory_id="mem_$(date +%s)_$(echo "$query" | tr ' ' '_' | head -c 20)"
      
      # Save the memory entry
      mkdir -p "$UAID_DIR/memory/sessions"
      cat > "$UAID_DIR/memory/sessions/$memory_id.json" << EOF
{
  "id": "$memory_id",
  "timestamp": "$(date -Iseconds)",
  "query": "$query",
  "context": ["$file"],
  "response": "Save the AI response here"
}
EOF
      
      echo "Memory entry saved to $UAID_DIR/memory/sessions/$memory_id.json"
      echo "Please update the response field with the actual AI response"
      ;;
      
    "load")
      local search_term="$1"
      
      if [ -z "$search_term" ]; then
        echo "Error: Search term is required for memory load"
        echo "Usage: ./uaid.sh memory load 'Search term'"
        exit 1
      fi
      
      echo "Searching memory for: $search_term"
      
      # Search for the term in memory files
      grep -l "$search_term" "$UAID_DIR/memory/"{sessions,long-term}/*.json 2>/dev/null
      
      if [ $? -ne 0 ]; then
        echo "No memory entries found matching '$search_term'"
      fi
      ;;
      
    *)
      echo "Error: Unknown memory operation: $operation"
      echo "Available operations: save, load"
      exit 1
      ;;
  esac
}

# Function to handle metrics operations
handle_metrics() {
  local operation="$1"
  shift
  
  case "$operation" in
    "generate")
      local file="$1"
      
      if [ -z "$file" ]; then
        echo "Error: File is required for metrics generation"
        echo "Usage: ./uaid.sh metrics generate path/to/file.js"
        exit 1
      fi
      
      if [ ! -f "$file" ]; then
        echo "Error: File not found: $file"
        exit 1
      fi
      
      echo "Generating metrics for file: $file"
      
      # Create the output directory if it doesn't exist
      file_id=$(echo "$file" | tr '/' '_')
      output_dir="$UAID_DIR/analysis/metrics"
      mkdir -p "$output_dir"
      
      # Extract file extension
      ext="${file##*.}"
      
      # Basic metrics calculation
      lines=$(wc -l < "$file")
      code_lines=$(grep -v '^\s*$' "$file" | grep -v '^\s*\/\/' | grep -v '^\s*\/\*' | grep -v '^\s*\*' | grep -v '^\s*\*\/' | wc -l)
      comment_lines=$(grep -e '^\s*\/\/' -e '^\s*\/\*' -e '^\s*\*' -e '^\s*\*\/' "$file" | wc -l)
      blank_lines=$((lines - code_lines - comment_lines))
      
      # Generate a simple metrics JSON
      cat > "$output_dir/$file_id.json" << EOF
{
  "file": "$file",
  "analyzed_at": "$(date -Iseconds)",
  "metrics": {
    "size": {
      "total_lines": $lines,
      "code_lines": $code_lines,
      "comment_lines": $comment_lines,
      "blank_lines": $blank_lines,
      "comment_ratio": $(echo "scale=2; $comment_lines / $lines" | bc)
    }
  }
}
EOF
      
      # Get the metrics prompt
      prompt=$(cat "$UAID_DIR/prompts/metrics-generation.txt")
      code=$(cat "$file")
      prompt="${prompt//\{\{CODE\}\}/$code}"
      
      echo "Basic metrics generated! Output saved to $output_dir/$file_id.json"
      echo ""
      echo "-----------------------------------------------"
      echo "AI PROMPT FOR DETAILED METRICS:"
      echo "-----------------------------------------------"
      echo "$prompt"
      echo "-----------------------------------------------"
      echo ""
      echo "Copy this prompt to your preferred AI assistant for detailed metrics."
      echo "Then save the AI's response to $output_dir/${file_id}_ai_metrics.txt"
      ;;
      
    "view")
      local file="$1"
      
      if [ -z "$file" ]; then
        echo "Error: File is required for viewing metrics"
        echo "Usage: ./uaid.sh metrics view path/to/file.js"
        exit 1
      fi
      
      file_id=$(echo "$file" | tr '/' '_')
      metrics_file="$UAID_DIR/analysis/metrics/$file_id.json"
      
      if [ ! -f "$metrics_file" ]; then
        echo "No metrics found for file: $file"
        echo "Generate metrics first with: ./uaid.sh metrics generate $file"
        exit 1
      fi
      
      echo "Metrics for $file:"
      cat "$metrics_file"
      ;;
      
    *)
      echo "Error: Unknown metrics operation: $operation"
      echo "Available operations: generate, view"
      exit 1
      ;;
  esac
}

# Function to handle adapter operations
handle_adapter() {
  local operation="$1"
  shift
  
  case "$operation" in
    "list")
      echo "Available adapters:"
      find "$UAID_DIR/adapters" -name "adapter.json" -exec dirname {} \; | sed "s|$UAID_DIR/adapters/||"
      ;;
      
    "info")
      local adapter="$1"
      
      if [ -z "$adapter" ]; then
        echo "Error: Adapter name is required"
        echo "Usage: ./uaid.sh adapter info [adapter]"
        exit 1
      fi
      
      adapter_file="$UAID_DIR/adapters/$adapter/adapter.json"
      
      if [ ! -f "$adapter_file" ]; then
        echo "Error: Adapter not found: $adapter"
        echo "Available adapters:"
        find "$UAID_DIR/adapters" -name "adapter.json" -exec dirname {} \; | sed "s|$UAID_DIR/adapters/||"
        exit 1
      fi
      
      echo "Adapter information for $adapter:"
      cat "$adapter_file"
      ;;
      
    *)
      echo "Error: Unknown adapter operation: $operation"
      echo "Available operations: list, info"
      exit 1
      ;;
  esac
}

# Main script logic
if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

command="$1"
shift

case "$command" in
  "$CMD_INIT")
    init_uaid
    ;;
    
  "$CMD_ANALYZE")
    if [ $# -eq 0 ]; then
      echo "Error: Missing file to analyze"
      echo "Usage: ./uaid.sh analyze path/to/file.js"
      exit 1
    fi
    analyze_file "$1"
    ;;
    
  "$CMD_CONTEXT")
    if [ $# -eq 0 ]; then
      echo "Error: Missing file to build context for"
      echo "Usage: ./uaid.sh context path/to/file.js"
      exit 1
    fi
    build_context "$1"
    ;;
    
  "$CMD_MEMORY")
    if [ $# -eq 0 ]; then
      echo "Error: Missing memory operation"
      echo "Usage: ./uaid.sh memory [save|load] [options]"
      exit 1
    fi
    handle_memory "$@"
    ;;
    
  "$CMD_METRICS")
    if [ $# -eq 0 ]; then
      echo "Error: Missing metrics operation"
      echo "Usage: ./uaid.sh metrics [generate|view] [file]"
      exit 1
    fi
    handle_metrics "$@"
    ;;
    
  "$CMD_ADAPTER")
    if [ $# -eq 0 ]; then
      echo "Error: Missing adapter operation"
      echo "Usage: ./uaid.sh adapter [list|info] [adapter]"
      exit 1
    fi
    handle_adapter "$@"
    ;;
    
  "$CMD_HELP")
    show_help
    ;;
    
  *)
    echo "Error: Unknown command: $command"
    show_help
    exit 1
    ;;
esac

exit 0
