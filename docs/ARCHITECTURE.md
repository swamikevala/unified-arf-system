# System Architecture

## Overview

The Unified ARF System follows a modular, agent-based architecture that combines philosophical evaluation with technical validation.

## Core Components

### 1. Philosophy Engine
- Evaluates mathematical ideas based on elegance criteria
- Scoring system with weighted factors
- Automatic acceptance/rejection thresholds

### 2. Agent Orchestra
- 8 specialized agents working in concert
- Sequential and parallel task execution
- CrewAI-based orchestration

### 3. Model Manager
- Hybrid API/web scraping approach
- Intelligent fallback mechanisms
- Usage tracking and rate limiting

### 4. Validation Engine
- Dataset acquisition from multiple sources
- Python script generation and execution
- Sandboxed environment for safety

### 5. Document Manager
- LaTeX generation and compilation
- Version control integration
- Multi-modal comment system

### 6. State Persistence
- Complete system state serialization
- Graceful shutdown handling
- Automatic resume capabilities

## Data Flow

```
Input (ChatGPT Exports) 
    ↓
Archivist (Parse)
    ↓
Analyst (Extract Concepts)
    ↓
Theorist (Evaluate Elegance)
    ↓
Validator (Run Experiments)
    ↓
Communicator (Clarify)
    ↓
Scribe (Document)
    ↓
Output (LaTeX + Appendices)
```

## Technology Stack

- **Python 3.10+**: Core language
- **CrewAI**: Agent orchestration
- **LangChain**: LLM integration
- **Playwright**: Web automation
- **Flask**: Web interface
- **PyLaTeX**: Document generation
- **Git**: Version control
