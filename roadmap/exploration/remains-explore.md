# Ruins exploration ("Exploração das Ruínas")

Feature [exploration](README.md), module `remains-explore`. Aliases in [README.md](README.md).

## 1. Overview

- 4 ruins ("Deserto da Praga", "Floresta Misteriosa", "Pântano do Submundo", "Penhasco abandonado"), 3 nodes each (12 checkpoints 101..403). Each exploration step costs "Faíscas" (tinder, 20 per step) and triggers a random event of the node's event group: a soldier fight, goods, a mirror image of a player, the small boss ("chefe") or the big boss ("chefão").
- Progress 0..100 %. The small boss appears at 50 % and must be beaten to continue; the big boss appears at 100 % and opens the next ruin. Completed ruins can be explored again, with random boss appearances (`boss1NodeId`, `boss2NodeId`) for rare rewards.
- Tinder: max 300, refilled at midnight; up to 6 purchases per day with increasing diamond prices.
- Daily and weekly activity ("Prêmios de atividade"): 6 daily and 6 weekly tasks each worth 20 points; 5 chests per period at 20/40/60/80/100 points.
- Battles exclude goddess, Einherjar, guardians, protection spirits, divine and sacred weapons and titans ("Os seguintes sistemas e unidades foram selados").
- Disabled in this build: `VersionSwitch.REMAINS_EXPLORE = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:214`).

## 2. Screens

