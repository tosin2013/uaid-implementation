# Code Metrics

This directory contains metrics collected from code analysis. Metrics provide quantitative measurements of code quality, complexity, and other characteristics.

## Metric Types

- **Complexity Metrics**: Cyclomatic complexity, cognitive complexity, etc.
- **Size Metrics**: Lines of code, comment ratio, etc.
- **Maintainability Metrics**: Maintainability index, technical debt, etc.
- **Performance Metrics**: Time complexity estimates, resource usage, etc.
- **Quality Metrics**: Code smell density, bug probability, etc.

## File Format

Metrics are stored in JSON format with the following structure:

```json
{
  "file": "path/to/file.js",
  "timestamp": "2025-03-31T12:34:56Z",
  "metrics": {
    "complexity": {
      "cyclomatic": 12,
      "cognitive": 8
    },
    "size": {
      "lines": 120,
      "comments": 25,
      "commentRatio": 0.21
    },
    "maintainability": {
      "index": 75,
      "technicalDebt": "2h"
    }
  }
}
```

## Usage

Metrics are used by AI tools to:
- Identify code quality issues
- Prioritize refactoring efforts
- Generate better suggestions based on code characteristics
- Track improvements over time
