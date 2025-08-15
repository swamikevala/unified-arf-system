#!/bin/bash

# GitHub Repository Setup Script for Unified ARF System
# Run this script to create and push the repository to GitHub

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   GitHub Repository Setup for Unified ARF System         ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Configuration
GITHUB_USERNAME="swamikevala"
REPO_NAME="unified-arf-system"
REPO_DESCRIPTION="Autonomous Research Framework for Mathematical Physics - An AI-powered system that continuously develops mathematical frameworks with elegance and inevitability"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
fi

# Check if gh CLI is installed (required)
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI is not installed. Please install it first:"
    echo "   sudo apt update && sudo apt install gh"
    exit 1
fi

echo "✅ GitHub CLI detected."

# Check for GitHub token file
if [ ! -f "github-token.txt" ]; then
    echo "❌ github-token.txt not found!"
    echo ""
    echo "Please create a Personal Access Token:"
    echo "1. Go to: https://github.com/settings/tokens/new"
    echo "2. Name: 'ARF System Token'"
    echo "3. Select scopes: repo, workflow"
    echo "4. Click 'Generate token'"
    echo "5. Save token to github-token.txt in this directory"
    echo ""
    exit 1
fi

echo "📄 Found github-token.txt"

# Authenticate with GitHub CLI using token
echo "🔐 Authenticating with GitHub..."
if ! gh auth login --with-token < github-token.txt 2>/dev/null; then
    echo "❌ GitHub authentication failed!"
    echo "Please check your token in github-token.txt"
    echo "Make sure it has 'repo' and 'workflow' scopes"
    exit 1
fi

echo "✅ Successfully authenticated with GitHub"

# Verify authentication
if ! gh auth status >/dev/null 2>&1; then
    echo "❌ GitHub authentication verification failed!"
    exit 1
fi

# Initialize git repository
echo "📁 Initializing git repository..."
git init

# Create .gitignore file
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST
.pytest_cache/
.coverage
.tox/
.hypothesis/
*.log

# Virtual Environment
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Environment files
.env
.env.local
.env.*.local

# State and cache
state/
cache/
*.pkl
*.pickle

# Validation data (too large for git)
validation_data/*.csv
validation_data/*.json
validation_data/*.xlsx
validation_results/
validation_scripts/venv_*/

# Output files (keep structure but not content)
output/**/*.pdf
output/**/*.aux
output/**/*.log
output/**/*.out
output/**/*.toc
output/**/*.synctex.gz

# Keep empty directories
!output/.gitkeep
!input/.gitkeep
!state/.gitkeep
!validation_data/.gitkeep

# Logs
logs/
*.log

# Database
*.db
*.sqlite
*.sqlite3

# Jupyter
.ipynb_checkpoints/
*.ipynb

# Node (for web interface)
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Playwright
playwright-report/
test-results/

# macOS
.DS_Store
.AppleDouble
.LSOverride

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini

# Linux
.directory
.Trash-*
EOF

# Create LICENSE file (MIT License)
echo "📜 Creating LICENSE..."
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 Swami Kevala

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Create CONTRIBUTING.md
echo "🤝 Creating CONTRIBUTING.md..."
cat > CONTRIBUTING.md << 'EOF'
# Contributing to Unified ARF System

Thank you for your interest in contributing to the Unified Autonomous Research Framework!

## 🎯 Philosophy

When contributing, please keep in mind our core philosophical principles:
- **Inevitability**: Features should feel necessary, not arbitrary
- **Elegance**: Solutions should be beautiful and simple
- **Parsimony**: Avoid unnecessary complexity
- **Explanatory Power**: Contributions should unify or clarify

## 🚀 Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes following the guidelines below
4. Test thoroughly
5. Submit a pull request

## 📝 Contribution Guidelines

### Code Style
- Follow PEP 8 for Python code
- Use type hints where appropriate
- Document all functions and classes
- Keep functions focused and small

### Adding New Agents
When adding a new agent:
1. Define its philosophical role clearly
2. Ensure it complements existing agents
3. Document its evaluation criteria
4. Add appropriate tests