Controller `remainsexplore`: openType default `RemainsExploreFrame`, 2 `RemainsExploreNodeFrame`, 3 `RemainsExploreDropFrame`, 4 `RemainsExploreActivityFrame` (`decompiled/core_module/scripts/mvc/controler/RemainsExploreControler.as:56-69`).

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RE/RemainsExploreFrame.as` (900 x 655) | "Exploração das Ruínas"; help "Guia da Exploração das Ruínas" | 4 area rows (`_num = 4`, `:37`) of 3 node items, activity button; sends op 0 on open (`:39-45`) | `SwitchPageHelp.openRemainsExploreFrame` | nodes |
| `RE/RemainsExploreAreaItem.as`, `RE/RemainsExploreNodeItem.as` | "Progresso da exploração:{0}%"; locked "Área atual bloqueada, não pode entrar" | Node tile with lock, progress and boss marks; click opens the node frame (`RemainsExploreNodeItem.as:98-140`) | main frame | `nodeList`, boss node ids |
| `RE/RemainsExploreNodeFrame.as` (770 x 625) | chapter name; "Faíscas" counter "{0}/{1}"; tips "A Faísca se restabelece automaticamente todos os dias à meia noite.", "Derrote o chefe para continuar explorando!", "Derrote o chefe para encerrar a exploração da área atual!" | Explore button, buy tinder, boss buttons, progress bar, event animations (`:78-371`) | node item (openType 2); after a ruins battle (`decompiled/m4/scripts/castle/CastleSceneView.as:311-321`, `decompiled/m3/scripts/map/space/SpaceSceneController.as:426-436`) | `currentInfo`, `tinder`, `exploreCost` |
| `RE/RemainsExploreDropFrame.as` (390 x 360) | "Visualização do Drop"; "Drop da Exploração:", "Drop do Chefe:", "Drop do Chefão:" | Drop preview of the node event group (`:97-117`) | node frame drop button (openType 3) | templates |
| `RE/RemainsExploreActivityFrame.as`, `RE/RemainsExploreActivityItem.as`, `RE/RemainsExploreProgressView.as`, `RE/RemainsExploreBoxItem.as` (580 x 495) | "Prêmios de atividade"; "{0} atividades" | Daily/weekly task list with claim, activity bars and 5 chests each (`RemainsExploreActivityItem.as:64-103`, `RemainsExploreBoxItem.as:68-114`) | main frame activity button (openType 4) | `dayLiveness`, `weekLiveness`, leed lists, `boxStates` |
| `decompiled/m16/scripts/yishi/view/tips/RemainsExploreTip.as` | | Tip | | |

## 3. Routes (client to server)

All requests: send 9703 (0x25e7) `C_REMAINS_EXPLORE_OP`, protobuf `PlayerOpMsg` (package `player`; only these fields are used: `op` (#1, INT32), `type` (#2, INT32), `index` (#6, INT32), `campaignId` (#9, INT32), `value1` (#13, INT32)). Senders in `decompiled/core_module/scripts/yishi/manager/RemainsExploreManager.as` (`REM:223-275`), op constants `REM:25-35`.

| # | op | UI and sender | Client checks | Request fields | Expected reply |
|---|---|---|---|---|---|
| R0 | 0 GET_DATA | main frame open (`RE/RemainsExploreFrame.as:44`, `REM:223-229`) | entry checks (section 5) | `op` | 519 full info, 521 activity |
| R1 | 1 EXPLORE | "Explorar" (`RE/RemainsExploreNodeFrame.as:220-238`, `REM:231-238`) | `tinder >= exploreCost` else "A quantidade de Faíscas não é suficiente, adquira mais Faíscas"; not in a team else "Você encontra-se numa equipe, não é possível de fazer esta operação"; buttons locked until the animation ends | `campaignId = checkpointId` | 520 with new `tinder`, `progress` and `eventType` |
| R2 | 3 ATTACK, type 0 | automatic after the event animation (`RE/RemainsExploreNodeFrame.as:309-336`): goods animation (`eventType 2`) or mark animation (other types) | none | `campaignId = checkpointId`, `type = 0` | goods: bag 115 + 519; fight events (1 soldiers, 3 mirror): battle start (battleType 3899 or 3900), then 519 and 521 |
| R3 | 3 ATTACK, boss | boss buttons (`RE/RemainsExploreNodeFrame.as:169-179`) | button visible when `progress >= 50` and boss 1 not passed, or `progress >= 100` and boss 2 not passed, or the node is the random boss node (`RemainsExploreNodeInfo.as:25-33`, `RE/RemainsExploreNodeFrame.as:275-284`) | `campaignId = checkpointId`, `type = 1` (small boss) or `2` (big boss) | battle start; after: 519 (`isBoss1Pass`/`isBoss2Pass`, next ruin unlocked), 521 |
| R4 | 2 BUY_TINDER | buy button (`RE/RemainsExploreNodeFrame.as:181-218`, `REM:240-246`) | `tinder < 300` else "Já está cheio de Faíscas"; `canBuyTimes > 0` else "Compras diárias atingiu o limite"; price row `tinder_buy[len - canBuyTimes]`; confirm "Usar {0} diamantes para aumentar {1} faíscas? (Pode comprar {2}x hoje)"; `point >= price` else recharge | `op` | 519 with `tinder`, `canBuyTimes - 1`; player info 3 |
| R5 | 4 RECEIVE | task claim (`RE/RemainsExploreActivityItem.as:64-67`, `REM:258-265`) | `completeState == 1` | `campaignId = RemainsLeedTemp.TemplateId` | 521 with `completeState = 2` and the new liveness |
| R6 | 5 BOX | activity chest (`RE/RemainsExploreBoxItem.as:68-71`, `REM:267-275`) | chest state 1 | `value1 = 1 day / 2 week`, `index = 1..5` | 519 `boxStates` updated; bag 115 |

## 4. Server messages (server to client)

Receivers `REM:81-221` (listeners `REM:83-85`).

### 519 (0x0207) `U_C_REMAINS_EXPLORE_INFO`

`RemainsExploreMsg` (package `module`): `tinder` (#1, INT32); `canBuyTimes` (#2, INT32) purchases left today; `dayLiveness` (#3, INT32); `weekLiveness` (#4, INT32); `boss1NodeId` (#5, INT32) checkpoint where a random small boss stands; `boss2NodeId` (#6, INT32) checkpoint of a random big boss; `boxStates` (#7, STRING) `"type|index|state,..."` with state 0 locked, 1 claimable, 2 claimed (`decompiled/core_module/scripts/mvc/module/remainsexplore/RemainsExploreModel.as:67-102`); `nodeList` (#8, `RemainsExploreNodeMsg`, repeated): `checkpointId` (#1), `chapterId` (#2), `node` (#3), `progress` (#4, 0..100), `exploreCost` (#5, tinder per step), `isBoss1Pass` (#6, BOOL), `isBoss2Pass` (#7, BOOL). Scalars applied when present; nodes upserted by `checkpointId` (unlocked nodes only; missing nodes are locked). When: reply to ops 0, 2, 3, 5; daily reset.

### 520 (0x0208) `U_C_DO_EXPLORE_UPDATE`

`DoExploreResponseMsg`: `checkpointId` (#1), `chapterId` (#2), `node` (#3), `progress` (#4), `tinder` (#5), `eventType` (#6) 1 soldiers, 2 goods, 3 mirror hero, 4 small boss, 5 big boss (`REM:37-45`). Updates the node progress and plays the step (goods) or mark animation, which then sends R2 (`REM:198-221`). When: reply to op 1.

### 521 (0x0209) `U_C_REMAINS_LEED_UPDATE`

`RemainsLeedUpdateMsg`: `dayLiveness` (#1), `weekLiveness` (#2), `leedDataList` (#3, `RemainsLeedDataMsg`, repeated: `templateId` (#1), `currentCount` (#2), `completeState` (#3) 0 running, 1 claimable, 2 claimed). Lists are rebuilt from `RemainsLeedTemps.xml` by `MasterType` (1 day, 2 week) and sorted claimable first (`REM:88-147`). When: reply to op 0 and op 4; after any counted action.

## 5. Rules and formulas

- Entry (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2995-3017`): `VersionSwitch.REMAINS_EXPLORE` (false) else "Esta função ainda não foi ativada"; not in a team; hero "Classe Consagrada" (`thane.isHoly`) else "Abre com a Classe Consagrada"; scene check. Only opener: NPC dialog option 155 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:865-867`), which no node of `MapNodeInfos.xml` offers in this build.
- `remainsexplore_config = 20,300,6,6,6`: 20 tinder per step, max 300, 6 purchases per day, random small boss cooldown 6 h, random big boss cooldown 6 h.
- `remainsexplore_tinder_buy = 200,100|200,100|300,100|500,100|800,100|1000,100`: diamonds and tinder per purchase number.
- Tinder refills to 300 at midnight (tip text).
- Progress per step and event weights are not in the client; each node has `EventCount` events (20, 25, 30, 35 by chapter) which suggests `100 / EventCount` % per step (assumption).
- Activity: each task gives `GaintPoint = 20` once completed (`Param1` = 3 daily, 10 weekly); chests at `remains_daybox_values` and `remains_weekbox_values` = 20, 40, 60, 80, 100.
- Mirror battles use 60 % of the mirrored player's attributes (`remains_mirror_percent = 60`).
- Battle types 3899 and 3900 (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:481-484`); assumption: 3899 normal and boss fights, 3900 mirror fights.
- Leed event types (`RemainsLeedTemps.xml EventType`): 1 expeditions, 2 small bosses, 3 big bosses, 4 monsters, 5 mirror images, 6 treasures (text of 1006 says expeditions; 2006 says treasures).

