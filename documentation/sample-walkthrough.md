# UAID Sample Application Walkthrough

This guide walks through the process of using UAID with the sample Express API application included in this repository. It demonstrates the core functionality of UAID and how it enhances AI-assisted development.

## Getting Started

### Prerequisites

- Bash shell environment
- An AI assistant (like Claude, ChatGPT, etc.)
- Basic understanding of Node.js/Express

### Sample Application Overview

The sample application (`sample/app.js`) is a simple Express API that provides CRUD operations for a user resource. It includes:

- Express server setup
- Middleware configuration
- In-memory data store
- API routes for user management
- Error handling

## Step 1: Initialize UAID

First, let's initialize UAID in the project:

```bash
cd /Users/tosinakinosho/workspaces/uaid-implementation
./uaid.sh init
```

This command:
1. Creates the `.ai-dev` directory structure
2. Generates core configuration files
3. Sets up rule definitions
4. Creates prompt templates
5. Initializes adapter placeholders

You should see output confirming that UAID has been initialized successfully.

## Step 2: Analyze the Sample Application

Now, let's analyze the sample Express API:

```bash
./uaid.sh analyze sample/app.js
```

### Behind the Scenes

When you run this command, UAID:

1. **Reads the file**: Loads the content of `sample/app.js`
2. **Collects basic statistics**: Calculates lines of code, file size
3. **Processes the file**: Examines the structure and patterns
4. **Applies relevant rules**: Uses rules from `.ai-dev/rules/` that match the file
5. **Generates analysis metadata**: Saves basic analysis to `.ai-dev/analysis/codebase/sample_app.js.json`
6. **Creates an AI prompt**: Generates a prompt based on the template in `.ai-dev/prompts/code-analysis.txt`

### What You'll See

The command output will include:
- Confirmation that the analysis is complete
- The location of the saved analysis metadata
- An AI prompt that you can copy and send to your preferred AI assistant

The prompt will look something like this:

```
You are a code analysis expert. Please analyze the following code and provide:
1. A summary of what the code does
2. Key functions and their purposes
3. Any potential issues or improvements
4. Dependencies and their roles
5. Architecture patterns identified

CODE:
[The content of sample/app.js will be here]

Please format your analysis in a clear, structured way with headings and bullet points for each section.
```

## Step 3: Get AI Analysis

1. **Copy the generated prompt**: Select the entire prompt from your terminal
2. **Send it to your AI assistant**: Paste the prompt to Claude, ChatGPT, or your preferred AI
3. **Receive the analysis**: The AI will provide a detailed analysis of the code

### Sample AI Response

The AI's response will include a detailed analysis of the Express API, potentially identifying:

- The purpose of the application (a REST API for user management)
- Key routes and their functions (GET, POST, PUT, DELETE operations)
- The middleware used (cors, express.json, morgan)
- Potential issues (in-memory data store, lack of validation)
- Suggested improvements (add authentication, input validation)

## Step 4: Save the AI Analysis

Save the AI's response to enhance UAID's understanding of the code:

```bash
# Create a text file with the AI's response
vi .ai-dev/analysis/codebase/sample_app.js_ai_analysis.txt
# Paste the AI's response and save the file
```

By saving this analysis, you're building up UAID's knowledge base, which will be used for context building in the next steps.

## Step 5: Build Context for the Application

Now that we have an analysis, let's build context for the application:

```bash
./uaid.sh context sample/app.js
```

### Behind the Scenes

When you run this command, UAID:

1. **Checks for existing analysis**: Retrieves the analysis we created earlier
2. **Finds related files**: Identifies other files in the same directory (like `package.json`)
3. **Examines project structure**: Gets a high-level view of the project
4. **Applies context rules**: Uses rules from `.ai-dev/rules/` that apply to context building
5. **Generates context metadata**: Saves basic context to `.ai-dev/analysis/context/sample_app.js.json`
6. **Creates an AI prompt**: Generates a prompt based on the template in `.ai-dev/prompts/context-building.txt`

### What You'll See

The command output will include:
- Confirmation that context building is complete
- The location of the saved context metadata
- An AI prompt for enhanced context building

The prompt will look something like this:

```
You are helping to build comprehensive context for AI-assisted development. Using the following information, create a rich context that would help an AI assistant understand this code better:

FILE: sample/app.js
CODE SUMMARY: [This might include info from the previous analysis if available]
RELATED FILES: sample/package.json
PROJECT STRUCTURE: [Basic project structure information]

Please organize this into a structured context that captures:
1. The purpose and functionality of the code
2. How it fits within the larger project
3. Key dependencies and relationships
4. Patterns and conventions used
5. Important considerations for modifications

This context will be used to improve AI-assisted coding, so focus on what would be most useful for an AI to know when helping with this code.
```

## Step 6: Get Enhanced Context from AI

