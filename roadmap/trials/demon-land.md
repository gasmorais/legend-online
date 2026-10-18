# Demon Land ("Continente dos Demônios")

Area: trials, module `demon-land`. Client package `demonland` (`decompiled/m11/scripts/demonland`), manager `yishi.manager.DemonLandManager`, model `mvc.module.demonland.DemonLandModel`, controller key `demonland`. Server opcodes are named `EVIL_LAND`; messages `module.EvilLandMsg` and `gameplot.PlotMsg`. Sweeps use the generic [mopup](../mopup/README.md) route with `sweep_type = 4`.

Not to be confused with the "Rua Mítica" (`demonroad` proto package, opcode 5195), documented in [../roads/increasing-road.md](../roads/increasing-road.md).

Path aliases:

| Alias | File |
|---|---|
| DLM | `decompiled/core_module/scripts/yishi/manager/DemonLandManager.as` |
| DLMOD | `decompiled/core_module/scripts/mvc/module/demonland/DemonLandModel.as` |
| DL | `decompiled/m11/scripts/demonland/` |

## 1. Overview

Story campaign of 30 chapters x 10 nodes ("A força dos demônios selou as suas capacidades. Vá salvar as Deusas e juntamente com elas purificar este continente!"). Nodes 5 and 10 of each chapter are bosses. Each fight costs "Lágrimas da Deusa" (goddess tears, 10 for normal nodes, 25 for bosses; max 500, +20 per hour, 5 diamond refills per day at 250 diamonds). Boss nodes also have a daily attack limit (3) that can be bought back with diamonds. First clears give first drops; every clear gives attack drops. Cleared chapters give stars that open 6 star chests (5, 10, ..., 30). Chapters can open with plot dialogs. Battle type 3880 `DEMON_LAND`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `demonland.DemonLandFrame` (`DL/DemonLandFrame.as`), 1030 x 651 | "Lágrimas da Deusa:" counter, "A cada hora recupera {0} Lágrimas da Deusa." tip, raid buff tip "Ganhos da Raid do Continente dos Demônios +100%" | Chapter road (30 chapters, `DemonRoadMapIcon`), 6 star chests (`AwardBox`), tear refill button | controller `demonland` openType 1 (`decompiled/core_module/scripts/mvc/controler/DemonLandController.as:28-43`) via `SwitchPageHelp.openDemonLandFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2517-2534`) | 4879 |
| `demonland.DemonLandLevelSelectFrame` (`DL/DemonLandLevelSelectFrame.as`), 994 x 305 | chapter pages, "Por favor complete primeiro a fase anterior." | 10 nodes of a chapter (`LevelStateIcon`, bosses at 5 and 10) with first drop item | openType 2 after 4878 with `loop = false` (`DLM:134-153`) | 4879 node list, templates |
| `demonland.AwardView` (`DL/AwardView.as`), 387 x 438 | first clear rewards, attack rewards, attacks "{left}/{max}", buttons attack, sweep, buy count | Node detail and fight | node click -> openType 3 (`DL/LevelStateIcon.as:191-204`) | node msg, template |
| Plot dialog (`DialogControl`) | `PlotInfoMsg` texts | Chapter story | 4878 with `loop = true` | 4878 |
| `mopup.view.DemonLandMopupPrepareFrame` / `DemonLandMopupIngFrame` | "Bot do Continente dos Demônios" | Sweep a cleared node | `AwardView` sweep button -> controller `mopup` openType 13, 14 | 4425 |

## 3. Routes (client to server)