### Adding Validation Sources
New data sources should:
1. Be freely accessible or have clear licensing
2. Include proper caching mechanisms
3. Have error handling for network issues
4. Document the data format

### Philosophy Modifications
Changes to the evaluation criteria require:
1. Clear justification
2. Examples of improved outcomes
3. Discussion in an issue before implementation

## 🧪 Testing

Run tests before submitting:
```bash
pytest tests/
```

For new features, add tests in `tests/test_your_feature.py`

## 📖 Documentation

- Update README.md if adding major features
- Document new configuration options
- Include docstrings for all new functions
- Add examples for complex features

## 🐛 Bug Reports

When reporting bugs, please include:
1. System configuration (OS, Python version)
2. Relevant parts of config.yaml
3. Error messages and logs
4. Steps to reproduce

## 💡 Feature Requests

Feature requests should:
1. Align with the philosophical core
2. Include use cases
3. Consider impact on existing functionality
4. Be discussed in issues first

## 🔄 Pull Request Process

1. Update documentation
2. Add tests for new functionality
3. Ensure all tests pass
4. Update CHANGELOG.md
5. Request review from maintainers

## 📊 Code Review Criteria

PRs will be evaluated on:
- Philosophical alignment
- Code quality and style
- Test coverage
- Documentation completeness
- Performance impact

## 🌟 Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md
- Release notes
- Project documentation

## 📬 Contact

For major changes or philosophical discussions, open an issue first.

Thank you for helping make mathematical research more autonomous and elegant!
EOF

# Create CHANGELOG.md
echo "📋 Creating CHANGELOG.md..."
cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to the Unified ARF System will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of Unified Autonomous Research Framework
- Core philosophical evaluation system (inevitability, symmetry, parsimony)
- Eight specialized agents for research pipeline
- Hybrid API/web scraping model access
- Validation engine with dataset integration
- Continuous operation with state persistence
- LaTeX document generation with technical appendices
- Web dashboard for monitoring and comments
- External source integration (YouTube, articles, arXiv)
- Multi-modal comment system
- Graceful shutdown and resume capabilities

### Technical Stack
- CrewAI for agent orchestration
- LangChain for LLM integration
- Playwright for web automation
- Flask for web interface
- PyLaTeX for document generation

## [0.1.0] - 2024-01-XX (Planned)

### Planned Features
- Docker containerization
- Cloud deployment options
- Enhanced validation visualizations
- Real-time collaboration features
- Plugin system for custom agents
EOF

# Create CODE_OF_CONDUCT.md
echo "🤝 Creating CODE_OF_CONDUCT.md..."
cat > CODE_OF_CONDUCT.md << 'EOF'
# Code of Conduct

## Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

## Our Standards

Examples of behavior that contributes to creating a positive environment include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members
* Pursuing mathematical elegance and philosophical rigor

Examples of unacceptable behavior include:

* Harassment of any kind
* Publishing others' private information without permission
* Conduct which could reasonably be considered inappropriate in a professional setting
* Arbitrary or inelegant solutions (philosophically speaking!)

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting the project team. All complaints will be reviewed and investigated promptly and fairly.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant](https://www.contributor-covenant.org), version 2.0.
EOF

# Create .github directory structure
echo "📁 Creating GitHub workflows..."
mkdir -p .github/workflows
mkdir -p .github/ISSUE_TEMPLATE

# Create CI workflow
cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.10, 3.11, 3.12]

    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install pytest pytest-cov
    
    - name: Run tests
      run: |
        pytest tests/ --cov=src --cov-report=xml
    
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
EOF

# Create issue templates
cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Configuration settings
2. Input data used
3. Command executed
4. Error message

**Expected behavior**
What you expected to happen.

**System Information:**
- OS: [e.g., Ubuntu 22.04]
- Python version: [e.g., 3.10.6]
- ARF version: [e.g., 0.1.0]

**Logs**
Please attach relevant log files from `logs/arf_system.log`

