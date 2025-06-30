#!/bin/bash
# Create cross-repository issues for Soulforge Universe

echo "🌌 Soulforge Universe Issue Creator"
echo "=================================="
echo ""
echo "This will create linked issues across soulforge and soulsoup repos"
echo ""

# Get issue details
read -p "Issue title: " title
read -p "Brief description: " description
read -p "Primary component (soulforge/soulsoup/both): " component
read -p "Soul system (genome/learning/relationships/narrative/grace): " soul_system

# Create issue in appropriate repos
if [ "$component" = "both" ] || [ "$component" = "soulsoup" ]; then
  echo "Creating issue in soulsoup..."
  soulsoup_issue=$(gh issue create --repo jeremedia/soulsoup \
    --title "[SOUL] $title" \
    --body "$description" \
    --label "soul:$soul_system,component:soulsoup" \
    | tail -1)
  echo "Created: $soulsoup_issue"
fi

if [ "$component" = "both" ] || [ "$component" = "soulforge" ]; then
  echo "Creating issue in soulforge_battle..."
  
  # Add reference to soulsoup issue if created
  if [ ! -z "$soulsoup_issue" ]; then
    body="$description\n\nRelated backend work: $soulsoup_issue"
  else
    body="$description"
  fi
  
  soulforge_issue=$(gh issue create --repo jeremedia/soulforge_battle \
    --title "[SOUL] $title" \
    --body "$body" \
    --label "soul:$soul_system,component:soulforge" \
    | tail -1)
  echo "Created: $soulforge_issue"
  
  # Update soulsoup issue with reference if both created
  if [ ! -z "$soulsoup_issue" ] && [ "$component" = "both" ]; then
    gh issue comment $soulsoup_issue --body "Related frontend work: $soulforge_issue"
  fi
fi

echo ""
echo "✨ Issues created successfully!"