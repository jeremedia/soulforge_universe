#!/bin/bash
# Quick status check for Claude Code sessions

echo "🌌 SOULFORGE UNIVERSE STATUS"
echo "=========================="
echo ""
echo "📋 PROJECT BOARD: https://github.com/users/jeremedia/projects/1"
echo ""

# Check if gh is authenticated
if ! gh auth status &>/dev/null; then
    echo "⚠️  GitHub CLI not authenticated. Run: gh auth login"
    echo ""
fi

echo "🚀 IN PROGRESS ITEMS:"
ITEMS=$(gh project item-list 1 --owner jeremedia --limit 100 2>/dev/null)
if [ -n "$ITEMS" ]; then
    # Parse the text output format from gh
    echo "$ITEMS" | grep -E "^Issue|^DraftIssue|^Note" | head -5 | while IFS=$'\t' read -r type title number repo id; do
        if [ -n "$title" ]; then
            echo "• ${repo}#${number}: ${title}"
        fi
    done
    
    # Check if any items were found
    if [ $(echo "$ITEMS" | grep -c "^Issue\|^DraftIssue\|^Note") -eq 0 ]; then
        echo "   No items currently in progress"
    fi
else
    echo "   Unable to fetch from project board"
fi

echo ""
echo "📍 YOUR LOCATION:"
pwd
echo ""

echo "🎯 ALL PROJECT ITEMS:"
if [ -n "$ITEMS" ]; then
    echo "$ITEMS" | grep -E "^Issue|^DraftIssue|^Note" | head -10 | while IFS=$'\t' read -r type title number repo id; do
        if [ -n "$title" ]; then
            echo "• ${repo}#${number}: ${title}"
        fi
    done
else
    echo "   Unable to fetch from project board"
fi

echo ""
echo "📊 REPOSITORY STATUS:"

# Check if submodules are initialized
if [ ! -f "soulforge/.git" ] || [ ! -f "soulsoup/.git" ]; then
    echo "⚠️  SUBMODULES NOT INITIALIZED!"
    echo ""
    echo "Run: git submodule update --init --recursive"
    echo "Or use: ./scripts/check-setup.sh"
else
    echo "- soulforge_battle: $(cd soulforge 2>/dev/null && git branch --show-current 2>/dev/null || echo "not found")"
    echo "- soulsoup: $(cd soulsoup 2>/dev/null && git branch --show-current 2>/dev/null || echo "not found")"
fi

echo ""
echo "💡 TIPS:"
echo "- Open project board: open https://github.com/users/jeremedia/projects/1"
echo "- View detailed status: ./scripts/project-status.sh"
echo "- Start work on issue: ./scripts/start-work.sh [issue-number]"
echo "- See all v0.2 work: ./scripts/show-v02-work.sh"