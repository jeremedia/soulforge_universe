# Cross-Repository Work Guide

This guide helps you implement features that span both soulforge (frontend) and soulsoup (backend).

## Common Cross-Repo Features

### 1. Soul Learning Implementation (Issue #1 + #29)

**Backend (soulsoup) - Issue #1**
```bash
cd soulsoup
./scripts/start-work.sh 1
```

Tasks:
1. Create `soul_experiences` table
2. Add experience calculation to `ProcessIncarnationJob`
3. Implement personality drift in `Soul#apply_experience`
4. Create learning API endpoint

**Frontend (soulforge) - Issue #29**
```bash
cd ../soulforge  
./scripts/start-work.sh 29
```

Tasks:
1. Add visual indicators for soul personality
2. Update soldier behavior based on new modifiers
3. Show soul evolution in UI
4. Test with live API

### 2. Vendetta System (Issue #3 + #30)

**Start with Backend:**
1. Create `soul_relationships` table
2. Track repeated kills between souls
3. Add vendetta formation logic
4. Include vendetta_souls in incarnation response

**Then Frontend:**
1. Visual vendetta indicators (red outline?)
2. Damage bonus against vendetta targets
3. Priority targeting for vendetta souls
4. Vendetta formation animation

## Workflow for Cross-Repo Features

### Step 1: Plan the Interface
Before coding, define the API contract:

```javascript
// What the frontend needs
{
  soul_id: "xxx",
  modifiers: {
    vendetta_fury: 0.5  // New modifier
  },
  vendetta_souls: ["soul-1", "soul-2"]  // New data
}
```

### Step 2: Implement Backend First
```bash
# In soulsoup
rails generate migration AddVendettaToSouls
rails db:migrate
rails test
```

### Step 3: Test with Mock Data
```javascript
// In soulforge, test with mock before API is ready
const mockSoul = {
  soul_id: "test",
  vendetta_souls: ["enemy-1"]
};
```

### Step 4: Connect Real API
```javascript
// Replace mock with real API call
const soul = await api.requestIncarnation();
```

### Step 5: Test Full Integration
```bash
# Run both servers
cd soulsoup && rails server
cd soulforge && npm run dev

# Test the feature end-to-end
```

## Git Workflow for Cross-Repo Changes

### Working on Related Features
```bash
# Create branches in both repos
cd soulsoup
git checkout -b feature/vendetta-system

cd ../soulforge  
git checkout -b feature/vendetta-ui
```

### Committing Related Work
```bash
# Commit backend first
cd soulsoup
git add -A
git commit -m "feat(vendetta): Add soul relationship tracking

- Create soul_relationships table
- Track kills between souls
- Form vendettas after 3 deaths
- Include in incarnation response

Part of #3"

# Then frontend
cd ../soulforge
git add -A  
git commit -m "feat(vendetta): Add vendetta indicators in combat

- Red outline for vendetta targets
- Damage bonus implementation
- Priority targeting logic
- Formation animation

Part of #30
Depends on: jeremedia/soulsoup#3"
```

### Creating Cross-Repo PRs
```bash
# Create backend PR first
cd soulsoup
gh pr create --title "feat: Vendetta relationship system" \
  --body "Backend implementation for soul vendettas.
  
  Frontend PR: jeremedia/soulforge_battle#[number]
  Closes #3"

# Then frontend PR
cd ../soulforge
gh pr create --title "feat: Vendetta UI and targeting" \
  --body "Frontend implementation for soul vendettas.
  
  Requires: jeremedia/soulsoup#[number]
  Closes #30"
```

## Testing Cross-Repo Features

### 1. Unit Tests (Isolated)
```ruby
# soulsoup/test/models/soul_test.rb
test "forms vendetta after repeated deaths" do
  soul_a = souls(:one)
  soul_b = souls(:two)
  
  3.times { soul_a.killed_by(soul_b) }
  
  assert soul_a.has_vendetta_against?(soul_b)
end
```

```javascript
// soulforge/test/test-vendetta.js
test('prioritizes vendetta targets', () => {
  soldier.vendettaSouls = ['enemy-1'];
  const target = soldier.selectTarget(enemies);
  
  expect(target.soulId).toBe('enemy-1');
});
```

### 2. Integration Tests
```bash
# Run the soul lifecycle test
cd soulsoup
rails souls:test_lifecycle

# This tests:
# 1. Soul creation
# 2. Incarnation request  
# 3. Event processing
# 4. Soul evolution
```

### 3. Manual Testing Checklist
- [ ] Start both servers
- [ ] Open browser console for errors
- [ ] Create souls through gameplay
- [ ] Verify events are logged
- [ ] Check soul evolution in Rails console
- [ ] Confirm UI updates reflect changes

## Common Patterns

### Frontend Waiting for Backend
```javascript
// Graceful degradation when API not ready
async function requestSoul() {
  try {
    return await api.requestIncarnation();
  } catch (error) {
    console.warn('Soul API not available, using defaults');
    return createDefaultSoul();
  }
}
```

### Backend Providing Progressive Data
```ruby
# Start simple, add fields incrementally
render json: {
  soul_id: soul.id,
  incarnation_id: incarnation.id,
  # modifiers: soul.modifiers,  # Add in phase 2
  # vendetta_souls: [],         # Add in phase 3
  # memories: []                # Add in phase 4
}
```

### Debugging Cross-Repo Issues
```bash
# Check Rails logs
tail -f soulsoup/log/development.log

# Check browser console
# Open soulforge in browser, press F12

# Check network tab for API calls
# Look for 4001 port requests

# Use Rails console for data inspection
cd soulsoup && rails console
Soul.last.incarnations.last.events
```

## Deployment Considerations

When deploying cross-repo features:

1. **Deploy backend first** - New API won't break old frontend
2. **Feature flags** - Consider flags for gradual rollout
3. **Version compatibility** - Document minimum versions
4. **Database migrations** - Run before deploying code

```ruby
# Good practice: Version check
if api_version >= "1.2.0"
  include_vendetta_data
end
```

## Quick Reference

### Find Cross-Repo Issues
```bash
# Show all soul learning issues
gh issue list --repo jeremedia/soulsoup --label "soul:learning"
gh issue list --repo jeremedia/soulforge_battle --label "soul:learning"

# Show all relationship issues  
gh issue list --repo jeremedia/soulsoup --label "soul:relationships"
gh issue list --repo jeremedia/soulforge_battle --label "soul:relationships"
```

### Common File Locations

**Frontend (soulforge)**
- API integration: `js/systems/SoulforgeAPI.js`
- Soldier behavior: `js/entities/Soldier.js`
- Event tracking: Called from various entity files
- UI updates: `js/systems/UIManager.js`

**Backend (soulsoup)**
- API endpoints: `app/controllers/api/v1/*`
- Soul logic: `app/models/soul.rb`
- Event processing: `app/jobs/process_incarnation_job.rb`
- Migrations: `db/migrate/*`

Remember: Features that touch souls almost always require changes in both repositories!