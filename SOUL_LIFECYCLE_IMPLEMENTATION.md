# Soul Lifecycle Implementation Guide

This document details the complete soul lifecycle implementation across the Soulforge Universe, documenting the work completed on June 30, 2025.

## Overview

The soul lifecycle ensures that digital souls persist beyond individual game sessions, accumulating experiences that shape their evolution. This implementation creates the foundation that all future forges will use.

## Architecture Diagram

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Combat Forge   │     │   Soulsoup API   │     │  Soul Database  │
│  (Frontend)     │────▶│   (Rails)        │────▶│  (PostgreSQL)   │
└─────────────────┘     └──────────────────┘     └─────────────────┘
         │                       │                         │
         │                       ▼                         ▼
         │              ┌──────────────────┐     ┌─────────────────┐
         │              │  Solid Queue     │     │  Event Store    │
         └─────────────▶│  (Jobs)          │────▶│  (RailsEvent)   │
                        └──────────────────┘     └─────────────────┘
```

## Implementation Flow

### 1. Soul Request & Incarnation

**Frontend (main.js)**
```javascript
async spawnSoldier(x, y, team) {
  // Request soul from backend
  const incarnationData = await soulforgeAPI.requestIncarnation('combat', [team.id]);
  
  // Create soldier with soul modifiers
  const soldier = new Soldier(x, y, this.canvas, team, base);
  
  // Apply soul modifiers and register
  soulforgeAPI.applySoulModifiers(soldier, incarnationData);
  soulforgeAPI.registerIncarnation(soldier.id, incarnationData);
}
```

**Backend (incarnations_controller.rb)**
```ruby
def create
  soul = Soul.match_or_create(
    forge_type: params[:forge_type],
    team_preferences: params[:team_preferences]
  )
  
  incarnation = soul.incarnations.create!(
    incarnation_id: generate_incarnation_id,
    forge_type: params[:forge_type],
    game_session_id: params[:game_session_id],
    started_at: Time.current,
    modifiers: soul.calculate_modifiers
  )
  
  render json: incarnation_response(incarnation)
end
```

### 2. Experience Tracking

**Event Types Tracked**
- `combat_kill` - When soldier defeats enemy
- `combat_death` - When soldier is defeated  
- `resource_gathered` - Metal/crystal collection
- `cooperation_event` - Team coordination
- `level_up` - Advancement through combat
- `base_interaction` - Healing/resupply

**Event Batching (SoulforgeAPI.js)**
```javascript
// Events queued and sent every 5 seconds
logEvent(entityId, eventType, eventData) {
  const event = {
    incarnation_id: incarnation.incarnation_id,
    type: eventType,
    timestamp: Date.now(),
    ...eventData
  };
  this.eventQueue.push(event);
}
```

### 3. Heartbeat System

**Purpose**: Detect disconnected sessions without explicit termination

**Frontend (SoulforgeAPI.js)**
```javascript
// Send heartbeat every 30 seconds
async sendHeartbeat() {
  const activeIncarnationIds = Array.from(this.incarnations.values())
    .map(inc => inc.incarnation_id);
    
  const response = await fetch(`/api/v1/sessions/${this.gameSessionId}/heartbeat`, {
    method: 'POST',
    body: JSON.stringify({ incarnation_ids: activeIncarnationIds })
  });
}
```

**Backend (sessions_controller.rb)**
```ruby
def heartbeat
  incarnation_ids = params[:incarnation_ids] || []
  
  incarnation_ids.each do |incarnation_id|
    incarnation = Incarnation.active.find_by(incarnation_id: incarnation_id)
    incarnation&.update!(last_heartbeat_at: Time.current)
  end
  
  render json: { updated_count: updated_count }
end
```

### 4. Incarnation End

**Trigger Points**
1. Soldier death (onDeath method)
2. Game victory (all enemies defeated)
3. Page unload (beforeunload event)
4. Tab hidden (visibilitychange event)
5. Timeout (CleanupStaleIncarnationsJob)

**Death Context (Soldier.js)**
```javascript
onDeath() {
  if (this.incarnationId) {
    soulforgeAPI.endIncarnation(this.id, {
      outcome: 'death',
      final_level: this.level,
      kills: this.kills,
      lifetime: Date.now() - this.spawnTime,
      last_position: { x: this.x, y: this.y },
      last_state: this.state
    });
  }
}
```

### 5. Experience Processing

**ProcessIncarnationJob**
```ruby
def perform(incarnation)
  # Calculate experience components
  duration_bonus = Math.log(duration_minutes + 1) * 10
  combat_score = kills * 10 - deaths * 5
  victory_multiplier = outcome == 'victory' ? 1.5 : 1.0
  
  total_experience = (duration_bonus + combat_score) * victory_multiplier
  
  # Update incarnation
  incarnation.update!(
    memory_summary: enhanced_summary.to_json,
    total_experience: total_experience
  )
  
  # Update soul grace
  soul.increment!(:current_grace_level, total_experience * 0.001)
