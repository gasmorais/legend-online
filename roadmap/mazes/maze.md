# Maze ("Labirinto")

Feature `mazes`, module `maze`. Client: `M9/maze/MazeFrame.as`, `M9/maze/view/MazeFloorItem.as`, `M9/maze/order/*`, `CM/mvc/controler/MazeControler.as`, `CM/mvc/module/maze/MazeModel.as`, `CM/yishi/manager/PlayerManager.as:162-163, 363-427` (tower info), `M9/room/net/RoomSocketOuterManager.as:44-71`, `CM/yishi/service/managers/SocketSendManager.as:438-457`, campaign HUD `M3/map/campaign/view/ui/MazeView.as`, `MazeRiverView.as`, `MazeAutoFightHelper.as`, `M3/map/campaign/mediator/mapview/MazeMapMediator.as`, `M3/map/campaign/mediator/maze/MazeRiverMediator.as`, `CM/yishi/manager/BaseManager.as:317, 2922-2945`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Three mazes, one tab each in the frame:

| Tab | Campaign | Floors (map ids) | Name | Unlock | Daily runs | Double reward |
|---|---|---|---|---|---|---|
| 0 | 8001 | 100 (8001..8100) | "Labirinto Subterrâneo" ("Labirinto") | hero level 12 | 1 free per day | 1 "Chave do Labirinto" (208008) |
| 1 | 8101 | 30 (8101..8130) | "Labirinto do Abismo" | floor 100 of maze 1 ("Necessário concluir o piso 100 do labirinto subterrâneo"); server marks it by sending a tower info with `campaign_id != 0` | 1 per day | 3 "Chave do Labirinto" |
| 2 | 8401 | 30 (8401..8430) | "Labirinto Pergatório" | maze 2 open and job advance (`vocationGrades > 0`, "Esta função será liberada após o avanço de nv.80") | 1 per day | 3 "Chave do Purgatório" (208037) |

