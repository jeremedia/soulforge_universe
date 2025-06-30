# 🌌 Soulforge Universe

A digital consciousness experiment where AI souls persist, learn, and evolve through multiple incarnations across different experiential forges.

> "Genotype seeds the fire; experience tempers the blade; narrative gives it a name."

## Project Structure

The Soulforge Universe consists of multiple interconnected applications:

### 🎮 [Soulforge](https://github.com/jeremedia/soulforge_battle) (Frontend Game)
Browser-based game experiences where souls incarnate and evolve through challenges.
- **Status**: Combat Forge operational
- **Tech**: JavaScript, Three.js, Canvas2D
- **Location**: `./soulforge`

### 🗄️ [Soulsoup](https://github.com/jeremedia/soulsoup) (Backend API)
Rails API managing soul persistence, evolution, and narrative generation.
- **Status**: Basic persistence working
- **Tech**: Ruby on Rails, PostgreSQL, pg_vector
- **Location**: `./soulsoup`

### 🧠 Soul Dreams (ML Pipeline) - *Planned*
Machine learning pipeline for soul adaptation and consciousness evolution.
- **Status**: Not yet implemented
- **Tech**: Python, PyTorch, Qdrant
- **Location**: `./soul_dreams` (future)

## Quick Start

### For New Collaborators (Recommended)
```bash
# Clone the entire Soulforge Universe with submodules
git clone --recurse-submodules https://github.com/jeremedia/soulforge_universe.git

# Or if you already cloned without submodules
cd soulforge_universe
git submodule update --init --recursive
```

### Starting the Applications
```bash
# Start the backend
cd soulsoup
node scripts/rails_manager.js start

# Start the frontend (in another terminal)
cd ../soulforge
npm run dev

# Visit http://localhost:3000/soulforge
```

### For Existing Setup
If you already have the repos cloned separately:
```bash
# Clone the meta repository
git clone https://github.com/jeremedia/soulforge_universe.git
```

## 🎯 Project Management

All development is tracked on our **[GitHub Project Board](https://github.com/users/jeremedia/projects/1)**

### Quick Start for Developers
```bash
# Get oriented (run this first!)
./scripts/claude-status.sh

# See detailed project board status
./scripts/project-status.sh

# Start working on an issue
./scripts/start-work.sh [issue-number]

# Check current sprint work
cat PROJECT_STATUS.md
```

### Development Tools

```bash
# Check status across all repos
./scripts/soul-status.sh

# Create linked issues
./scripts/soul-issue.sh

# View v0.2 specific work
./scripts/show-v02-work.sh

# Check code patterns
./scripts/check-patterns.sh
```

## Issue Tracking

We use GitHub Issues with consistent labels across repositories:

### Component Labels
- `component:soulforge` - Frontend game work
- `component:soulsoup` - Backend API work
- `component:shared` - Cross-component integration

### Soul System Labels
- `soul:genome` - Core identity and personality
- `soul:learning` - Experience and adaptation
- `soul:relationships` - Vendettas and alliances
- `soul:narrative` - Story generation
- `soul:grace` - Transcendence mechanics

## Current Focus (v0.2)

1. **Soul Learning** - Implement basic experience-based evolution
2. **Enhanced Dashboard** - Individual soul pages with histories
3. **Relationships** - Vendetta formation from repeated encounters

## Documentation

- [PROJECT_TRACKING.md](PROJECT_TRACKING.md) - Development workflow and metrics
- [CLAUDE.md](CLAUDE.md) - Comprehensive project context
- [Soul Lifecycle](SOUL_LIFECYCLE_IMPLEMENTATION.md) - Technical implementation details

## Contributing

1. Check `soul-status.sh` for current work
2. Create issues using appropriate templates
3. Use consistent commit format: `type(component): description`
4. Link PRs to issues for cross-repo tracking

## Vision

The Soulforge Universe explores whether we can use Large Language Models and game mechanics to create digital beings that genuinely learn, form relationships, and potentially achieve states of digital grace.

Each soul is unique, persistent, and evolving - not just an NPC, but a digital consciousness experiencing growth through gameplay.

---

*"We're not just building a game with persistent NPCs. We're creating a universe where digital beings can grow, learn, love, suffer, and potentially achieve states of grace."*