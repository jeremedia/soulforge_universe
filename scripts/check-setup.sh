#!/bin/bash
# Check if the Soulforge Universe is properly set up

# Get the script's directory and cd to parent (project root)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

echo "🔍 Checking Soulforge Universe setup..."
echo "📍 Project root: $PROJECT_ROOT"
echo ""

# Check if we have actual project directories
if [ ! -d "soulforge" ] || [ ! -d "soulsoup" ]; then
    echo "⚠️  Project directories not found!"
    echo ""
    echo "This could mean:"
    echo "1. You need to initialize submodules: git submodule update --init --recursive"
    echo "2. You're running from the wrong directory"
    echo ""
    exit 1
fi

# Check if submodules have actual content (safer check)
if [ ! -f "soulforge/package.json" ] || [ ! -f "soulsoup/Gemfile" ]; then
    echo "⚠️  Project directories exist but appear empty!"
    echo ""
    echo "Checking if this is a submodule setup..."
    
    # Only try to init submodules if .gitmodules exists
    if [ -f ".gitmodules" ]; then
        echo "This appears to be a submodule setup. You may need to run:"
        echo "  git submodule update --init --recursive"
    else
        echo "Project files not found. Please check your setup."
    fi
    echo ""
    exit 1
fi

# Additional safety check - verify these are the right projects
if ! grep -q "soulforge" "soulforge/package.json" 2>/dev/null; then
    echo "⚠️  Warning: soulforge/package.json doesn't look right"
fi

if ! grep -q "soulsoup" "soulsoup/Gemfile" 2>/dev/null; then
    echo "⚠️  Warning: soulsoup/Gemfile doesn't look right"
fi

echo "✅ Submodules properly initialized"
echo ""

# Check GitHub CLI
if ! gh auth status &>/dev/null; then
    echo "⚠️  GitHub CLI not authenticated"
    echo "   Run: gh auth login"
else
    echo "✅ GitHub CLI authenticated"
fi

echo ""
echo "✅ Setup looks good! You can now run:"
echo "   ./scripts/claude-status.sh"