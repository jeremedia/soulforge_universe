# Soulforge Patterns Quick Reference

## Soul Modifier Application
```javascript
// In Soldier.js
if (this.soulModifiers) {
  const courageBonus = this.soulModifiers.courage_bonus || 0;
  this.retreatThreshold = BASE_RETREAT * (1 - courageBonus);
}
```

## Event Tracking
```javascript
// Always include context
api.trackEvent({
  type: 'combat_kill',
  incarnation_id: this.incarnationId,
  data: {
    victim_soul_id: target.soulId,
    range: distance,
    level_difference: this.level - target.level
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