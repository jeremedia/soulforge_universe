#!/bin/bash
# Start working on a specific issue

if [ $# -eq 0 ]; then
    echo "Usage: $0 <issue-number>"
    echo "Example: $0 15"
    exit 1
fi

ISSUE=$1
PROJECT_ID=1
OWNER=jeremedia

echo "🎬 Starting work on issue #$ISSUE"
echo ""

# Try to find the issue in both repos
echo "Searching for issue #$ISSUE..."

# Check soulforge_battle
SOULFORGE_ISSUE=$(gh issue view $ISSUE --repo jeremedia/soulforge_battle --json number,title,state,url 2>/dev/null)
if [ $? -eq 0 ]; then
    REPO="soulforge_battle"
    REPO_PATH="/Volumes/jer4TBv3/Soulforge_Universe/soulforge"
    echo "Found in soulforge_battle repository"
else
    # Check soulsoup
    SOULSOUP_ISSUE=$(gh issue view $ISSUE --repo jeremedia/soulsoup --json number,title,state,url 2>/dev/null)
    if [ $? -eq 0 ]; then
        REPO="soulsoup"
        REPO_PATH="/Volumes/jer4TBv3/Soulforge_Universe/soulsoup"
        echo "Found in soulsoup repository"
    else
        echo "❌ Issue #$ISSUE not found in either repository"
        exit 1
    fi
fi

# Show issue details
echo ""
gh issue view $ISSUE --repo jeremedia/$REPO

# Create feature branch
cd $REPO_PATH
CURRENT_BRANCH=$(git branch --show-current)
BRANCH="feature/issue-$ISSUE"

echo ""
echo "📍 Current branch: $CURRENT_BRANCH"

# Check if branch already exists
if git show-ref --verify --quiet refs/heads/$BRANCH; then
    echo "⚠️  Branch $BRANCH already exists. Switching to it..."
    git checkout $BRANCH
else
    echo "Creating new branch: $BRANCH"
    git checkout -b $BRANCH
fi

# Update Claude tracking
mkdir -p /Volumes/jer4TBv3/Soulforge_Universe/.claude
echo "Issue #$ISSUE in $REPO" > /Volumes/jer4TBv3/Soulforge_Universe/.claude/CURRENT_WORK.md

# Try to assign to self (might fail if already assigned)
gh issue edit $ISSUE --repo jeremedia/$REPO --add-assignee @me 2>/dev/null

# Show relevant documentation
echo ""
echo "📚 Relevant documentation:"
if [[ "$REPO" == "soulsoup" ]]; then
    echo "- soulsoup/CLAUDE.md"
    echo "- soulsoup/README.md"
    echo "- docs/SOUL_API_INTEGRATION.md"
else
    echo "- soulforge/CLAUDE.md"
    echo "- soulforge/README.md"
    echo "- soulforge/docs/"
fi

echo ""
echo "✅ Ready to work!"
echo ""
echo "Next steps:"
echo "1. Make your changes"
echo "2. Commit with: git commit -m \"feat: Description (Closes #$ISSUE)\""
echo "3. Push with: git push -u origin $BRANCH"
echo "4. Create PR with: gh pr create"