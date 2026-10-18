# Auto chess ("Supremacia do Legend")

Client packages `chess` (`decompiled/m3/scripts/chess/**`, scene and views) and `mvc.module.chess` (`decompiled/core_module/scripts/mvc/module/chess/**`, `SelfChessManager`, model). Entry card in the 7th anniversary hub (`decompiled/m11/scripts/sevenyear/view/battleflag/SevenYearSelfChessView.as`). Messages: `chat.ChessRoomMsg`, `chat.SelfChessPlayerMsg`, `simple.PropertyMsg`; fights use the normal battle pipeline with battleType 349 `SELF_PROPELLED_CHESS_BATTLE`.

Six players queue, enter a dedicated scene and play rounds: in each preparation phase they spend match gold to buy units from a 5-card shop, place up to "level" units on 8 battle slots (8 bench slots), merge 3 copies into a higher star (server side), buy XP, refresh or lock the shop; then the server runs automatic battles between pairs. The loser loses HP by the winner's remaining pieces; at HP 0 a player is out. Final placement grants "Pontos de Guerreiro" (600/400/300/200/100/50) to the shared anniversary counter.

The full game design (rules, field layout, the 112 unit templates, synergies, level table, assets, how `chessList` enters the battle) is already documented in **[docs/battle/chess-modes.md](../../docs/battle/chess-modes.md) Part B** and is not repeated here. These files list routes, server messages, server responsibilities, state and checklists.

The registry name also lists the client package `chesspvp` and the "Duelo Tático" mode. That is guild chess and is fully documented in **[../guild/chess.md](../guild/chess.md)** (`mvc/module/chesspvp/**`, `ChessPvpManager`, opcodes 9730, 25232, 561-566).

All traffic is socket based. PostgreSQL schema: `auto_chess`. Rust handlers: `auto_chess::<module>::handle_<action>`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `CH/` = `decompiled/m3/scripts/chess/`, `M11/` = `decompiled/m11/scripts/`, `SCM` = `CM/mvc/module/chess/SelfChessManager.as`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| 7th anniversary hub, "Bandeira de Batalha" tab, card `SevenYearSelfChessView` ("Começar emparelhamento") | `SwitchInfo.SELF_CHESS = true` (`CM/yishi/datas/SwitchInfo.as:6`) else "public.unopen.wait" (`M11/sevenyear/view/battleflag/SevenYearSelfChessView.as:176-183`) | Matchmaking ([matchmaking.md](matchmaking.md)) |
| Queue reaches `chess_room_num` = 6 | client sets the scene after 1 s (`SevenYearSelfChessView.as:212-226`) | Scene `SELF_CHESS_SCENE` (`chess.SelfChessSceneController`) |
| Game over 4217 | only while in `SELF_CHESS_SCENE` | `chess.SelfChessGameOverFrame` ([game-over.md](game-over.md)) |

Reachability: the anniversary hub frame is only reopened after leaving the star-area scene in this build (see [../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)), so the rebuild needs an entry point (A).

## Modules

| Module | Content |
|---|---|
| [matchmaking.md](matchmaking.md) | 9701 start/cancel, 4218 queue counter, 4219 tips, invite to chat, room creation and scene entry |
| [preparation.md](preparation.md) | 25031 ops 3..10 (buy, sell, move/swap, refresh, buy XP, leave, lock), 4216 room snapshots and the redraw contract |
| [rounds-and-battles.md](rounds-and-battles.md) | Server round engine: phases and timers, income, shop rolls, merges, pairing, battle 349 (`chessList`), HP damage, elimination, PvE rounds |
| [game-over.md](game-over.md) | Placement, 4217, rewards to the shared war-points counter, exit (op 8), statistics |

## Protocol ownership note (hugehead, stackhead)

`roadmap/features.json` lists the proto packages `hugehead` and `stackhead` under this feature, but the client uses them only in the Outyard ("Terrálem") system (`CM/yishi/manager/OutyardManager.as`, `decompiled/m11/scripts/outyard/**`, `decompiled/m3/scripts/outyard/OutyardAreaView.as`). Auto chess uses none of them. They are mapped in the outyard folder:

| Messages | Documented in |
|---|---|
| `HugeHeadActiveMsg`, `HugeHeadMySignInStateMsg`, `HugeHeadOpenTimeMsg`, `HugeHeadStateMsg`, `HugeHeadRequestMsg` | [../outyard/season.md](../outyard/season.md) |
| `HugeHeadBattleFieldMsg`, `HugeHeadForceMsg`, `HugeHeadGuildMsg`, `HugeHeadMapNodeMsg`, `HugeHeadRequestMsg` | [../outyard/land-map.md](../outyard/land-map.md) |
| `HugeHeadNodeBattleAreaMsg`, `HugeHeadNodeBattleFieldMsg`, `HugeHeadNodeBattleReqMsg`, `HugeHeadNodeBattleUserMsg` | [../outyard/node-battle.md](../outyard/node-battle.md) |
| `HugeHeadUserMsg`, `HugeHeadGuildMsg`, `StackHeadAttackMsg`, `StackHeadBattleDefenceMsg`, `StackHeadBattleFieldMsg`, `StackHeadForceMsg`, `StackHeadForceUserListMsg`, `StackHeadRequestMsg`, `StackHeadSelfMsg`, `StackHeadSeniorGeneralMsg`, `StackHeadUserMsg` | [../outyard/crystal-war.md](../outyard/crystal-war.md) |
| package `stackhead`: `StackHeadExploreReqMsg`, `StackHeadExploreResMsg`, `StackHeadExploreMsg`, `StackHeadExploreNodeMsg`, `StackHeadExploreRawNodeMsg`, `StackHeadExploreDiceMsg`, `StackHeadExploreNodeEventStateMsg`, `StackHeadNodeEventUpdatedMsg`, `ExplorePlayerMsg`, enums `StackHeadExploreDirection`, `StackHeadExploreErrorCode`, `StackHeadExploreOpState` | outyard "Pesquisa da Terralém" dice board (9608 -> 361), `land-explore.md` in [../outyard/README.md](../outyard/README.md) |

## Dependencies

- [hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md): entry card, shared "Pontos de Guerreiro" counter (`SevenYearUserMsg.snowScore`, cap `snow_vehicle_daily_reward_max` = 600), quiz shown while matching.
- [artillery/snow-battle.md](../artillery/snow-battle.md): the same counter and the same queue UI pattern.
- Battle engine (`docs/battle/server-engine.md`, `docs/battle/formation.md`): battle 349 with `BattlePrepareMsg.chessList` (#29).
- [chat](../chat/README.md): invite message on channel 8; chat blocked in the scene.
- [guild/chess.md](../guild/chess.md): "Duelo Tático" (`chesspvp`).

## Suggested implementation order

1. Templates: `AutoChessHeroInfos`, `AutoChessBuffInfos`, `UpGradeTempInfos` Types=81, ConfigInfos `chess_*`.
2. [matchmaking.md](matchmaking.md): queue and room creation.
3. [preparation.md](preparation.md): room state and the 7 player ops with full 4216 snapshots.
4. [rounds-and-battles.md](rounds-and-battles.md): phase scheduler, pairing, battle 349, HP.
5. [game-over.md](game-over.md): placement rewards and shared counter.
