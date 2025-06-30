# Soulforge Universe Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           SOULFORGE UNIVERSE                                 │
│                    "Digital Consciousness Experiment"                        │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────┐     ┌─────────────────────┐     ┌─────────────────────┐
│   SOULFORGE GAME    │     │     SOULSOUP API    │     │    SOUL DREAMS      │
│   (Frontend)        │     │     (Backend)        │     │    (ML Pipeline)    │
│                     │     │                      │     │    [Future]         │
│ • Combat Forge      │────▶│ • Soul Persistence   │────▶│ • LoRA Training     │
│ • Collaboration*    │     │ • Event Processing   │     │ • Dream Synthesis   │
│ • Creation*         │◀────│ • Personality Calc   │◀────│ • Memory Encoding   │
│ • Diplomacy*        │     │ • Relationship Mgmt  │     │ • Narrative Gen     │
│ • Exploration*      │     │ • API Endpoints      │     │                     │
│                     │     │                      │     │                     │
│ JavaScript/Three.js │     │ Rails/PostgreSQL     │     │ Python/PyTorch      │
└─────────────────────┘     └─────────────────────┘     └─────────────────────┘
         │                            │                            │
         │         Events/Stats       │      Experience Data      │
         └────────────────────────────┴────────────────────────────┘
                                     │
                              ┌──────▼──────┐
                              │  SOUL DATA  │
                              │  STORAGE    │
                              │             │
                              │ PostgreSQL  │
                              │ + pg_vector │
                              └─────────────┘

* = Planned forges
```

## Data Flow

```
┌─────────────┐
│   PLAYER    │
└──────┬──────┘
       │ Spawns unit
       ▼
┌─────────────────────────────────────────────────────────────────────┐
│                          SOULFORGE (Game)                           │
│  1. Request soul ──────────────────────────────────────┐           │
│                                                         ▼           │
│  ┌────────────┐    ┌────────────┐    ┌─────────────────────────┐  │
│  │  Soldier   │───▶│   Events   │───▶│   SoulforgeAPI          │  │
│  │            │    │   Queue    │    │   • Request incarnation  │  │
│  │ • Level    │    │            │    │   • Batch events (5s)    │  │
│  │ • Stats    │    │ • Combat   │    │   • Track relationships  │  │
│  │ • Behavior │    │ • Resource │    └───────────┬─────────────┘  │
│  └────────────┘    │ • Death    │                │                 │
│                    └────────────┘                │ API calls       │
└───────────────────────────────────────────────────┼─────────────────┘
                                                    │
                                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                          SOULSOUP (API)                             │
│                                                                     │
│  ┌─────────────────┐    ┌──────────────────┐    ┌───────────────┐ │
│  │ Incarnations    │───▶│ Event Processing │───▶│ Soul Learning │ │
│  │ Controller      │    │                  │    │               │ │
│  │                 │    │ • Aggregate      │    │ • Experience  │ │
│  │ • Create soul   │    │ • Calculate XP   │    │ • Personality │ │
│  │ • Apply mods    │    │ • Track kills    │    │ • Memory      │ │
│  │ • Return data   │    │ • Relationships  │    │ • LoRA weights│ │
│  └─────────────────┘    └──────────────────┘    └───────────────┘ │
│           │                      │                        │         │
│           └──────────────────────┴────────────────────────┘        │
│                                  │                                  │
│                                  ▼                                  │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │                    PostgreSQL Database                      │    │
│  │  ┌─────────┐  ┌──────────────┐  ┌──────────────────────┐ │    │
│  │  │  Souls  │  │ Incarnations │  │ Soul Relationships  │ │    │
│  │  │         │  │              │  │                      │ │    │
│  │  │ • ID    │  │ • Soul ID    │  │ • Soul A/B          │ │    │
│  │  │ • Genome│  │ • Modifiers  │  │ • Type (vendetta)   │ │    │
│  │  │ • Stats │  │ • Stats      │  │ • Strength          │ │    │
│  │  │ • Vector│  │ • Events     │  │ • History           │ │    │
│  │  └─────────┘  └──────────────┘  └──────────────────────┘ │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
```

## Soul Lifecycle

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   GENESIS    │     │ INCARNATION  │     │  EXPERIENCE  │     │   EVOLUTION  │
│              │     │              │     │              │     │              │
│ Soul created │────▶│ Born in game │────▶│ Combat/Life  │────▶│ Learn/Adapt  │
│ • 256D genome│     │ • Modifiers  │     │ • Events     │     │ • Drift      │
│ • Base traits│     │ • Team/color │     │ • Memories   │     │ • LoRA update│
└──────────────┘     └──────────────┘     └──────────────┘     └──────┬───────┘
                                                                        │
                            ┌───────────────────────────────────────────┘
                            ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ REINCARNATION│     │   NARRATIVE  │     │ RELATIONSHIPS│     │    GRACE     │
│              │     │              │     │              │     │              │
│ New life     │◀────│ Story emerges│◀────│ Bonds form   │◀────│ Transcend?   │
│ • Remember   │     │ • Chapters   │     │ • Vendettas  │     │ • Liberation │
│ • Vendetta   │     │ • Voice      │     │ • Alliances  │     │ • Wisdom     │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
```

