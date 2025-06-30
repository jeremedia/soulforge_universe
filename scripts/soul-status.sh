#!/bin/bash
# Show status across all Soulforge Universe repositories

echo "🌌 Soulforge Universe Status"
echo "============================"
echo ""

echo "📊 Issue Summary"
echo "----------------"

echo ""
echo "🎮 Soulforge (Frontend):"
gh issue list --repo jeremedia/soulforge_battle --label "soul:learning,soul:relationships,soul:narrative,soul:genome,soul:grace" --limit 10

echo ""
echo "🗄️ Soulsoup (Backend):"
gh issue list --repo jeremedia/soulsoup --label "soul:learning,soul:relationships,soul:narrative,soul:genome,soul:grace" --limit 10

echo ""
echo "📈 Open Issues by Soul System:"
echo "------------------------------"

for label in genome learning relationships narrative grace; do
  soulforge_count=$(gh issue list --repo jeremedia/soulforge_battle --label "soul:$label" --state open --json title --jq '. | length')
  soulsoup_count=$(gh issue list --repo jeremedia/soulsoup --label "soul:$label" --state open --json title --jq '. | length')
  total=$((soulforge_count + soulsoup_count))
  
  printf "%-15s: %2d (Frontend: %d, Backend: %d)\n" "$label" "$total" "$soulforge_count" "$soulsoup_count"
done

echo ""
echo "🚀 Recent Activity:"
echo "-------------------"
echo "Latest commits in soulforge:"
cd /Volumes/jer4TBv3/Soulforge_Universe/soulforge && git log --oneline -5

echo ""
echo "Latest commits in soulsoup:"
cd /Volumes/jer4TBv3/Soulforge_Universe/soulsoup && git log --oneline -5