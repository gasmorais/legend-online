# Glory supremacy ("Supremacia da Glória")

Client packages `gloryGame` (`decompiled/m9/scripts/gloryGame/**`, room scene views) and `mvc.module.gloryGame` (`decompiled/core_module/scripts/mvc/module/gloryGame/**`, model and constants), manager `managers.GloryGameManager` (`decompiled/core_module/scripts/managers/GloryGameManager.as`), hub tab views in `decompiled/m11/scripts/sevenyear/view/gloryGame/**`. Protobuf package `com.road.yishi.proto.Glory` plus `simple.PropertyMsg`. Battles use battleType 3891 `GLORY_GAME_BATTLE` (`CM/yishi/datas/battle/BattleType.as:214`).

A weekly team tournament of the 7th anniversary event. Captains of a free team ("equipe livre") register the team; members confirm within 10 s. Round 1 "Eleição Marinha" (open qualifier, 15 turns, points); the top 16 teams enter the group stage (3 turns per group); the top 2 of each group go to the knockout: quarter-finals, semi-finals and final (best of three). Matches are played on Saturday evenings in a room scene (`GLORY_GAME_SCENE`, room type 15). Every player can also "predict" ("predição") the winners of the knockout pairs for a bonus. Rewards are "Pontos de Guerreiro" (item -15000) by final placement.

All traffic is socket based. PostgreSQL schema: `glory_supremacy`. Rust handlers: `glory_supremacy::<module>::handle_<action>`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M9/` = `decompiled/m9/scripts/`, `M11/` = `decompiled/m11/scripts/`, `GGM` = `CM/managers/GloryGameManager.as`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| 7th anniversary hub, tab "Supremacia da Glória" (`M11/sevenyear/SevenYearMainFrame.as:130-140,183-191`) | `GloryGameManager.model.isOpen` (state string not "0,0,0"), else "Supremacia da Glória ainda não começou" (`SevenYearGloryGame.sign.str9`) | `SevenYearGloryGameView` with sub tabs Inscrição / Calendário / Predição (`M11/sevenyear/view/SevenYearGloryGameView.as:37-48`) |
| Hub daily-game card: "Ver Competição" / "Mostrar predição" (`M11/sevenyear/view/battleflag/SevenYearGameView.as:105-121,285-293`) | none | jumps to the schedule or forecast tab (`JUMP_TO_SCHEDULE`, `JUMP_TO_BET`) |
| Room push 12 with `roomType = 15` | after op 3 enter | scene `GLORY_GAME_SCENE` (`CM/yishi/manager/BaseManager.as:2682-2685`, `CM/mvc/controler/GloryGameRoomController.as`) |

Reachability: the hub is only reopened after leaving the star-area scene in this build ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)); the rebuild needs an entry (A).

## Modules

| Module | Content |
|---|---|
| [registration.md](registration.md) | Main view (9694 op 1 -> 4991), team registration by the captain (op 2), member confirmation (4990, op 5), stages and states, hall display |
| [matches.md](matches.md) | Calendar (Saturday schedule), enter room (op 3), room scene and updates (4993), leave (op 6, 5025), battles 3891, stage progression, final ranking and rewards |
| [forecast.md](forecast.md) | Predictions: open (op 4 -> 4992), lock (9699), rewards with the lock-time bonus |

## Dependencies

- [team/freedom-team.md](../team/freedom-team.md): free team, captain check (`FreedomTeamManager.hasTeam`, `isCaptain`).
- [hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md): hub, event dates (`SevenYearModel.beginTime` drives the schedule), achievement type 9 "Predizer equipe", war points.
- Generic room protocol (12, 120, 17, 5025): see [../artillery/trial-lobby.md](../artillery/trial-lobby.md) for the shared messages.
- Battle engine (`docs/battle/server-engine.md`): type 3891, team PvP.
- [inventory](../inventory/README.md): item -15000 "Pontos de Guerreiro".

## Suggested implementation order

1. Stage/state machine and schedule ([matches.md](matches.md) section 5).
2. [registration.md](registration.md).
3. [matches.md](matches.md): rooms, pairing, battles, standings, rewards.
4. [forecast.md](forecast.md).