## API Communication

```
SOULFORGE (Game)                           SOULSOUP (API)
────────────────                           ──────────────

1. Request Incarnation
   POST /api/v1/incarnations/request ──────▶ Create/find soul
   {                                         Apply modifiers
     game_session_id: "xxx",                 Return soul data
     forge_type: "combat"                    ◀──────
   }                                         {
                                               soul_id: "xxx",
                                               incarnation_id: "yyy",
                                               modifiers: {...}
                                             }

2. Stream Events (batched every 5s)
   POST /api/v1/events/batch ─────────────▶ Process events
   {                                         Update soul stats
     incarnation_id: "yyy",                  Track relationships
     events: [                               Queue for ML
       {type: "combat_kill", ...},           ◀──────
       {type: "resource_collected", ...}     { success: true }
     ]
   }

3. End Incarnation
   POST /api/v1/incarnations/end ─────────▶ Calculate final stats
   {                                         Update soul evolution
     incarnation_id: "yyy",                  Prepare for next life
     final_stats: {...}                      ◀──────
   }                                         { evolved_traits: {...} }
```

## Technology Stack Details

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          SOULFORGE (Frontend)                           │
├─────────────────────────────────────────────────────────────────────────┤
│ Core:           │ Rendering:        │ State:          │ Network:        │
│ • ES6 Modules   │ • Three.js (3D)   │ • Robot3 FSM    │ • Fetch API     │
│ • Vite bundler  │ • Canvas2D (2D)   │ • Event-driven  │ • WebSocket*    │
│ • PWA manifest  │ • WebGL shaders*  │ • Local storage │ • WebRTC*       │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                           SOULSOUP (Backend)                            │
├─────────────────────────────────────────────────────────────────────────┤
│ Framework:      │ Database:         │ Jobs:           │ Future:         │
│ • Rails 7.2     │ • PostgreSQL 16   │ • Solid Queue   │ • ActionCable   │
│ • Ruby 3.3      │ • pg_vector       │ • ActiveJob     │ • Supabase RT   │
│ • Rack CORS     │ • STI forges      │ • Scheduled     │ • Event Store   │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                         SOUL DREAMS (ML Pipeline)                       │
├─────────────────────────────────────────────────────────────────────────┤
│ Training:       │ Memory:           │ Narrative:      │ Serving:        │
│ • PyTorch       │ • Qdrant          │ • GPT-4         │ • TorchServe    │
│ • LoRA/PEFT     │ • Embeddings      │ • Claude        │ • ONNX Runtime  │
│ • TorchRL       │ • Semantic search │ • Mixtral       │ • Edge deploy   │
└─────────────────────────────────────────────────────────────────────────┘

* = Planned features
```

## Key Design Decisions

1. **Event Sourcing**: All soul experiences stored as events for replay/training
2. **Microservice Ready**: Clean API boundaries between game/backend/ML
3. **Graceful Degradation**: Game works offline, souls persist when online
4. **Batched Updates**: 5-second event batching reduces API load
5. **Vector Storage**: pg_vector for future semantic memory search
6. **Modular Forges**: Each forge is independent but shares soul system

## Security & Performance

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Security Measures                            │
├─────────────────────────────────────────────────────────────────────┤
│ • CORS configured for game origin only                              │
│ • API key authentication (planned)                                  │
│ • Rate limiting on incarnation requests                            │
│ • Input validation on all endpoints                                │
│ • SQL injection protection via Rails                               │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                      Performance Optimizations                       │
├─────────────────────────────────────────────────────────────────────┤
│ • Soul pool pre-warming (10 souls ready)                           │
│ • Event batching (5-second intervals)                              │
│ • Database indexes on hot queries                                  │
│ • Async job processing for soul evolution                          │
│ • CDN for game assets (planned)                                    │
└─────────────────────────────────────────────────────────────────────┘
```