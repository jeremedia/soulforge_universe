# Comprehensive Context Awareness System for Soulforge Universe

## Overview

This system ensures future Claude Code sessions achieve full project awareness within 60 seconds and can be productively coding within 3 minutes. The system is self-documenting, self-updating, and guides Claude through established patterns.

## 🏗️ Repository Structure

The Soulforge Universe now uses a **meta-repository with submodules**:

```
soulforge_universe/              (meta git repository)
├── .git/                       (root repo tracking all context)
├── .claude/                    (context awareness system)
├── .github/                    (issue templates)
├── scripts/                    (project management scripts)
├── soulforge/                  (submodule → soulforge_battle)
├── soulsoup/                   (submodule → soulsoup)
├── CLAUDE.md                   (project vision & context)
├── PROJECT_STATUS.md           (current sprint details)
└── README.md                   (quick start guide)
```

### Benefits
- **Single Clone**: `git clone --recurse-submodules` gets everything
- **Versioned Context**: All Claude awareness files are tracked
- **Preserved Scripts**: Helper scripts are part of the project
- **Unified Documentation**: Project-wide docs at root level

## 📍 GitHub Project Board Integration

**THE SOURCE OF TRUTH**: https://github.com/users/jeremedia/projects/1

All work is tracked on the project board with:
- Custom fields: Component, Soul System, Phase, Priority
- Multiple views: Component Kanban, Roadmap, Soul Systems
- Automated workflows: Issues → In Progress → Done

## 🚀 Layer 1: Immediate Orientation (First 30 seconds)

### `.claude/WELCOME.md`
Quick-start file that Claude sees immediately with:
- Link to GitHub Project Board
- Quick status command
- Repository links
- Last session reference

### `scripts/claude-status.sh`
One command showing:
- Project board in-progress items
- Repository branch status
- High priority backlog
- Quick tips for next actions

## 📚 Layer 2: Progressive Discovery (30 seconds - 2 minutes)

### Enhanced `CLAUDE.md` Files
- Root CLAUDE.md: Project board section, quick commands, patterns
- Sub-project CLAUDE.md: Reference to root context system
- All point to GitHub Project Board as source of truth

### `PROJECT_STATUS.md`
- Current sprint overview (v0.2: Soul Learning & Memory)
- Key features being implemented
- Links to project board
- Development guidelines

## 🎯 Layer 3: Action Guidance (2-3 minutes)

### Project Scripts
- `start-work.sh [issue]` - Creates branch, shows context
- `project-status.sh` - Detailed board analysis
- `show-v02-work.sh` - Current sprint items
- `check-patterns.sh` - Verify code quality

### `.claude/PATTERNS.md`
Quick reference for:
- Soul modifier application
- Event tracking patterns
- Testing integration
- Config constants usage

## ✅ Layer 4: Quality Maintenance

### `.claude/CHECKLIST.md`
Pre-commit checklist:
- Code quality checks
- Soul-specific requirements
- Git hygiene
- Documentation updates

### Pattern Checking
- `check-patterns.sh` - Automated verification
- No magic numbers (use config.js)
- No console.log (use debugLog)
- Proper commit format

## 🔄 Layer 5: Session Handoff

### `end-session.sh`
Documents:
- Current work state
- Repository branches
- Recent commits
- Next priorities

### `.claude/LAST_SESSION.md`
Generated file showing:
- What was worked on
- Current branch state
- Uncommitted changes
- Next steps

## 📝 Implementation Status

### ✅ Completed
1. Created `.claude/` directory with all context files
2. Implemented all helper scripts
3. Updated all CLAUDE.md files with project board references
4. Created PROJECT_STATUS.md for sprint tracking
5. **Initialized meta-repository with submodules**
6. **Created GitHub repository: soulforge_universe**
7. **Updated README with submodule clone instructions**

### 🎉 Result
The Soulforge Universe now has:
- **Central Repository**: https://github.com/jeremedia/soulforge_universe
- **Project Board**: https://github.com/users/jeremedia/projects/1
- **Complete Context System**: Preserved in git
- **One-Command Setup**: Clone with submodules

## 🚦 How Future Sessions Work

### 1. Clone & Orient (0-60 seconds)
```bash
git clone --recurse-submodules https://github.com/jeremedia/soulforge_universe.git
cd soulforge_universe
./scripts/claude-status.sh
```

### 2. Find Work (60-120 seconds)
- Check project board "In Progress" column
- Review PROJECT_STATUS.md for context
- Read .claude/LAST_SESSION.md if continuing work

### 3. Start Coding (120-180 seconds)
```bash
./scripts/start-work.sh [issue-number]
# Branch created, context shown, ready to code!
```

### 4. Maintain Quality
- Reference `.claude/PATTERNS.md`
- Use `.claude/CHECKLIST.md` before commits
- Run `./scripts/check-patterns.sh`

### 5. Hand Off
```bash
./scripts/end-session.sh
# State documented for next session
```

## 🎯 Key Achievement

The context awareness system is now:
- **Permanent**: Tracked in git repository
- **Discoverable**: One clone gets everything
- **Self-Documenting**: Scripts and docs explain themselves
- **Project-Board Driven**: Single source of truth
- **Session-Friendly**: Quick orientation for any Claude instance

Future Claude Code sessions will never lose context about the project structure, current work, or established patterns!