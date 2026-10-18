# Campaign selection ("Campanha")

Module `selection` of [campaign](README.md). Covers the solo campaign chooser (`selectcampaign` module, M13) and the start of a solo campaign. The campaign map itself is in [map-session.md](map-session.md); grades and sweep in [stars-and-sweep.md](stars-and-sweep.md).

## 1. Overview

- The player opens a world map of chapters ("Pasto Livre (Nível 1-20)" ... "Porta da Decisão (Nível 70-80)"). Each chapter (`Campaigns.DungeonId` 101..107) holds 2..8 areas (`AreaId`, e.g. 10101). Each area has a Normal campaign (`DifficultyGrade` 1, ids 1001..1602) and, from chapter 102 on, a "Herói" campaign (`DifficultyGrade` 2, ids 11101..11602).
- Data is fully template driven on the client. The server only provides the per-campaign grade list (4151, see [stars-and-sweep.md](stars-and-sweep.md)) and the Energy value (player info).
- Starting a campaign sends **5039** with `para_int1 = 1` (solo flag) and `para_int2 = CampaignId`. The server answers with **125** (campaign instance created, [map-session.md](map-session.md)) or a failure.
- Client wiring:
  - controller `SelectCampaignController` (`CM/mvc/controler/SelectCampaignController.as`), module key `selectcampaign`, frame class `selectCP.SelectCampaignFrame` (:93-96);
  - model `SelectCampaignModel` (`CM/mvc/module/selectcampaign/SelectCampaignModel.as`);
  - land, chapter and area trees built once by `CampaignTemplateManager.setup` (`CM/yishi/manager/CampaignTemplateManager.as:47-91`). Only `LandId = 1` is shown (`SelectCampaignModel.as:136-139`).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SelectCampaignFrame` (`M13/selectcampaign/SelectCampaignFrame.as`) | none (art title) | Container, 930x550 | main bar button "Campanha" and hotkey Z (`CM/ui/maintoolbar/MainToolBar.as:1360-1364`), `SwitchPageHelp.gotoSingleCampaign` (`CM/yishi/SwitchPageHelp.as:889-910`), `gotoCampaignById` for quest campaigns (:1067-1136), daily guide (`CM/managers/DayGuideManager.as:474`) | Fonte Mágica buffer badges for slot types 3 and 4 (`SelectCampaignFrame.as:82-110`; fantasy-bar feature); help frame `selectCP.helpFrame`. On construction it sends **9536** (`:53`) |
| `AreaView` (`M13/selectcampaign/view/AreaView.as`) | chapter combobox, e.g. "Pasto Livre (Nível 1-20)" (`CM/mvc/module/selectcampaign/CampaignChapterInfo.as:148-169`) | Chapter navigation | inside the frame | Chapters up to `maxChapter` (highest chapter with an open area, `SelectCampaignModel.as:86-121`; `AreaView.as:115`). Prev/next buttons (:207-235). Chapter reward button toggles `ChapterRewardView` (:242-246); its art switches when `isAllOpenArea()` (:195-205) |
| `SelectCpMapView` (`M13/selectcampaign/view/SelectCpMapView.as`) | none | Chapter map with one `CampaignPointView` per area at `PosX/PosY` | inside `AreaView` | Map swf `swf/singlecampaign1/{chapterId}/map/{chapterId}.swf` (:258-264; preloaded by the controller, `SelectCampaignController.as:59-74`). Areas above the player level are not selectable (:233-236). Quest marker "Missão de Campanha" on the quest area (:242) |
| `CampaignPointView` (`M13/selectcampaign/view/CampaignPointView.as`) | area name | One area | map | States default/open/over/disable from template `state` and `MinLevel` (:289-330). Grade badge `_profile.setFrame(rank)` (:398). Click selects the area; double click asks "Entrar no {0} (Herói)/(Normal)" and starts (:214-235) |
| `CampaignInfoView` (`M13/selectcampaign/view/CampaignInfoView.as`) | area name image | Selected area detail | click on an area | Big icon `PathManager.mapInstanceBigIconPath(CampaignId)`, name image, Normal/"Herói" toggle, grade (`_optimizeProfile.setFrame(rank)`, :520-540), drop showcase `Item` ("Ver Drop", `FallGoodsView`), start button, "Modo Bot" button (visible only when `state == 1`, :524-531; disabled under level 20 with tip "Nv.20", :134-142) |
| `ChapterRewardView` (`M13/selectcampaign/view/ChapterRewardView.as`) | none | Chapter clear and SSS reward preview | chapter reward button | `DistrictDrop[District = chapterId]` items and `DistrictSSSDrop` items; "Esta área não tem recompensa SSS" when the SSS list is empty (`AreaView.as:262-300`) |
| `FallGoodsView` (`M13/selectcampaign/view/FallGoodsView.as`) | "Ver Drop" | Drop showcase | info view button | `Campaigns.Item` template ids (display only) |
| `CampaignNoWearyFrame` / `TodayNotAlertFrame` (core) | "Energia inferior a 20, se entrar na campanha não obterá ganhos, continuar?" | Low Energy warning with "Não alertar mais" and an Energy potion shortcut | start with `weary < 20` | see §5 |

## 3. Routes (client to server)

### 3.1 Frame open: 9536 C_SINGLE_HERO_REQ

| Item | Value |
|---|---|
| UI control | none, frame constructor |
| Sender | `CampaignSocketOutManager.buyCount(1)` (`CM/map/campaign/CampaignSocketOutManager.as:150-157`), called at `M13/selectcampaign/SelectCampaignFrame.as:53` |
| Checks | none |
| Route | C>S **9536 (0x2540) C_SINGLE_HERO_REQ** |
| Request | `campaign.SingleHeroReqMsg`: `op (#1, INT32)` = 1, `pay_type (#2, INT32)` = 1 |
| Expected response | **4948 (0x1354) U_C_SINGLE_HERO_RSP** `SingleHeroCountMsg{count (#1, INT32), buy_count (#2, INT32)}` per the opcode table ("单人英雄副本回应", `CM/yishi/datas/consant/ProtocolTypeTable.as:600`). **No listener exists in this client**, so the reply is ignored. ConfigInfos `single_hero_buy_cost` = 10 diamonds is read into `needPoint` but never used (`SelectCampaignModel.as:22-24`) |

### 3.2 Start a solo campaign: 5039 U_C_CAMPAIGN_ENTER

| Item | Value |
|---|---|
| UI controls | info view start button `__clickHandler` (`M13/selectcampaign/view/CampaignInfoView.as:282-308`); low Energy alert callback `alerrBack` (:476-482); double click on an area `CampaignPointView.enter` (:168-180) |
| Sender | `SingWarSocketSendManager.sendStartCampaignScene(campaignId, 1)` (`M13/net/SingWarSocketSendManager.as:56-76`) |
| Client checks, in order | (1) not in a free team (`FreedomTeamManager.hasTeam`), else "Você encontra-se numa equipe, não é possível de fazer esta operação" (:284-288); (2) an area is selected, else "Escolha Mapa"; (3) a difficulty is selected, else "Dificuldade do Mapa" (:291-302); (4) Energy: if `weary < 20` and the "Não alertar mais" flag is not set for today, show the warning; confirm still starts (:333-364); (5) anti flood: a second call within 3000 ms is dropped (`SingWarSocketSendManager.as:58-66`). The double click path picks the "Herói" campaign automatically when the Normal grade is >= 5 (S) and a hero campaign exists (`CampaignPointView.as:168-179`) |
| Route | C>S **5039 (0x13af) U_C_CAMPAIGN_ENTER** |
| Request | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` = 1 (solo); `para_int2 (#2, INT32)` = `CampaignId`. Other fields (`para_int3 (#3)`, `para_int4 (#4)`, `para_int5 (#5)`, `para_string1 (#6)`, `para_bool1 (#7)`, `server_name (#8)`, `isCross (#9)`) are not set |
| Expected response, success | **125 U_C_CAMPAIGN_CREATE** `RoomCreatedMsg{created_type 1, room{room_id, campaignId = map id, master_id = player, capacity 1, room_type 0}}`, then **21**, **127**, fog **130** and the rest of the map bootstrap ([map-session.md](map-session.md)). The frame closes itself on scene switch (`SelectCampaignFrame.as:153-156`) |
| Expected response, failure | **4192 (0x1060) U_C_SINGLEROOM_FAIL** ("单人本创建失败"). The listener exists but is empty (`CampaignInfoView.as:170, 221-223`), so the server must also send the reason as **126** `CampaignNotifyMsg{id 2, body}` ([node-combat.md](node-combat.md) §4) *(assumption)* |

### 3.3 Client-only actions

| Action | Code | Effect |
|---|---|---|
| Change chapter | `AreaView.__onAreaBtnClick`, `__selectedChapterChange` (:207-260) | loads the chapter map swf; refreshes chapter rewards |
| Select area | `CampaignPointView.__mouseClick` (:209-212) | fills `CampaignInfoView`; "Herói" is enabled only when the Normal grade is >= 5 (S) (`CampaignInfoView.as:240-280`) |
| Toggle Normal/"Herói" | `__selectedChangeHandler` (:484-518) | selects the campaign of that difficulty |
| "Modo Bot" | `__mopupHandler` (:310-331) | requires a selected campaign, `weary >= 20` ("Energia insuficiente, entre no mapa manualmente.") and a scene other than the outer city ("No cenário atual não é possível usar o Modo BOT"); opens the mopup frame type 1. Protocol in [stars-and-sweep.md](stars-and-sweep.md) |
| Use an Energy potion from the low Energy frame | `useWeary` (:366-410) | uses the first owned of 2030503, 2030502, 2030501, 2030500 through inventory opcode **5006** `ItemUseMsg` (inventory feature), after the daily caps checks (`200 - weary`, `600 - wearyLimit`, :412-450) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4151 (0x1037) U_C_RANK_LIST** | `RankListRspMsg{rankInfo (#1, RankMsg, repeated)}`; `RankMsg{user_id (#1, INT32), campaign_id (#2, INT32), rank (#3, INT32)}` | `CampaignRankManager.__rankListHandler` (`CM/yishi/manager/CampaignRankManager.as:52-88`) | login and after each grade change | unlock states and grade badges; see [stars-and-sweep.md](stars-and-sweep.md) |
| 4948 U_C_SINGLE_HERO_RSP | `SingleHeroCountMsg{count (#1, INT32), buy_count (#2, INT32)}` | none | reply to 9536 | none (may be omitted) |
| 4192 U_C_SINGLEROOM_FAIL | empty body *(assumption)* | `CampaignInfoView.__createFailHandler` (empty) | 5039 refused | none; pair with a 126 tip |
| 125, 21, 127 ... | see [map-session.md](map-session.md) | | 5039 accepted | scene switch to the campaign map |
| 3 / 260 (hero feature) | player info `weary`, `wearyLimit` | `PlayerInfo` | login, after each run | Energy display and the low Energy warning |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Visible land | `LandId = 1` only | `SelectCampaignModel.as:136-139` |
| Template state | 0 locked, 1 cleared (has a grade), 2 open (no grade, previous campaign graded or `PreCampaignId = 0`) | `CampaignTemplateManager.checkCanChoose` (`CampaignTemplateManager.as:132-162`) |
| Area selectable | `getMapByDifficult(1).MinLevel <= level` | `SelectCpMapView.as:233-236`; `CampaignChapterInfo.getMaxSelectAewa` (:118-135) |
| Chapter navigation limit | up to the highest chapter with any Normal campaign not locked (`maxChapter`) | `SelectCampaignModel.as:86-121`; `AreaView.as:115,225` |
| Default chapter on open | quest campaign chapter if `taskCampaignTem` is given and reachable; else the lowest chapter with an open area; else the last | `SelectCampaignModel.as:105-120` |
| "Herói" difficulty available | Normal grade of the area >= 5 (S) and a `DifficultyGrade 2` template exists | `CampaignInfoView.as:250-255`; `CampaignPointView.as:168-179, 269-274` |
| "Modo Bot" button | campaign `state == 1` (already graded), level >= 20 | `CampaignInfoView.as:134-142, 524-531` |
| Energy per run | `SingleCampaign_Weary` = 20; with less, the run gives no gains (warning text) | ConfigInfos; `yishi.view.base.ThewAlertFrame.disclist04` |
| Energy cap | 200 (`Player_weary`), potions add at most 600 per day (`Weary_Limit`) | ConfigInfos; `CampaignInfoView.as:412-450` |
| Feature unlock | `newbieProcess > 23000` | `SwitchPageHelp.as:899-904` |
| Quest shortcut | `Capacity == 1` and level >= `MinLevel` opens the selection on that campaign ("Nível insuficiente, favor completar primeiro oitras missões principais e missões de recompensa" otherwise) | `SwitchPageHelp.as:1067-1136` |
| Chapter clear reward and SSS reward | shown from `DistrictDrop` and `DistrictSSSDrop`; no claim route exists, so the server grants them *(assumption: when every area of the chapter is graded, and when every area is SSS; `isAllOpenArea` requires rank 7 for areas > 10200)* | `AreaView.as:262-300`; `CampaignChapterInfo.as:53-79` |
| `getChapterRevengeCost` | 100 x (chapter index + 1), not used by this module | `CampaignChapterInfo.as:171-194` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` (285 rows, `CampaignTemplateResolve`) | campaign | `CampaignId`, `CampaignName`, `Types` (0 = PvE), `LandId` (1 = selection), `DungeonId` (chapter 101..107), `AreaId` (area, also image folder `images/InstanceImg/{AreaId}/`), `DifficultyGrade` (1 Normal, 2 Herói), `MinLevel`, `MaxLevel`, `PreCampaignId` (unlock chain), `Capacity` (1 solo), `PosX`/`PosY` (point on the chapter map), `Item` (drop showcase), `StandSecond` (boss time for the result grade), `BaseGp` (EXP, server), `NeedTransfer`, `NeedChangeJob`, `NeedThirdTransfer`, `NeedTransferType` (server checks *(assumption)*) |
| `raw/xml/tempinfos/MapInfos.xml` | map | `Id` (map id sent in 125), `CampaignId`, `MapFileId`, `BattleGround` |
| `raw/xml/tempinfos/DistrictDrop.xml` | chapter clear reward | `District` (= chapter id), `ItemId`, `Count`, `ValidDate` |
| `raw/xml/tempinfos/DistrictSSSDrop.xml` | chapter SSS reward | same fields |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `SingleCampaign_Weary` 20, `Player_weary` 200, `Weary_Limit` 600, `single_hero_buy_cost` 10 |

Distribution of solo campaigns (LandId 1, Types 0): chapter 101: 7 areas, level 11..21, ids 1001..1007 (Normal only); 102: 7 areas x 2; 103: 7 x 2; 104: 8 x 2; 105: 7 x 2; 106: 7 x 2; 107: 2 x 2 (level 70..80).

## 7. Persistent state (schema `campaign`)

```sql
CREATE SCHEMA IF NOT EXISTS campaign;

CREATE TABLE campaign.player_energy (
  player_id      integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  energy         smallint NOT NULL DEFAULT 200 CHECK (energy >= 0),
  potion_restored_today smallint NOT NULL DEFAULT 0 CHECK (potion_restored_today BETWEEN 0 AND 600),
  reset_on       date NOT NULL DEFAULT current_date
);

CREATE TABLE campaign.chapter_reward_claim (
  player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  chapter_id  smallint NOT NULL CHECK (chapter_id BETWEEN 101 AND 199),
  reward_kind smallint NOT NULL CHECK (reward_kind IN (1, 2)),
  granted_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, chapter_id, reward_kind)
);
```

- `reward_kind`: 1 = `DistrictDrop` (chapter cleared), 2 = `DistrictSSSDrop` (chapter all SSS).
- Grades are in `campaign.player_campaign_grade` ([stars-and-sweep.md](stars-and-sweep.md)).
- Energy may already live in the hero feature (player info field `weary`). If so, drop `campaign.player_energy` and use that table *(assumption)*.

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::selection::handle_single_hero_req` | 9536 | none | optional 4948 `{count, buy_count}`; nothing else (no client consumer) |
| `campaign::selection::handle_start_solo` | 5039 with `para_int1 = 1` | (1) player not in a campaign, room or battle; (2) `para_int2` is a template with `Types 0`, `LandId 1`, `Capacity 1`; (3) level >= `MinLevel`; (4) template `state != 0` for this player: `PreCampaignId = 0` or the player has a grade on `PreCampaignId`; (5) for `DifficultyGrade 2`, Normal campaign of the same `AreaId` graded >= 5; (6) job transfer flags | Do not reject on Energy: remember `has_gains = energy >= 20` in the instance. Create the instance (map = first `MapInfos` row of the campaign, [map-session.md](map-session.md)) and send 125, 21, 127, 130. On failure send 4192 then 126 `{id 2, body}` |

- Energy is charged when the run starts *(assumption: the client shows the cost before entry and the sweep charges 20 per run)*. Push the new Energy through the hero player info message.
- At login send 4151 with every graded campaign (all difficulties, also team instances) so `checkCanChoose` and the room views work.
- Chapter rewards: after a grade update, check the chapter; when every Normal area of the chapter has a grade, grant `DistrictDrop` once; when every area has grade 7, grant `DistrictSSSDrop` once (by mail or direct grant) *(assumption)*.

## 9. Open questions and assumptions

1. 9536/4948 ("single hero campaign count") has no client consumer: daily limits for "Herói" runs may exist server side. *(assumption: no limit beyond Energy)*.
2. 4192 body is unknown (no reader). *(assumption: empty)*.
3. When exactly Energy is deducted (on start, on boss kill) is not visible. *(assumption: on start, refunded never)*.
4. Chapter reward grant trigger and channel. *(assumption above)*.
5. `NeedTransfer*` flags are only checked client side for team rooms; for solo the server should check them too *(assumption)*.

## 10. Implementation checklist

- [ ] Loader: `Campaigns` (state per player computed server side), `MapInfos`, `DistrictDrop`, `DistrictSSSDrop`, ConfigInfos keys
- [ ] Screen check: `SelectCampaignFrame`, `AreaView`, `SelectCpMapView`, `CampaignPointView`, `CampaignInfoView`, `ChapterRewardView`, `FallGoodsView`
- [ ] Route 9536 (accept, optional 4948)
- [ ] Route 5039 solo (`para_int1 = 1`) with validation and 125 bootstrap
- [ ] Failure path 4192 + 126 tip
- [ ] 4151 at login and after grade changes
- [ ] Energy state, daily reset, potion cap interplay with inventory 5006
- [ ] Tables `campaign.player_energy` (or hero feature field), `campaign.chapter_reward_claim`
- [ ] Rule: hero difficulty gate (Normal grade >= 5)
- [ ] Rule: chapter rewards grant once
- [ ] Test: start 1001 at level 11 -> 125 with map 1021; start 1002 without a grade on 1001 -> 4192 + tip
- [ ] Test: hero 11101 refused until 1101 is graded S
