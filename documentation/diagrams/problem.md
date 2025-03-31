# Problem Statement Diagrams

These diagrams illustrate the problems that UAID aims to solve.

## The Current AI Development Tool Landscape

```mermaid
flowchart TD
    classDef tools fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef configs fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef context fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef dev fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    
    Developer["Developer"]:::dev
    
    subgraph Cursor["Cursor"]
        CursorTool["Cursor Tool"]:::tools
        CursorConfig[".cursor/ Config"]:::configs
        CursorContext["Cursor Context"]:::context
    end
    
    subgraph Windsurf["Windsurf"]
        WindsurfTool["Windsurf Tool"]:::tools
        WindsurfConfig[".windsurf/ Config"]:::configs
        WindsurfContext["Windsurf Context"]:::context
    end
    
    subgraph Roo["Roo"]
        RooTool["Roo Tool"]:::tools
        RooConfig[".roo/ Config"]:::configs
        RooContext["Roo Context"]:::context
    end
    
    subgraph VSCode["VS Code + AI Extension"]
        VSCodeTool["VS Code"]:::tools
        VSCodeConfig[".vscode/ Config"]:::configs
        VSCodeContext["Extension Context"]:::context
    end
    
    %% Developer connections to tools
    Developer --> Cursor
    Developer -.-> Windsurf
    Developer -.-> Roo
    Developer -.-> VSCode
    
    %% No connections between tools
    
    %% Problem callouts
    DuplicateConfig["Problem: Duplicate Configurations"]
    DuplicateConfig -.-> CursorConfig
    DuplicateConfig -.-> WindsurfConfig
    DuplicateConfig -.-> RooConfig
    DuplicateConfig -.-> VSCodeConfig
    
    NoSharedContext["Problem: No Shared Context"]
    NoSharedContext -.-> CursorContext
    NoSharedContext -.-> WindsurfContext
    NoSharedContext -.-> RooContext
    NoSharedContext -.-> VSCodeContext
    
    ContextLoss["Problem: Context Loss When Switching Tools"]
    ContextLoss -.-> Developer
    
    LockIn["Problem: Tool Lock-in"]
    LockIn -.-> Developer
    
    TeamFragmentation["Problem: Team Fragmentation"]
    TeamFragmentation -.-> Developer
```

## Context Loss When Switching Tools

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Tool1 as Tool A
    participant Context1 as Tool A Context
    participant Tool2 as Tool B
    participant Context2 as Tool B Context
    
    Note over Dev,Context2: Without UAID
    
    Dev->>Tool1: Use Tool A
    Tool1->>Context1: Build context
    Context1-->>Tool1: Provide context
    Tool1->>Dev: AI assistance with context
    
    Note over Dev: Decides to switch tools
    
    Dev->>Tool2: Switch to Tool B
    
    Note over Context1,Context2: ❌ Context lost
    
    Tool2->>Context2: Start building context from scratch
    Context2-->>Tool2: Limited initial context
    Tool2->>Dev: Limited AI assistance
    Dev->>Tool2: Rebuild context manually
    Tool2->>Context2: Slowly rebuild context
    Context2-->>Tool2: Gradually improving context
    Tool2->>Dev: Gradually improving assistance
    
    Note over Dev,Context2: Context must be rebuilt
```

## Project Configuration Duplication

```mermaid
flowchart TD
    classDef config fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef shared fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px
    classDef dupe fill:#ffcdd2,stroke:#c62828,stroke-width:2px
    
    subgraph Project["Project Directory"]
        Code["Source Code"]
        
        subgraph Configs["Tool Configurations"]
            CursorConfig[".cursor/"]:::config
            WindsurfConfig[".windsurf/"]:::config
            RooConfig[".roo/"]:::config
            VSCodeConfig[".vscode/ai-config"]:::config
        end
        
        subgraph CursorConfigDetail[".cursor/ Details"]
            CursorIgnore["cursor.ignore"]:::config
            CursorJson["cursor.json"]:::config
            CursorRules["rules.json"]:::config
        end
        
        subgraph WindsurfConfigDetail[".windsurf/ Details"]
            WindsurfIgnore["windsurf.ignore"]:::dupe
            WindsurfJson["config.json"]:::config
            WindsurfRules["rules.json"]:::dupe
        end
        
        subgraph RooConfigDetail[".roo/ Details"]
            RooIgnore["roo.ignore"]:::dupe
            RooJson["roo.json"]:::config
            RooRules["rules.json"]:::dupe
        end
        
        %% Connections to show duplication
        CursorConfig --> CursorConfigDetail
        WindsurfConfig --> WindsurfConfigDetail
        RooConfig --> RooConfigDetail
        
        DuplicatedRules["Duplicated Rules"]:::dupe
        DuplicatedRules -.-> CursorRules
        DuplicatedRules -.-> WindsurfRules
        DuplicatedRules -.-> RooRules
        
        DuplicatedIgnore["Duplicated Ignores"]:::dupe
        DuplicatedIgnore -.-> CursorIgnore
        DuplicatedIgnore -.-> WindsurfIgnore
        DuplicatedIgnore -.-> RooIgnore
    end
    
    subgraph UAIDSolution["With UAID"]
        UAIDDir[".ai-dev/"]:::shared
        UAIDRules["rules/"]:::shared
        UAIDAdapters["adapters/"]:::shared
        
        UAIDDir --> UAIDRules
        UAIDDir --> UAIDAdapters
        
        CursorAdapter["cursor/"]:::config
        WindsurfAdapter["windsurf/"]:::config
        RooAdapter["roo/"]:::config
        
        UAIDAdapters --> CursorAdapter
        UAIDAdapters --> WindsurfAdapter
        UAIDAdapters --> RooAdapter
        
        SharedRules["Shared Rules"]:::shared
        SharedRules -.-> UAIDRules
    end
    
    Project --> UAIDSolution