Route: send 9676 (0x25cc) `C_EVIL_LAND_OP` with `player.PlayerOpMsg` (fields: `op` (#1, INT32), `index` (#6, INT32), `nodeId` (#10, INT32), `chapterId` (#11, INT32); the other `PlayerOpMsg` fields are unused here, full list in [shadow-land.md](shadow-land.md)).

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| D1 | Main frame open | `DLM.sendGetDemonLandData` (`DLM:206-212`) from `DL/DemonLandFrame.as:125` | open: `VersionSwitch.DEMON_LAND`, changed job, `checkScene()` | `op = 0` | 4879 `type 0` (full) |
| D2 | Chapter icon / page | `DLM.sendEnterDemonLandChapter(chapter)` (`DLM:214-221`) from `DL/DemonRoadMapIcon.as:111`, `DL/DemonLandLevelSelectFrame.as:162`, `DLM.battleOverHandlerView` (`DLM:286-298`) | chapter <= `maxChapterId` ("Por favor complete primeiro a fase anterior.") | `op = 1`, `chapterId` | 4878 (`loop = true` when the chapter has a dialog to play, then the client reopens frames; `loop = false` opens or refreshes the level select frame) |
| D3 | "Atacar" | `DLM.sendEnterDemonLandNode(chapter, node)` (`DLM:223-231`) from `DL/AwardView.as:186-211` | if tears < node `Cost` and refills left: refill dialog "Deseja gastar {0} diamantes para repor as Lágrimas da Deusa? (Ainda pode repor {1} vezes.)" (`DLMOD:67-78`); boss attacks left > 0 (button disabled otherwise); node unlocked | `op = 2`, `chapterId`, `nodeId` | battle 3880; after: 4879 `type 1` and `type 2` (node update); client reopens frames, auto opens the next chapter after the chapter boss (`DLM:286-298`) |
| D4 | Star chest | `DLM.sendOpenAwardBox(index0)` (`DLM:233-240`) from `DL/AwardBox.as:105-114` | `myStar >= threshold` (button disabled otherwise) | `op = 3`, `index` 0..5 | 4879 `type 1` with `boxState` |
| D5 | Refill tears | `DLM.sendBuyTear` (`DLM:242-248`) from `DL/DemonLandFrame.as:160-190` and `AwardView` | confirm with price (250) and refills left (5 + returning bonus - bought) | `op = 4` | 4879 `type 1` with `goddessTear`, `buyCount` |
| D6 | Buy boss attack | `DLM.sendBuyAttackCount(chapter, node)` (`DLM:250-258`) from `DL/AwardView.as:270-286` | confirm "Deseja gastar {0} diamantes para comprar uma oportunidade de participação? (Ainda pode comprar {1} vezes.)" (50 diamonds); disabled when attacks are full | `op = 5`, `chapterId`, `nodeId` | 4879 `type 2` with the node |
| D7 | Sweep | `MopupManager.sendMopupInfo(4, op, chapter, count, node)` (`decompiled/m5/scripts/mopup/view/DemonLandMopupPrepareFrame.as:265-290`, `DemonLandMopupIngFrame.as:407`, `:441`, `:462`, `:609`) | node passed (`isPassed`); tears for `count x Cost` (refill dialog); gold `evilland_sweep_gold` | send 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type` (#1) 4, `op_type` (#2) 1..4, `campaign_id` (#3) chapter, `count` (#4), `e_index` (#5) node, `pay_type` (#9) | 4425 (mopup), 4879 |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4879 (0x130f) `U_C_EVIL_LAND` | `module.EvilLandMsg`: `type` (#1, INT32) 0 full, 1 summary, 2 one node; `chapterId` (#2, INT32) highest open chapter; `nodeId` (#3, INT32) highest cleared node in that chapter (client uses `nodeId + 1` as next); `star` (#4, INT32); `goddessTear` (#5, INT32); `buyCount` (#6, INT32) tear refills bought today; `updateTime` (#7, STRING) unused; `boxState` (#8, STRING) CSV of 6 values, 0 not opened, 1 opened; `nodeUpdate` (#9, `EvilLandNodeMsg`) for type 2; `nodeList` (#10, repeated `EvilLandNodeMsg`) for type 0. `EvilLandNodeMsg`: `chapterId` (#1), `nodeId` (#2), `attackCount` (#3) attacks used today, `buyCount` (#4) attacks bought today | `DLM.onReceiveEvilLandData` (`DLM:52-99`); dispatches `DEMON_LAND_DATA` | D1 (type 0), after fights, purchases and chests |
| 4878 (0x130e) `U_C_DIALOG` | `gameplot.PlotMsg`: `loop` (#1, BOOL) true = play dialog then reopen; `scene_type` (#2, INT32); `info` (#3, repeated `PlotInfoMsg`: `index` (#1), `direction` (#2), `role_id` (#3, 0 = own portrait), `role_name` (#4, "%s" = own nickname), `event` (#5), `param` (#6), `text` (#7), `delayTime` (#8)) | `DLM.onReceiveDialogData` (`DLM:134-204`) | Reply to D2; shared with the plot system ([tutorial](../tutorial/plot-dialog.md)) |

## 5. Rules and formulas

- Chapters 1..30, 10 nodes each (`DLMOD:10-12`); bosses at nodes 5 and 10 (`DL/LevelStateIcon.as:130-135`).
- Goddess tears (`evilland_goddess_tear_config = 500,20,5,250`): max 500, +20 per hour, 5 refills per day (+ `OldPlayerReturnManager.model.demonLandCount`), 250 diamonds per refill (refill amount unknown: assumption, fill to max).
- Fight cost: template `Cost` (10 normal, 25 boss).
- Boss attack limit: template `AttackCount` (3 for bosses, 0 = unlimited); left = `AttackCount - attackCount + buyCount`; extra attack costs `evilland_buy_count_cost = 50` diamonds, at most `AttackCount` purchases (`DL/AwardView.as:240-272`).
- Rewards: first clear `FirstDropId`, every clear `AttackDropId` (`EvilLandDrop.xml`).
- Stars and chests: `myStar` counts completed chapters (assumption from `DemonRoadMapIcon` star frame when `maxChapterId > idx`); 6 chests with thresholds `EvilLandBoxDrop.site` (5, 10, 15, 20, 25, 30).
- Dialog: template `DialogId > 0` plays a plot on the first chapter entry (assumption).
- Sweep: `evilland_sweep_time = 60` s, `evilland_sweep_gold = 50000`, cost in tears per run = node `Cost`.
- Entry points: daily guide type 85 (`decompiled/core_module/scripts/managers/DayGuideManager.as:936-937`), space NPC dialog option 134 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:797-798`), queue bar (`demonland` 1).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/EvilLandTemplates.xml` (300 rows) | node | `ChapterId`, `NodeId`, `Name`, `Bosses` (hero template), `Npcs` (`pawnId,pos|...`), `Cost`, `AttackCount`, `DialogId`, `FirstDropId`, `AttackDropId` |
| `raw/xml/tempinfos/EvilLandDrop.xml` | drop | `DropId`, `ItemId`, `Count`, `IsBind`, `ValidDate` |
| `raw/xml/tempinfos/EvilLandBoxDrop.xml` (25 rows) | star chest | `site` = star threshold, `itemId`, `count`, `isBind` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `evilland_goddess_tear_config`, `evilland_buy_count_cost`, `evilland_sweep_time`, `evilland_sweep_gold` | |

## 7. Persistent state

```sql
CREATE TABLE trials.demon_land_state (
    player_id          integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    max_chapter_id     smallint    NOT NULL DEFAULT 1 CHECK (max_chapter_id BETWEEN 1 AND 30),
    max_node_id        smallint    NOT NULL DEFAULT 0 CHECK (max_node_id BETWEEN 0 AND 10),
    stars              smallint    NOT NULL DEFAULT 0,
    tears              integer     NOT NULL DEFAULT 500 CHECK (tears >= 0),
    tears_updated_at   timestamptz NOT NULL DEFAULT now(),
    tear_refills_today smallint    NOT NULL DEFAULT 0,
    box_state          smallint[]  NOT NULL DEFAULT '{0,0,0,0,0,0}',
    daily_date         date        NOT NULL DEFAULT current_date
);

CREATE TABLE trials.demon_land_node (
    player_id      integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    chapter_id     smallint NOT NULL CHECK (chapter_id BETWEEN 1 AND 30),
    node_id        smallint NOT NULL CHECK (node_id BETWEEN 1 AND 10),
    attacks_used   smallint NOT NULL DEFAULT 0,
    attacks_bought smallint NOT NULL DEFAULT 0,
    first_cleared  boolean  NOT NULL DEFAULT false,
    PRIMARY KEY (player_id, chapter_id, node_id)
);
```

## 8. Backend implementation notes

- Handlers: `trials::demon_land::handle_get_data` (op 0), `handle_enter_chapter` (1), `handle_fight` (2), `handle_open_box` (3), `handle_buy_tear` (4), `handle_buy_attack` (5).
- Lazy tear regeneration (+20 per full hour, cap 500) before every handler; daily reset at 0:00 of refills and boss attacks.
- Fight: validate unlock (`chapter < max_chapter_id` or (`chapter == max_chapter_id` and `node <= max_node_id + 1`)), tears >= `Cost`, boss attacks left; deduct, start battle 3880 (`Bosses` + `Npcs`). Victory: first clear grants `FirstDropId` and advances progress (node 10 opens the next chapter and adds a star), always grants `AttackDropId`, increments `attacks_used` for bosses. Push 4879 type 1 and type 2.
- Enter chapter: reply 4878 with the chapter dialog (`DialogId`) on first entry (`loop = true`), else an empty `PlotMsg` with `loop = false` to open the node list.
- Chests: `stars >= threshold`, not opened; grant `EvilLandBoxDrop` rows for that threshold.
- Sweep: `mopup::handle_campaign_sweep` type 4 for cleared nodes, tears per run.

## 9. Open questions and assumptions

- Amount restored by a tear refill (assumed: to max).
- Star definition (completed chapters vs boss kills).
- Exact dialog trigger rule and dialog ids table (`DialogId` references plot templates).
- Battle map for 3880 not in the client templates.

## 10. Implementation checklist

- [ ] Template loaders for `EvilLandTemplates.xml`, `EvilLandDrop.xml`, `EvilLandBoxDrop.xml`, config keys
- [ ] Tables `trials.demon_land_state`, `demon_land_node`
- [ ] D1 data (4879 type 0)
- [ ] D2 chapter enter with 4878 plot reply
- [ ] D3 fight 3880 and rewards
- [ ] D4 star chests
- [ ] D5 tear refill, D6 boss attack purchase
- [ ] D7 sweep type 4
- [ ] Tear regeneration and daily reset
- [ ] Tests: unlock order, costs, boss attack limit, chest thresholds
