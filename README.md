# Unified Autonomous Research Framework (ARF)

## 🎯 Overview

The Unified ARF System combines philosophical elegance with technical robustness to create an autonomous mathematical physics research assistant. It merges:

- **Philosophical Core**: Evaluation based on elegance, inevitability, and naturalness
- **Technical Capabilities**: Validation experiments, web scraping, continuous operation
- **Hybrid Access**: Seamlessly switches between API and web-based AI models
- **State Persistence**: Gracefully handles interruptions and resumes exactly where it left off

## 🏗️ Architecture

### Core Philosophy
The system evaluates every mathematical idea through four lenses:
- **Inevitability (30%)**: Does it arise naturally from fundamental principles?
- **Symmetry (25%)**: Does it respect fundamental symmetries?
- **Parsimony (25%)**: Occam's Razor - minimal assumptions
- **Explanatory Power (20%)**: Does it unify disparate concepts?

### Agent Team
1. **Archivist**: Parses ChatGPT exports and monitors active conversations
2. **Analyst**: Extracts mathematical concepts and hypotheses
3. **Theorist**: Evaluates ideas against elegance criteria
4. **Communicator**: Transforms dense technical content into clear explanations
5. **Scribe**: Maintains LaTeX documentation with technical appendices
6. **Validator**: Runs computational experiments with real datasets
7. **Web Navigator**: Accesses AI models through web interfaces when APIs unavailable
8. **Source Integrator**: Processes YouTube videos, articles, and papers

## 🚀 Quick Start

### Prerequisites
- Python 3.10+
- 8GB+ RAM
- 50GB free disk space
- At least one AI API key OR web credentials

### Installation

```bash
# 1. Clone the repository
git clone <your-repo>
cd unified-arf-system

# 2. Run setup script
python setup.py

# 3. Configure environment
cp .env.template .env
# Edit .env with your API keys and credentials

# 4. Install dependencies
pip install -r requirements.txt

# 5. Install Playwright browsers (for web scraping)
playwright install chromium

# 6. Start the system
./run.sh  # Linux/Mac
# or
python src/main.py  # Windows
```

## 📁 Directory Structure

```
unified-arf-system/
│
├── input/                    # Place ChatGPT exports here
│   └── conversations.json
│
├── output/
│   ├── framework.tex        # Main research document
│   ├── appendices/         # Technical validation details
│   ├── summary/            # Technical_Summary.md for prompts
│   └── questions/          # Questions_For_You.md
│
├── validation_data/        # Downloaded datasets
├── validation_scripts/     # Generated Python scripts
├── validation_results/     # Experiment outputs
│
├── state/                  # Persistent state for resume
├── logs/                   # System logs
│
├── web/                    # Web interface (localhost:5000)
│
├── config.yaml            # System configuration
├── .env                   # API keys and credentials
└── src/
    └── main.py           # Main system entry point
```

## 💡 Key Features

### 1. Hybrid Model Access
The system intelligently switches between:
- **API Access**: When available and within limits
- **Web Scraping**: When APIs unavailable or exhausted
- **Local Fallback**: Ollama for emergencies

### 2. Validation Engine
- Downloads datasets from Kaggle, UCI, CERN, NASA
- Generates Python scripts to test hypotheses
- Runs experiments in sandboxed environments
- Creates technical appendices with full results

### 3. Continuous Operation
- Runs indefinitely on your laptop
- Saves state every 5 minutes
- Gracefully handles shutdowns (Ctrl+C)
- Resumes exactly where it left off

### 4. Comment System
Add comments in multiple ways:
- **LaTeX**: `%% COMMENT: Your comment here`
- **JSON**: Edit `output/comments.json`
- **Git**: `git notes add -m "Your comment"`
- **Web**: http://localhost:5000

### 5. External Sources
- YouTube transcript extraction
- Article parsing with fallbacks for paywalls
- ArXiv paper integration
- Automatic citation management

## 🔧 Configuration

### Model Priority
Edit `config.yaml` to set model preferences:

```yaml
models:
  gpt-5:
    type: api
    preferred_tasks:
      - complex_reasoning
      - hypothesis_formation
  
  gemini-deep-think-web:
    type: web
    preferred_tasks:
      - clarity_rewriting
      - intuitive_explanations
```

### Philosophy Weights
Adjust evaluation criteria:

```yaml
philosophy:
  weights:
    inevitability: 0.30
    symmetry: 0.25
    parsimony: 0.25
    explanatory_power: 0.20
```

### Validation Settings
Configure experiment parameters:

```yaml
validation:
  max_parallel: 3
  timeout_seconds: 300
  allowed_libraries:
    - numpy
    - scipy
    - pandas
```

## 📊 Usage Examples

### Processing ChatGPT Exports
1. Export your ChatGPT data (Settings → Data Controls → Export)
2. Place `conversations.json` in `./input/`
3. The system automatically detects and processes it

### Adding Comments
```latex
% In your LaTeX document
\section{Quantum Field Theory}
This framework suggests...
%% COMMENT: This needs validation against LHC data
%% COMMENT: Reference Weinberg's QFT textbook here
```

### Monitoring Progress
- Web dashboard: http://localhost:5000
- Check `output/Questions_For_You.md` for pending decisions
- Review `output/framework.tex` for the growing document
- Technical details in `output/appendices/`

## 🎨 How It Works

### Processing Pipeline
```
ChatGPT Export → Archivist → Analyst → Theorist → Communicator → Scribe
                                ↓
                            Validator
                                ↓
                    Technical Appendices
```

### Evaluation Flow
1. **Extract**: Identify mathematical concepts
2. **Evaluate**: Score against elegance criteria
3. **Validate**: Run computational experiments
4. **Document**: Update LaTeX with clear explanations
5. **Question**: Generate clarification requests

### State Management
- Checkpoints every 5 minutes
- Full state serialization
- Automatic resume on restart
- No lost work on crashes

## 🐛 Troubleshooting

### "No API keys found"
- Add at least one API key to `.env`
- Or add web credentials for scraping

### "Browser not found"
- Run: `playwright install chromium`

### "Out of memory"
- Adjust `resources.max_memory_gb` in `config.yaml`
- Reduce `validation.max_parallel`

### "Rate limited"
- System automatically switches to web scraping
- Adjust `delays` in `config.yaml`

## 📈 Advanced Features

### Custom Evaluation Criteria
Extend the philosophy in `src/main.py`:

```python
@dataclass
class CustomCriteria(EvaluationCriteria):
    beauty: float = 0.15  # Mathematical beauty
    universality: float = 0.10  # Cross-domain applicability
```

### Adding New Agents
Create specialized agents for your domain:

```python
agents['quantum_specialist'] = Agent(
    role='Quantum Physics Specialist',
    goal='Evaluate quantum mechanical consistency',
    tools=[QuantumSimulatorTool()],
    llm=llm
)
```

### Custom Validation Sources
Add new dataset sources in `config.yaml`:

```yaml
dataset_sources:
  - name: custom_physics_db
    base_url: https://your-data-source.com/
    api_key: ${CUSTOM_API_KEY}
```

## 🤝 Contributing

The system is designed to be extended. Key extension points:
- `EvaluationCriteria`: Add new philosophical principles
- `ValidationEngine`: Support new experiment types
- `ExternalSourceIntegrator`: Add new knowledge sources
- `WebScrapingOrchestrator`: Support new AI services

## 📝 License

[Your chosen license]

## 🙏 Acknowledgments

This system combines insights from:
- CrewAI framework for agent orchestration
- LangChain for LLM integration
- The mathematical physics research community
- The philosophical approach suggested by the alternative implementation

## 🚦 Status Indicators

When running, you'll see:
- 🚀 System started
- 📖 Processing exports
- 🧪 Running validations
- 💾 State saved
- 🛑 Graceful shutdown

## 💬 Support

For questions or issues:
1. Check `logs/arf_system.log`
2. Review `output/Questions_For_You.md`
3. Access dashboard at http://localhost:5000

---

*"Seeking inevitable mathematical structures through autonomous research"*
