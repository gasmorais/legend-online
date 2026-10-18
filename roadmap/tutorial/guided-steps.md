# Guided steps (novice script)

Area: tutorial, module `guided-steps`. Covers the client side tutorial script engine (`dialog.utils.NewbieManager` plus the m8 module `nodes.*`, `mediators.*`), the forced click UI (mask, cut out target, arrows, tip bubbles), the order of scripted nodes and checkpoints, and every server request the script issues: training campaign node battles, room exit, novice collection battle (8699), building and queue init (8281), battle pause and continue (10010, 10022), quest 1834 reward, plus the QTE skill guide flag (8302).

Conventions: see [README.md](README.md). Related: [novice-process.md](novice-process.md) (the stored checkpoint and 5017), [plot-dialog.md](plot-dialog.md) (dialog UI used by the script), [../campaign/README.md](../campaign/README.md), [../battle/README.md](../battle/README.md), [../castle/README.md](../castle/README.md), [../quests/README.md](../quests/README.md).

## 1. Overview

The script runs entirely in the client. It is data in code: `NewbieModel` maps checkpoint values to node classes (`decompiled/core_module/scripts/dialog/utils/NewbieModel.as:8`). Each node is a small state machine polled every 100 ms (`NewbieTutorialBase.prepare` `decompiled/core_module/scripts/dialog/utils/NewbieTutorialBase.as:49`); each step runs one action (`actionType` = `"<mediator class>|<static function>"`, `actionParams` = comma list) through `utils.NewbieUtils.execFunc` (`NewbieTutorialBase.excuteAction` `:72`). Steps are skipped while the scene is locked or a mop up runs (`checkCommonCons` `:101`). When the last step completes, the node writes its `nid` into `noviceProcess` and sends 5017 (`complete` `:176`).

Two phases:

