"""
setup.py - Installation and setup script for Unified ARF System
"""

import os
import sys
import subprocess
from pathlib import Path

def create_requirements_file():
    """Create requirements.txt with all dependencies"""
    requirements = """# Core Framework
crewai>=0.28.0
langchain>=0.1.0
langchain-openai>=0.0.5
langchain-google-genai>=0.0.11
langchain-anthropic>=0.1.1
langchain-community>=0.0.20
langgraph>=0.0.26
pydantic>=2.0.0

# Web Scraping & Automation
playwright>=1.40.0
beautifulsoup4>=4.12.0
selenium>=4.15.0
undetected-chromedriver>=3.5.0
requests>=2.31.0
httpx>=0.25.0

# AI/ML Libraries
openai>=1.12.0
google-generativeai>=0.3.2
anthropic>=0.18.0
tiktoken>=0.5.0
transformers>=4.36.0
ollama>=0.1.7  # For local fallback

# Data Processing & Validation
pandas>=2.1.0
numpy>=1.24.0
scipy>=1.11.0
scikit-learn>=1.3.0
sympy>=1.12
matplotlib>=3.7.0
plotly>=5.17.0
seaborn>=0.12.0

# Document Management
pylatex>=1.4.2
markdown>=3.5.0
pymupdf>=1.23.0
python-docx>=1.1.0
nbconvert>=7.9.0

# External Sources
youtube-transcript-api>=0.6.1
newspaper3k>=0.2.8
arxiv>=2.0.0
scholarly>=1.7.0
feedparser>=6.0.10

# System Management
apscheduler>=3.10.0
pyyaml>=6.0.1
python-dotenv>=1.0.0
gitpython>=3.1.40
watchdog>=3.0.0

# Database & Caching
redis>=5.0.0
sqlalchemy>=2.0.0
alembic>=1.12.0

# Web Interface
flask>=3.0.0
flask-cors>=4.0.0
flask-socketio>=5.3.0
websockets>=12.0
gradio>=4.0.0  # Alternative UI

# Utilities
rich>=13.7.0  # Better terminal output
tqdm>=4.66.0  # Progress bars
click>=8.1.0  # CLI interface
loguru>=0.7.0  # Better logging
python-decouple>=3.8  # Config management

# Development & Testing
pytest>=7.4.0
pytest-asyncio>=0.21.0
pytest-cov>=4.1.0
black>=23.12.0
pylint>=3.0.0
mypy>=1.7.0

# Optional but recommended
jupyterlab>=4.0.0  # For interactive development
streamlit>=1.29.0  # Alternative UI option
"""
    
    with open("requirements.txt", "w") as f:
        f.write(requirements)
    print("✅ Created requirements.txt")

def create_env_template():
    """Create .env.template file"""
    env_template = """# API Keys (at least one LLM API key required)
OPENAI_API_KEY=sk-...
GOOGLE_API_KEY=...
ANTHROPIC_API_KEY=...

# Web Scraping Credentials (optional - for web-only access)
CHATGPT_EMAIL=your_email@example.com
CHATGPT_PASSWORD=your_password
GOOGLE_EMAIL=your_email@gmail.com
GOOGLE_PASSWORD=your_password
CLAUDE_EMAIL=your_email@example.com
CLAUDE_PASSWORD=your_password

# External Services (optional)
YOUTUBE_API_KEY=...
KAGGLE_API_KEY=...

# Notifications (optional)
NOTIFICATION_EMAIL=arf_system@example.com
USER_EMAIL=you@example.com
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...

# Development (optional)
DEBUG=false
"""
    
    with open(".env.template", "w") as f:
        f.write(env_template)
    print("✅ Created .env.template")

def create_directory_structure():
    """Create all necessary directories"""
    directories = [
        # Input/Output
        "./input",
        "./output",
        "./output/latex",
        "./output/appendices", 
        "./output/summary",
        "./output/questions",
        
        # State & Logs
        "./state",
        "./logs",
        
        # Validation
        "./validation_data",
        "./validation_scripts",
        "./validation_results",
        
        # Cache
        "./cache",
        "./cache/models",
        "./cache/datasets",
        
        # Web Interface
        "./web",
        "./web/static",
        "./web/templates"
    ]
    
    for dir_path in directories:
        Path(dir_path).mkdir(parents=True, exist_ok=True)
    
    print("✅ Created directory structure")

