# Sample Application Workflow

This diagram illustrates the step-by-step process of using UAID with the sample Express API application.

## Complete UAID Workflow with Sample Application

```mermaid
sequenceDiagram
    participant Dev as New User
    participant UAID as UAID Shell Script
    participant Files as Sample Express API
    participant AIDir as .ai-dev Directory
    participant AI as AI Assistant

    %% Initialize UAID
    Dev->>UAID: ./uaid.sh init
    UAID->>AIDir: Create directory structure
    UAID->>AIDir: Generate config files
    UAID->>Dev: Confirm successful initialization
    
    %% Analyze sample app
    Dev->>UAID: ./uaid.sh analyze sample/app.js
    UAID->>Files: Read sample/app.js
    UAID->>AIDir: Calculate basic stats
    UAID->>AIDir: Save to analysis/codebase/sample_app.js.json
    UAID->>Dev: Generate AI prompt for analysis
    
    %% AI analysis
    Dev->>AI: Send analysis prompt
    AI->>Dev: Return detailed code analysis
    Dev->>AIDir: Save analysis to analysis/codebase/sample_app.js_ai_analysis.txt
    
    %% Build context
    Dev->>UAID: ./uaid.sh context sample/app.js
    UAID->>AIDir: Check for existing analysis
    UAID->>Files: Find related files (package.json)
    UAID->>AIDir: Save to analysis/context/sample_app.js.json
    UAID->>Dev: Generate AI prompt for context building
    
    %% AI context building
    Dev->>AI: Send context prompt
    AI->>Dev: Return enhanced context
    Dev->>AIDir: Save context to analysis/context/sample_app.js_ai_context.txt
    
    %% Memory management
    Dev->>UAID: ./uaid.sh memory save "How to add authentication?" sample/app.js
    UAID->>AIDir: Create memory entry
    UAID->>Dev: Prompt for AI interaction
    
    %% AI specific question
    Dev->>AI: Ask about adding authentication
    AI->>Dev: Provide implementation guidance
    Dev->>AIDir: Save response to memory/sessions/mem_[timestamp].json
    
    %% Metrics generation
    Dev->>UAID: ./uaid.sh metrics generate sample/app.js
    UAID->>Files: Calculate code metrics
    UAID->>AIDir: Save to analysis/metrics/sample_app.js.json
    UAID->>Dev: Generate AI prompt for detailed metrics
    
    %% AI metrics analysis
    Dev->>AI: Send metrics prompt
    AI->>Dev: Return detailed metrics analysis
    Dev->>AIDir: Save metrics to analysis/metrics/sample_app.js_ai_metrics.txt
    
    %% Later: Memory retrieval
    Note over Dev,AIDir: Later...
    Dev->>UAID: ./uaid.sh memory load "authentication"
    UAID->>AIDir: Search memory entries
    UAID->>Dev: Return matching memory entries
    
    %% Benefits
    Note over Dev,AI: Benefits:
    Note over Dev,AI: ✅ Structured knowledge base
    Note over Dev,AI: ✅ Enhanced AI assistance
    Note over Dev,AI: ✅ Reusable interactions
    Note over Dev,AI: ✅ Consistent approach
```

## Directory Structure After Complete Workflow

```mermaid
flowchart TD
    classDef core fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef analysis fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef memory fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef rules fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    
    Root["uaid-implementation/"]
    
    AIDir[".ai-dev/"]:::core
    Sample["sample/"]
    Docs["documentation/"]
    
    Root --> AIDir
    Root --> Sample
    Root --> Docs
    
    SampleApp["app.js"]:::core
    SamplePkg["package.json"]:::core
    
    Sample --> SampleApp
    Sample --> SamplePkg
    
    Rules["rules/"]:::rules
    Analysis["analysis/"]:::analysis
    Memory["memory/"]:::memory
    Prompts["prompts/"]:::core
    Adapters["adapters/"]:::core
    Spec["spec.json"]:::core
    
    AIDir --> Rules
    AIDir --> Analysis
    AIDir --> Memory
    AIDir --> Prompts
    AIDir --> Adapters
    AIDir --> Spec
    
    CoreRules["core/"]:::rules
    CustomRules["custom/"]:::rules
    ToolRules["tools/"]:::rules
    
    Rules --> CoreRules
    Rules --> CustomRules
    Rules --> ToolRules
    
    Codebase["codebase/"]:::analysis
    Context["context/"]:::analysis
    Metrics["metrics/"]:::analysis
    
    Analysis --> Codebase
    Analysis --> Context
    Analysis --> Metrics
    
    Sessions["sessions/"]:::memory
    LongTerm["long-term/"]:::memory
    
    Memory --> Sessions
    Memory --> LongTerm
    
    %% Sample analysis files
    AppAnalysis["sample_app.js.json"]:::analysis
    AppAIAnalysis["sample_app.js_ai_analysis.txt"]:::analysis
    
    Codebase --> AppAnalysis
    Codebase --> AppAIAnalysis
    
    %% Sample context files
    AppContext["sample_app.js.json"]:::analysis
    AppAIContext["sample_app.js_ai_context.txt"]:::analysis
    
    Context --> AppContext
    Context --> AppAIContext
    
    %% Sample metrics files
    AppMetrics["sample_app.js.json"]:::analysis
    AppAIMetrics["sample_app.js_ai_metrics.txt"]:::analysis
    
    Metrics --> AppMetrics
    Metrics --> AppAIMetrics
    
    %% Sample memory files
    MemoryEntry["mem_timestamp_How_to_add_authentication.json"]:::memory
    
    Sessions --> MemoryEntry
```

