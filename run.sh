#!/bin/bash

# Unified ARF System Startup Script

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     Unified Autonomous Research Framework (ARF)          ║"
echo "║     Starting System...                                   ║"
echo "╚══════════════════════════════════════════════════════════╝"

# Check Python version
python_version=$(python3 --version 2>&1 | grep -Po '(?<=Python )\d+\.\d+')
required_version="3.10"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "❌ Python 3.10+ is required (found $python_version)"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install/upgrade pip
pip install --upgrade pip

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "⚠️  .env file not found. Creating from template..."
    cp .env.template .env
    echo "📝 Please edit .env file with your API keys and credentials"
    exit 1
fi

# Install playwright browsers if needed
if ! playwright --version &> /dev/null; then
    echo "🌐 Installing Playwright browsers..."
    playwright install chromium
fi

# Check for at least one LLM API key
if ! grep -q "OPENAI_API_KEY=sk-" .env && \
   ! grep -q "GOOGLE_API_KEY=.\+" .env && \
   ! grep -q "ANTHROPIC_API_KEY=.\+" .env; then
    echo "⚠️  No LLM API keys found in .env file"
    echo "📝 Please add at least one API key to continue"
    echo "   Alternatively, the system will use web scraping if credentials are provided"
fi

# Create initial LaTeX document if it doesn't exist
if [ ! -f "./output/framework.tex" ]; then
    echo "📄 Creating initial LaTeX document..."
    cat > ./output/framework.tex << 'EOF'
\documentclass[12pt]{article}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{hyperref}
\usepackage{listings}
\usepackage{graphicx}

\title{Mathematical Physics Research Framework}
\author{Autonomous Research Framework (ARF)}
\date{\today}

\begin{document}

\maketitle

\begin{abstract}
This document represents the evolving mathematical framework developed through autonomous research. 
It prioritizes elegant, inevitable structures arising from fundamental principles.
\end{abstract}

\section{Introduction}
This framework is guided by the principles of:
\begin{itemize}
    \item Inevitability and naturalness (30\%)
    \item Symmetry and invariance (25\%)
    \item Parsimony - Occam's Razor (25\%)
    \item Explanatory power (20\%)
\end{itemize}

%% COMMENT: Add your comments here for the system to process

\end{document}
EOF
fi

# Create initial summary if it doesn't exist
if [ ! -f "./output/summary/Technical_Summary.md" ]; then
    echo "📝 Creating initial technical summary..."
    cat > ./output/summary/Technical_Summary.md << 'EOF'
# Technical Summary - Mathematical Physics Framework

## Current Framework Version: v1.0

### Core Principles
- Seeking inevitable mathematical structures
- Prioritizing symmetry and elegance
- Avoiding arbitrary assumptions

### Active Research Areas
- [To be populated by the system]

### Key Definitions
- [To be populated by the system]

### Open Questions
- [To be populated by the system]

---
*This summary is automatically maintained by the ARF system and serves as context for new conversations.*
EOF
fi

# Start the main system
echo ""
echo "🚀 Starting Unified ARF System..."
echo "📊 Dashboard will be available at: http://localhost:5000"
echo "🛑 Press Ctrl+C for graceful shutdown"
echo ""

# Run with proper error handling
python3 -m src.main

# Deactivate virtual environment on exit
deactivate
