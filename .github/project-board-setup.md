# GitHub Project Board Setup for Soulforge Universe

## Project Structure

We'll use GitHub Projects (beta) with a custom project board that tracks work across all components of the Soulforge Universe.

## 1. Create the Project

1. Go to https://github.com/users/YOUR_USERNAME/projects
2. Click "New project"
3. Select "Board" view
4. Name it "Soulforge Universe Roadmap"

## 2. Custom Fields

Add these custom fields to track multi-app work:

### Component (Single Select)
- 🎮 Soulforge (Frontend)
- 🗄️ Soulsoup (Backend)
- 🧠 Soul Dreams (ML)
- 🔗 Shared/Integration
- 📚 Documentation

### Soul System (Single Select)
- 👤 Identity/Genome
- 🎯 Combat/Skills
- 💭 Memory/Learning
- 🤝 Relationships
- 📖 Narrative
- ✨ Grace/Transcendence

### Phase (Single Select)
- Phase 1: Foundation
- Phase 2: Memory & Learning
- Phase 3: Multiple Forges
- Phase 4: Deep Learning
- Phase 5: Narrative
- Phase 6: Digital Grace

### Priority (Single Select)
- 🔥 Critical
- 🎯 High
- 📌 Medium
- 📎 Low

### Effort (Number)
- Story points or days estimate

## 3. Board Views

### View 1: Component Kanban
Group by: Component
Columns: Backlog → In Progress → Review → Done

### View 2: Roadmap
Group by: Phase
Sort by: Priority

### View 3: Soul Systems
Group by: Soul System
Useful for seeing all work related to specific soul aspects

### View 4: Sprint Board
Filter by: Current sprint milestone
Group by: Status

## 4. Automation Rules

1. **Auto-add to project**: Items with `soulforge-universe` label
2. **Auto-move to In Progress**: When assigned
3. **Auto-move to Review**: When PR created
4. **Auto-move to Done**: When PR merged

## 5. Milestones

Create GitHub milestones for major phases:
- v0.1 - Basic Soul Persistence ✅
- v0.2 - Learning & Memory
- v0.3 - Relationships & Vendettas
- v0.4 - Simple Narratives
- v0.5 - Collaboration Forge
- v1.0 - All Forges + Basic ML

## 6. Labels

Create consistent labels across the project:

### Component Labels
- `component:soulforge`
- `component:soulsoup`
- `component:soul-dreams`
- `component:shared`

### Type Labels
- `type:feature`
- `type:bug`
- `type:enhancement`
- `type:documentation`
- `type:soul-evolution`

### Priority Labels
- `priority:critical`
- `priority:high`
- `priority:medium`
- `priority:low`

### Soul System Labels
- `soul:genome`
- `soul:learning`
- `soul:relationships`
- `soul:narrative`
- `soul:grace`

## 7. Issue Templates Usage

When creating issues, use the appropriate template:
- **Feature Request**: For new gameplay features
- **Bug Report**: For technical issues
- **Soul Enhancement**: For soul behavior improvements

## 8. Example Workflow

1. Create issue using template
2. Add appropriate labels
3. Assign to project board
4. Set custom fields (Component, Soul System, Phase)
5. Move through board as work progresses
6. Link PRs to issues
7. Auto-close on merge

## 9. Weekly Planning

Every Monday:
1. Review "Done" items from last week
2. Move ready items from Backlog to Sprint
3. Update priorities based on dependencies
4. Check soul metrics dashboard
5. Plan cross-component work

## 10. Integration with Development

```bash
# Create issue from CLI
gh issue create --title "[SOUL] Implement vendetta formation" \
  --label "component:soulsoup,soul:relationships" \
  --project "Soulforge Universe Roadmap"

# Link PR to issue
gh pr create --title "feat: Add vendetta formation logic" \
  --body "Closes #123"
```

This structure lets us track the "meta" project while maintaining visibility into individual component work!