```

## AI Interaction Silos

```mermaid
flowchart TD
    classDef dev fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef tool fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef ai fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef memory fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef problem fill:#ffcdd2,stroke:#c62828,stroke-width:2px
    
    Dev1["Developer 1"]:::dev
    Dev2["Developer 2"]:::dev
    
    subgraph Tool1["Tool A"]
        Tool1AI["AI Integration"]:::ai
        Tool1Memory["Tool A Memory"]:::memory
    end
    
    subgraph Tool2["Tool B"]
        Tool2AI["AI Integration"]:::ai
        Tool2Memory["Tool B Memory"]:::memory
    end
    
    Dev1 --> Tool1
    Dev1 -.-> Tool2
    Dev2 --> Tool2
    Dev2 -.-> Tool1
    
    Tool1 --> Tool1AI
    Tool1AI --> Tool1Memory
    
    Tool2 --> Tool2AI
    Tool2AI --> Tool2Memory
    
    %% Problem callouts
    NoMemorySharing["Problem: No Memory Sharing"]:::problem
    NoMemorySharing -.-> Tool1Memory
    NoMemorySharing -.-> Tool2Memory
    
    DuplicateQueries["Problem: Duplicate Queries"]:::problem
    DuplicateQueries -.-> Tool1AI
    DuplicateQueries -.-> Tool2AI
    
    NoTeamLearning["Problem: No Team Learning"]:::problem
    NoTeamLearning -.-> Dev1
    NoTeamLearning -.-> Dev2
    
    RedundantWork["Problem: Redundant Work"]:::problem
    RedundantWork -.-> Dev1
    RedundantWork -.-> Dev2
```

## The Impact on Development Speed

```mermaid
graph LR
    classDef productive fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px
    classDef overhead fill:#ffcdd2,stroke:#c62828,stroke-width:2px
    
    subgraph WithoutUAID["Without UAID"]
        ProductiveTime1["Productive Development"]:::productive
        ContextBuilding["Context Building"]:::overhead
        ToolSwitching["Tool Switching Overhead"]:::overhead
        Duplication["Duplicated Work"]:::overhead
        
        ContextBuilding --> ToolSwitching --> Duplication --> ProductiveTime1
    end
    
    subgraph WithUAID["With UAID"]
        ProductiveTime2["Productive Development"]:::productive
        SharedContext["Shared Context"]:::productive
        SeamlessSwitching["Seamless Tool Switching"]:::productive
        Collaboration["Team Collaboration"]:::productive
        
        SharedContext --> SeamlessSwitching --> Collaboration --> ProductiveTime2
    end
    
    WithoutUAID --> WithUAID
```

## Team Collaboration Challenges

```mermaid
flowchart TD
    classDef dev fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    classDef tool fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef context fill:#fff8e1,stroke:#ff8f00,stroke-width:2px
    classDef problem fill:#ffcdd2,stroke:#c62828,stroke-width:2px
    
    subgraph NoUAID["Without UAID"]
        subgraph Team1["Team 1"]
            Dev1["Developer 1"]:::dev
            Dev2["Developer 2"]:::dev
            
            Tool1["Tool A"]:::tool
            Context1["Tool A Context"]:::context
            
            Dev1 --> Tool1
            Dev2 --> Tool1
            Tool1 --> Context1
        end
        
        subgraph Team2["Team 2"]
            Dev3["Developer 3"]:::dev
            Dev4["Developer 4"]:::dev
            
            Tool2["Tool B"]:::tool
            Context2["Tool B Context"]:::context
            
            Dev3 --> Tool2
            Dev4 --> Tool2
            Tool2 --> Context2
        end
        
        NoContextSharing["Problem: No Context Sharing Between Teams"]:::problem
        NoContextSharing -.-> Team1
        NoContextSharing -.-> Team2
        
        ToolConstraint["Problem: Teams Constrained to Same Tool"]:::problem
        ToolConstraint -.-> Team1
        ToolConstraint -.-> Team2
    end
    
    WithUAID["With UAID: Seamless Cross-team Collaboration"]
```
