# UAID Architecture Diagram

```mermaid
flowchart TD
    classDef coreComponent fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef storage fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef adapters fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef external fill:#f5f5f5,stroke:#616161,stroke-width:1px
    
    subgraph UAID["UAID Standard (.ai-dev)"]
        Spec["spec.json\nVersion & Compatibility"]:::coreComponent
        
        subgraph Rules["Rules System"]
            RulesDir["rules/"]:::coreComponent
            CoreRules["core/\nRequired Rules"]:::coreComponent
            ToolRules["tools/\nTool-specific Rules"]:::coreComponent
            CustomRules["custom/\nProject-specific Rules"]:::coreComponent
            
            RulesDir --> CoreRules
            RulesDir --> ToolRules
            RulesDir --> CustomRules
        end
        
        subgraph Analysis["Analysis System"]
            AnalysisDir["analysis/"]:::coreComponent
            Codebase["codebase/\nCode Analysis"]:::storage
            Context["context/\nContext Building"]:::storage
            Metrics["metrics/\nCode Metrics"]:::storage
            
            AnalysisDir --> Codebase
            AnalysisDir --> Context
            AnalysisDir --> Metrics
        end
        
        subgraph Memory["Memory System"]
            MemoryDir["memory/"]:::coreComponent
            LongTerm["long-term/\nPersistent Memory"]:::storage
            Sessions["sessions/\nSession Memory"]:::storage
            
            MemoryDir --> LongTerm
            MemoryDir --> Sessions
        end
        
        subgraph Adapters["Adapters System"]
            AdaptersDir["adapters/"]:::coreComponent
            CursorAdapter["cursor/\nCursor Adapter"]:::adapters
            WindsurfAdapter["windsurf/\nWindsurf Adapter"]:::adapters
            RooAdapter["roo/\nRoo Adapter"]:::adapters
            
            AdaptersDir --> CursorAdapter
            AdaptersDir --> WindsurfAdapter
            AdaptersDir --> RooAdapter
        end
        
        Prompts["prompts/\nAI Prompt Templates"]:::coreComponent
    end
    
    subgraph AIDevTools["AI Development Tools"]
        Cursor["Cursor"]:::external
        Windsurf["Windsurf"]:::external
        Roo["Roo"]:::external
        OtherTools["Other Tools..."]:::external
    end
    
    subgraph AIServices["AI Services"]
        OpenAI["OpenAI"]:::external
        Claude["Claude"]:::external
        OtherAI["Other AI Models"]:::external
    end
    
    Developer["Developer"]:::external
    
    %% Connections
    Developer <--> AIDevTools
    AIDevTools <--> Adapters
    AIDevTools <--> AIServices
    
    Rules <--> Analysis
    Rules <--> Memory
    Analysis <--> Memory
    
    %% Tool-specific connections
    Cursor <--> CursorAdapter
    Windsurf <--> WindsurfAdapter
    Roo <--> RooAdapter
```

## Key Components Explained

### Core Components

- **spec.json**: Defines UAID version and compatibility information
- **Rules System**: Defines how code is analyzed and understood
- **Analysis System**: Stores results of code analysis and context building
- **Memory System**: Stores interaction history and project knowledge
- **Adapters System**: Provides compatibility with different AI development tools
- **Prompts**: Templates for generating AI prompts

### External Components

- **AI Development Tools**: Tools like Cursor, Windsurf, and Roo that integrate with UAID
- **AI Services**: AI models and services that provide intelligence
- **Developer**: The human developer using the tools

### Relationships

- Developers interact with AI Development Tools
- Tools connect to UAID through Adapters
- Tools also connect to AI Services for intelligence
- Within UAID, the Rules, Analysis, and Memory systems interact to provide comprehensive context
- Each tool has its own Adapter that translates between the tool and UAID
