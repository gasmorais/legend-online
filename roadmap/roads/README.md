# Roads ("Caminhos")

Domain: PvE. The "road" activities: staged progressions with daily or weekly resets, buffs, currencies and reward packages. Client packages `finalroad`, `gloryroad`, `goldroad`, `heroroad`, `redemptionroad`, `increasingly` / `increasinglyroad`, `revenge`; proto packages `finalroad`, `gloryroad`, `goldenroad`, `heroroad`, `redemptionroad` (plus `demonroad` for the Rua Mítica and `module.RevengeRoadMsg`).

All traffic is socket based. PostgreSQL schema: `roads`. Rust handlers: `roads::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Space ("Reino do Céu") NPC dialog options (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:349-900`) | 108 glory road (level 15); 145 revenge road; 147 redemption road; 149 Rua Mítica; 161 final road | module frames |
| Daily guide (`decompiled/core_module/scripts/managers/DayGuideManager.as:924-955`) | 81 revenge road, 90 redemption road, 91 Rua Mítica | openers in `SwitchPageHelp` |
| Queue bar (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as`) | glory road (item 13), revenge and redemption roads; hero road buttons `_heroRoadBtn` / `_heroRoadBtn2` and gift pop button (level 11) | controllers `gloryroad`, `revengeroad`, `redemptionroad`, `heroroad` |
| Top toolbar activity icon `goldroad` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1209-1231`) | event switch 3031 open, not in a team | gold road |
| Unlocks | final road: changed job, quest 1391, royalty level 10, weekly window; redemption road, Rua Mítica, revenge road: deified hero (`isAvenger`); Rua Mítica: not in a team | |

## Modules

| Module | pt-BR | Content | Battle type |
|---|---|---|---|
| [final-road.md](final-road.md) | Caminho Final | weekly chapters (3 difficulties) of 6 floors x 5 stages with monster and buff choices, retries, sweep; 9711 / 532, 533 | 3906 |
| [glory-road.md](glory-road.md) | Caminho da Glória | daily 15 layer mirror gauntlet with difficulty factors, stars, buff shop, chests, skips, score rewards; 9624 / 384, 385 | 3863 |
| [gold-road.md](gold-road.md) | Caminho de Ouro | event dice board (36 cells), temporary bag 25, super dice; 9520..9522 / 4933, 4934, 300 | none |
| [hero-road.md](hero-road.md) | Histórico | milestone tasks with "Pontos históricos", discount packages, day and VIP packages (tab 1 of the frame; tab 2 achievements in [medals](../medals/achievements.md)); 9634 / 407 | none |
| [redemption-road.md](redemption-road.md) | Caminho da Salvação | weekly 10 floor branching tower in 3 difficulties with buffs/debuffs and cooldowns; 8659 / 208, 209 | 3888 |
| [increasing-road.md](increasing-road.md) | Rua Mítica | endless floors of bosses with action points, reward refresh, sweep, dust shop 1022; 5195 / 205 | 3893 |
| [revenge-road.md](revenge-road.md) | Caminho da Vingança | 5 areas x 10 nodes with revenge hearts, boss attack limits, area chests, sweep; 9688 / 4895, 4896 | 3887 |

## Shared mechanics and dependencies

- Sweeps for final road (`sweep_type 8`) and revenge road (5) go through [mopup](../mopup/README.md) (8528 / 4425).
- Shops: glory shop 1008 and Rua Mítica shop 1022 in [shops](../shops/README.md); purchase counts of the glory shop arrive in 528.
- Achievements and achievement gift packages (8671 / 4288 / 4289) live in [medals](../medals/README.md) but are hosted by `HeroRoadManager` and `HeroRoadFrame`.
- Guardians and Einherjar selection (glory road) depend on the children and pet systems ([guardians](../guardians/README.md), [einherjar](../einherjar/README.md)).
- Deified hero requirement: [avenger](../avenger/README.md).
- Team refuse toggles used by the gold road: [team](../team/README.md).
- Activity switch 4422 (`U_C_SWITCH`, entry 3031) for the gold road event window.
- Battles: [docs/battle/server-engine.md](../../docs/battle/server-engine.md); glory road needs mirror opponents built from `MirrorInfoMsg`.

## Suggested implementation order

1. [hero-road.md](hero-road.md): no battles, pure state and rewards; required by the queue bar at login.
2. [revenge-road.md](revenge-road.md) and [redemption-road.md](redemption-road.md): linear PvE with simple currencies.
3. [increasing-road.md](increasing-road.md): scene based floors, energy purchase ladder, dust shop.
4. [final-road.md](final-road.md): weekly window, chapter accesses, event choices, buffs in battle.
5. [glory-road.md](glory-road.md): mirrors, carried HP, buff shop, chests.
6. [gold-road.md](gold-road.md): event only; implement when the 3031 event is scheduled.
