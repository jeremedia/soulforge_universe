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
gh project item-list 1 --owner jeremedia --limit 20 --format json 2>/dev/null | \
  jq -r '.items[] | 
  select(.status == "In Progress") | 
  "• \(.content.repository // "unknown")#\(.content.number // "?"): \(.content.title // .title // "Unknown title")"' || \
  echo "   Unable to fetch from project board"

echo ""
echo "📍 YOUR LOCATION:"
pwd
echo ""

echo "🎯 HIGH PRIORITY BACKLOG:"
gh project item-list 1 --owner jeremedia --limit 50 --format json 2>/dev/null | \
  jq -r '.items[] | 
  select(.status == "Backlog" or .status == "Todo") | 
  select(.priority == "🔥 Critical" or .priority == "🎯 High" or .priority == null) |
  "• \(.content.repository // "unknown")#\(.content.number // "?"): \(.content.title // .title // "Unknown title")"' | \
  head -5 || \
  echo "   Unable to fetch from project board"

echo ""
echo "📊 REPOSITORY STATUS:"
echo "- soulforge_battle: $(cd /Volumes/jer4TBv3/Soulforge_Universe/soulforge 2>/dev/null && git branch --show-current 2>/dev/null || echo "not found")"
echo "- soulsoup: $(cd /Volumes/jer4TBv3/Soulforge_Universe/soulsoup 2>/dev/null && git branch --show-current 2>/dev/null || echo "not found")"

echo ""
echo "💡 TIPS:"
echo "- Open project board: open https://github.com/users/jeremedia/projects/1"
echo "- View detailed status: ./scripts/project-status.sh"
echo "- Start work on issue: ./scripts/start-work.sh [issue-number]"
echo "- See all v0.2 work: ./scripts/show-v02-work.sh"