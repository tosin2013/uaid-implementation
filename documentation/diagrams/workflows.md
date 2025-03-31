# UAID Workflow Diagrams

This file contains Mermaid diagrams illustrating various UAID workflows.

## Code Analysis Workflow {#code-analysis}

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Script as UAID Script
    participant Rules as Rules System
    participant Analysis as Analysis System
    participant AI as AI Assistant
    
    Dev->>Script: ./uaid.sh analyze file.js
    
    Script->>Rules: Load applicable rules
    Rules-->>Script: Return matching rules
    
    Script->>Analysis: Perform basic analysis
    
    Note over Script,Analysis: Collect file stats, structure
    
    Script->>Analysis: Store analysis metadata
    Analysis-->>Script: Confirm storage
    
    Script->>Dev: Generate AI prompt
    
    Dev->>AI: Send generated prompt
    AI->>Dev: Return detailed analysis
    
    Dev->>Analysis: Save AI analysis
    Analysis-->>Dev: Confirm storage
    
    Note over Dev,Analysis: Analysis now available for context building
```

## Context Building Workflow {#context-building}

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Script as UAID Script
    participant Analysis as Analysis System
    participant Memory as Memory System
    participant AI as AI Assistant
    
    Dev->>Script: ./uaid.sh context file.js
    
    Script->>Analysis: Check for existing analysis
    
    alt Analysis exists
        Analysis-->>Script: Return existing analysis
    else No analysis found
        Script->>Analysis: Generate new analysis
        Analysis-->>Script: Return new analysis
    end
    
    Script->>Script: Find related files
    Script->>Script: Identify project structure
    
    Script->>Memory: Check for relevant memories
    Memory-->>Script: Return matching memories
    
    Script->>Analysis: Store context metadata
    Analysis-->>Script: Confirm storage
    
    Script->>Dev: Generate AI prompt with context
    
    Dev->>AI: Send generated prompt
    AI->>Dev: Return enhanced context
    
    Dev->>Analysis: Save AI context
    Analysis-->>Dev: Confirm storage
    
    Note over Dev,Analysis: Rich context now available for AI assistance
```

## Memory Management Workflow {#memory-management}

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Script as UAID Script
    participant Memory as Memory System
    participant AI as AI Assistant
    
    %% Save workflow
    Dev->>Script: ./uaid.sh memory save "Query" file.js
    
    Script->>Memory: Generate memory ID
    Script->>Memory: Create memory entry
    Memory-->>Script: Confirm creation
    
    Script->>Dev: Provide memory file location
    
    Dev->>AI: Ask query
    AI->>Dev: Return response
    
    Dev->>Memory: Save AI response to memory file
    Memory-->>Dev: Confirm storage
    
    %% Load workflow
    Note over Dev,Memory: Later...
    
    Dev->>Script: ./uaid.sh memory load "Search term"
    
    Script->>Memory: Search for matching entries
    Memory-->>Script: Return matching memory files
    
    Script->>Dev: Display matching memories
    
    Dev->>Memory: Read specific memory
    Memory-->>Dev: Display memory content
    
    Note over Dev,Memory: Memory helps inform future questions
```

## Tool Integration Workflow {#tool-integration}

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Tool1 as Tool A (e.g., Cursor)
    participant Adapter1 as Tool A Adapter
    participant UAID as UAID System
    participant Adapter2 as Tool B Adapter
    participant Tool2 as Tool B (e.g., Windsurf)
    
    %% First tool workflow
    Dev->>Tool1: Use Tool A
    
    Tool1->>Adapter1: Initialize UAID adapter
    Adapter1->>UAID: Connect to UAID system
    UAID-->>Adapter1: Confirm connection
    
    Tool1->>Adapter1: Request context for file.js
    Adapter1->>UAID: Retrieve context
    UAID-->>Adapter1: Return context data
    Adapter1-->>Tool1: Provide enhanced context
    
    Tool1->>Dev: Provide AI assistance
    
    Tool1->>Adapter1: Store interaction in memory
    Adapter1->>UAID: Save to memory system
    UAID-->>Adapter1: Confirm storage
    
    %% Switch tools
    Note over Dev,Tool2: Developer switches tools
    
    Dev->>Tool2: Use Tool B
    
    Tool2->>Adapter2: Initialize UAID adapter
    Adapter2->>UAID: Connect to UAID system
    UAID-->>Adapter2: Confirm connection
    
    Tool2->>Adapter2: Request context for same file.js
    Adapter2->>UAID: Retrieve context and memory
    UAID-->>Adapter2: Return comprehensive data
    Adapter2-->>Tool2: Provide enhanced context
    
    Tool2->>Dev: Provide AI assistance with shared context
    
    Note over Dev,Tool2: Context preserved across tools
```

## Phase 1 Implementation Workflow

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Script as UAID Shell Script
    participant Dir as .ai-dev Directory
    participant AI as AI Assistant
    
    Dev->>Script: ./uaid.sh init
    Script->>Dir: Create directory structure
    Script->>Dir: Create initial config files
    Dir-->>Dev: UAID initialized
    
    Dev->>Script: ./uaid.sh analyze file.js
    Script->>Dir: Perform basic analysis
    Script->>Dev: Generate AI prompt
    Dev->>AI: Copy prompt to AI assistant
    AI->>Dev: Return detailed analysis
    Dev->>Dir: Save analysis results
    
    Dev->>Script: ./uaid.sh context file.js
    Script->>Dir: Generate context data
    Script->>Dev: Generate AI prompt with context
    Dev->>AI: Copy prompt to AI assistant
    AI->>Dev: Return enhanced context
    Dev->>Dir: Save context results
    
    Dev->>Script: ./uaid.sh memory save "Query" file.js
    Script->>Dir: Create memory entry
    Dev->>AI: Ask query to AI assistant
    AI->>Dev: Return response
    Dev->>Dir: Save response to memory
    
    Note over Dev,Dir: Phase 1 is manual but establishes the structure
```
