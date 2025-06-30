# Soulforge Universe - Current Status
*Last Updated: June 30, 2025*
*GitHub Project Board: https://github.com/users/jeremedia/projects/1*

## 🎯 Current Sprint: v0.2 - Soul Learning & Memory
**Goal**: Souls that learn from experience without requiring the full ML pipeline

### 📊 Sprint Overview
The v0.2 milestone focuses on making souls more dynamic and responsive to their experiences. We're implementing basic learning mechanisms that will later be enhanced by the ML pipeline.

### 🚀 Key Features for v0.2
1. **Experience Accumulation**
   - Track combat statistics per soul
   - Store significant events (vendettas, achievements)
   - Calculate experience points from actions

2. **Personality Evolution**
   - Personality vectors drift based on experiences
   - Combat style adapts to success/failure patterns
   - Relationships affect behavior modifiers

3. **Soul Memory**
   - Basic episodic memory storage
   - Key events remembered across incarnations
   - Memory influences future decisions

4. **Enhanced Dashboard**
   - Individual soul detail pages
   - Incarnation history visualization
   - Personality evolution graphs

### 📋 Work Items
Check the GitHub Project Board for up-to-date status:
https://github.com/users/jeremedia/projects/1

**Quick filters:**
- In Progress items: Look for "In Progress" column
- v0.2 items: Filter by "Phase 2: Memory & Learning"
- High priority: Look for 🔥 Critical or 🎯 High priority labels

### 🛠️ Development Guidelines

#### When working on v0.2 features:
1. **Soul data belongs in soulsoup** - All persistence and learning logic
2. **Game behavior in soulforge** - How souls act based on their data
3. **Test the full loop** - Soul creation → gameplay → experience → evolution
4. **Document soul changes** - Update soul-related docs when adding features

#### Key files to know:
- `soulsoup/app/models/soul.rb` - Core soul model
- `soulsoup/app/models/incarnation.rb` - Individual soul lives
- `soulforge/js/systems/SoulforgeAPI.js` - Frontend API integration
- `soulforge/js/entities/Soldier.js` - Where soul modifiers apply

### 📈 Progress Tracking
- Phase 1 (Foundation): ✅ Complete
- Phase 2 (Memory & Learning): 🚧 In Progress
- Phase 3 (Multiple Forges): 📅 Planned
- Phase 4 (Deep Learning): 📅 Planned
- Phase 5 (Narrative): 📅 Planned
- Phase 6 (Digital Grace): 📅 Planned

### 🔗 Quick Links
- [GitHub Project Board](https://github.com/users/jeremedia/projects/1)
- [Soulforge Battle Repo](https://github.com/jeremedia/soulforge_battle)
- [Soulsoup Repo](https://github.com/jeremedia/soulsoup)
- [Issue Templates](.github/ISSUE_TEMPLATE/)

### 💡 Next Session Checklist
When starting a new Claude Code session:
1. [ ] Run `./scripts/claude-status.sh` for quick overview
2. [ ] Check project board for In Progress items
3. [ ] Read any updates in `.claude/LAST_SESSION.md`
4. [ ] Run tests to ensure clean state
5. [ ] Pick up where last session left off

---

*"Experience tempers the blade" - Every battle shapes the soul*