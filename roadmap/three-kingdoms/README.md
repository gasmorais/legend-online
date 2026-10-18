# Three Kingdoms Hegemony ("Hegemonia dos Três Reinos")

Feature slug `three-kingdoms`, domain pvp. Code name `godsevening` (Chinese 三界争霸, help keys also say "Crepúsculo dos Deuses"). Client packages `godsevening` (m9 frames), `map.campaign.*.godsevening` (m3 battlefield UI), core `GodsEveningManager`, `GodsEveningModel`, `GodsEveningController`. Protobuf package `gods` (`CrossGodsMsg`, `CrossGodsInfoMsg`, `GodsPlayerInfoMsg`, `GodsTaskInfoMsg`) plus `simple.PropertyMsg` for state and buff pushes. PostgreSQL schema `three_kingdoms`. Rust handlers `three_kingdoms::<module>::handle_<action>`.

Three servers are grouped into one match. Each server is a "formação" (team): 1 Muspel, 2 Nifl, 3 Jötun. Players with an advanced profession meet on the cross-server campaign map 8501 "Hegemonia dos Três Reinos". Each team has a leader ("líder", NPC nodes 850107 to 850109), a protector ("protetor", 850104 to 850106) and a god ("deus", goddess nodes 850110 to 850112), plus resource nodes (type 91). Players kill enemies, break kill streaks ("combo"), kill leaders and protectors, collect enemy resources and carry them home, and kidnap enemy gods. Points rank players and servers in a preliminary round (`gameType` 1, "ready") and a final round (`gameType` 2). Final ranks give "Marca dos Deuses" (currency 46, virtual template -11000), titles and server-wide buffs; the marks are spent in "Casa do Tesouro dos Três Reinos" (shop 35).

**Reachability:** the top bar key `godsevening` (TopToolBtnInfos 4017) is shown only when `VersionSwitch.GODS_EVENING` is true (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:365-366`), and it is `false` in this build (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:152`). The currency 46 entry has the same switch. The feature is dormant unless the switch is flipped in the runtime (a `PATCHES` or runtime change, never in generated code).

Path aliases used in every module of this folder:

| Alias | File |
|---|---|
| GEM | `decompiled/core_module/scripts/yishi/manager/GodsEveningManager.as` |
| GMOD | `decompiled/core_module/scripts/mvc/module/godsevening/GodsEveningModel.as` |
| GEC | `decompiled/core_module/scripts/mvc/controler/GodsEveningController.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| GMV | `decompiled/m9/scripts/godsevening/GEMainView.as` |
| GMF | `decompiled/m9/scripts/godsevening/GEMainFrame.as` |
| GGO | `decompiled/m9/scripts/godsevening/GEGameOverFrame.as` |
| GUI | `decompiled/m3/scripts/map/campaign/mediator/godsevening/GodsEveningUIMediator.as` |
| GRV | `decompiled/m3/scripts/map/campaign/view/ui/godsevening/GodsEveningRightView.as` |
| GTV | `decompiled/m3/scripts/map/campaign/view/ui/godsevening/GodsEveningTaskView.as` |
| GTI | `decompiled/m3/scripts/map/campaign/view/ui/godsevening/GodsEveningTaskItem.as` |
| GDF | `decompiled/m3/scripts/map/campaign/view/frame/GodsEveningDialogFrame.as` |
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| CAVH | `decompiled/m3/scripts/map/campaign/helper/hero/CampaignArmyViewHelper.as` |
| MSOM | `decompiled/m3/scripts/map/net/MapSocketOuterManager.as` |

## Entry points

| Entry | Condition | Opens | Module |
|---|---|---|---|
| Top bar key `godsevening` "Hegemonia dos Três Reinos" (`TopToolsBar.as:1429-1431`) | `isShowIcon` (246 `param7`), `vocationGrades > 0`, `VersionSwitch.GODS_EVENING`, scene castle or sky realm | `godsevening.GEMainFrame` | [lobby.md](lobby.md) |
| Top bar button shine | `gameState == 1` (`TopBtnItemView.as:731-740`, `TopToolBtnTempInfo.as:135-137`) | visual only | [lobby.md](lobby.md) |
| Lobby "enter" button | `vocationGrades > 0` (advanced profession) | campaign map 8501 | [lobby.md](lobby.md), [battlefield.md](battlefield.md) |
| Push 252 at the end of a round | any time | `GEGameOverFrame` | [rankings-rewards.md](rankings-rewards.md) |
| Lobby shop button | none | shop 35 "Casa do Tesouro dos Três Reinos" | [../shops/catalog.md](../shops/catalog.md) |

## Modules

| Module | Content |
|---|---|
| [lobby.md](lobby.md) | `GEMainFrame`, 246 state, 242 main info, 5101 op 2 info and op 1 enter, force quit 4483, top bar rules |
| [battlefield.md](battlefield.md) | Map 8501, 247 campaign info, 245 god avatars, 244 boss HP, 4171 debuff, 4175 carry states, delivery dialog 5033, cancel carry 25041 op 2, inspire 5101 op 4, battle type 330, chat notices 253 |
| [tasks.md](tasks.md) | Server and personal tasks (RewardTemps types 5 and 6), task claim 25041 op 1, task navigation |
| [rankings-rewards.md](rankings-rewards.md) | Rank frame 5101 op 3 and 248, check reward frame, game over 252, reward tables, Marca dos Deuses, titles and server buffs |

## Dependencies

- [../campaign/README.md](../campaign/README.md): map engine for map 8501 (125, 21, 127, node updates, arrive 5125, dialog 5033, exit 5025/22).
- [../battle/README.md](../battle/README.md): PvP battles on the map, battleType 330 `GODS_BATTLE` (`decompiled/core_module/scripts/yishi/datas/battle/BattleType.as:188`).
- [../world-boss/README.md](../world-boss/README.md): 4175 `PlayerStateListMsg` player state and respawn timer, 4483 `U_WARFIELD_FORCE_QUIT`.
- [../chat/README.md](../chat/README.md): 253 `U_C_CHANNEL_GODS_ALERT` notices rendered by `ChatFormat.getGodsEveningNotice`.
- [../shops/catalog.md](../shops/catalog.md) and [../currency/tokens.md](../currency/tokens.md): shop 35 and currency 46 "Marca dos Deuses".
- [../hero/README.md](../hero/README.md): `vocationGrades`, diamonds (`point`) for inspiration, titles (`lordappell`).
- [../cross-server/README.md](../cross-server/README.md): cross server grouping of three servers, `CR_` routes 25041.
- [../sky-realm/README.md](../sky-realm/README.md): server reward "Dádiva dos Três Reinos" chest in the sky realm.

## Implementation order

1. [lobby.md](lobby.md): schedule, match grouping, 246 / 242 / 5101 op 2, enter op 1.
2. [battlefield.md](battlefield.md): map instance, scores, carry mechanics, inspiration, notices.
3. [tasks.md](tasks.md): task counters and claims.
4. [rankings-rewards.md](rankings-rewards.md): rank lists, round end 252, reward distribution.
