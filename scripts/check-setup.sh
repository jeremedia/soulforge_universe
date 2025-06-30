#!/bin/bash
# Check if the Soulforge Universe is properly set up

# Get the script's directory and cd to parent (project root)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

echo "🔍 Checking Soulforge Universe setup..."
echo "📍 Project root: $PROJECT_ROOT"
echo ""

# Check if submodules are initialized
if [ ! -f "soulforge/.git" ] || [ ! -f "soulsoup/.git" ]; then
    echo "⚠️  Submodules not initialized!"
    echo ""
    echo "Please run:"
    echo "  git submodule update --init --recursive"
    echo ""
    echo "Or if you haven't cloned yet, use:"
    echo "  git clone --recurse-submodules https://github.com/jeremedia/soulforge_universe.git"
    echo ""
    exit 1
fi

# Check if submodules have content
if [ ! -f "soulforge/package.json" ] || [ ! -f "soulsoup/Gemfile" ]; then
    echo "⚠️  Submodules are empty!"
    echo ""
    echo "Running submodule initialization..."
    git submodule update --init --recursive
    echo ""
    echo "✅ Submodules initialized! Please run this script again."
    exit 0
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