def create_startup_script():
    """Create run.sh startup script"""
    startup_script = """#!/bin/bash

# Unified ARF System Startup Script

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     Unified Autonomous Research Framework (ARF)          ║"
echo "║     Starting System...                                   ║"
echo "╚══════════════════════════════════════════════════════════╝"

# Check Python version
python_version=$(python3 --version 2>&1 | grep -Po '(?<=Python )\\d+\\.\\d+')
required_version="3.10"

if [ "$(printf '%s\\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
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
if ! grep -q "OPENAI_API_KEY=sk-" .env && \\
   ! grep -q "GOOGLE_API_KEY=.\\+" .env && \\
   ! grep -q "ANTHROPIC_API_KEY=.\\+" .env; then
    echo "⚠️  No LLM API keys found in .env file"
    echo "📝 Please add at least one API key to continue"
    echo "   Alternatively, the system will use web scraping if credentials are provided"
fi

# Create initial LaTeX document if it doesn't exist
if [ ! -f "./output/framework.tex" ]; then
    echo "📄 Creating initial LaTeX document..."
    cat > ./output/framework.tex << 'EOF'
\\documentclass[12pt]{article}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{listings}
\\usepackage{graphicx}

\\title{Mathematical Physics Research Framework}
\\author{Autonomous Research Framework (ARF)}
\\date{\\today}

\\begin{document}

\\maketitle

\\begin{abstract}
This document represents the evolving mathematical framework developed through autonomous research. 
It prioritizes elegant, inevitable structures arising from fundamental principles.
\\end{abstract}

\\section{Introduction}
This framework is guided by the principles of:
\\begin{itemize}
    \\item Inevitability and naturalness (30\\%)
    \\item Symmetry and invariance (25\\%)
    \\item Parsimony - Occam's Razor (25\\%)
    \\item Explanatory power (20\\%)
\\end{itemize}

%% COMMENT: Add your comments here for the system to process

\\end{document}
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
"""
    
    with open("run.sh", "w") as f:
        f.write(startup_script)
    
    # Make executable
    os.chmod("run.sh", 0o755)
    print("✅ Created run.sh startup script")