1. **Copy the generated prompt**: Select the entire prompt from your terminal
2. **Send it to your AI assistant**: Paste the prompt to your preferred AI
3. **Receive the enhanced context**: The AI will provide a comprehensive context for the code

### Sample AI Response

The AI's response will provide a rich context for the application, potentially including:

- The application's purpose and architecture
- The relationship between the Express API and its dependencies
- Common patterns in Express applications
- Considerations for extending the API
- Notes about the in-memory data store and potential real-world adaptations

## Step 7: Save the Enhanced Context

Save the AI's context response:

```bash
# Create a text file with the AI's response
vi .ai-dev/analysis/context/sample_app.js_ai_context.txt
# Paste the AI's response and save the file
```

## Step 8: Use Memory to Store an Interaction

Let's say you have a specific question about implementing authentication in this API. You can use UAID's memory system to store this interaction:

```bash
./uaid.sh memory save "How can I add JWT authentication to this Express API?" sample/app.js
```

### Behind the Scenes

When you run this command, UAID:

1. **Generates a memory ID**: Creates a unique identifier for this interaction
2. **Creates a memory entry**: Saves a template in `.ai-dev/memory/sessions/`
3. **Links to the file**: Associates the query with `sample/app.js`

### What You'll See

The command output will include:
- Confirmation that the memory entry has been created
- The location of the memory file
- Instructions to update the file with the AI's response

## Step 9: Get AI Response for Your Question

1. **Ask your AI assistant**: "How can I add JWT authentication to this Express API?" (including relevant context from your previous interactions)
2. **Receive the response**: The AI will provide guidance on implementing JWT authentication

## Step 10: Save the AI Response to Memory

Edit the memory file to include the AI's response:

```bash
# Find the memory file (the exact filename will be shown in the output from step 8)
vi .ai-dev/memory/sessions/mem_[timestamp]_How_can_I_add_JWT.json
# Update the "response" field with the AI's response
```

## Step 11: Retrieve Memory Later

When you're working on authentication in the future, you can retrieve this memory:

```bash
./uaid.sh memory load "authentication"
```

This will show you all memory entries related to authentication, allowing you to build upon previous interactions.

## Step 12: Generate Metrics for the Application

Let's analyze the code quality metrics:

```bash
./uaid.sh metrics generate sample/app.js
```

### Behind the Scenes

When you run this command, UAID:

1. **Calculates basic metrics**: Lines of code, comment ratio, etc.
2. **Saves metrics metadata**: Stores the metrics in `.ai-dev/analysis/metrics/sample_app.js.json`
3. **Creates an AI prompt**: Generates a prompt based on the template in `.ai-dev/prompts/metrics-generation.txt`

### What You'll See

The command output will include:
- Confirmation that basic metrics have been generated
- The location of the metrics file
- An AI prompt for detailed metrics analysis

## Step 13: Get Detailed Metrics from AI

1. **Copy the generated prompt**: Select the metrics prompt from your terminal
2. **Send it to your AI assistant**: Paste the prompt to your preferred AI
3. **Receive the detailed metrics**: The AI will provide a comprehensive metrics analysis

## Step 14: Save the Detailed Metrics

Save the AI's metrics response:

```bash
# Create a text file with the AI's response
vi .ai-dev/analysis/metrics/sample_app.js_ai_metrics.txt
# Paste the AI's response and save the file
```

## Putting It All Together

By following these steps, you've created a rich knowledge base about the sample application:

1. **Basic Analysis**: Understanding what the code does
2. **Enhanced Context**: How it fits into the larger project
3. **Memory**: Specific interactions about extending the code
4. **Metrics**: Quantitative assessment of code quality

This knowledge base can be:
- Used by AI tools that implement the UAID standard
- Shared between different development environments
- Built upon as the project evolves
- Used to onboard new developers quickly

## Next Steps

Now that you've seen how UAID works with a simple Express application, you can:

1. **Apply it to your own projects**: Initialize UAID in your development projects
2. **Customize rules**: Create custom rules in `.ai-dev/rules/custom/`
3. **Enhance prompt templates**: Modify templates in `.ai-dev/prompts/`
4. **Contribute to UAID**: Help develop the next phases of the standard

## Common Questions and Issues

### Q: My AI assistant doesn't understand the prompt format
**A**: Try simplifying the prompt or breaking it down into smaller parts. You can also modify the prompt templates in `.ai-dev/prompts/`.

### Q: The analysis doesn't capture important aspects of my code
**A**: Create custom rules in `.ai-dev/rules/custom/` to guide the analysis process for your specific needs.

### Q: How can I share this with my team?
**A**: Currently in Phase 1, you can commit the `.ai-dev` directory to your version control system. Future phases will include better team collaboration features.

### Q: Can I use this with my preferred AI tool?
**A**: Yes! The Phase 1 implementation works with any AI assistant. Future phases will include direct integration with specific tools.
