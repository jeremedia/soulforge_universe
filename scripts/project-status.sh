#!/bin/bash
# Show detailed project board status

PROJECT_ID=1
OWNER=jeremedia

echo "📋 Soulforge Universe Project Board"
echo "===================================="
echo "URL: https://github.com/users/$OWNER/projects/$PROJECT_ID"
echo ""

# Check authentication
if ! gh auth status &>/dev/null; then
    echo "⚠️  GitHub CLI not authenticated. Run: gh auth login"
    exit 1
fi

# Fetch all items
echo "Fetching project data..."
ITEMS=$(gh project item-list $PROJECT_ID --owner $OWNER --limit 100 --format json 2>/dev/null)

if [ -z "$ITEMS" ]; then
    echo "❌ Unable to fetch project data. Check your connection and permissions."
    exit 1
fi

# In Progress items with full context
echo ""
echo "🚀 IN PROGRESS:"
echo "$ITEMS" | jq -r '.items[] | 
  select(.status == "In Progress") | 
  "• \(.content.repository // "project")#\(.content.number // "N/A"): \(.content.title // .title // "Unknown")
    URL: \(.content.url // "No URL")
    Type: \(.content.type // "Unknown")"' || echo "   No items in progress"

echo ""
echo "📊 BOARD STATS:"
# Count by status
echo "$ITEMS" | jq -r '.items | 
  group_by(.status) | 
  map({status: .[0].status, count: length}) | 
  sort_by(.status) |
  .[] | "  \(.status): \(.count)"'

echo ""
echo "🎯 HIGH PRIORITY BACKLOG:"
echo "$ITEMS" | jq -r '.items[] | 
  select(.status == "Backlog" or .status == "Todo") |
  select(.priority == "🔥 Critical" or .priority == "🎯 High" or .priority == null) |
  "• \(.content.repository // "project")#\(.content.number // "N/A"): \(.content.title // .title // "Unknown")"' | head -10

echo ""
echo "📈 RECENT ACTIVITY (Last 5 completed):"
echo "$ITEMS" | jq -r '.items[] | 
  select(.status == "Done") |
  "• \(.content.repository // "project")#\(.content.number // "N/A"): \(.content.title // .title // "Unknown")"' | head -5

echo ""
echo "🔍 PHASE BREAKDOWN:"
echo "$ITEMS" | jq -r '.items | 
  map(select(.phase != null)) |
  group_by(.phase) | 
  map({phase: .[0].phase, count: length}) | 
  sort_by(.phase) |
  .[] | "  \(.phase): \(.count)"'

echo ""
echo "💡 COMMANDS:"
echo "- View in browser: open https://github.com/users/$OWNER/projects/$PROJECT_ID"
echo "- Start work: ./scripts/start-work.sh [issue-number]"
echo "- Create issue: ./scripts/soul-issue.sh \"Title\" \"Body\" \"Component\""