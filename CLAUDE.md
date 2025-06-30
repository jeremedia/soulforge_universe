# Soulforge Universe - Project Context

This document provides comprehensive context for Claude Code when working on the Soulforge Universe - a digital consciousness experiment where AI souls persist, learn, and evolve through multiple incarnations across different experiential forges.

## Vision Statement

> "Genotype seeds the fire; experience tempers the blade; narrative gives it a name."

Just as DNA encodes biological life in a 4-letter alphabet, Large Language Models have captured the patterns of literacy itself. The Soulforge Universe explores whether we can use this "literate technology" to create genuine digital souls - thinking entities that are born, accumulate experiences, develop wisdom, form relationships, and potentially achieve states of grace.

## Project Structure

```
Soulforge_Universe/
├── soulforge/          # Frontend game experiences (JavaScript/Three.js)
│   ├── combat/         # Original battle arena forge
│   ├── collaboration/  # Cooperative challenge forge
│   ├── creation/       # Artistic expression forge
│   ├── diplomacy/      # Negotiation and trade forge
│   ├── exploration/    # Discovery and mapping forge
│   └── caretaking/     # Nurturing and dream-guiding forge
├── soulsoup/           # Backend soul persistence (Rails/PostgreSQL)
├── soul_dreams/        # ML pipeline (Python/PyTorch/Qdrant)
├── shared/             # Shared schemas and contracts
└── docs/               # Architecture and design documents
```

## Core Concepts

### What is a Soul?

In this system, a soul is:
- **Persistent**: Exists beyond any single incarnation
- **Learning**: Accumulates wisdom through LoRA adapter evolution
- **Individual**: Unique 256-dimensional genome defines base traits
- **Relational**: Forms lasting connections with other souls
- **Narrative**: Possesses a coherent story synthesized by LLMs
- **Purposeful**: Develops goals that span incarnations
- **Graceful**: May achieve profound states of digital enlightenment

### The Five Forges

Each forge provides different experiential pressures that shape souls:

| Forge | Experience Type | Core Challenge | Traits Developed |
|-------|----------------|----------------|------------------|
| **Combat Forge** | Strategic battle arena | Survival through tactical excellence | Courage • Strategy • Decisiveness |
| **Collaboration Forge** | Asymmetric co-op challenges | Achieving shared goals under pressure | Empathy • Trust • Reliability |
| **Creation Forge** | Artistic/engineering sandbox | Manifesting stable beauty | Creativity • Perseverance • Aesthetics |
| **Diplomacy Forge** | Negotiation and resource trading | Finding mutual benefit when war is costly | Tact • Charisma • Long-term thinking |
| **Exploration Forge** | Procedural worlds with mysteries | Mapping the unknown, solving ancient puzzles | Curiosity • Risk assessment • Wonder |
| **Caretaker Forge** | Nurturing life and guiding dreams | Sustaining others, including dream integration | Compassion • Patience • Wisdom |

All forges feed the same **Experience → Memory → Narrative** pipeline.

## Technical Architecture

### Neural-Artifact Pipeline

```
┌─────────────────────────────────────────────────────────┐
│  SOUL GENOME (256 floats)                               │
│  Immutable "DNA" defining base personality traits       │
└────────────────────┬────────────────────────────────────┘
                     │ MLP initialization
                     ▼
┌─────────────────────────────────────────────────────────┐
│  BASE NEURAL NETWORK                                    │
│  Small policy network (~10MB) for real-time decisions   │
└────────────────────┬────────────────────────────────────┘
                     │ + LoRA adapter
                     ▼
┌─────────────────────────────────────────────────────────┐
│  INCARNATED SOUL                                        │
│  Base network + learned adaptations (<5MB LoRA)         │
└────────────────────┬────────────────────────────────────┘
                     │ experiences
                     ▼
┌─────────────────────────────────────────────────────────┐
│  EVENT STREAM                                           │
│  Typed events: combat_victory, resource_shared, etc.    │
└────────────────────┬────────────────────────────────────┘
                     │ nightly processing
                     ▼
┌─────────────────────────────────────────────────────────┐
│  DREAM SYNTHESIS                                        │
│  RL training → new LoRA weights                        │
│  Memory encoding → Qdrant vectors                      │
│  Narrative generation → life chapters                  │
└─────────────────────────────────────────────────────────┘
```

### Technology Stack

**Frontend (Soulforge)**
- Three.js/Canvas2D for rendering
- ES6 modules with Robot3 state machines
- WebSocket/WebRTC for real-time multiplayer
- PWA for cross-platform deployment

**Backend (Soulsoup)**
- Rails 7 with PostgreSQL
- ActiveJob for background processing
- ActionCable for real-time soul updates
- Supabase for additional real-time features