def create_web_interface():
    """Create basic web interface for document viewing and comments"""
    
    # Create Flask app
    flask_app = '''"""
Web interface for ARF System - Document viewer with comments
"""

from flask import Flask, render_template, request, jsonify, send_file
from flask_cors import CORS
from flask_socketio import SocketIO, emit
import json
from pathlib import Path
from datetime import datetime

app = Flask(__name__)
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.route('/')
def index():
    """Main dashboard"""
    return render_template('index.html')

@app.route('/document')
def document_viewer():
    """PDF viewer with comment interface"""
    return render_template('document.html')

@app.route('/api/document/pdf')
def get_pdf():
    """Serve the compiled PDF"""
    pdf_path = Path("./output/framework.pdf")
    if pdf_path.exists():
        return send_file(pdf_path, mimetype='application/pdf')
    return jsonify({"error": "PDF not found"}), 404

@app.route('/api/comments', methods=['GET'])
def get_comments():
    """Get all comments"""
    comments_file = Path("./output/comments.json")
    if comments_file.exists():
        with open(comments_file, 'r') as f:
            return jsonify(json.load(f))
    return jsonify({"comments": []})

@app.route('/api/comments', methods=['POST'])
def add_comment():
    """Add a new comment"""
    data = request.json
    comment = {
        'id': str(datetime.now().timestamp()),
        'text': data['text'],
        'section': data.get('section', 'general'),
        'timestamp': datetime.now().isoformat(),
        'status': 'pending'
    }
    
    # Load existing comments
    comments_file = Path("./output/comments.json")
    if comments_file.exists():
        with open(comments_file, 'r') as f:
            comments_data = json.load(f)
    else:
        comments_data = {"comments": []}
    
    # Add new comment
    comments_data['comments'].append(comment)
    
    # Save
    with open(comments_file, 'w') as f:
        json.dump(comments_data, f, indent=2)
    
    # Notify via WebSocket
    socketio.emit('new_comment', comment)
    
    return jsonify({"success": True, "comment": comment})

@app.route('/api/status')
def system_status():
    """Get system status"""
    state_file = Path("./state/system_state.pkl")
    if state_file.exists():
        import pickle
        with open(state_file, 'rb') as f:
            state = pickle.load(f)
        return jsonify({
            'last_checkpoint': state['last_checkpoint'].isoformat(),
            'processed_chats': len(state['processed_chats']),
            'pending_validations': len(state['pending_validations']),
            'framework_version': state['current_framework_version']
        })
    return jsonify({"status": "Not initialized"})

@app.route('/api/questions')
def get_questions():
    """Get pending questions for user"""
    questions_file = Path("./output/questions/Questions_For_You.md")
    if questions_file.exists():
        content = questions_file.read_text()
        # Parse markdown to extract questions
        questions = []
        for line in content.split('\\n'):
            if line.startswith('- ['):
                questions.append(line[2:])
        return jsonify({"questions": questions})
    return jsonify({"questions": []})

@socketio.on('connect')
def handle_connect():
    """WebSocket connection handler"""
    emit('connected', {'data': 'Connected to ARF System'})

if __name__ == '__main__':
    socketio.run(app, debug=False, port=5000)
'''
    
    Path("./web").mkdir(exist_ok=True)
    with open("./web/app.py", "w") as f:
        f.write(flask_app)
    
    # Create HTML template
    html_template = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ARF System Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            backdrop-filter: blur(10px);
        }
        .comment-section {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            backdrop-filter: blur(10px);
        }
        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
        }
        button {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Unified ARF System</h1>
            <p>Mathematical Physics Research Framework</p>
        </div>
        
        <div class="stats" id="stats">
            <!-- Populated by JavaScript -->
        </div>
        
        <div class="comment-section">
            <h2>💭 Add Comment</h2>
            <textarea id="comment-text" rows="4" placeholder="Enter your comment or question..."></textarea>
            <button onclick="addComment()">Submit Comment</button>
        </div>
        
        <div class="comment-section" style="margin-top: 20px;">
            <h2>❓ Pending Questions</h2>
            <div id="questions">
                <!-- Populated by JavaScript -->
            </div>
        </div>
    </div>
    
    <script src="https://cdn.socket.io/4.5.4/socket.io.min.js"></script>
    <script>
        const socket = io();
        
        async function loadStatus() {
            const response = await fetch('/api/status');
            const data = await response.json();
            
            document.getElementById('stats').innerHTML = `
                <div class="stat-card">
                    <h3>Last Checkpoint</h3>
                    <p>${data.last_checkpoint || 'Not started'}</p>
                </div>
                <div class="stat-card">
                    <h3>Processed Chats</h3>
                    <p>${data.processed_chats || 0}</p>
                </div>
                <div class="stat-card">
                    <h3>Pending Validations</h3>
                    <p>${data.pending_validations || 0}</p>
                </div>
                <div class="stat-card">
                    <h3>Framework Version</h3>
                    <p>${data.framework_version || 'v1.0'}</p>
                </div>
            `;
        }
        
        async function loadQuestions() {
            const response = await fetch('/api/questions');
            const data = await response.json();
            
            const questionsHtml = data.questions.map(q => 
                `<div style="margin: 10px 0; padding: 10px; background: rgba(255,255,255,0.05); border-radius: 5px;">${q}</div>`
            ).join('');
            
            document.getElementById('questions').innerHTML = questionsHtml || '<p>No pending questions</p>';
        }
        
        async function addComment() {
            const text = document.getElementById('comment-text').value;
            if (!text) return;
            
            await fetch('/api/comments', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({text})
            });
            
            document.getElementById('comment-text').value = '';
            alert('Comment submitted!');
        }
        
        socket.on('new_comment', (data) => {
            console.log('New comment received:', data);
            loadQuestions();
        });
        
        // Load initial data
        loadStatus();
        loadQuestions();
        
        // Refresh every 30 seconds
        setInterval(() => {
            loadStatus();
            loadQuestions();
        }, 30000);
    </script>
</body>
</html>'''
    
    Path("./web/templates").mkdir(exist_ok=True)
    with open("./web/templates/index.html", "w") as f:
        f.write(html_template)
    
    print("✅ Created web interface")

def main():
    """Main setup function"""
    print("""
    ╔══════════════════════════════════════════════════════════╗
    ║     Unified ARF System - Setup                          ║
    ╚══════════════════════════════════════════════════════════╝
    """)
    
    # Create all necessary files and directories
    create_requirements_file()
    create_env_template()
    create_directory_structure()
    create_startup_script()
    create_web_interface()
    
    print("""
    ✅ Setup complete!
    
    Next steps:
    1. Copy .env.template to .env and add your API keys
    2. Install dependencies: pip install -r requirements.txt
    3. Install Playwright browsers: playwright install chromium
    4. Run the system: ./run.sh (Linux/Mac) or python src/main.py (Windows)
    
    Optional:
    - Place ChatGPT export JSON files in ./input/
    - Add comments with %% COMMENT: in LaTeX files
    - Access web interface at http://localhost:5000
    """)

if __name__ == "__main__":
    main()