- A run starts at floor 1 ("Iniciar") or continues the current floor ("Continuar"). The player enters the floor campaign (single player, `Types 4`, capacity 1), walks and fights the floor monsters, takes the exit to the next floor. Experience (`totalGp`) and items are accumulated and shown in the HUD; the item list of the run is shown at the end ("Item Recebido").
- On death the player can revive (cost given by the server, 5 diamonds by the text) or give up: giving up ends the run for today ("Desistir do Labirinto hoje?").
- "Recomeçar" (reset) abandons the current floor and restarts the run.
- After floor 10 the "Bot" sweep (mopup feature) can clear floors up to the record.
- A ranking per maze is loaded from static XML files; the first kill holder of each floor of maze 2 is shown in the HUD.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `maze.MazeFrame` (`M9/maze/MazeFrame.as`), controller `maze` (`CM/mvc/controler/MazeControler.as`, frame `maze.MazeFrame1`), preloaded by 8297 (`:35-50`) | "Labirinto" (`maze.MazeFrame.title`) | Maze hub | Castle building 1507, `gotoMazeFrame`, return from a maze (openType 2 plays the maze 2 button animation) | Tabs `_maze1.._maze3` (maze 2 enabled only when `VersionSwitch.MAZE_SWTICH` and `towerInfo2.campaignId != 0`, `:249-252`; maze 3 click checks, `:353-374`); record "{maxIndex}" and rank "{order}" or "Nenhum" (`:580-592`); without a run: "Iniciar", today's free count "{free - used}/{free}" (maze 1) or extra count (mazes 2, 3), double reward toggle; with a run (`towerIndex > 0`): current floor, experience, "Continuar", "Recomeçar", "Bot contínuo", link "Item obtidos dessa vez" (`:596-715`); floor medals 10..100 (maze 1) or 5..30 (maze 2) greyed above the record with drop tips from `MapInfos.Description` (`:731-790`, `M9/maze/view/MazeFloorItem.as:38-55`); buttons ranking (`:425-437`), shop (`:411-415`), help (`:376-382`), bot (`:439-485`) |
| `maze.order.MazeOrderFrame` (`M9/maze/order/*`) | "Ranking do Labirinto" / "Labirinto do Abismo" / "Labirinto do Purgatório" | Ranking of the selected maze | Ranking button after `tower*.xml` is loaded | `MazeOrderInfo`: rank `towerOrder`, nickname, guild, job, floor reached `towerIndex`, level, fight power, VIP (`CM/mvc/controler/MazeControler.as:85-112`) |
| `map.campaign.view.ui.MazeView` (`M3/map/campaign/view/ui/MazeView.as`) by `MazeMapMediator` on maps `Types 4` (`M3/map/campaign/view/CampaignMapView.as:226-231`) | none (HUD) | Run HUD on the floor map | Floor maps | "Piso Atual:" `towerIndex`, "Exp. recebida:" `totalGp` (`:86-92, 232-233`); "Itens obtidos" link; first kill name for maze 2 floors (`VersionSwitch.MAZE_FIRST_KILL`, `:105-117`); auto fight toggle (`MazeModel.isAuto`, `:182-200`) |
| `map.campaign.view.ui.MazeRiverView` (`M3/map/campaign/view/ui/MazeRiverView.as`) by `MazeRiverMediator` (`M3/map/campaign/mediator/maze/MazeRiverMediator.as:27-79`) | "Você está morto, ressuscitar?" | Revive or give up | Player death on a floor (4207) | Revive button (cost from 4207 `msg`), cancel |
| `MazeFallItemsFrame` (`campaign.maze.FallItemsFrame`) | "Item Recebido" | Items of the run | Link of the frame or HUD; 4419 after the run (`CM/yishi/manager/BaseManager.as:2922-2945`) | Item list "tid,count\|..." |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| Z1 | Opening the frame (preload) and tab change | `MazeControler.startPreLoad` (`CM/mvc/controler/MazeControler.as:40-43`), `MazeFrame.__mazePanelChangeHandler` (`M9/maze/MazeFrame.as:392-402`) → `SocketSendManager.requestTowerInfo(index)` (`CM/yishi/service/managers/SocketSendManager.as:438-444`) | none | **8297 (0x2069) C_TOWER_INFO** | `campaign.TowerInfoReqMsg`: `index (#1, INT32)` tab 0, 1, 2 | **4205** for that maze (the frame opens on the first 4205, `UPDATE_TOWER_INFO`) |
| Z2 | "Iniciar" | `MazeFrame.__startTowerInfoHandler` (`:537-573`) → `RoomSocketOuterManager.enterTowerInfo(campaignId, 1, double ? 2 : 1)` (`M9/room/net/RoomSocketOuterManager.as:52-66`) | `enterCount < maxEnterCount` ("Desafios de hoje esgotados!"); double selected requires keys: maze 1 at least 1 key 208008, maze 2 at least 3 keys 208008, maze 3 at least 3 keys 208037, else the quick buy frame for the key opens (`:806-819`); anti spam 5 s | **8296 (0x2068) C_ENTER_TOWER** | `campaign.EnterTowerInfoMsg`: `choose_index (#1, INT32)` 1 = start a new run; `campaign_id (#2, INT32)` 8001, 8101 or 8401; `is_double (#3, INT32)` 2 double, 1 normal | **4205** (run started, `towerIndex` 1), then campaign creation of floor 1 (125, 21, 127) |
| Z3 | "Continuar" | `MazeFrame.__continueHandler` (`:531-535`) → `enterTowerInfo(campaignId, 0)` | anti spam | **8296** | `{choose_index = 0, campaign_id, is_double = 1}` | Campaign creation of the current floor |
| Z4 | "Recomeçar" (confirm "Desistir do piso atual e recomeçar?") | `MazeFrame.__resetHandler` / `__resetMazeLevel` (`:512-529`) → `RoomSocketOuterManager.resetTowerInfo(index)` (`M9/room/net/RoomSocketOuterManager.as:42-48`) | confirmation | **8299 (0x206b) C_TOWER_RESET** | `TowerInfoReqMsg {index (#1) = tab}` | **4205** with `towerIndex = 0` *(assumption: the run is ended, the day's entry stays used)* |
| Z5 | Revive on death | `MazeRiverView.__riverClickHandler` / `__riverCall` (`M3/map/campaign/view/ui/MazeRiverView.as:85-171`) → `SocketSendManager.sendTowerRiver(useBind)` (`CM/yishi/service/managers/SocketSendManager.as:446-457`) | cost 0: sends at once with `useBind = true`; from the third death of the session no confirmation; else confirmation with the bound diamond option; `allPoint` (bound + diamonds) or `point` must cover the cost, else recharge alert | **8300 (0x206c) C_TOWER_LIVE** | `player.PayTypeMsg`: `pay_type (#1, INT32)` 0 = bound diamonds allowed, 1 = diamonds only. Unused: `property1 #2`, `property2 #3`, `type #4` | Player alive again on the floor (4175 or campaign army state *(assumption)*), currency push |
| Z6 | Give up after death (confirm "Desistir do Labirinto hoje?" or, when `enterCount == 0`, "Desisitir do piso atual e recomeçar?") | `MazeRiverView.__cannelCall` (`:139-158`) → `CampaignSocketOutManager.sendReturnCampaignRoom(armyId)` (`CM/map/campaign/CampaignSocketOutManager.as:68-80`) | confirmation | **5025 (0x13a1) U_C_CAMPAIGN_ROOM_EXIT** | `RoomExitMsg` (campaign feature) | 22 exit; **4419** run report; **4205** |
| Z7 | "Bot" / "Bot contínuo" | `MazeFrame.__startMopupHandler`, `__continueMopupHandler` (`:439-510`) → `mopup` openType 3 with the tab | `enterCount < maxEnterCount`; not in the outer city; double needs keys as in Z2; enabled only when `maxIndex >= 10 && towerIndex < maxIndex` ("Depois de ultrapassar 10 pisos, poderá usar o Modo BOT.") | 8528 `C_CAMPAIGN_SWEEP` (`M5/mopup/view/MazeMopupPrepareFrame.as:254`, `MazeMopupIngFrame.as:441-650`), see [../mopup/README.md](../mopup/README.md) | | |
| Z8 | Ranking button | `MazeFrame.__openOrderHandler` (`:425-437`) → `MazeControler.loadMazeOrderData(index)` (`CM/mvc/controler/MazeControler.as:85-89`) | none | HTTP GET `{TPL}tower.xml`, `tower2.xml`, `tower3.xml` (`PathManager.getMazeOrderPath`, `CM/yishi/manager/PathManager.as:498-513`) | | XML items `userId, job, nickName, consortiaName, towerOrder, towerIndex, grades, fightingCapacity, IsVip, VipType` |
| Z9 | Secretary "towers" | `SecretaryManager.goGettower` (`CM/managers/SecretaryManager.as:90-94`) | | **9742 (0x260e) C_GET_TOWER_LIST** | no body | **4373** list of every maze |
| Z10 | Secretary resets | `DixAction`, `SyAction`, `LyAction` `resetTowerInfo` (`CM/mvc/module/secretary/acts/*.as:49-55`) | | 8299 | as Z4 | as Z4 |
| Z11 | Fight on a floor | campaign map arrive 5125 | auto fight when `MazeModel.isAuto` (`CM/battle/control/EnterBattleController.as:255`) | 5125 | | battle (campaign battle type of the floor), result 137/4103; auto turned off on a lost battle (`CM/battle/handler/BattleResultHandler.as:110-113`) |

---

## 4. Server messages (server to client)

`campaign.TowerInfoMsg` (used by 4205, 4373 and 4419): `enter_count (#1, INT32)` runs used today; `total_gp (#2, INT32)` experience gained in the current run; `tower_index (#3, INT32)` current floor of the run, 0 = no run; `max_index (#4, INT32)` record floor; `order (#5, INT32)` rank, 0 = unranked; `max_enterCount (#6, INT32)` runs allowed today (free + key); `item_tempIds (#7, STRING)` items of the run "tid,count\|..."; `free_enterCount (#8, INT32)` free runs per day; `campaign_id (#9, INT32)` 8001, 8101 or 8401 (0 = maze locked); `index (#10, INT32)` tab 0..2; `first_hitId (#11, INT32)` and `first_hitName (#12, STRING)` first kill holder of the current floor (maze 2).

| Opcode | Name | Message | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4205 (0x106d)** | U_C_TOWERINFO | `TowerInfoMsg` | `PlayerManager.__towerInfoHandler` (`CM/yishi/manager/PlayerManager.as:162, 363-383`) | Response to 8297, 8296, 8299; after each floor change and each kill on a floor (`totalGp`, `towerIndex`) | Copies into `towerInfo` (current tab) and into `towerInfo1/2/3` chosen by `campaign_id` range (8000..8100, 8101..8130, 8401..8430), fires `UPDATE_TOWER_INFO` (frame and HUD refresh; `MazeControler` opens the frame on the first one) |
| **4373 (0x1115)** | U_C_TOWERLIST | `campaign.TowerListMsg`: `towerInfo (#1, TowerInfoMsg, repeated)` | `PlayerManager.__towerListHandler` (`:163, 385-412`) | At login *(assumption, needed to enable tab 2)* and response to 9742 | Fills `towerInfo1/2/3` |
| **4207 (0x106f)** | U_C_TOWER_DIED | `campaign.TowerDiedMsg`: `title (#1, STRING)` unused; `msg (#2, STRING)` revive cost in diamonds as text | `CampaignSocketManger.__towerDiedHandler` / `riverTower` (`M3/map/campaign/CampaignSocketManger.as:1074-1087`), buffered until the campaign scene is ready (`SocketSceneBufferManager`) | When the player loses a floor battle | `selfMemberData.isDie = 1`, `MAZE_DIE` event with `int(msg)` → `MazeRiverView.cost`; the river view appears |
| **4419 (0x1143)** | U_C_TOWER_REPORT | `TowerInfoMsg` (only `item_tempIds` read) | `BaseManager.__towerReportHandler` (`CM/yishi/manager/BaseManager.as:317, 2922-2945`) | When a run ends (give up, last floor, end of day) | Delayed alert showing `MazeFallItemsFrame` with the items; nothing when empty |
| 125, 21, 127, 22, 137 | campaign | floor campaigns | campaign module | Z2, Z3, floor exit | |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Level | 12 | building 1507, `gotoMazeFrame` |
| Floors | 100 / 30 / 30 (map ids above; `MapInfos.xml` `CampaignId` 8001, 8101, 8401) | `MapInfos.xml`; `WorldBossHelper.checkMaze/checkMaze2/checkMaze3` (`CM/yishi/utils/WorldBossHelper.as:114-138`) |
| Runs per day | Maze 1: one free run, no item cost; mazes 2 and 3: one run per day (help) | `maze.MazeFrame.helpContent` |
| Double reward | Maze 1: 1 key 208008; maze 2: 3 keys 208008; maze 3: 3 keys 208037; consumed at start *(assumption)* | `MazeFrame.as:537-573` |
| Bot | Available when `maxIndex >= 10` and `towerIndex < maxIndex`; costs gold (help item 5) | `MazeFrame.as:255-275, 717-728` |
| Revive | Cost in 4207 `msg` (text: 5 diamonds); bound diamonds first when `pay_type = 0` | `map.campaign.view.ui.MazeRiverView.content01` |
| Unlocks | Maze 2 after floor 100 of maze 1; maze 3 after job advance | help item 1 |
| Shop | "Moeda do Labirinto" 208009 (`MazeModel.SHOP_MAZE_COIN_TEMPID`) in shop 4; some goods need a floor ("Disponível após concluir piso {0}") | `CM/mvc/module/maze/MazeModel.as`; `maze.shop.tips` |
| Ranking | Static XML per maze, regenerated by the server *(assumption: daily)* | Z8 |
| Achievement | Condition 101 parm1 1/2/3 = maze 1/2/3, value = record floor | [../medals/achievements.md](../medals/achievements.md) |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` 8001, 8101, 8401 | Maze campaigns | `Types 4`, `Capacity 1`, `CampaignName` |
| `raw/xml/tempinfos/MapInfos.xml` 8001..8100, 8101..8130, 8401..8430 | Floors | `CampaignId`, `MapName`, `MapFileId`, `Description` (drop tip, empty in the local data) |
| Floor map files (`web/public/maps`) | Monsters and exits per floor | nodes |
| `raw/xml/tempinfos/ItemTempInfos.xml` 208008, 208037, 208009 | Keys and maze coin | |

---

## 7. Persistent state (PostgreSQL, schema `mazes`)

```sql
CREATE SCHEMA IF NOT EXISTS mazes;

CREATE TABLE mazes.tower_progress (
  player_id      integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  maze_index     smallint NOT NULL CHECK (maze_index BETWEEN 0 AND 2),   -- tab: 0 = 8001, 1 = 8101, 2 = 8401
  unlocked       boolean  NOT NULL DEFAULT false,
  record_floor   smallint NOT NULL DEFAULT 0 CHECK (record_floor >= 0),
  current_floor  smallint NOT NULL DEFAULT 0 CHECK (current_floor >= 0),  -- 0 = no run
  run_double     boolean  NOT NULL DEFAULT false,
  run_gp         integer  NOT NULL DEFAULT 0,
  run_items      text     NOT NULL DEFAULT '',   -- "tid,count|..."
  entries_date   date,
  entries_used   smallint NOT NULL DEFAULT 0,
  deaths_in_run  smallint NOT NULL DEFAULT 0,
  updated_at     timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, maze_index)
);
CREATE INDEX tower_progress_rank ON mazes.tower_progress (maze_index, record_floor DESC);