- Forced tutorial (`noviceProcess < 25000`): `NewbieManager.start` picks the node whose key is the greatest key <= the current value (`findNextNodeId` `decompiled/core_module/scripts/dialog/utils/NewbieManager.as:60`) and chains nodes on completion (`__tutorialCompleteHandler` `:243`).
- Level and quest guides (`noviceProcess >= 25000`, `isMaxNovice` `:214`): nodes are queued as map actions (`GameBaseQueueManager`) when a `LEVEL_COMMIT` or `TASK_COMMIT` notification matches `NOVICE_LEVEL_NODES` or `NOVICE_TASK_NODES` (`:159`, `:170`, `:181`). These `NewbieNodeBase` nodes cannot display in battle or after a campaign ends (`decompiled/core_module/scripts/dialog/utils/NewbieNodeBase.as:156`) and disable the keyboard while running (`:49`).
- Item lock guides: `checkHasViceGuild` (`NewbieManager.as:100`) when `needViceGuild` is true and hero level >= 10; `playLockWeekGuild` (`:124`) when `isNeedWeekLockGuild`. Flags come from push 4696 `VicePasswordMsg` opType 5 and 6 (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:318`, owned by [hero](../hero/README.md)).

The server never drives the script directly. It must (a) store checkpoints, (b) answer the gameplay requests the script makes with the normal campaign, battle, castle and quest flows, and (c) keep campaign node states consistent because many steps are skipped or completed by checking node state 4 (`FIGHTING`) or 8 (`DESTROYED`) (`decompiled/core_module/scripts/map/internals/constant/NodeState.as:12`).

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Mask (`NewbieBaseActionMediator.showMask` `decompiled/m8/scripts/mediators/NewbieBaseActionMediator.as:140`, `drawTargetOnMask` `:161`) | none | Dark full screen layer (alpha from params, 0.6 default) with an erase blended copy of the target; clicks on the cut out are forwarded to the real control (forced click) | actions `a1`, `a2` | Target resolved by `getGuildTarget` (`:1233`): `2_n` main toolbar button type n, `3_n` / `29_n` castle building son type n, `5_n` battle skill slot n, `9_n` barracks recruit button for pawn n, `28_x` campaign selection control, `31_n` quest trace item of quest n, `84` vice password button, `81` world map button |
| `views.NoviceFrame1` (`decompiled/m8/scripts/views/NoviceFrame1.as`) | text `newbieXml.node.action.content<id>`, e.g. 1405 "Clique no Quartel para abrir a janela do Quartel", 1406 "Clique em Recrutar para recrutar soldados", 1411 "Clique na Campanha para entrar no mapa de Campanha", 1412 "Clique na Campanha para para entrar na janela de Campanha", 1419 "Clique no Transmissor para mudar de mapa", 1420 "Clique no Mapa Mundi para abrir o mapa", 1423 "Clique na árvore de Yggdrasil para entrar na Fazenda" | Tip bubble anchored to the target | `createGuildFrame1` (`NewbieBaseActionMediator.as:490`), text via `getContentByValue` (`:1417`) | text id |
| `views.NoviceFameCampaign` | 1501 "Clique na Habilidade para usá-la", 1502 "Obteu habilidades \n “{1~9}”", 1503 "Clique para usar a habilidade “{1~9}”", 50501 "Clique em \"Inventário\".", 50502 "Clique em \"Bloqueio de Itens\" e defina uma senha." | Tip bubble in battle and frames | `createGuildFrame2` (`:513`) | text id |
| `views.NoviceFrame4` | movie keyed `toCastle_1130`, `toCastle_1160`, `toCastle_3800`, `toCastle_4000` | Animated building introduction | `createGuildFrame4` (`:533`) | none |
| `yishi.view.guild.NoviceArrowView` (`decompiled/core_module/scripts/yishi/view/guild/NoviceArrowView.as:35`) | 2001 "Clique para adquirir habilidade" | Pointing arrow | `createGuildArrow` (`:540`), `setTaskArrowGuild` (`:441`, notification `NOVICE_ARROW_STATE` to `NewbieTaskTraceView`) | none |
| `views.GameStartPlayView` (`decompiled/m8/scripts/views/GameStartPlayView.as:14`) | none | Opening animation | `showStartPlayView` (`:1131`) | none |
| `views.NewModuleOpenPopView` (`decompiled/m8/scripts/views/NewModuleOpenPopView.as:13`) | 5706 "Aberuta da nova função [Guilda]", 5708 "[Montaria]", 5710 "[Astrologia]", 5719 "[Einherjar]", 5722 "Abertura da nova função [Arma Divina]", 5723 "[Espírito de Proteção]" | Icon flies to the toolbar | `newModuleOpen` (`:1156`) | icon, text id |
| `ui.tasktracebar.view.NewbieTaskTraceView` | quest names | Simplified quest trace while `noviceProcess < 19000` | `TaskTraceBar` (`decompiled/core_module/scripts/ui/tasktracebar/TaskTraceBar.as:74`) | quests |
| `yishi.view.guild.QteGuideFrame` | key `qteGuideConenct` | First QTE skill explanation | `QteSkillGuide.guideForFirstQte` (`decompiled/core_module/scripts/yishi/view/guild/QteSkillGuide.as:46`) | skill |
| Dialog (`dialog.DialogControl`) | see [plot-dialog.md](plot-dialog.md) | Scripted story lines from `NoviceDialogueXml` | action `showDialog` (`:345`) | story id |

## 3. Routes (client to server)

The checkpoint save (5017) and the training campaign entry (5127) are in [novice-process.md](novice-process.md). Routes owned by other features are listed so the server knows the script depends on them.

| # | Trigger | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| G1 | Tutorial nodes 40, 50: hero walks onto the enemy node | action `sendNodeArrive` `NewbieBaseActionMediator.as:1126` -> `CampaignMapController.sendCampaignArrive` `decompiled/m3/scripts/map/campaign/CampaignMapController.as:1519` -> `MapSocketOuterManager.sendCampaignArrive` `decompiled/m3/scripts/map/net/MapSocketOuterManager.as:55` | skipped when the node is already state 4 or 8 | C>S 5125 0x1405 `U_C_CAMPAIGN_ARRIVE` (owned by [campaign](../campaign/README.md)) | `CampaignReqMsg`: `para_int1 (#1, INT32)` node id 1000206 or 1000208, `para_bool1 (#7, BOOL)` true. Header `extend` 0 | Battle start on that node (node state 4, then 8 after victory); see [battle](../battle/README.md) |
| G2 | Battle guide pause (nodes 40, 50) | action `controlBattleState("1")` `:661` -> `NewbieSocketOutManager.sendBattlePause` `decompiled/core_module/scripts/dialog/utils/NewbieSocketOutManager.as:41` | only in battle scene; node 50 skips when `checkRolesNumInBattle(2,1)` | C>S 10010 0x271a `U_B_USR_STOP_CMD` ("暂停指令") | `BattleReqMsg` (package `battle`): `battleId (#2, STRING)` current battle | Server freezes the battle clock until G3 (Assumption). No client listener for a reply |
| G3 | Battle guide resume after the forced skill click | `controlBattleState("0")` -> `sendBattleContinue` `NewbieSocketOutManager.as:49`; also any skill use while `noviceProcess < 19000` (`decompiled/core_module/scripts/battle/view/ui/SkillItemListController.as:700`, `SkillWarsoulView.as:353`, `AddOtherSkillView.as:309`) | in battle | C>S 10022 0x2726 `B_PAUSE_FINISHED` ("暂停完成继续战斗") | `BattleReqMsg`: `battleId (#2, STRING)` | Battle resumes; for skill use the client sends 10008 `U_B_HERO_ORDER` 400 ms later (`docs/battle/hud.md`) |
| G4 | Tutorial node 60: leave campaign movie ends | `NewbieSpecialActionMediator.enterSceneAfterPlayMovie("leavecampaign",2,103)` `decompiled/m8/scripts/mediators/NewbieSpecialActionMediator.as:373` -> `enterSceneCall` `:398` case 103 | none | C>S 5125 0x1405 then C>S 5025 0x13a1 `U_C_CAMPAIGN_ROOM_EXIT` | 5125 `CampaignReqMsg` `para_int1` = 1000211, `para_bool1` = true; 5025 `RoomExitMsg`: `msg (#1, STRING)` = "" (`decompiled/core_module/scripts/map/campaign/CampaignSocketOutManager.as:68`) | Campaign closed, player returned to the castle scene ([campaign](../campaign/README.md)) |
| G5 | Tutorial node 160: `flytocastle` movie ends | `NewbieSpecialActionMediator.playFlyToCastle` `NewbieSpecialActionMediator.as:523` -> `NewbieBaseActionMediator.sendEnterCollectionBattle` `:1015` -> `NewbieSocketOutManager.sendEnterCollectionBattle` `NewbieSocketOutManager.as:73` | none | C>S 8699 0x21fb `C_NEW_GUILD_FIGHT` ("新手触发采集战斗", novice triggers the collection battle) | no body | Server starts a scripted battle; the node completes when the scene becomes `BATTLE_SCENE` (`decompiled/m8/scripts/nodes/NoviceTutorial_160.as:36`) |
| G6 | Tutorial node 170 in the castle | action `sendInitBuildAndQueue` `NewbieBaseActionMediator.as:742` -> `NewbieSocketOutManager.sendInitBuildAndQueue` `NewbieSocketOutManager.as:57` | `checkInScene(1)` castle (`decompiled/m8/scripts/nodes/NoviceTutorial_170.as:44`) | C>S 8281 0x2059 `C_BUILDING_INIT` | no body | Server creates the starting buildings (including son types 901 Prefeitura, 402 Quartel, 1509 Residência, 1511 Transmissor) and build queues, then pushes the castle building and queue data ([castle](../castle/README.md), Assumption) |
| G7 | Tutorial node 200 | `NoviceTutorial_200` `decompiled/m8/scripts/nodes/NoviceTutorial_200.as:85` -> `TaskSocketManager.sendGetTaskReward` `decompiled/core_module/scripts/managers/TaskSocketManager.as:23` | quest 1834 complete and its trace item visible (`checkConditionCommon(3,"1834")`) | C>S 5014 0x1396 `U_C_QUEST_FINISH` (owned by [quests](../quests/README.md)) | `QuestFinishedReqMsg`: `templateId` = 1834, `rewardItemId` = 0, `isPass` = true | Quest reward flow |
| G8 | First QTE skill in the skill frame | `QteSkillGuide.guideForFirstQte` `decompiled/core_module/scripts/yishi/view/guild/QteSkillGuide.as:62` -> `SocketSendManager.sendQteGuideComplete` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:458` | `skill.templateInfo.QTETime > 0` and `PlayerInfo.qteGuide == 0`; sets the local flag to 1 | C>S 8302 0x206e `C_GUIDE_FINISHED` ("引导QTE完成") | no body | Store `qte_guide = 1`; next `PlayerMsg` carries `qte_guide (#56)` = 1. No reply. `QteSkillGuide.guide` has no caller in this build, so this route is dormant |
| G9 | (unused) campaign callback from the script | action `sendCallInCampaign` `NewbieBaseActionMediator.as:784` -> `NewbieSocketOutManager.sendCallInCampaign` `:63` | not used by any reachable node | C>S 5032 0x13a8 `U_C_CAMPAIGN_CALLBACK` | `CallBackReqMsg`: `map_id (#1)`, `node_id (#2)`, `cmd (#3)` | see [plot-dialog.md](plot-dialog.md) |
| G10 | (unused) training campaign entry from the script | action `sendEnterScene(3, type)` `:117` | not used by any reachable node | C>S 5127 0x1407 | `NoviceReqMsgMsg.type (#3)` | see [novice-process.md](novice-process.md) |

Other server visible side effects of the script: hero fast keys `sendSetSkillFastKey` (5167, `:886`) is defined but not used by any reachable node; `FarmManager.model.showHomeFarmValue = 1` is local only (`decompiled/m8/scripts/nodes/NoviceNode_10.as:138`).

## 4. Server messages (server to client)

The script consumes no tutorial specific packet. It polls client state that comes from other features:

| Data | Source push | Used by |
|---|---|---|
| Campaign node states (4 fighting, 8 destroyed) of nodes 1000206, 1000208 on map 10002 | campaign pushes ([campaign](../campaign/README.md)) | `checkCampaignNodeState` (`decompiled/m8/scripts/mediators/NewbieBaseConditionMediator.as:121`) in nodes 30 to 60 |
| Current scene (1 castle, 3 campaign, 4 battle) | scene switch flow | `checkInScene` (`:53`) |
| Quest state of 1832, 1834, 1912 | quest pushes ([quests](../quests/README.md)) | `checkTaskIsComplete` (`:98`), `checkTaskHasCompleted` (`:109`), `TASK_COMMIT` (`decompiled/core_module/scripts/yishi/manager/TaskManage.as:257`) |
| Hero level | `PlayerMsg` / hero pushes | `checkPlayerGrade` (`:48`), `LEVEL_COMMIT` (`decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:614`) |
| Castle buildings | castle pushes | `checkCastleBuild`, targets `3_n`, `29_n` |
| Pawn count of type 101 | army pushes ([army](../army/README.md)) | `checkHavePawn(101,200)` in node 190 |
| `needViceGuild`, `needShowReward` | 4696 `VicePasswordMsg` opType 5 and 6 | vice guild nodes |
| `qte_guide` | 3 `PlayerMsg (#56)` | G8 |

## 5. Rules and formulas

### 5.1 Forced tutorial nodes (`NewbieModel.TUTORIAL_NODES`, `NewbieModel.as:8`)

| Key (start when value >= key) | Class | Writes on finish (`nid`) | What happens | Server work |
|---|---|---|---|---|
| 11000 | `nodes.NoviceTutorial_10` | 11300 | In campaign scene: opening animation `GameStartPlayView` | campaign 10002 already entered (5127) |
| 11300 | `NoviceTutorial_20` | 11400 | Mask, lock camera, two NPC walks, dialog 1 (royal guards accuse the hero), clean | none |
| 11400 | `NoviceTutorial_30` | 11500 | NPC walk, dialog 2 (Débora); skipped if node 1000206 is 4 or 8 | none |
| 11500 | `NoviceTutorial_40` | 12500 | Walk to node 1000206 and attack (G1); in battle: pause (G2), tip 1501 on skill slot 0, forced click or key 1, resume (G3); done when 1000206 is 8 | battle on node 1000206 with pause support |
| 12500 | `NoviceTutorial_50` | 14000 | NPC 1000202, dialog 17 and 4, attack node 1000208 (G1); in battle: pause, dialog 6, "Obteu habilidades" 1502, arrow 2001, tip 1503 on skill slot 1, resume; done when 1000208 is 8 | battle on node 1000208; hero gains its second skill before or during this battle (Assumption) |
| 14000 | `NoviceTutorial_60` | 19000 | After 1000208 destroyed: dialog 7, NPC walk, explicit save 19000, `leavecampaign` movie, G4 | node 1000211 arrive and room exit; return to castle |
| 19000 | `NoviceTutorial_160` | 19500 | `flytocastle` movie, G5 collection battle | scripted battle for 8699 |
| 19500 | `NoviceTutorial_170` | 20000 | In castle: G6 building init; when quest 1832 is complete: mask, trace item shine, quest arrow, forced click on the quest trace item; dialog 9 | 8281; quest 1832 "Voltar para a Cidade" completes at 19000 ([novice-process.md](novice-process.md) 5.5) |
| 20000 | `NoviceTutorial_180` | 21000 | Focus and highlight Prefeitura (901), building movie, dialog 10 | building 901 must exist |
| 21000 | `NoviceTutorial_190` | 23000 | Quartel (402) movie and tip 1405, forced click on 402; in `CasernFrame` tip 1406 on the recruit button of pawn 101; loops back while pawn 101 count < 200; skipped when quest 1834 is finished | quest 1834 "Recrutar Soldados" (condition type 3, `Para1=1`, `Para2=200`) |
| 23000 | `NoviceTutorial_200` | 25000 | Dialog 11, explicit save 25000, claim quest 1834 (G7), forced click on toolbar campaign button (tip 1411) and on the campaign window start button (tip 1412) | quest 1834 reward |

Nodes `NoviceTutorial_70` to `NoviceTutorial_150` exist in m8 but are not referenced by `TUTORIAL_NODES`; they are unreachable (legacy). `NoviceTutorial_150` would also save 19000.

### 5.2 Level and quest guides (`NOVICE_LEVEL_NODES` `NewbieModel.as:65`, `NOVICE_TASK_NODES` `:96`)

| Trigger | Class | Writes | Content |
|---|---|---|---|
| hero level 12 | `NoviceNode_10` | 26000 | Residência 1509 movie and tip 1423 (farm); castle scene only |
| level 13 | `NoviceNode_20` | 27200 | new function Guilda (5706), toolbar button 8 |
| level 15 | `NoviceNode_30` | 35000 | Transmissor 1511 movie, tip 1419, then world map button tip 1420 |
| level 16 | `NoviceNode_40` | 36000 | new function Montaria (5708), toolbar button 13 |
| level 18 | `NoviceNode_50` | 38000 | new function Astrologia (5710), toolbar button 5 |
| level 50 | `NoviceNode_60` | 45000 | new function Einherjar (5719), toolbar button 14 |
| level 70 | `NoviceNode_70` | 50000 | shows toolbar button 6 |
| quest 1912 "Audiência real III" committed | `NoviceNode_80` | 50000 | new functions Arma Divina (5722) and Espírito de Proteção (5723) |
| `needViceGuild` and level >= 10 | `NoviceTutorial_50500` | 50500 | tip 50501 on the bag button, tip 50502 on "Bloqueio de Itens" |
| `isNeedWeekLockGuild` | `NoviceTutorial_50501` | nothing (overrides `complete`, `decompiled/m8/scripts/nodes/NoviceTutorial_50501.as:60`) | tip 50502 |

Level guides are skipped while the level up popup (`HeroLeveUpdateAction`) is visible (`checkConditionCommon(6)`, `NewbieBaseConditionMediator.as:306`).

### 5.3 Toolbar unlocks tied to the tutorial (client only)

`NewbieMainToolBarLevelControl` (`decompiled/core_module/scripts/dialog/utils/NewbieMainToolBarLevelControl.as:48`, `:78`): toolbar button types 2, 4, 3 visible after quests 1823 "Escapar", 1826 "Pântano do Sono", 1827 "Visitar Ferreiro" are finished; button types by hero level: 1 at 10, 2 at 4, 3 at 7, 4 at 7, 5 at 18, 6 at 70, 7 at 6, 8 at 13, 13 at 16, 14 at 50, 17 at 15. The server only needs to send correct quest and level data.

### 5.4 Timing

- Node poll interval 100 ms (`NewbieTutorialBase.as:24`, `NewbieNodeBase.as:26`). Level guides re-enable the keyboard after 1 s (`NewbieNodeBase.as:51`).
- In battle with `noviceProcess < 19000` every skill click sends 10022 then the 10008 order 400 ms later (G3).

### 5.5 Preload

`NewbieModel.preloadXML` (`NewbieModel.as:101`) preloads castle and UI assets for checkpoints 11300 to 14000; `NewbieManager.initialize` (`NewbieManager.as:288`). Client only.

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `index/language.json` | `newbieXml.node.action.content<id>` (116 keys) | tip texts listed in section 2 |
| `decompiled/core_module/scripts/dialog/data/NoviceDialogueXml.as` | `story` with `nameId` 1 to 26 | dialogs shown by `showDialog` (see [plot-dialog.md](plot-dialog.md)) |
| `raw/xml/tempinfos/QuestTemps.xml`, `QuestCondictionInfos.xml` | quests 1823, 1826, 1827, 1832, 1834, 1912 | gates and rewards |
| `raw/xml/tempinfos/BuildingTempInfos.xml` | `SonType` 901 Prefeitura, 402 Quartel, 1509 Residência, 1511 Transmissor | highlighted buildings; must exist after 8281 |
| `raw/xml/tempinfos/Campaigns.xml`, `MapInfos.xml` | campaign and map 10002 "Monte do Dragão Divino", battle ground 14 | training campaign |

The novice campaign node layout (nodes 1000202, 1000206, 1000208, 1000211) is campaign map data, not a tempinfo file (Open question).

## 7. Persistent state

`tutorial.player_progress` ([novice-process.md](novice-process.md)) holds `novice_process` and `qte_guide_done`. One extra table records server side one shot effects so retries are idempotent:

```sql
CREATE TABLE tutorial.player_milestone (
    player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    milestone   text        NOT NULL CHECK (milestone IN ('building_init','collection_battle','training_campaign_left')),
    done_at     timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, milestone)
);
```

## 8. Backend implementation notes

- `tutorial::guided_steps::handle_building_init` (8281): if milestone `building_init` exists, resend the castle state and stop; else in one transaction create the starting buildings and queues from castle templates (Assumption: the same set a normal character gets), insert the milestone, then push the castle building list and queue list.
- `tutorial::guided_steps::handle_collection_battle` (8699): accept only when `novice_process` is between 19000 and 19500 (Assumption) and the milestone is absent; start a single player PvE battle (`docs/battle/server-engine.md`), battle map 14 (the only battle map preloaded for novices, `decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:151`), units unknown (Open question). Insert the milestone when the battle ends; return the player to the castle.
- `tutorial::guided_steps::handle_qte_guide_finished` (8302): set `qte_guide_done = true`. No reply.
- 10010 and 10022 are handled by `battle::...` handlers: a paused battle must not advance its clock or AI until 10022. Validate that `battleId` belongs to the sender.
- 5125 on nodes 1000206 and 1000208 and 5025 are handled by the campaign feature; the tutorial needs the node states 4 then 8 pushed exactly as for normal campaigns, and node 1000211 arrive to be accepted without a battle (Assumption).
- 5014 for quest 1834 is the normal quest reward handler.
- Validation order for tutorial handlers: player online, checkpoint window, milestone idempotency, then side effect.

## 9. Open questions and assumptions

- Battle composition for nodes 1000206, 1000208 and for 8699 is not in the client; it lives in server campaign data. Needs a source (capture or invented content).
- Which skill the hero gains in node 50 ("Obteu habilidades") and whether the server grants it at the battle or at a checkpoint is unknown; the client shows skill slot 1 with `showNewSkillInBattle(1,9)`.
- 8281 exact effect (which buildings and queue counts) is unknown; the 5017 description in `ProtocolTypeTable.as` suggests the original server did it on a checkpoint save.
- `QteSkillGuide.guide` has no caller, so 8302 is never sent by this build.
- 10010 has no visible reply; Assumption: none.
- Unreachable nodes 70 to 150 suggest an older, longer script; not needed.
- C>S 10009 0x2719 and S>C 74 0x004a `U_B_USR_GUIDE` ("新手进入战斗", novice enters battle) exist in `protocol/opcodes.csv` and `ProtocolTypeTable.as` but have no sender and no listener in this client; the novice battles start through 5125 and 8699 instead. Not needed.

## 10. Implementation checklist

- [ ] Campaign 10002 with nodes 1000202, 1000206, 1000208, 1000211 and states 4/8 (campaign)
- [ ] Battles for nodes 1000206 and 1000208 with pause (10010) and resume (10022)
- [ ] Route G4: node 1000211 arrive without battle, then 5025 room exit to castle
- [ ] Route G5: 8699 novice collection battle
- [ ] Route G6: 8281 building and queue init, idempotent
- [ ] Route G7: quest 1834 reward
- [ ] Route G8: 8302 QTE guide flag
- [ ] Table `tutorial.player_milestone`
- [ ] Quests 1832 and 1834 accepted at the right checkpoints (quests)
- [ ] Vice password flags 4696 opType 5 and 6 (hero)
- [ ] Test: full run 11000 to 25000 with relog at every checkpoint resumes the right node
- [ ] Test: level up to 12, 13, 15, 16, 18 after 25000 triggers each guide and saves its checkpoint
- [ ] Test: 8281 and 8699 sent twice do not duplicate buildings or battles
