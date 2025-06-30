# Soulforge UI Mockups

## Current Combat UI
```
┌────────────────────────────────────────────────────────────────────┐
│ SOULFORGE v1.4.13                                    FPS: 60        │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  ┌─────────────┐                                    ┌───────────┐ │
│  │ TEAM STATS  │                                    │ SOUL INFO │ │
│  ├─────────────┤                                    ├───────────┤ │
│  │ RED     5/20│         ┌──────────────┐          │ Zyx-7742  │ │
│  │ BLUE    3/20│         │              │          │ Level: 5  │ │
│  │ GREEN   7/20│         │  GAME ARENA  │          │ Lives: 23 │ │
│  │ YELLOW  2/20│         │              │          │ Kills: 3  │ │
│  │ PINK    4/20│         │   [Combat]   │          │           │ │
│  └─────────────┘         └──────────────┘          └───────────┘ │
│                                                                    │
│  Resources: 45 Metal | 12 Organics | 0 Crystals    [D] Debug     │
└────────────────────────────────────────────────────────────────────┘
```

## Planned Soul Evolution UI (Issue #29)
```
┌────────────────────────────────────────────────────────────────────┐
│ SOULFORGE v1.5.0                                    FPS: 60        │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  ┌─────────────┐         ┌──────────────┐         ┌─────────────┐ │
│  │ TEAM STATS  │         │              │         │ SOUL DETAIL │ │
│  ├─────────────┤         │              │         ├─────────────┤ │
│  │ RED     5/20│         │  GAME ARENA  │         │ Zyx-7742    │ │
│  │ BLUE    3/20│         │              │         │ ┌─────────┐ │ │
│  │ GREEN   7/20│         │   [Soldier]  │         │ │ C:█████ │ │ │
│  │ YELLOW  2/20│         │      ╱│╲     │         │ │ S:███░░ │ │ │
│  │ PINK    4/20│         │      ╱ ╲     │         │ │ E:██░░░ │ │ │
│  └─────────────┘         └──────────────┘         │ └─────────┘ │ │
│                                    ▲               │ Vendetta: ⚔  │ │
│  [Click unit to see soul] ────────┘               └─────────────┘ │
└────────────────────────────────────────────────────────────────────┘

C = Courage, S = Strategic, E = Empathy (personality traits)
```

## Vendetta Indicator Mockup (Issue #30)
```
Normal Soldier:          Vendetta Target:         Vendetta Encounter:
    ╱│╲                     ╱│╲                       ╱│╲
   ╱ │ ╲                   ╱ │ ╲                     ╱!│!\╲
   │ ● │                   │ ● │                     │ ● │
   ╱ │ ╲                   ╱ │ ╲                     ╱ │ ╲
  │  │  │                 [│ │ │]                   <│ │ │>
                          Red Box                   Pulsing

During Combat:
┌─────────────────────────────────────────┐
│             VENDETTA!                   │
│   Zyx-7742 vs Qor-3891                 │
│   Deaths to this soul: 3               │
└─────────────────────────────────────────┘
```

## Soul Dashboard Mockup (Future)
```
┌────────────────────────────────────────────────────────────────────┐
│ SOUL CODEX - Zyx-7742                                 [X] Close   │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  ┌──────────────┐  ┌────────────────────────────────────────────┐ │
│  │              │  │ PERSONALITY EVOLUTION                       │ │
│  │   [PORTRAIT] │  │                                             │ │
│  │              │  │  Courage    ████████░░ → █████████░        │ │
│  │  Lives: 23   │  │  Strategy   ███░░░░░░░ → ████░░░░░░        │ │
│  │  Kills: 127  │  │  Empathy    ██░░░░░░░░ → █░░░░░░░░░        │ │
│  │  Deaths: 89  │  │  Risk       ███████░░░ → █████░░░░░        │ │
│  └──────────────┘  └────────────────────────────────────────────┘ │
│                                                                    │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │ LIFETIME MEMORIES                                           │   │
│  ├────────────────────────────────────────────────────────────┤   │
│  │ • First kill: Qor-3891 (has become vendetta)              │   │
│  │ • Destroyed RED base with Tyx-9901 (now allied)           │   │
│  │ • Survived 5 incarnations without death                   │   │
│  │ • Gathered 1000+ resources lifetime                       │   │
│  └────────────────────────────────────────────────────────────┘   │
│                                                                    │
│  Relationships: [Vendetta: 2] [Allied: 1] [Neutral: 94]          │
└────────────────────────────────────────────────────────────────────┘
```

## Resource Collection UI
```
Soldier carrying metal:     Nebula gathering:        Crystal found:
    ╱│╲                        ╱│╲                       ╱│╲
   ╱ │ ╲                      ╱ │ ╲                     ╱ │ ╲
   │ ● │ [▪]                  │ ● │                     │ ● │
   ╱ │ ╲                      ╱ │ ╲                     ╱ │ ╲
  │  │  │                    │  │  │                   │  │  │
  Metal box                  ~~~~~~~~~                  ◆ ◆ ◆
                            Pink cloud                 Crystals!

Progress bar above:
[████████░░] 80% capacity   (1/5) gathering          +3 spawns!
```

## Win Screen Mockup
```
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│                                                                    │
│                        ┌─────────────────┐                         │
│                        │   SOULS ASCEND   │                         │
│                        │                  │                         │
│                        │   TEAM GREEN     │                         │
│                        │    VICTORIOUS    │                         │
│                        │                  │                         │
│                        │  Notable Souls:  │                         │
│                        │  • Zyx-7742 (15) │                         │
│                        │  • Pqr-1122 (12) │                         │
│                        │  • Wex-9988 (11) │                         │
│                        │                  │                         │
│                        │ [New Game] [Codex]│                        │
│                        └─────────────────┘                         │
│                                                                    │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

## Color Palette
- Background: #000000 (Pure black)
- Primary: #00FF00 (Bright green)
- Highlight: #FFFF00 (Yellow for changes)
- Danger: #FF0000 (Red for vendetta)
- Resource: #FF00FF (Pink for organics)
- Info: #00FFFF (Cyan for special)

## Font Stack
```css
font-family: 'Berkeley Mono', 'Courier New', monospace;
```

All UI elements maintain the retro terminal aesthetic while providing modern game information.