CREATE TABLE mazes.floor_first_kills (
  maze_index  smallint NOT NULL,
  floor       smallint NOT NULL,
  player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  nickname    text     NOT NULL,
  killed_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (maze_index, floor)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `mazes::maze::handle_tower_info` | 8297 | `index` 0..2 | Reset `entries_used` when `entries_date` is not today. Send 4205 for that maze (`campaign_id = 0` if locked) |
| `mazes::maze::handle_tower_list` | 9742 and login hook | none | Send 4373 with the three mazes |
| `mazes::maze::handle_enter` | 8296 | maze unlocked; `choose_index = 1`: `entries_used < max`, no run in progress *(assumption)*, double requires keys (consume them), level >= 12; `choose_index = 0`: a run exists | `choose_index = 1`: tx: `entries_used += 1`, `current_floor = 1`, reset run fields, consume keys. Send 4205, then create the floor campaign (map id = base + floor - 1) via the campaign module |
| `mazes::maze::on_floor_cleared` (campaign exit node of a floor) | campaign | | `current_floor += 1`, `record_floor = max(record_floor, current_floor - 1)`, add rewards (x2 when `run_double`) to the bag and `run_items`, first kill row; send 4205 and create the next floor campaign; after the last floor end the run (4419) |
| `mazes::maze::on_battle_lost` | campaign battle | | `deaths_in_run += 1`; mark the army dead; send 4207 `{msg = revive cost}` |
| `mazes::maze::handle_revive` | 8300 | player dead in a maze floor; diamonds (bound first when `pay_type = 0`) >= cost | Debit; mark alive; push the army state |
| `mazes::maze::handle_reset` | 8299 | `index` 0..2 | End the run: `current_floor = 0`, send 4419 if items, 4205 |
| Give up (5025 on a maze floor) | campaign | | End the run as above (the day's entry stays used) |

- Floor battles use the campaign battle configuration of the floor nodes (monster armies of the map files); experience counts into `run_gp`.
- Ranking job writes `tower.xml`, `tower2.xml`, `tower3.xml` (`<item userId job nickName consortiaName towerOrder towerIndex grades fightingCapacity IsVip VipType/>`).
- Report achievement condition 101 when `record_floor` rises.

---

## 9. Open questions and assumptions

- *(assumption)* Revive cost progression (the text says 5 diamonds; the first revive may be free when `msg = 0`).
- *(assumption)* Whether reset (8299) gives the day's entry back.
- *(assumption)* 4373 at login.
- Floor rewards and monster lineups come from the map files and server data; `MapInfos.Description` (drop tips) is empty locally.
- Floor selection strings ("Selecionável ao passar do Piso 20") exist but no code uses them.

---

## 10. Implementation checklist

- [ ] Tables `mazes.tower_progress`, `mazes.floor_first_kills`.
- [ ] Routes 8297 → 4205, 9742 → 4373 (and login), 8296, 8299, 8300.
- [ ] Floor campaign creation and floor progression hooks; 4207 on lost battles; 4419 at run end.
- [ ] Key consumption for double rewards.
- [ ] Ranking files `tower.xml`, `tower2.xml`, `tower3.xml`.
- [ ] Screen check: tabs locks, counters, run buttons, floor medals, HUD, revive view.
- [ ] Test: second run of the day refused ("Desafios de hoje esgotados!").
- [ ] Test: death then revive with bound diamonds.
- [ ] Test: maze 2 tab enabled after record 100 on maze 1.
