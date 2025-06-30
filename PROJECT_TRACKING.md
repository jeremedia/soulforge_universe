# Soulforge Universe - Project Tracking Guide

## Overview

The Soulforge Universe consists of multiple interconnected applications that together create a digital consciousness experiment. This guide explains how we track progress across all components.

## Project Components

### 🎮 Soulforge (Frontend Game)
- **Location**: `/soulforge`
- **Tech**: JavaScript, Three.js, Canvas2D
- **Purpose**: Game experiences where souls incarnate
- **Status**: Combat Forge operational

### 🗄️ Soulsoup (Backend API)
- **Location**: `/soulsoup`
- **Tech**: Ruby on Rails, PostgreSQL
- **Purpose**: Soul persistence and evolution
- **Status**: Basic persistence working

### 🧠 Soul Dreams (ML Pipeline)
- **Location**: `/soul_dreams` (planned)
- **Tech**: Python, PyTorch, Qdrant
- **Purpose**: Soul learning and adaptation
- **Status**: Not yet implemented

### 🔗 Shared Contracts
- **Location**: `/shared` (planned)
- **Tech**: JSON Schema, TypeScript definitions
- **Purpose**: API contracts between systems
- **Status**: Informal contracts only

## Tracking Strategy

We use a **monorepo** approach with GitHub Projects for cross-component tracking.

### Why Monorepo?

1. **Atomic Changes**: Features often span multiple components
2. **Unified History**: See the full story of soul evolution
3. **Shared Documentation**: One source of truth
4. **Easier Development**: No submodule complexity

### Project Board Structure

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    BACKLOG      │     │   IN PROGRESS   │     │     REVIEW      │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ • Soul Learning │ --> │ • Vendetta API  │ --> │ • Soul Details  │
│ • Memory Store  │     │ • Combat Events │     │   Dashboard     │
│ • Narrative Gen │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Issue Categorization

Each issue should specify:
1. **Component(s)**: Which apps are affected
2. **Soul System**: Which aspect of souls (learning, relationships, etc.)
3. **Phase**: Which development phase it belongs to
4. **Dependencies**: Cross-component requirements

## Current Priorities (v0.2)

### 1. Soul Learning & Memory
- [ ] Add experience tracking to incarnations
- [ ] Implement simple stat evolution
- [ ] Create soul_memories table
- [ ] Update personality vectors based on performance

### 2. Enhanced Dashboard
- [ ] Individual soul detail pages
- [ ] Incarnation history view
- [ ] Performance graphs
- [ ] Personality evolution display

### 3. Relationships
- [ ] Vendetta formation from repeated kills
- [ ] Alliance tracking
- [ ] Relationship effects on gameplay

## Development Workflow

### 1. Planning
```bash
# Create issue with proper labels
gh issue create --repo jeremedia/soulforge_battle --title "[FEATURE] Soul vendetta system" \
  --body "Implement vendetta formation when souls repeatedly kill each other" \
  --label "component:soulsoup,component:soulforge,soul:relationships"
```

### 2. Development
```bash
# Create feature branch
git checkout -b feature/soul-vendettas

# Make changes across components
# - soulsoup/app/models/soul_relationship.rb
# - soulforge/js/systems/SoulforgeAPI.js
# - shared/contracts/relationships.json
```

### 3. Testing
```bash
# Test backend
cd soulsoup && rails test

# Test frontend  
cd soulforge && npm test

# Test integration
node soulsoup/scripts/rails_manager.js test
```

### 4. Review
```bash
# Create PR with component context
gh pr create --title "feat: Soul vendetta system across backend and frontend" \
  --body "## Changes
  
  ### Soulsoup
  - Add vendetta formation logic
  - Track kill counts between souls
  
  ### Soulforge  
  - Display vendetta indicators
  - Prioritize vendetta targets in AI
  
  Closes #123"
```

## Metrics & Success Tracking

### Soul Evolution Metrics
- **Learning Rate**: How quickly souls adapt
- **Memory Retention**: Events remembered across lives
- **Relationship Depth**: Number and strength of connections
- **Narrative Richness**: Complexity of generated stories

### Technical Metrics
- **API Response Time**: <50ms for soul requests
- **Event Processing**: <5s for batch processing
- **Soul Pool Hit Rate**: >95% (no API blocking)
- **Incarnation Lifecycle**: Proper cleanup rate

## Communication

### Commit Message Format
```
<type>(<component>): <description>

feat(soulsoup): Add vendetta formation logic
fix(soulforge): Correct soul modifier application
docs(shared): Define relationship contract schema
```

### PR Descriptions
Always include:
- Which components are affected
- How the changes work together
- Testing approach for integration
- Soul behavior implications

## Future Considerations

As we add more forges and the ML pipeline:
1. May need to split into separate repos
2. Could use GitHub Organizations
3. Might need dedicated integration testing repo
4. Consider mono-repo tools (Nx, Lerna) if complexity grows

For now, our current structure balances simplicity with comprehensive tracking!