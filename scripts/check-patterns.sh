#!/bin/bash
# Check for common pattern violations

echo "🔍 Checking Soulforge Patterns"
echo "=============================="
echo ""

# Check for magic numbers in JavaScript (excluding config.js)
echo "📊 Checking for magic numbers..."
MAGIC_NUMBERS=$(find /Volumes/jer4TBv3/Soulforge_Universe/soulforge/js -name "*.js" -not -name "config.js" -not -path "*/node_modules/*" -exec grep -n "[^a-zA-Z_][0-9]\+\(\.[0-9]\+\)\?" {} + | grep -v "const\|let\|var\|import\|export" | head -10)

if [ -n "$MAGIC_NUMBERS" ]; then
    echo "⚠️  Found potential magic numbers:"
    echo "$MAGIC_NUMBERS"
else
    echo "✅ No obvious magic numbers found"
fi

echo ""
echo "📝 Checking for console.log usage..."
CONSOLE_LOGS=$(find /Volumes/jer4TBv3/Soulforge_Universe/soulforge/js -name "*.js" -not -name "debug.js" -not -path "*/node_modules/*" -exec grep -l "console\.log" {} + | wc -l | tr -d ' ')

if [ "$CONSOLE_LOGS" -gt 0 ]; then
    echo "⚠️  Found console.log in $CONSOLE_LOGS files (should use debugLog)"
    find /Volumes/jer4TBv3/Soulforge_Universe/soulforge/js -name "*.js" -not -name "debug.js" -not -path "*/node_modules/*" -exec grep -l "console\.log" {} + | head -5
else
    echo "✅ No console.log usage found"
fi

echo ""
echo "🔄 Checking commit format (last 10 commits)..."
IMPROPER_COMMITS=$(git log --oneline -10 2>/dev/null | grep -v "^[a-f0-9]\+ [a-z]\+\(([^)]\+)\)\?: " | wc -l | tr -d ' ')

if [ "$IMPROPER_COMMITS" -gt 0 ]; then
    echo "⚠️  Found $IMPROPER_COMMITS commits not following format 'type(component): message'"
    git log --oneline -10 | grep -v "^[a-f0-9]\+ [a-z]\+\(([^)]\+)\)\?: " | head -5
else
    echo "✅ Recent commits follow proper format"
fi

echo ""
echo "🎯 Checking soul integration..."
# Check if SoulforgeAPI is imported where soldiers are created
SOUL_IMPORTS=$(grep -l "SoulforgeAPI" /Volumes/jer4TBv3/Soulforge_Universe/soulforge/js/entities/Base.js 2>/dev/null)

if [ -n "$SOUL_IMPORTS" ]; then
    echo "✅ Soul API properly imported in Base.js"
else
    echo "⚠️  Soul API not imported in Base.js"
fi

echo ""
echo "📋 Quick Reminders:"
echo "- Always reference issues in commits (Closes #123)"
echo "- Use debugLog instead of console.log"
echo "- Put all numbers in config.js"
echo "- Test with soul API both on and off"
echo "- Update PROJECT_STATUS.md for major completions"