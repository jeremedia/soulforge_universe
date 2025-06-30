# Soulforge Integration Test Guide

## Setup

1. **Start the Rails backend (Soulsoup)**
   ```bash
   cd soulsoup
   rails server  # Runs on port 4001
   ```

2. **Start the game frontend (Soulforge)**
   ```bash
   cd soulforge
   npm run dev
   ```

3. **Access the game**
   - Open http://localhost:5173

## What's New

The Combat Forge now integrates with the Soulsoup backend to create persistent souls:

### Soul Features
- **Soul Creation**: Each soldier spawned gets a unique soul from the backend
- **Personality Modifiers**: Souls have genome-based traits that affect:
  - Courage bonus (affects aggression)
  - Aim adjustment (affects accuracy)
  - Retreat timing (affects when they flee)
- **Event Tracking**: The game logs:
  - Combat kills (with context like range, level difference)
  - Deaths (tracking who killed whom)
  - Resource gathering (metal, organics, crystals)
- **Vendetta System**: Souls remember who killed them and form vendettas

### Testing the Integration

1. **Watch the browser console** for soul incarnation messages:
   ```
   Soul incarnated: soul-xxxxx with modifiers {...}
   ```

2. **Check the Rails logs** to see API requests:
   - POST /api/v1/incarnations/request - Soul requests
   - POST /api/v1/events/batch - Event batches (every 5 seconds)

3. **Verify in Rails console**:
   ```ruby
   rails console
   Soul.count
   Incarnation.count
   Soul.first.incarnations
   ```

### API Endpoints

- **Request Soul**: `POST http://localhost:4001/api/v1/incarnations/request`
- **Send Events**: `POST http://localhost:4001/api/v1/events/batch`
- **View Souls**: `GET http://localhost:4001/api/v1/souls`

### Debug Mode

The game will work even if the Rails backend is not running - it falls back to creating temporary souls without persistence.

## Next Steps

- Admin interface to view soul histories
- LLM integration for narrative generation
- Dream synthesis for soul learning
- Soul viewer UI in the game