## User Experience Flow

```mermaid
flowchart LR
    classDef task fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef action fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef outcome fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    
    Start([Start])
    
    Init["Initialize UAID"]:::task
    Analyze["Analyze Code"]:::task
    Context["Build Context"]:::task
    Memory["Use Memory System"]:::task
    Metrics["Generate Metrics"]:::task
    
    RunInit["./uaid.sh init"]:::action
    RunAnalyze["./uaid.sh analyze sample/app.js"]:::action
    AskAI1["Send prompt to AI Assistant"]:::action
    SaveAnalysis["Save AI analysis"]:::action
    RunContext["./uaid.sh context sample/app.js"]:::action
    AskAI2["Send prompt to AI Assistant"]:::action
    SaveContext["Save AI context"]:::action
    RunMemory["./uaid.sh memory save 'Query' file"]:::action
    AskAI3["Ask question to AI Assistant"]:::action
    SaveMemory["Save AI response to memory"]:::action
    RunMetrics["./uaid.sh metrics generate sample/app.js"]:::action
    AskAI4["Send prompt to AI Assistant"]:::action
    SaveMetrics["Save AI metrics"]:::action
    
    DirCreated["Directory structure created"]:::outcome
    PromptGenerated1["Analysis prompt generated"]:::outcome
    AnalysisReceived["Detailed analysis received"]:::outcome
    AnalysisSaved["Analysis saved to .ai-dev"]:::outcome
    PromptGenerated2["Context prompt generated"]:::outcome
    ContextReceived["Enhanced context received"]:::outcome
    ContextSaved["Context saved to .ai-dev"]:::outcome
    MemoryCreated["Memory entry created"]:::outcome
    ResponseReceived["Implementation guidance received"]:::outcome
    MemorySaved["Response saved to memory"]:::outcome
    MetricsGenerated["Basic metrics generated"]:::outcome
    DetailedMetricsReceived["Detailed metrics received"]:::outcome
    MetricsSaved["Metrics saved to .ai-dev"]:::outcome
    
    End([Enhanced AI Development])
    
    Start --> Init
    Init --> RunInit --> DirCreated
    
    DirCreated --> Analyze
    Analyze --> RunAnalyze --> PromptGenerated1
    PromptGenerated1 --> AskAI1 --> AnalysisReceived
    AnalysisReceived --> SaveAnalysis --> AnalysisSaved
    
    AnalysisSaved --> Context
    Context --> RunContext --> PromptGenerated2
    PromptGenerated2 --> AskAI2 --> ContextReceived
    ContextReceived --> SaveContext --> ContextSaved
    
    ContextSaved --> Memory
    Memory --> RunMemory --> MemoryCreated
    MemoryCreated --> AskAI3 --> ResponseReceived
    ResponseReceived --> SaveMemory --> MemorySaved
    
    MemorySaved --> Metrics
    Metrics --> RunMetrics --> MetricsGenerated
    MetricsGenerated --> AskAI4 --> DetailedMetricsReceived
    DetailedMetricsReceived --> SaveMetrics --> MetricsSaved
    
    MetricsSaved --> End
```

## The Value Chain

```mermaid
flowchart TB
    classDef input fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef process fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef output fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef value fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    
    Code["Sample Express API"]:::input
    UAID["UAID Process"]:::process
    AI["AI Assistant"]:::process
    
    Analysis["Code Analysis"]:::output
    Context["Enhanced Context"]:::output
    Memory["Stored Knowledge"]:::output
    Metrics["Code Metrics"]:::output
    
    BetterCode["Improved Code Quality"]:::value
    FasterDev["Accelerated Development"]:::value
    Knowledge["Knowledge Preservation"]:::value
    Consistency["Consistent AI Assistance"]:::value
    Sharing["Cross-Tool Sharing"]:::value
    
    Code --> UAID
    UAID --> AI
    AI --> Analysis & Context & Memory & Metrics
    
    Analysis --> BetterCode
    Analysis --> FasterDev
    
    Context --> BetterCode
    Context --> FasterDev
    Context --> Consistency
    
    Memory --> Knowledge
    Memory --> Consistency
    Memory --> Sharing
    
    Metrics --> BetterCode
    Metrics --> Knowledge
    
    BetterCode & FasterDev & Knowledge & Consistency & Sharing --> Value(["Business Value"]):::value
```
