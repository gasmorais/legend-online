# World Boss ("Chefão global")

Feature slug `world-boss`, domain `pve`. Registry: client package `worldboss` (`decompiled/m13/scripts/worldboss`), no proto package of its own (`roadmap/features.json`). Following the code adds `CM/managers/WorldBossManager.as`, `CM/managers/WorldBossSocketOutManager.as`, `CM/mvc/controler/WorldBossControler.as`, `CM/mvc/module/worldboss/*`, the campaign map HUD in `M3/map/campaign/view/ui/WorldBoss*.as`, `M3/map/internals/view/frame/Wound*.as`, `M3/map/internals/view/frame/WorldBossReward*.as`, the world boss mediators in `M3/map/campaign/mediator/mapview/WorldBoss*Mediator.as` and handlers in `CM/yishi/manager/BaseManager.as`. Messages come from the packages `campaign` (owned by [../campaign/README.md](../campaign/README.md)), `simple`, `worldmap` and `player`.

Twice a day a world boss appears in an open campaign map (5001 "Rei dos Lobos" 11:00-12:00, 5003 "Dragão Infernal" 21:35-22:35). Every player of level 20 or more enters the map and fights the boss repeatedly. Damage is shared: the boss HP is a server wide pool. Each fight gives gold and spirit ("Espírito") according to the damage; after a fight the player waits a revive countdown (or pays to fight again at once). A damage ranking (overall and by job), cumulative damage reward tiers and global "Inspiração" buffs accompany the fight. When the boss dies the last hitter gets the "Grande Prêmio da Sorte" and the top 10 of each job the "Grande Prêmio do Deus da Guerra". A paid "Clone" ("Usar Clone") fights in the player's place while offline.

The same package also contains the "Campo de Batalha" selector frame (cross-server battlefield entry), documented here because it is in the package and the controller, although the battlefield maps themselves belong to [../campaign/README.md](../campaign/README.md).

| Module | pt-BR | What it covers | Transport |
|---|---|---|---|
| [boss-list.md](boss-list.md) | "Chefão global" | World boss list frame, open states, entering, clone purchase | 8271 → 4182, 8258, 8526 → 4424, 4423, 4381 |
| [boss-map.md](boss-map.md) | "Ranking Geral", "Mesma Profissão", "Contagem de ressuscitação:" | Boss campaign map, shared HP, wound ranking, revive and instant fight, damage reward tiers, inspiration buff, battle type 17, end report | 4174, 4175, 4262, 4371, 4369, 8264, 4203, battle opcodes, dormant 8470 |
| [battlefield-entry.md](battlefield-entry.md) | "Campo de Batalha" | Battlefield list and entry checks | 8599 → 4493, 8332, 4248 |

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`, `M3` = `m3/scripts`, `M9` = `m9/scripts`, `M10` = `m10/scripts`, `M13` = `m13/scripts`, `M15` = `m15/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were read from the AS3 `writeToBuffer` of each class.
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| Top tool bar time button `worldboss` (tip "Chefão Global") | `CM/ui/toptoolbar/TopToolsBar.as:1369-1375` | Visible when hero level >= 20 (`CM/ui/toptoolbar/TopBtnCheckShowHelper.as:243-244`) and the time box is active; click requires `checkIsOpen(2)`: level >= `TIME_ACTIVE_GRADES[2]` = 20 and state "open" (`TopToolsBar.as:1581-1601`, `CM/ui/toptoolbar/TopBtnType.as:212-216`) | `worldboss.WorldBossFrame` (controller `worldboss`, openType 1) |
| Daily guide / quest skip types 40 and 41 | `SwitchPageHelp.gotoWorldBossFrame` (`CM/yishi/SwitchPageHelp.as:274-276, 1203-1230`) | Not in bot mode, level >= 20, `checkScene()`, `playerInfo.worldbossState` true (tip "Chefão Global não aberto ainda ou encerrado") | Same frame |
| Task frame campaign button | `TaskFrameII` sends `worldBossControler.sendEnterBattle(worldBossTemplateDict[task.NeedFightId])` (`M15/task/TaskFrameII.as:848-853`, `CM/mvc/controler/WorldBossControler.as:102-108`) | Not in a campaign map (`M15/task/TaskFrameII.as:833-838`); the 5 s anti spam of 8258 | Direct enter (8258) for whatever campaign of `worldBossTemplateDict` the quest names (`Types >= 1`, not only world bosses). `WorldBossControler.sendEnterWorldBossBattle` (`:70-100`, level, scene and open checks) is never called |
| Top tool bar time button `rvr1` | `TopToolsBar.as:1366-1368` | Visible at level >= 30 (`TopBtnCheckShowHelper.as:277-278`) | `worldboss.PvpSelectFrame` (openType 3), see [battlefield-entry.md](battlefield-entry.md) |
| Skip to battlefield | `SwitchPageHelp.gotoWorldFightFrame` (`:1232-1258`) | level >= 30, not bot mode, scene, `worldFightState` | Same |

## Dependencies

| Feature | Why |
|---|---|
| [../campaign/README.md](../campaign/README.md) | The boss map is campaign 5001/5003 (`Types 1`, capacity 10000); create 125, nodes 127, move 5124, arrive 5125, exit 5120; proto package `campaign` holds `WorldBoss*Msg` |
| [../battle/README.md](../battle/README.md) | battleType 17 `WORLD_BOSS_BATTLE`, server synced boss HP and invincible state (`docs/battle/rules.md` rows P-WB and 17) |
| [../returning-players/README.md](../returning-players/README.md) | King contract buff 11 enables automatic revive and auto walk |
| [../currency/README.md](../currency/README.md) | Gold and spirit ("strengy") rewards; diamonds and bound diamonds for clone, instant fight |
| [../medals/achievements.md](../medals/achievements.md) | Achievement condition 114 "Dano acumulado no Chefão Global" |
| [../castle/README.md](../castle/README.md) | Hook rooms ("Santuário", `Types 3`) reuse opcode 8258 (`CM/mvc/controler/HookContorler.as:113-117`); out of scope here |

## Suggested implementation order

1. Campaign templates 5001/5003 (`OpenTime`, `StopTime`, `MinLevel`), config keys `WorldBoss_*`, `Live_Pay`, `Live_Fight_Pay`, buffer templates `CampaignBufferTemps` Types 7.
2. World boss scheduler (open, invincible phase, killable phase, close) and state broadcast 4182 ([boss-list.md](boss-list.md)).
3. Enter route 8258 and the boss campaign map with 4174 sync ([boss-map.md](boss-map.md)).
4. Battle 17 with shared HP, damage rewards, death state 4175 and revive/instant fight 8264.
5. Damage reward tiers 4369, inspiration buff, end report 4203, last hit and ranking rewards.
6. Clone (8526, 4423, 4424) and offline auto damage.
7. Battlefield entry ([battlefield-entry.md](battlefield-entry.md)) once the battlefield maps exist.