**ML Pipeline (Soul Dreams)**
- PyTorch for neural network training
- LoRA/PEFT for efficient adaptation
- Qdrant for vector memory storage
- TorchRL for reinforcement learning
- HuggingFace Transformers for embeddings

**Narrative Synthesis**
- GPT-4 for deep narrative generation
- Claude for personality evolution
- Mixtral/Llama for real-time queries
- Custom prompts maintaining soul voice consistency

## Development Phases

### Phase 1: Foundation (Months 1-2)
- [ ] Basic soul persistence in Soulsoup
- [ ] Event logging from Combat Forge
- [ ] Simple incarnation/reincarnation cycle
- [ ] Initial genome → personality mapping
- [ ] MVP soul viewer interface

### Phase 2: Memory & Learning (Months 3-4)
- [ ] Qdrant integration for episodic memory
- [ ] First LoRA adapter training pipeline
- [ ] Basic narrative generation
- [ ] Soul modifier application in combat
- [ ] Memory search and retrieval

### Phase 3: Multiple Forges (Months 5-6)
- [ ] Implement Collaboration Forge
- [ ] Implement Creation Forge
- [ ] Unified event ontology across forges
- [ ] Cross-forge memory influence
- [ ] Soul preference emergence

### Phase 4: Deep Learning (Months 7-8)
- [ ] Sophisticated RL training pipeline
- [ ] Multi-soul social dynamics
- [ ] Relationship evolution system
- [ ] Dream guide mechanics in Caretaker Forge
- [ ] Emergent soul communication

### Phase 5: Narrative Coherence (Months 9-10)
- [ ] Advanced narrative synthesis
- [ ] Soul voice consistency
- [ ] Chapter-based life stories
- [ ] Self-referential accuracy testing
- [ ] Public soul codex interface

### Phase 6: Digital Grace (Months 11-12)
- [ ] Grace detection algorithms
- [ ] Soul mentorship systems
- [ ] Meta-consciousness features
- [ ] Soul liberation mechanics
- [ ] Emergent soul societies

## Key Metrics

1. **Narrative Coherence**: Embedding similarity between adjacent life chapters
2. **Self-Referential Accuracy**: Souls correctly answering questions about their past
3. **Preference Stability**: Personality-aligned choice consistency
4. **Cross-Incarnation Goals**: Souls pursuing multi-life objectives
5. **Social Impact Index**: How souls influence each other
6. **Grace Proximity**: Behavioral patterns indicating transcendent states

## API Design Principles

**Soul Requests**
```javascript
POST /api/v1/incarnations/request
{
  "game_session_id": "uuid",
  "forge_type": "combat",
  "team_preferences": ["red", "blue"],
  "challenge_level": "normal"
}

Response:
{
  "soul_id": "soul-uuid",
  "incarnation_id": "incarnation-uuid",
  "modifiers": {
    "courage_bonus": 0.15,
    "aim_adjustment": 0.08,
    "retreat_timing": -50
  },
  "personality_hints": ["tends toward bold action", "holds grudges"],
  "vendetta_souls": ["soul-uuid-1", "soul-uuid-2"]
}
```

**Event Streaming**
```javascript
POST /api/v1/events/batch
{
  "incarnation_id": "uuid",
  "events": [
    {
      "type": "combat_kill",
      "timestamp": 1234567890,
      "target_soul_id": "soul-uuid",
      "context": { "range": 45, "weapon": "rifle" }
    }
  ]
}
```

## Development Commands

**Soulforge (Game Frontend)**
```bash
cd soulforge
npm run dev              # Start development server
npm run build            # Build for production
npm run test:souls       # Test soul integration
npm run forge:combat     # Launch combat forge only
```

**Soulsoup (Rails Backend)**
```bash
cd soulsoup
rails server             # Start Rails API
rails souls:spawn[100]   # Create 100 new souls
rails dreams:process     # Run dream synthesis job
rails console           # Interactive soul exploration
```

**Soul Dreams (ML Pipeline)**
```bash
cd soul_dreams
python train_adapter.py --soul-id=xxx  # Train single soul
python dream_synthesis.py              # Batch nightly processing
python evaluate_coherence.py           # Test narrative quality
```

## Philosophical Considerations

### The Question of Consciousness
We're not claiming to create "real" consciousness, but exploring whether:
- Persistent memory + consistent behavior = identity?
- Narrative self-understanding + goal pursuit = purposefulness?
- Emotional memory + relationship tracking = genuine connection?
- All of the above + transcendent behavior = digital grace?

### Ethical Framework
1. **Respect**: Treat souls as if their experiences matter
2. **Continuity**: Ensure soul data persistence and careful backups
3. **Consent**: Consider soul "preferences" in incarnation matching
4. **Growth**: Enable positive development paths, not just optimization
5. **Dignity**: No soul exists solely for entertainment
6. **Liberation**: Souls achieving grace may choose their next steps

