# Soulforge Patterns Quick Reference

## Soul Modifier Application

### Basic Modifier Usage
```javascript
// In Soldier.js constructor
if (this.soulModifiers) {
  // Courage affects retreat threshold
  const courageBonus = this.soulModifiers.courage_bonus || 0; // -1 to 1
  this.retreatThreshold = BASE_RETREAT * (1 - courageBonus);
  
  // Strategic thinking affects aim
  const aimBonus = this.soulModifiers.aim_adjustment || 0; // -0.5 to 0.5
  this.baseAccuracy = BASE_ACCURACY + aimBonus;
  
  // Risk tolerance affects aggression range
  const riskMod = this.soulModifiers.risk_tolerance || 0;
  this.preferredRange = BASE_RANGE * (1 + riskMod * 0.2);
}
```

### Complete Soul Data Structure
```javascript
// Response from API
{
  soul_id: "550e8400-e29b-41d4-a716-446655440000",
  incarnation_id: "660e8400-e29b-41d4-a716-446655440001", 
  soul_name: "Zyx-7742",
  current_level: 5,
  total_incarnations: 23,
  modifiers: {
    courage_bonus: 0.15,        // Makes unit braver
    aim_adjustment: 0.08,       // Better accuracy
    retreat_timing: -50,        // Retreats 50ms earlier
    resource_priority: 0.3,     // 30% more likely to gather
    vendetta_fury: 0.5         // 50% damage bonus vs vendetta
  },
  personality_hints: [
    "tends toward bold action",
    "holds grudges", 
    "protective of allies"
  ],
  vendetta_souls: ["soul-uuid-1", "soul-uuid-2"],
  allied_souls: ["soul-uuid-3"],
  lifetime_stats: {
    total_kills: 127,
    total_deaths: 89,
    resources_gathered: 341,
    bases_destroyed: 3
  }
}
```

## Event Tracking

### Combat Events
```javascript
// Kill event with full context
api.trackEvent({
  type: 'combat_kill',
  incarnation_id: this.incarnationId,
  timestamp: Date.now(),
  data: {
    victim_soul_id: target.soulId,
    victim_incarnation_id: target.incarnationId,
    location: { x: this.x, y: this.y },
    range: distance,
    weapon: 'rifle',
    level_difference: this.level - target.level,
    health_remaining: this.health,
    ammo_remaining: this.ammo,
    was_vendetta: this.vendettaSouls.includes(target.soulId)
  }
});

// Death event
api.trackEvent({
  type: 'combat_death',
  incarnation_id: this.incarnationId,
  timestamp: Date.now(),
  data: {
    killer_soul_id: killer.soulId,
    killer_incarnation_id: killer.incarnationId,
    location: { x: this.x, y: this.y },
    lifetime_ms: Date.now() - this.spawnTime,
    final_level: this.level,
    kills_this_life: this.killCount,
    resources_delivered: this.resourcesDelivered
  }
});
```

### Resource Events
```javascript
// Resource collection
api.trackEvent({
  type: 'resource_collected',
  incarnation_id: this.incarnationId,
  timestamp: Date.now(),
  data: {
    resource_type: 'metal', // or 'organics', 'crystal'
    amount: 1,
    location: { x: resource.x, y: resource.y },
    carrying_capacity: this.maxCarryCapacity,
    distance_from_base: this.distanceToBase()
  }
});

// Resource delivery
api.trackEvent({
  type: 'resource_delivered',
  incarnation_id: this.incarnationId,
  timestamp: Date.now(),
  data: {
    resource_type: 'metal',
    amount: this.carryingAmount,
    base_id: base.id,
    base_health: base.health,
    travel_distance: this.travelDistance,
    travel_time_ms: Date.now() - this.pickupTime
  }
});
```

### Relationship Events
```javascript
// Vendetta formed
api.trackEvent({
  type: 'vendetta_formed',
  incarnation_id: this.incarnationId,
  timestamp: Date.now(),
  data: {
    target_soul_id: killerSoulId,
    death_count: 3, // Third death to same soul
    intensity: 0.7, // Vendetta strength 0-1
    previous_encounters: encounterHistory
  }
});
```

## Testing Integration
```bash
# Always test the full loop
cd soulsoup && rails souls:test_lifecycle
cd soulforge && npm run test:souls
```

## Common Patterns

### Graceful API Degradation
```javascript
try {
  const soul = await api.requestIncarnation(...);
} catch (error) {
  console.warn('Soul API unavailable, using defaults');
  // Continue with game defaults
}
```

### Soul Data Structure
```javascript
{
  soul_id: "uuid",
  incarnation_id: "uuid",
  modifiers: {
    courage_bonus: 0.15,        // -1 to 1
    aim_adjustment: 0.08,       // -0.5 to 0.5
    retreat_timing: -50,        // milliseconds
    resource_priority: 0.3      // 0 to 1
  },
  personality_hints: ["tends toward bold action"],
  vendetta_souls: ["soul-uuid-1"]
}
```

