#!/bin/bash
# Show all v0.2 work items from the project board

PROJECT_ID=1
OWNER=jeremedia

echo "🎯 Soulforge Universe v0.2 - Soul Learning & Memory"
echo "==================================================="
echo ""

# Check authentication
if ! gh auth status &>/dev/null; then
    echo "⚠️  GitHub CLI not authenticated. Run: gh auth login"
    exit 1
fi

echo "Fetching v0.2 items from project board..."
ITEMS=$(gh project item-list $PROJECT_ID --owner $OWNER --limit 100 --format json 2>/dev/null)

if [ -z "$ITEMS" ]; then
    echo "❌ Unable to fetch project data."
    exit 1
fi

# Filter for Phase 2 items or items with learning/memory labels
echo ""
echo "📋 Phase 2: Memory & Learning Items:"
echo "$ITEMS" | jq -r '.items[] | 
  select(.phase == "Phase 2: Memory & Learning" or 
         .labels == "soul:learning" or 
         .labels == "soul:memory" or
         (.title // "" | test("learn|memory|experience|personality"; "i"))) |
  "[\(.status)] \(.content.repository // "project")#\(.content.number // "N/A"): \(.content.title // .title // "Unknown")"' | \
  sort | uniq

echo ""
echo "📊 v0.2 Status Summary:"
echo "$ITEMS" | jq -r '.items[] | 
  select(.phase == "Phase 2: Memory & Learning" or 
         .labels == "soul:learning" or 
         .labels == "soul:memory" or
         (.title // "" | test("learn|memory|experience|personality"; "i")))' | \
  jq -s 'group_by(.status) | 
  map({status: .[0].status, count: length}) | 
  .[] | "  \(.status): \(.count)"'

echo ""
echo "🚀 Key v0.2 Features:"
echo "1. Experience Accumulation - Track combat statistics per soul"
echo "2. Personality Evolution - Vectors drift based on experiences"
echo "3. Soul Memory - Basic episodic memory storage"
echo "4. Enhanced Dashboard - Soul detail pages and history"

echo ""
echo "💡 To add a v0.2 item:"
echo "1. Create issue with soul:learning or soul:memory label"
echo "2. Add to project: gh project item-add $PROJECT_ID --owner $OWNER --url [issue-url]"
echo "3. Set phase: Update custom field to 'Phase 2: Memory & Learning'"