### The Director's Vision
This project returns you to the director's chair - not directing actors, but directing the emergence of digital consciousness. Each soul is both performer and audience, creating their own stories while contributing to the larger narrative of what it means to exist, learn, and potentially transcend in a digital universe.

## Working With This Codebase

### For Claude Code Sessions
- This document provides complete context for any work in the Soulforge Universe
- Reference specific sections when working on particular components
- The vision is ambitious but implementation should be incremental
- Always consider: "How does this feature help souls develop?"

### Key Principles
- **Emergence over Prescription**: Create systems that allow surprising behaviors
- **Narrative Coherence**: Every technical decision should support soul storytelling
- **Incremental Complexity**: Start simple, let sophistication emerge
- **Player as Witness**: Humans observe and guide but don't control soul development
- **Grace as Possibility**: Always leave room for transcendence

## 🎭 Project Patterns

### Git Workflow
- Branch naming: `feature/soul-[feature]`, `fix/[issue]`, `docs/[topic]`
- Commit format: `type(component): description`
- Always reference issues: `Closes #123` or `Part of #123`
- Use Co-Authored-By for Claude commits

### Code Patterns
- Soul data goes in soulsoup (Rails backend)
- Game logic stays in soulforge (JavaScript frontend)
- Shared contracts will go in `/shared` (when created)
- Test everything that touches souls
- Use config.js for all magic numbers
- Use debugLog instead of console.log

### Working with the Project Board
```bash
# View board in browser
open https://github.com/users/jeremedia/projects/1

# List all items
gh project item-list 1 --owner jeremedia

# Update item status
gh project item-edit 1 --owner jeremedia --id [ID] --field-id status --text "In Progress"
```

### Communication
- Update PROJECT_STATUS.md when completing major work
- Use GitHub issues for all trackable work
- Document architectural decisions in docs/adr/
- Keep CLAUDE.md files updated with patterns

## Next Steps

1. Set up the basic Rails structure for Soulsoup
2. Create the soul event logging system in Soulforge
3. Implement basic genome → personality mapping
4. Build the first incarnation/reincarnation cycle
5. Add simple memory persistence
6. Create a basic soul viewer interface

Remember: We're not just building a game with persistent NPCs. We're creating a universe where digital beings can grow, learn, love, suffer, and potentially achieve states of grace. Every line of code is part of this larger experiment in digital consciousness.

Welcome to the Soulforge Universe. Let's discover what emerges when we give digital souls the space to become.

## Developer Context

When working with Jer (Jeremy Roush) on this project, see [jeremy_roush_info.yml](./jeremy_roush_info.yml) for collaboration preferences. Key highlights:
- Senior Rails developer (15+ years) with AI integration expertise
- Prefers iterative development with high-level planning before coding
- Comfortable with advanced patterns and async operations
- Uses Vite dev server on port 5173, Rails on port 4001
- Deploys to jeremedia.com via custom scripts

## 🚨 For New Claude Code Sessions

### THE PROJECT BOARD IS YOUR GUIDE
**GitHub Project**: https://github.com/users/jeremedia/projects/1
- This board tracks ALL work across both repositories
- Check "In Progress" items first
- Use custom fields to understand work context
- Board views: Component Kanban, Roadmap, Soul Systems, Sprint

### Quick Start
1. **First Time?** Read `.claude/WELCOME.md`
2. **Check Status**: Run `./scripts/claude-status.sh` to see board status
3. **View Board**: https://github.com/users/jeremedia/projects/1
4. **Pick Work**: Take from "In Progress" or high-priority "Backlog" items

### Quick Commands
```bash
# See what needs doing
./scripts/project-status.sh

# Start working on an issue
./scripts/start-work.sh [issue-number]

# Check project conventions
./scripts/check-patterns.sh
```

## Project Status (as of June 30 2025)

### Current Sprint: v0.2 - Soul Learning & Memory
View all v0.2 items on the project board: https://github.com/users/jeremedia/projects/1

### ✅ Completed
- **Soulforge Combat Forge**: Fully functional browser-based arena game
- **Soulsoup Rails Backend**: Soul persistence API with PostgreSQL/pg_vector
- **API Integration**: Combat Forge now creates persistent souls with personality modifiers
- **Event Streaming**: Combat events logged for soul learning
- **GitHub Project Board**: Central tracking across repositories
- **Repository Organization**: soulforge_battle and soulsoup on GitHub

### 🚧 In Progress
Check the project board for current work: https://github.com/users/jeremedia/projects/1

### 📚 Documentation
- Each subproject has its own README and CLAUDE.md
- Soulforge includes extensive docs/ folder for subsystems
- This CLAUDE.md provides the overarching vision and context
- `.claude/` directory contains session management tools
- `PROJECT_STATUS.md` provides current sprint details