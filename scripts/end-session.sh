#!/bin/bash
# Document the current session state for the next Claude

echo "📝 Documenting session state..."

# Get current date
DATE=$(date +"%Y-%m-%d %H:%M")

# Get current branch info
SOULFORGE_BRANCH=$(cd /Volumes/jer4TBv3/Soulforge_Universe/soulforge 2>/dev/null && git branch --show-current)
SOULSOUP_BRANCH=$(cd /Volumes/jer4TBv3/Soulforge_Universe/soulsoup 2>/dev/null && git branch --show-current)

# Get recent commits
RECENT_COMMITS=$(git log --oneline -5 2>/dev/null || echo "No recent commits")

# Get current work
CURRENT_WORK=$(cat /Volumes/jer4TBv3/Soulforge_Universe/.claude/CURRENT_WORK.md 2>/dev/null || echo "No current work tracked")

# Get uncommitted changes
SOULFORGE_CHANGES=$(cd /Volumes/jer4TBv3/Soulforge_Universe/soulforge 2>/dev/null && git status -s | wc -l | tr -d ' ')
SOULSOUP_CHANGES=$(cd /Volumes/jer4TBv3/Soulforge_Universe/soulsoup 2>/dev/null && git status -s | wc -l | tr -d ' ')

# Create session summary
cat > /Volumes/jer4TBv3/Soulforge_Universe/.claude/LAST_SESSION.md << EOF
# Last Session: $DATE

## Current Work
$CURRENT_WORK

## Repository State
- **soulforge_battle**: branch \`$SOULFORGE_BRANCH\` ($SOULFORGE_CHANGES uncommitted files)
- **soulsoup**: branch \`$SOULSOUP_BRANCH\` ($SOULSOUP_CHANGES uncommitted files)

## Recent Activity
\`\`\`
$RECENT_COMMITS
\`\`\`

## Next Steps
Check the project board for current priorities:
https://github.com/users/jeremedia/projects/1

Run \`./scripts/claude-status.sh\` to see current state.

## Session Notes
(Add any important context here before ending session)
EOF

echo ""
echo "✅ Session documented in .claude/LAST_SESSION.md"
echo ""
echo "Next Claude session should:"
echo "1. Run ./scripts/claude-status.sh"
echo "2. Check .claude/LAST_SESSION.md"
echo "3. Review PROJECT_STATUS.md"
echo "4. Check the GitHub project board"
echo ""
echo "Would you like to add any session notes? (Press Ctrl+D when done)"
echo "---"

# Read additional notes
NOTES=$(cat)

if [ -n "$NOTES" ]; then
    echo "" >> /Volumes/jer4TBv3/Soulforge_Universe/.claude/LAST_SESSION.md
    echo "### Additional Notes" >> /Volumes/jer4TBv3/Soulforge_Universe/.claude/LAST_SESSION.md
    echo "$NOTES" >> /Volumes/jer4TBv3/Soulforge_Universe/.claude/LAST_SESSION.md
    echo "✅ Notes added to session file"
fi