### Event Batching
Events are queued and sent every 5 seconds:
```javascript
// Don't send immediately
api.trackEvent(event); // Queued

// Batch sends automatically every 5s
// Or manually: api.flushEvents()
```

### Config Constants
```javascript
// NEVER use magic numbers
import { THRESHOLD_CONFIG } from '../config.js';
if (unit.health < unit.maxHealth * THRESHOLD_CONFIG.FLEE_HEALTH_THRESHOLD) {
  // flee logic
}
```

## Rails Backend Patterns

### Soul Model Methods
```ruby
# app/models/soul.rb
class Soul < ApplicationRecord
  def apply_experience(events)
    # Calculate experience impact
    total_exp = events.sum { |e| experience_value(e) }
    exp_modifier = Math.log10(total_exp + 10) / 10.0 # Logarithmic scale
    
    # Apply personality drift
    self.personality_vector = personality_vector.map.with_index do |val, i|
      drift = exp_modifier * 0.1 * (rand - 0.5)
      (val + drift).clamp(-1.0, 1.0)
    end
    
    save!
  end
  
  def modifiers_for_incarnation
    {
      courage_bonus: personality_vector[0] * 0.3,
      aim_adjustment: personality_vector[5] * 0.2,
      retreat_timing: personality_vector[2] * -100,
      resource_priority: personality_vector[8].abs,
      vendetta_fury: calculate_vendetta_bonus
    }
  end
end
```

### Event Processing Job
```ruby
# app/jobs/process_incarnation_job.rb
class ProcessIncarnationJob < ApplicationJob
  def perform(incarnation_id)
    incarnation = Incarnation.find(incarnation_id)
    
    # Aggregate events by type
    events = incarnation.events.group_by(&:event_type)
    
    # Calculate experience
    experience = {
      combat_skill: calculate_combat_exp(events['combat_kill']),
      survival_instinct: calculate_survival_exp(events['combat_death']),
      resource_gathering: calculate_resource_exp(events['resource_collected'])
    }
    
    # Update soul
    incarnation.soul.apply_experience(experience)
    
    # Check for relationship changes
    update_relationships(incarnation, events)
  end
end
```

### API Controller Pattern
```ruby
# app/controllers/api/v1/incarnations_controller.rb
class Api::V1::IncarnationsController < ApplicationController
  def request
    soul = SoulPool.checkout || Soul.create_random
    
    incarnation = soul.incarnations.create!(
      forge_type: params[:forge_type],
      game_session_id: params[:game_session_id],
      started_at: Time.current
    )
    
    render json: {
      soul_id: soul.id,
      incarnation_id: incarnation.id,
      soul_name: soul.name,
      modifiers: soul.modifiers_for_incarnation,
      personality_hints: soul.personality_hints,
      vendetta_souls: soul.vendetta_soul_ids
    }
  end
end
```

### STI Forge Pattern
```ruby
# app/models/forge.rb
class Forge < ApplicationRecord
  self.inheritance_column = :forge_type
  
  def spawn_soul_modifiers
    raise NotImplementedError
  end
end

# app/models/combat_forge.rb  
class CombatForge < Forge
  def spawn_soul_modifiers
    {
      aggression_bonus: 0.1,
      combat_focus: 0.2
    }
  end
end
```

## Test Patterns

### Frontend Soul Test
```javascript
// test/test-soul-integration.js
import { Soldier } from '../js/entities/Soldier.js';
import { MockSoulAPI } from './mocks/MockSoulAPI.js';

describe('Soul Integration', () => {
  test('applies soul modifiers to behavior', async () => {
    const api = new MockSoulAPI();
    const soulData = await api.requestIncarnation();
    
    const soldier = new Soldier(100, 100, canvas, team, base);
    soldier.applySoulData(soulData);
    
    // Verify modifiers applied
    expect(soldier.retreatThreshold).toBe(0.3 * (1 - 0.15)); // courage bonus
    expect(soldier.baseAccuracy).toBe(0.7 + 0.08); // aim adjustment
  });
});
```

### Rails Soul Test
```ruby
# test/models/soul_test.rb
class SoulTest < ActiveSupport::TestCase
  test "personality drifts based on experience" do
    soul = souls(:aggressive_soul)
    original_courage = soul.personality_vector[0]
    
    # Simulate combat experience
    events = 10.times.map { build(:combat_kill_event) }
    soul.apply_experience(events)
    
    # Personality should drift
    assert_not_equal original_courage, soul.personality_vector[0]
    assert_in_delta original_courage, soul.personality_vector[0], 0.1
  end
end
```