end
```

### 6. Cleanup System

**CleanupStaleIncarnationsJob (runs every 10 minutes)**
```ruby
def perform
  # End sessions > 2 hours
  stale_incarnations = Incarnation.active
    .where("started_at < ?", 2.hours.ago)
    
  # End sessions with no heartbeat > 5 minutes  
  orphaned_incarnations = Incarnation.active
    .where("last_heartbeat_at IS NULL OR last_heartbeat_at < ?", 5.minutes.ago)
    
  (stale_incarnations + orphaned_incarnations).each do |incarnation|
    incarnation.end_incarnation!(summary: {
      outcome: 'timeout',
      reason: 'Session exceeded maximum duration'
    })
  end
end
```

## Browser Event Handling

**Page Unload Protection (main.js)**
```javascript
setupBrowserEventHandlers() {
  // Flush events before page closes
  window.addEventListener('beforeunload', (event) => {
    if (this.running && window.soulforgeAPI) {
      window.soulforgeAPI.sendEventBatch();
    }
  });
  
  // Handle tab visibility
  document.addEventListener('visibilitychange', () => {
    if (document.hidden && window.soulforgeAPI) {
      window.soulforgeAPI.sendEventBatch();
    }
  });
}
```

## Database Schema

### Incarnations Table
```ruby
create_table :incarnations do |t|
  t.string :incarnation_id, unique: true
  t.references :soul, null: false
  t.string :forge_type
  t.datetime :started_at
  t.datetime :ended_at
  t.string :game_session_id
  t.jsonb :modifiers
  t.integer :events_count
  t.float :total_experience
  t.text :memory_summary  # JSON string of experience details
  t.string :lora_weights_url
  t.datetime :last_heartbeat_at
  t.timestamps
end
```

## Testing the Implementation

### Manual Test Flow
```bash
# 1. Start services
node scripts/rails_manager.js start

# 2. Run automated test
node scripts/rails_manager.js test

# 3. Check results
ruby scripts/check_soul_processing.rb

# 4. Monitor logs
tail -f log/development.log | grep -E "incarnation|soul"
```

### Expected Results
- Incarnation created with soul modifiers
- Events streamed during gameplay
- Heartbeats updating last_heartbeat_at
- Death/victory triggers incarnation end
- Background job calculates experience
- Soul grace level increases
- Memory summary contains full context

## Configuration Files

### config/solid_queue.yml
```yaml
development:
  dispatchers:
    - polling_interval: 1
      batch_size: 500
  workers:
    - queues: "*"
      threads: 3
      processes: 1
      polling_interval: 0.1
```

### config/recurring.yml
```yaml
cleanup_stale_incarnations:
  class: CleanupStaleIncarnationsJob
  schedule: every 10 minutes
```

## Troubleshooting Guide

### Common Issues

1. **"No incarnation found for entity"**
   - Ensure soul request completed before spawning
   - Check network tab for failed requests
   - Verify Rails server is running on port 4001

2. **Jobs not processing**
   - Check `bin/jobs` is running
   - Look for errors in log/jobs.log
   - Ensure solid_queue tables exist in database

3. **Memory summary empty**
   - Verify memory_summary is JSON string (not hash)
   - Check ProcessIncarnationJob for errors
   - Ensure job completed successfully

4. **Heartbeat not updating**
   - Verify session ID matches
   - Check CORS configuration
   - Ensure heartbeat interval is running

## Future Considerations

### Scalability
- Consider Redis for event queue
- Implement connection pooling
- Add request rate limiting

### Features
- WebSocket for real-time updates
- Soul matching algorithm improvements
- Memory compression for long sessions
- Batch incarnation processing

### Monitoring
- Add APM instrumentation
- Create soul health dashboard
- Implement alerting for stale incarnations
- Track experience distribution

## Key Learnings

1. **Rails Manager Script**: Essential for rapid development iteration
2. **Three-Tier Robustness**: Explicit events + heartbeat + timeout cleanup
3. **JSON Column Handling**: TEXT columns need explicit JSON conversion
4. **Browser Events**: Critical for handling unexpected termination
5. **Background Jobs**: Solid Queue provides reliable async processing

This implementation creates a robust foundation for soul persistence across all future forges in the Soulforge Universe.