**Additional context**
Add any other context about the problem here.
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Philosophical Alignment**
How does this feature align with the principles of inevitability, elegance, and parsimony?

**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
EOF

# Create empty directories with .gitkeep files
echo "📁 Creating directory structure..."
directories=(
    "input"
    "output/latex"
    "output/appendices"
    "output/summary"
    "output/questions"
    "state"
    "logs"
    "validation_data"
    "validation_scripts"
    "validation_results"
    "cache/models"
    "cache/datasets"
    "web/static"
    "web/templates"
    "tests"
    "docs"
    "src"
)

for dir in "${directories[@]}"; do
    mkdir -p "$dir"
    touch "$dir/.gitkeep"
done

# Create a simple test file
cat > tests/test_philosophy.py << 'EOF'
"""Test philosophical evaluation criteria"""

import pytest
from dataclasses import dataclass

@dataclass
class EvaluationCriteria:
    inevitability: float = 0.30
    symmetry: float = 0.25
    parsimony: float = 0.25
    explanatory_power: float = 0.20

def test_criteria_weights_sum_to_one():
    """Ensure philosophical weights sum to 1.0"""
    criteria = EvaluationCriteria()
    total = (criteria.inevitability + 
             criteria.symmetry + 
             criteria.parsimony + 
             criteria.explanatory_power)
    assert abs(total - 1.0) < 0.001

def test_evaluate_elegant_idea():
    """Test evaluation of an elegant mathematical idea"""
    criteria = EvaluationCriteria()
    # Simulate scoring an elegant idea
    score = (0.9 * criteria.inevitability +
             0.8 * criteria.symmetry +
             0.85 * criteria.parsimony +
             0.7 * criteria.explanatory_power)
    assert score > 0.75  # Should pass acceptance threshold
EOF

# Create project documentation
cat > docs/ARCHITECTURE.md << 'EOF'
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
EOF

# Add all files to git
echo "📦 Adding files to git..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: Unified Autonomous Research Framework

- Core philosophical evaluation system
- 8 specialized research agents
- Hybrid API/web scraping capabilities
- Validation engine with real datasets
- Continuous operation with state persistence
- LaTeX document generation
- Web dashboard interface
- Complete documentation and setup scripts"

# Create repository using GitHub CLI
echo ""
echo "🌐 Creating GitHub repository..."
if ! gh repo create "$REPO_NAME" \
    --public \
    --description "$REPO_DESCRIPTION" \
    --homepage "https://github.com/$GITHUB_USERNAME/$REPO_NAME" \
    --remote origin \
    --source . \
    --push 2>/dev/null; then
    
    echo "❌ Failed to create repository!"
    echo "Possible reasons:"
    echo "- Repository might already exist"
    echo "- Token might not have sufficient permissions"
    echo "- Network issues"
    exit 1
fi

echo ""
echo "✅ Repository created and pushed successfully!"
echo "🔗 View your repository at: https://github.com/$GITHUB_USERNAME/$REPO_NAME"

# Set topics
echo "🏷️ Setting repository topics..."
if ! gh repo edit "$GITHUB_USERNAME/$REPO_NAME" \
    --add-topic "artificial-intelligence" \
    --add-topic "mathematical-physics" \
    --add-topic "autonomous-research" \
    --add-topic "crewai" \
    --add-topic "langchain" \
    --add-topic "python" 2>/dev/null; then
    
    echo "⚠️ Warning: Could not set repository topics (non-critical)"
fi

echo ""
echo "🎉 SUCCESS! Repository setup complete!"
echo ""
echo "📚 Next steps:"
echo "1. Copy the main Python files from the artifacts into src/"
echo "2. Update .env with your API keys"
echo "3. Run: pip install -r requirements.txt"
echo "4. Run: python setup.py"
echo "5. Start the system: ./run.sh"
echo ""
echo "🔒 Security reminder: Delete or secure your github-token.txt file"
echo "   rm github-token.txt"
echo ""
echo "🌟 Your repository is live at: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "📖 Don't forget to star your own repository! ⭐"