## 6. Templates

| File | Fields |
|---|---|
| `RemainsExploreChapterTemps.xml` | `ChapterId` 1..4, `ChapterName`, `ChapterDescription` (placeholder text) |
| `RemainsExploreNodeTemps.xml` (`remainsExploreTempCate.getTempInfo`) | `CheckPointId`, `ChapterId`, `Node` 1..3, `EventCount`, `EventGroup` |
| `RemainsExploreEventTemps.xml` (`remainsExploreEventTempCate`), 120 rows | `EventId`, `EventGroup`, `EventType` 1..5, `Param1` "template,level" of the enemy leader (assumption), `Param2` "pawnTemplate,pos|..." enemy units on cells 1, 3, 7, 9, `Param4` drop id |
| `RemainsExploreDrop.xml` (`remainsExploreDropTempCate`) | `dropId`, `itemId` (7106001..7106006), `count`, `appearType` 3/4, `isBind` |
| `RemainsLeedTemps.xml` (`remainsExploreActivityTempCate`) | `TemplateId`, `MasterType` 1 day / 2 week, `Description`, `EventType`, `GaintPoint`, `Param1` target |
| `RemainsExploreBox.xml` (`remainsExploreActivityDropTempCate.getTemplatesByTypeIndex`) | `site` 1 day / 2 week, `para2` chest 1..5, `itemId` 7110001, 7106005, 7106006, `count` |
| `ConfigInfos.xml` | `remainsexplore_config`, `remainsexplore_tinder_buy`, `remains_daybox_values`, `remains_weekbox_values`, `remains_mirror_percent` |

## 7. Persistent state

```sql
CREATE TABLE exploration.remains_state (
  player_id          INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  tinder             SMALLINT    NOT NULL DEFAULT 300 CHECK (tinder BETWEEN 0 AND 300),
  day                DATE        NOT NULL,
  week_start         DATE        NOT NULL,
  buys_today         SMALLINT    NOT NULL DEFAULT 0 CHECK (buys_today BETWEEN 0 AND 6),
  day_liveness       SMALLINT    NOT NULL DEFAULT 0,
  week_liveness      SMALLINT    NOT NULL DEFAULT 0,
  boss1_checkpoint   SMALLINT,
  boss1_next_at      TIMESTAMPTZ,
  boss2_checkpoint   SMALLINT,
  boss2_next_at      TIMESTAMPTZ,
  pending_event_id   INTEGER,
  pending_checkpoint SMALLINT
);

CREATE TABLE exploration.remains_node (
  player_id      INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  checkpoint_id  SMALLINT NOT NULL,
  progress       SMALLINT NOT NULL DEFAULT 0 CHECK (progress BETWEEN 0 AND 100),
  boss1_passed   BOOLEAN  NOT NULL DEFAULT false,
  boss2_passed   BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, checkpoint_id)
);

CREATE TABLE exploration.remains_task (
  player_id      INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id    INTEGER  NOT NULL,
  current_count  SMALLINT NOT NULL DEFAULT 0,
  state          SMALLINT NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 2),
  PRIMARY KEY (player_id, template_id)
);

CREATE TABLE exploration.remains_chest (
  player_id   INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  period_type SMALLINT NOT NULL CHECK (period_type IN (1, 2)),
  chest_index SMALLINT NOT NULL CHECK (chest_index BETWEEN 1 AND 5),
  claimed     BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, period_type, chest_index)
);
```

## 8. Backend implementation notes

- `exploration::remains_explore::handle_op` (9703) dispatching to `handle_get_data`, `handle_explore`, `handle_buy_tinder`, `handle_attack`, `handle_receive`, `handle_box`.
- Explore: node unlocked -> tinder >= cost -> no pending event -> deduct tinder, roll an event of the node `EventGroup` (types 4/5 only when progress thresholds hit), store it as pending, advance progress (capped at 50 until boss 1 passed, at 100 until boss 2 passed), reply 520.
- Attack type 0: resolve the pending event; goods -> grant `Param4` drop, reply 519; fight -> start battle with enemy from `Param1/Param2` (mirror: copy a random player at 60 %), battleType 3899/3900, with the excluded systems disabled. Battle end: on win grant drop, count tasks, clear pending.
- Attack type 1/2: boss of the node (event type 4/5) or the random boss node; win sets `boss1_passed`/`boss2_passed`, boss 2 unlocks the next ruin row (insert `remains_node` for the next checkpoint); random boss win clears `bossN_checkpoint` and sets `bossN_next_at = now + 6 h`.
- Tasks and chests: increment counters per event type; `receive` adds 20 liveness; chest claim requires liveness >= threshold.
- Resets: daily (tinder 300, buys, daily tasks and chests, day liveness), weekly (week tasks, chests, liveness; assumption Monday 00:00).

## 9. Open questions and assumptions

- Progress per step, event weights, enemy composition semantics of `Param1`.
- Battle type split between 3899 and 3900.
- Random boss spawn rule (which checkpoint, only completed ruins).
- The feature is off and has no NPC entry in this build.

## 10. Implementation checklist

- [ ] Screens: main frame, node frame, drop frame, activity frame
- [ ] Route R0 op 0
- [ ] Route R1 op 1 explore -> 520
- [ ] Route R2 op 3 type 0 resolve event (goods or battle)
- [ ] Route R3 op 3 type 1/2 boss battle
- [ ] Route R4 op 2 buy tinder
- [ ] Route R5 op 4 task claim
- [ ] Route R6 op 5 chest
- [ ] Server messages 519, 520, 521
- [ ] Tables `exploration.remains_state`, `remains_node`, `remains_task`, `remains_chest`
- [ ] Template loaders (6 files) and config keys
- [ ] Battles 3899/3900 with system exclusions
- [ ] Daily and weekly reset jobs
